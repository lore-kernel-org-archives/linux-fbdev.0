From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] Tile Blitting
Date: 27 Feb 2003 22:15:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046355210.1206.42.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0302270056200.16050-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Die+ArGiLoa5VLZlIj79"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18oOnp-0004zq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Feb 2003 06:14:25 -0800
In-Reply-To: <Pine.LNX.4.44.0302270056200.16050-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-Die+ArGiLoa5VLZlIj79
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-02-27 at 09:18, James Simmons wrote:
> > As Geert and DaveM has
> > mentioned to me, the current implementation might not be thread-safe
> > (although I see more of a concurrency problem between CPU and GPU).
> 
> I agree I see more of a problem with CPU GPU syncing issue. I do have a 
> fix in BK with allocating and deallocating continuely but it is the wrong
> approach.
> 

We can avoid concurrency problems by assigning different sections of the
buffer per call to fb_imageblit(). There is really no need to map/unmap
or allocate/deallocate buffers unless you do not trust the drivers to
behave :-).  The buffer will not be exposed to userland, unlike DRM
which has to implement "map->user access->unmap->pass to hardware".
 
> > Thus, the restriction that the buffer must be completely copied by the
> > driver before returning.  And because of this restriction, an extra copy
> > which might be unnecessary cannot be avoided (this was noted by Petr).
> > 
> > Treating the buffer as a ringbuffer, we eliminate these restrictions.
> 
> I didn't realize that the below was a ringbuffer implementation. The name
> threw me off. 

Well, it's not strictly a ringbuffer implementation.  This would require
a head and tail pointer where fbcon will adjust the tail and the
driver/hardware will adjust the head.  This will be very difficult to
implement in a device independent manner.  So we just cheat by issuing
an fb_sync() per loop to flush all pending commands.

> 
> Do you still have the original patch?
> 

Here's a revised one. Driver's can choose to fill up the following
structure, or leave it empty:

#define FB_PIXMAP_DEFAULT 1     /* used internally by fbcon */
#define FB_PIXMAP_SYSTEM  2     /* memory is in system RAM  */
#define FB_PIXMAP_IO      4     /* memory is iomapped       */
#define FB_PIXMAP_SYNC    256   /* set if GPU can DMA       */

struct fb_pixmap {
        __u8  *addr; 
	__u32 size;  
	__u32 offset;
	__u32 buf_align; 
	__u32 scan_align; 
	__u32 flags; 
	void (*outbuf)(u8 dst, u8 *addr); 
	u8   (*inbuf) (u8 *addr);
	unsigned long lock_flags;
	spinlock_t lock; 
};

The buffer can be anywhere, system or io.  If it's in special memory
(ie, offscreen graphics), access methods must be specified (outbuf,
inbuf).  If the buffer is DMA'able by the GPU, then FB_PIXMAP_SYNC must
be set (it issues an fb_sync()), otherwise leave it cleared (ie soft
accels). The buf_align and scan_align are hardware specific.  This will
let fbcon format the bitmap into a form acceptable by the hardware.  The
modified rivafb sets the alignment according to its needs, which greatly
simplified the rivafb_imageblit() function.

The spinlock may be necessary because fbcon_cursor, which is called via
timer or interrupt, might also use fb_imageblit().  You can change it to
a more appropriate locking method if you want.

The patch should work without driver breakage.  

Diff is against linux-2.5.61 + your fbdev.diff.gz + my accel_putcs
optimization patch + Geert's logo updates.  I know you already applied
them all in your tree.

Tony
 


--=-Die+ArGiLoa5VLZlIj79
Content-Disposition: attachment; filename=pixmap2.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=pixmap2.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.61/drivers/video/console/fbcon.c linux/drivers/video/c=
onsole/fbcon.c
--- linux-2.5.61/drivers/video/console/fbcon.c	2003-02-27 09:28:55.00000000=
0 +0000
+++ linux/drivers/video/console/fbcon.c	2003-02-27 11:40:39.000000000 +0000
@@ -134,6 +134,8 @@
 static int fbcon_set_origin(struct vc_data *);
 static int cursor_drawn;
=20
+#define FBCON_PIXMAPSIZE 8192
+
 #define CURSOR_DRAW_DELAY		(1)
=20
 /* # VBL ints between cursor state changes */
@@ -296,8 +298,191 @@
 }
=20
 /*
+ * drawing helpers
+ */
+static inline void sysmove_buf_aligned(u8 *dst, u8 *src, u32 d_pitch,=20
+				       u32 s_pitch, u32 height,=20
+				       struct fb_info *info)
+{
+	int i, j;
+=09
+	for (i =3D height; i--; ) {
+		for (j =3D 0; j < s_pitch; j++)=20
+			dst[j] =3D *src++;
+		dst +=3D d_pitch;
+	}
+}
+
+static inline void iomove_buf_aligned(u8 *dst, u8 *src, u32 d_pitch,=20
+				      u32 s_pitch, u32 height,
+				      struct fb_info *info)
+{
+	int i, j;
+=09
+	for (i =3D height; i--; ) {
+		for (j =3D 0; j < s_pitch; j++)=20
+			info->pixmap.outbuf(*src++, dst+j);
+		dst +=3D d_pitch;
+	}
+}
+
+static inline void sysmove_buf_unaligned(u8 *dst, u8 *src, u32 d_pitch,=20
+					 u32 height, u32 mask, u32 shift_high,
+					 u32 shift_low, u32 mod, u32 idx,
+					 struct fb_info *info)
+{
+	int i, j;
+=09
+	for (i =3D height; i--; ) {
+		for (j =3D 0; j < idx; j++) {=20
+			dst[j] &=3D mask;
+			dst[j] |=3D *src >> shift_low;
+			dst[j+1] =3D *src << shift_high;
+			src++;
+		}
+		dst[idx] &=3D mask;
+		dst[idx] |=3D *src >> shift_low;
+		if (shift_high < mod)
+			dst[idx+1] =3D *src<<shift_high;
+		src++;
+		dst +=3D d_pitch;
+	}
+}
+
+static inline void iomove_buf_unaligned(u8 *dst, u8 *src, u32 d_pitch,=20
+					u32 height, u32 mask, u32 shift_high,
+					u32 shift_low,u32 mod, u32 idx,=20
+					struct fb_info *info)
+{
+	int i, j;
+	u8 tmp;
+=09
+	for (i =3D height; i--; ) {
+		for (j =3D 0; j < idx; j++) {=20
+			tmp =3D info->pixmap.inbuf(dst+j);
+			tmp &=3D mask;
+			tmp |=3D *src >> shift_low;
+			info->pixmap.outbuf(tmp, dst+j);
+			info->pixmap.outbuf(*src << shift_high, dst+j+1);
+			src++;
+		}
+		tmp =3D info->pixmap.inbuf(dst+idx);
+		tmp &=3D mask;
+		tmp |=3D *src >> shift_low;
+		info->pixmap.outbuf(tmp, dst+idx);
+		if (shift_high < mod)
+			info->pixmap.outbuf(*src<<shift_high, dst+idx+1);
+		src++;
+		dst +=3D d_pitch;
+	}
+}
+
+static void putcs_unaligned(struct vc_data *vc, struct display *p,
+			    struct fb_info *info, struct fb_image *image,=20
+			    int count, const unsigned short *s)
+{
+	unsigned int width =3D (vc->vc_font.width + 7)/8;
+	unsigned int cellsize =3D vc->vc_font.height * width;
+	unsigned int maxcnt =3D info->pixmap.size/cellsize;
+	unsigned int pitch, cnt, k;
+	unsigned int shift_low =3D 0, mod =3D vc->vc_font.width % 8;
+	unsigned int shift_high =3D 8, size;
+	unsigned int buf_align =3D info->pixmap.buf_align - 1;
+	unsigned int scan_align =3D info->pixmap.scan_align - 1;
+	unsigned int idx =3D vc->vc_font.width/8;
+	unsigned short charmask =3D p->charmask;
+	u8 mask, *src, *dst, *dst0;
+	void (*move_data)(u8 *dst, u8 *src, u32 d_pitch, u32 height, u32 mask,
+			  u32 shift_high, u32 shift_low, u32 mod, u32 idx,=20
+			  struct fb_info *info);
+=09
+	if (info->pixmap.outbuf !=3D NULL)
+		move_data =3D iomove_buf_unaligned;
+	else
+		move_data =3D sysmove_buf_unaligned;
+
+	while (count) {
+		if (count > maxcnt)=20
+			cnt =3D k =3D maxcnt;
+		else
+			cnt =3D k =3D count;
+	=09
+		image->width =3D vc->vc_font.width * cnt;
+		pitch =3D (image->width + 7)/8 + scan_align;
+		pitch &=3D ~scan_align;
+		size =3D pitch * vc->vc_font.height + buf_align;
+		size &=3D ~buf_align;
+		dst0 =3D info->pixmap.addr + fb_get_buffer_offset(info, size);
+		image->data =3D dst0;
+		while (k--) {
+			src =3D p->fontdata + (scr_readw(s++) & charmask)*
+				cellsize;
+			dst =3D dst0;
+			mask =3D (u8) (0xfff << shift_high);
+			move_data(dst, src, pitch, image->height, mask,
+				  shift_high, shift_low, mod, idx, info);
+			shift_low +=3D mod;
+			dst0 +=3D (shift_low >=3D 8) ? width : width - 1;
+			shift_low &=3D 7;
+			shift_high =3D 8 - shift_low;
+		}
+	=09
+		info->fbops->fb_imageblit(info, image);
+		image->dx +=3D cnt * vc->vc_font.width;
+		count -=3D cnt;
+	}
+}
+
+static void putcs_aligned(struct vc_data *vc, struct display *p,
+			  struct fb_info *info, struct fb_image *image,=20
+			  int count, const unsigned short *s)
+{
+	unsigned int width =3D vc->vc_font.width/8;
+	unsigned int cellsize =3D vc->vc_font.height * width;
+	unsigned int maxcnt =3D info->pixmap.size/cellsize;
+	unsigned int scan_align =3D info->pixmap.scan_align - 1;
+	unsigned int buf_align =3D info->pixmap.buf_align - 1;
+	unsigned int pitch, cnt, size, k;
+	unsigned short charmask =3D p->charmask;
+	void (*move_data)(u8 *dst, u8 *src, u32 s_pitch, u32 d_pitch,=20
+			  u32 height, struct fb_info *info);
+	u8 *src, *dst, *dst0;
+
+	if (info->pixmap.outbuf !=3D NULL)
+		move_data =3D iomove_buf_aligned;
+	else
+		move_data =3D sysmove_buf_aligned;
+
+	while (count) {
+		if (count > maxcnt)
+			cnt =3D k =3D maxcnt;
+		else
+			cnt =3D k =3D count;
+		pitch =3D width * cnt + scan_align;
+		pitch &=3D ~scan_align;
+		size =3D pitch * vc->vc_font.height + buf_align;
+		size &=3D ~buf_align;
+		image->width =3D vc->vc_font.width * cnt;
+		dst0 =3D info->pixmap.addr + fb_get_buffer_offset(info, size);
+		image->data =3D dst0;
+		while (k--) {
+			src =3D p->fontdata + (scr_readw(s++) & charmask)*
+				cellsize;
+			dst =3D dst0;
+			move_data(dst, src, pitch, width, image->height, info);
+			dst0 +=3D width;
+		}
+	=09
+		info->fbops->fb_imageblit(info, image);
+		image->dx +=3D cnt * vc->vc_font.width;
+		count -=3D cnt;
+	}
+}
+
+/*
  * Accelerated handlers.
  */
+
 void accel_bmove(struct display *p, int sy, int sx, int dy, int dx,
 			int height, int width)
 {
@@ -331,22 +516,52 @@
 	info->fbops->fb_fillrect(info, &region);
 }=09
=20
-#define FB_PIXMAPSIZE 8192
-/*
- * FIXME: Break up this function, it's becoming too long...
- */       =20
-void accel_putcs(struct vc_data *vc, struct display *p,
-			const unsigned short *s, int count, int yy, int xx)
+static void accel_putc(struct vc_data *vc, struct display *p,
+		       int c, int ypos, int xpos)
 {
-	static u8 pixmap[FB_PIXMAPSIZE];
 	struct fb_image image;
 	struct fb_info *info =3D p->fb_info;
 	unsigned short charmask =3D p->charmask;
-	unsigned int width =3D ((vc->vc_font.width + 7)/8);
-	unsigned int cellsize =3D vc->vc_font.height * width;
-	unsigned int pitch, cnt, i, j, k;
-	unsigned int maxcnt =3D FB_PIXMAPSIZE/cellsize;
-	u8 *src, *dst, *dst0;
+	unsigned int width =3D (vc->vc_font.width + 7)/8;
+	unsigned int size, pitch;
+	unsigned int scan_align =3D info->pixmap.scan_align - 1;
+	unsigned int buf_align =3D info->pixmap.buf_align - 1;
+	void (*move_data)(u8 *dst, u8 *src, u32 s_pitch, u32 d_pitch,=20
+			  u32 height, struct fb_info *info);
+	u8 *src, *dst;
+
+	if (info->pixmap.outbuf !=3D NULL)
+		move_data =3D iomove_buf_aligned;
+	else
+		move_data =3D sysmove_buf_aligned;
+
+	image.dx =3D xpos * vc->vc_font.width;
+	image.dy =3D ypos * vc->vc_font.height;
+	image.width =3D vc->vc_font.width;
+	image.height =3D vc->vc_font.height;
+	image.fg_color =3D attr_fgcol(p, c);
+	image.bg_color =3D attr_bgcol(p, c);
+	image.depth =3D 0;
+
+	pitch =3D width + scan_align;
+	pitch &=3D ~scan_align;
+	size =3D pitch * vc->vc_font.height;
+	size +=3D buf_align;
+	size &=3D ~buf_align;
+	dst =3D info->pixmap.addr + fb_get_buffer_offset(info, size);
+	image.data =3D dst;
+	src =3D p->fontdata + (c & charmask) * vc->vc_font.height * width;
+
+	move_data(dst, src, pitch, width, image.height, info);
+
+	info->fbops->fb_imageblit(info, &image);
+}
+
+void accel_putcs(struct vc_data *vc, struct display *p,
+			const unsigned short *s, int count, int yy, int xx)
+{
+	struct fb_info *info =3D p->fb_info;
+	struct fb_image image;
 	u16 c =3D scr_readw(s);
 =09
 	image.fg_color =3D attr_fgcol(p, c);
@@ -355,80 +570,11 @@
 	image.dy =3D yy * vc->vc_font.height;
 	image.height =3D vc->vc_font.height;
 	image.depth =3D 0;
-	image.data =3D pixmap;
=20
-	if (!(vc->vc_font.width & 7)) {
-		while (count) {
-			if (count > maxcnt)=20
-				cnt =3D k =3D maxcnt;
-			else
-				cnt =3D k =3D count;
-		=09
-			dst0 =3D pixmap;
-			pitch =3D width * cnt;
-			image.width =3D vc->vc_font.width * cnt;
-			while (k--) {
-				src =3D p->fontdata + (scr_readw(s++)&charmask)*
-					cellsize;
-				dst =3D dst0;
-				for (i =3D image.height; i--; ) {
-					for (j =3D 0; j < width; j++)=20
-						dst[j] =3D *src++;
-					dst +=3D pitch;
-				}
-				dst0 +=3D width;
-			}
-
-			info->fbops->fb_imageblit(info, &image);
-			image.dx +=3D cnt * vc->vc_font.width;
-			count -=3D cnt;
-		}
-	=09
-	} else {
-		unsigned int shift_low =3D 0, mod =3D vc->vc_font.width % 8;
-		unsigned int shift_high =3D 8;
-		unsigned idx =3D vc->vc_font.width/8;
-		u8 mask;
-
-		while (count) {
-			if (count > maxcnt)=20
-				cnt =3D k =3D maxcnt;
-			else
-				cnt =3D k =3D count;
-		=09
-			dst0 =3D pixmap;
-			image.width =3D vc->vc_font.width * cnt;
-			pitch =3D (image.width + 7)/8;
-			while (k--) {
-				src =3D p->fontdata + (scr_readw(s++)&charmask)*=20
-					cellsize;
-				dst =3D dst0;
-				mask =3D (u8) (0xfff << shift_high);
-				for (i =3D image.height; i--; ) {
-					for (j =3D 0; j < idx; j++) {
-						dst[j] &=3D mask;
-						dst[j] |=3D *src >> shift_low;
-						dst[j+1] =3D *src << shift_high;
-						src++;
-					}
-					dst[idx] &=3D mask;
-					dst[idx] |=3D *src >> shift_low;
-					if (shift_high < mod)
-						dst[idx+1] =3D *src << shift_high;
-					src++;
-					dst +=3D pitch;
-				}
-				shift_low +=3D mod;
-				dst0 +=3D (shift_low >=3D 8) ? width : width - 1;
-				shift_low &=3D 7;
-				shift_high =3D 8 - shift_low;
-			}
-		=09
-			info->fbops->fb_imageblit(info, &image);
-			image.dx +=3D cnt * vc->vc_font.width;
-			count -=3D cnt;
-		}
-	}
+	if (!(vc->vc_font.width & 7))=20
+		putcs_aligned(vc, p, info, &image, count, s);
+	else=20
+		putcs_unaligned(vc, p, info, &image, count, s);
 }
=20
 void accel_clear_margins(struct vc_data *vc, struct display *p,
@@ -633,6 +779,18 @@
 	vc->vc_cols =3D info->var.xres/vc->vc_font.width;
 	vc->vc_rows =3D info->var.yres/vc->vc_font.height;
 =09
+	if (info->pixmap.addr =3D=3D NULL) {
+		info->pixmap.addr =3D kmalloc(FBCON_PIXMAPSIZE, GFP_KERNEL);
+		if (!info->pixmap.addr)
+			return NULL;
+		info->pixmap.size =3D FBCON_PIXMAPSIZE;
+		info->pixmap.buf_align =3D 1;
+		info->pixmap.scan_align =3D 1;
+		info->pixmap.flags =3D FB_PIXMAP_DEFAULT;
+	}
+	info->pixmap.offset =3D 0;
+	spin_lock_init(&info->pixmap.lock);
+
 	/* We trust the mode the driver supplies. */
 	if (info->fbops->fb_set_par)
 		info->fbops->fb_set_par(info);
@@ -1030,10 +1188,6 @@
 static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {
 	struct display *p =3D &fb_display[vc->vc_num];
-	struct fb_info *info =3D p->fb_info;
-	unsigned short charmask =3D p->charmask;
-	unsigned int width =3D ((vc->vc_font.width + 7) >> 3);
-	struct fb_image image;
 	int redraw_cursor =3D 0;
=20
 	if (!p->can_soft_blank && console_blanked)
@@ -1047,16 +1201,7 @@
 		redraw_cursor =3D 1;
 	}
=20
-	image.fg_color =3D attr_fgcol(p, c);
-	image.bg_color =3D attr_bgcol(p, c);
-	image.dx =3D xpos * vc->vc_font.width;
-	image.dy =3D real_y(p, ypos) * vc->vc_font.height;
-	image.width =3D vc->vc_font.width;
-	image.height =3D vc->vc_font.height;
-	image.depth =3D 1;
-	image.data =3D p->fontdata + (c & charmask) * vc->vc_font.height * width;
-
-	info->fbops->fb_imageblit(info, &image);
+	accel_putc(vc, p, c, real_y(p, ypos), xpos);
=20
 	if (redraw_cursor)
 		vbl_cursor_cnt =3D CURSOR_DRAW_DELAY;
diff -Naur linux-2.5.61/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.5.61/drivers/video/fbmem.c	2003-02-27 09:28:25.000000000 +0000
+++ linux/drivers/video/fbmem.c	2003-02-27 14:11:03.000000000 +0000
@@ -368,6 +368,31 @@
 	return n < 0 ? d >> -n : d << n;
 }
=20
+/*
+ * we need to lock this section since fbcon_cursor
+ * may use fb_imageblit()
+ */
+u32 fb_get_buffer_offset(struct fb_info *info, u32 size)
+{
+	u32 align =3D info->pixmap.buf_align - 1;
+	u32 offset;
+
+	spin_lock_irqsave(&info->pixmap.lock,
+			  info->pixmap.lock_flags);
+	offset =3D info->pixmap.offset + align;
+	offset &=3D ~align;
+	if (offset + size > info->pixmap.size) {
+		if (info->fbops->fb_sync &&=20
+		    info->pixmap.flags & FB_PIXMAP_SYNC)
+			info->fbops->fb_sync(info);
+		offset =3D 0;
+	}
+	info->pixmap.offset =3D offset + size;
+	spin_unlock_irqrestore(&info->pixmap.lock,
+			       info->pixmap.lock_flags);
+	return offset;
+}
+
 #ifdef CONFIG_LOGO
 #include <linux/linux_logo.h>
=20
@@ -1240,5 +1265,6 @@
 EXPORT_SYMBOL(fb_set_var);
 EXPORT_SYMBOL(fb_blank);
 EXPORT_SYMBOL(fb_pan_display);
+EXPORT_SYMBOL(fb_get_buffer_offset);
=20
 MODULE_LICENSE("GPL");
diff -Naur linux-2.5.61/drivers/video/softcursor.c linux/drivers/video/soft=
cursor.c
--- linux-2.5.61/drivers/video/softcursor.c	2002-12-16 02:07:59.000000000 +=
0000
+++ linux/drivers/video/softcursor.c	2003-02-27 11:40:28.000000000 +0000
@@ -17,30 +17,79 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
=20
+static inline void sysmove_buf(u8 *dst, u8 *src, u32 d_pitch, u32 s_pitch,=
=20
+			       u32 height, struct fb_info *info)
+{
+	int i, j;
+=09
+	for (i =3D height; i--; ) {
+		for (j =3D 0; j < s_pitch; j++)=20
+			dst[j] =3D *src++;
+		dst +=3D d_pitch;
+	}
+}
+
+static inline void iomove_buf(u8 *dst, u8 *src, u32 d_pitch, u32 s_pitch,=20
+			      u32 height, struct fb_info *info)
+{
+	int i, j;
+=09
+	for (i =3D height; i--; ) {
+		for (j =3D 0; j < s_pitch; j++)=20
+			info->pixmap.outbuf(*src++, dst+j);
+		dst +=3D d_pitch;
+	}
+}
+
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	int i, size =3D ((cursor->image.width + 7) / 8) * cursor->image.height;
+	static u8 src[64];
 	struct fb_image image;
-	static char data[64];
+	unsigned int i, size, s_pitch, d_pitch;
+	unsigned dsize =3D ((cursor->image.width + 7)/8) * cursor->image.height;
+	unsigned int scan_align =3D info->pixmap.scan_align - 1;
+	unsigned int buf_align =3D info->pixmap.buf_align - 1;
+	void (*move_data)(u8 *dst, u8 *src, u32 s_pitch,=20
+			  u32 d_pitch, u32 height,
+			  struct fb_info *info);
+	u8 *dst;
+			 =20
+	if (info->pixmap.outbuf !=3D NULL)
+		move_data =3D iomove_buf;
+	else
+		move_data =3D sysmove_buf;
+
+	s_pitch =3D (cursor->image.width + 7)/8;
+	d_pitch =3D (s_pitch + scan_align) & ~scan_align;
+	size =3D d_pitch * cursor->image.height + buf_align;
+	size &=3D ~buf_align;
+	dst =3D info->pixmap.addr + fb_get_buffer_offset(info, size);
+	image.data =3D dst;
=20
 	if (cursor->enable) {
 		switch (cursor->rop) {
 		case ROP_XOR:
-			for (i =3D 0; i < size; i++)
-				data[i] =3D (cursor->image.data[i] &
+			for (i =3D 0; i < dsize; i++) {
+				src[i] =3D  (cursor->image.data[i] &
 					   cursor->mask[i]) ^
-				    	   cursor->dest[i];
+					   cursor->dest[i];
+			}
 			break;
 		case ROP_COPY:
 		default:
-			for (i =3D 0; i < size; i++)
-				data[i] =3D
-				    cursor->image.data[i] & cursor->mask[i];
+			for (i =3D 0; i < dsize; i++) {
+				src[i] =3D cursor->image.data[i] &
+					 cursor->mask[i];
+			}
 			break;
 		}
-	} else
-		memcpy(data, cursor->dest, size);
-
+		move_data(dst, src, d_pitch, s_pitch, cursor->image.height,=20
+			  info);
+	} else {
+		move_data(dst, cursor->dest, s_pitch, d_pitch,=20
+			  cursor->image.height, info);
+	}
+	 =20
 	image.bg_color =3D cursor->image.bg_color;
 	image.fg_color =3D cursor->image.fg_color;
 	image.dx =3D cursor->image.dx;
@@ -48,7 +97,6 @@
 	image.width =3D cursor->image.width;
 	image.height =3D cursor->image.height;
 	image.depth =3D cursor->image.depth;
-	image.data =3D data;
=20
 	if (info->fbops->fb_imageblit)
 		info->fbops->fb_imageblit(info, &image);
diff -Naur linux-2.5.61/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.61/include/linux/fb.h	2003-02-27 09:22:20.000000000 +0000
+++ linux/include/linux/fb.h	2003-02-27 11:40:08.000000000 +0000
@@ -325,6 +325,23 @@
 	struct fb_image	image;	/* Cursor image */
 };
=20
+#define FB_PIXMAP_DEFAULT 1     /* used internally by fbcon */
+#define FB_PIXMAP_SYSTEM  2     /* memory is in system RAM  */
+#define FB_PIXMAP_IO      4     /* memory is iomapped       */
+#define FB_PIXMAP_SYNC    256   /* set if GPU can DMA       */
+
+struct fb_pixmap {
+        __u8  *addr;                      /* pointer to memory            =
 */ =20
+	__u32 size;                       /* size of buffer in bytes       */
+	__u32 offset;                     /* current offset to buffer      */
+	__u32 buf_align;                  /* byte alignment of each bitmap */
+	__u32 scan_align;                 /* alignment per scanline        */
+	__u32 flags;                      /* see FB_PIXMAP_*               */
+	void (*outbuf)(u8 dst, u8 *addr); /* access methods                */
+	u8   (*inbuf) (u8 *addr);
+	unsigned long lock_flags;         /* flags for locking             */
+	spinlock_t lock;                  /* spinlock                      */
+};
 #ifdef __KERNEL__
=20
 #include <linux/fs.h>
@@ -390,6 +407,7 @@
    struct fb_monspecs monspecs;         /* Current Monitor specs */
    struct fb_cursor cursor;		/* Current cursor */=09
    struct fb_cmap cmap;                 /* Current cmap */
+   struct fb_pixmap pixmap;	        /* Current pixmap */
    struct fb_ops *fbops;
    char *screen_base;                   /* Virtual address */
    struct vc_data *display_fg;		/* Console visible on this display */
@@ -464,6 +482,7 @@
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
+extern u32 fb_get_buffer_offset(struct fb_info *info, u32 size);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
=20

--=-Die+ArGiLoa5VLZlIj79
Content-Disposition: attachment; filename=rivafb_pixmap.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=rivafb_pixmap.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.61/drivers/video/riva/fbdev.c linux/drivers/video/riva=
/fbdev.c
--- linux-2.5.61/drivers/video/riva/fbdev.c	2003-02-27 09:22:20.000000000 +=
0000
+++ linux/drivers/video/riva/fbdev.c	2003-02-27 09:49:39.000000000 +0000
@@ -1383,18 +1383,16 @@
 			     const struct fb_image *image)
 {
 	struct riva_par *par =3D (struct riva_par *) info->par;
-	u32 fgx =3D 0, bgx =3D 0, width, mod, tmp;
+	u32 fgx =3D 0, bgx =3D 0, width, tmp;
 	u8 *cdat =3D (u8 *) image->data;
 	volatile u32 *d;
-	int i, j, k, size;
+	int i, size;
=20
 	if (image->depth !=3D 0) {
-		wait_for_idle(par);
 		cfb_imageblit(info, image);
 		return;
 	}
=20
-	width =3D (image->width + 7)/8;
 	switch (info->var.bits_per_pixel) {
 	case 8:
 		fgx =3D image->fg_color;
@@ -1429,49 +1427,23 @@
=20
 	d =3D &par->riva.Bitmap->MonochromeData01E;
=20
-	mod =3D width % 4;
-
-	if (width >=3D 4) {
-		k =3D image->height;
-		while (k--) {
-			size =3D width / 4;
-			while (size >=3D 16) {
-				RIVA_FIFO_FREE(par->riva, Bitmap, 16);
-				for (i =3D 0; i < 16; i++) {
-					tmp =3D *((u32 *)cdat)++;
-					reverse_order(&tmp);
-					d[i] =3D tmp;
-				}
-				size -=3D 16;
-			}
-
-			if (size) {
-				RIVA_FIFO_FREE(par->riva, Bitmap, size);
-				for (i =3D 0; i < size; i++) {
-					tmp =3D *((u32 *) cdat)++;
-					reverse_order(&tmp);
-					d[i] =3D tmp;
-				}
-			}
-
-			if (mod) {
-				RIVA_FIFO_FREE(par->riva, Bitmap, 1);
-				for (i =3D 0; i < mod; i++)
-					((u8 *)&tmp)[i] =3D *cdat++;
-				reverse_order(&tmp);
-				d[i] =3D tmp;
-			}
+	width =3D (image->width + 31)/32;
+	size =3D width * image->height;
+	while (size >=3D 16) {
+		RIVA_FIFO_FREE(par->riva, Bitmap, 16);
+		for (i =3D 0; i < 16; i++) {
+			tmp =3D *((u32 *)cdat)++;
+			reverse_order(&tmp);
+			d[i] =3D tmp;
 		}
-	} else {
-		for (i =3D image->height; i > 0; i-=3D16) {
-			size =3D (i >=3D 16) ? 16 : i;
-			RIVA_FIFO_FREE(par->riva, Bitmap, size);
-			for (j =3D 0; j < size; j++) {
-				for (k =3D 0; k < width; k++)=20
-					((u8 *) &tmp)[k] =3D *cdat++;
-				reverse_order(&tmp);
-				d[j] =3D tmp;
-			}
+		size -=3D 16;
+	}
+	if (size) {
+		RIVA_FIFO_FREE(par->riva, Bitmap, size);
+		for (i =3D 0; i < size; i++) {
+			tmp =3D *((u32 *) cdat)++;
+			reverse_order(&tmp);
+			d[i] =3D tmp;
 		}
 	}
 }
@@ -1632,6 +1604,12 @@
=20
 	cmap_len =3D riva_get_cmap_len(&info->var);
 	fb_alloc_cmap(&info->cmap, cmap_len, 0);=09
+
+	info->pixmap.size =3D 64 * 1024;
+	info->pixmap.buf_align =3D 4;
+	info->pixmap.scan_align =3D 4;
+	info->pixmap.flags =3D FB_PIXMAP_SYSTEM;
+
 	return 0;
 }
=20
@@ -1776,6 +1754,11 @@
 	memset(info, 0, sizeof(struct fb_info));
 	memset(default_par, 0, sizeof(struct riva_par));
=20
+	info->pixmap.addr =3D kmalloc(64 * 1024, GFP_KERNEL);
+	if (info->pixmap.addr =3D=3D NULL)
+		goto err_out_kfree1;
+	memset(info->pixmap.addr, 0, 64 * 1024);
+
 	strcat(rivafb_fix.id, rci->name);
 	default_par->riva.Architecture =3D rci->arch_rev;
=20
@@ -1805,7 +1788,7 @@
 	if (!request_mem_region(rivafb_fix.mmio_start,
 				rivafb_fix.mmio_len, "rivafb")) {
 		printk(KERN_ERR PFX "cannot reserve MMIO region\n");
-		goto err_out_kfree;
+		goto err_out_kfree2;
 	}
=20
 	default_par->ctrl_base =3D ioremap(rivafb_fix.mmio_start,
@@ -1921,6 +1904,10 @@
 	iounmap(default_par->ctrl_base);
 err_out_free_base0:
 	release_mem_region(rivafb_fix.mmio_start, rivafb_fix.mmio_len);
+err_out_kfree2:
+	kfree(info->pixmap.addr);
+err_out_kfree1:
+	kfree(default_par);
 err_out_kfree:
 	kfree(info);
 err_out:
@@ -1954,6 +1941,7 @@
 		iounmap((caddr_t)par->riva.PRAMIN);
 		release_mem_region(info->fix.smem_start + 0x00C00000, 0x00008000);
 	}
+	kfree(info->pixmap.addr);
 	kfree(par);
 	kfree(info);
 	pci_set_drvdata(pd, NULL);

--=-Die+ArGiLoa5VLZlIj79--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
