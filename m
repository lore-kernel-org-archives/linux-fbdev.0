From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: kernel: matrox fb - missing files,
	doesn't compile
Date: 27 Dec 2002 23:02:05 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041001322.992.13.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0212220943000.11631-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Rw9j-00020V-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Dec 2002 07:12:11 -0800
In-Reply-To: <Pine.GSO.4.21.0212220943000.11631-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Sun, 2002-12-22 at 16:44, Geert Uytterhoeven wrote:
> On 15 Dec 2002, Antonino Daplas wrote:
> > On Sun, 2002-12-15 at 03:44, Petr Vandrovec wrote:
> > > What if I'll decide to paint characters through busmastering? Then
> > > I need font data in buffers allocated by pci_alloc_consistent...
> > > In the past it was not a win to use busmastering, but now, when
> > > upper layers might prepare images much larger than 8x16, it may be 
> > > worth of rechecking that...
> > 
> > True, using kmalloc() to cache a good-sized pixmap is probably not the
> > best idea in all cases (in my case, it is best when the pixmap is in
> > graphics memory). I submitted a proposal before that allows more
> > flexibility: it will let the drivers decide on how it wants the buffers
> > allocated, the size of the buffer, specific alignment requirements, or
> > if it even actually needs one. Other driver-specific needs can probably
> > be added if necessary.
> 
> Add address/size fields in fb_info to let the driver tell it already allocated
> a suitable buffer? If those are NULL, fbcon can fall back to its own buffer
> (e.g. static and fixed 8 kiB buffer).
> 

How about the following?

Drivers can choose to fill up the fb_pixmap structure for
device-specific buffer requirements:


#define FB_PIXMAP_SYSMEM    0
#define FB_PIXMAP_IOMEM     1

struct fb_pixmap {
	__u32 loc;              /* location of buffer */
	__u8  *addr;            /* address of buffer */
	__u32 size;             /* size of buffer */
	__u32 align;            /* byte alignment per scanline */
};

Drivers can allocate the buffer in system memory (FB_PIXMAP_SYSMEM) or
io/graphics memory (FB_PIXMAP_IOMEM) and specify the alignment of each
line of pixels.  Otherwise, accel_putcs will default to using the
statically allocated buffer with a 1-byte alignment per scanline.

Attached is a patch against 2.5.52. Other changes:  

call fb_sync() if framebuffer memory is to be accessed (cfb_* drawing
functions, fb_read and fb_write).

Tony

diff -Nuar linux-2.4.52/drivers/video/cfbcopyarea.c linux/drivers/video/cfbcopyarea.c
--- linux-2.4.52/drivers/video/cfbcopyarea.c	2002-12-27 14:39:27.000000000 +0000
+++ linux/drivers/video/cfbcopyarea.c	2002-12-27 14:38:27.000000000 +0000
@@ -375,6 +375,9 @@
 	dst_idx += area->dy*next_line*8 + area->dx*p->var.bits_per_pixel;
 	src_idx += area->sy*next_line*8 + area->sx*p->var.bits_per_pixel;
 	
+	if (p->fbops->fb_sync)
+		p->fbops->fb_sync(p);
+
 	if (rev_copy) {
 		while (area->height--) {
 			dst_idx -= next_line*8;
diff -Nuar linux-2.4.52/drivers/video/cfbfillrect.c linux/drivers/video/cfbfillrect.c
--- linux-2.4.52/drivers/video/cfbfillrect.c	2002-12-27 14:39:30.000000000 +0000
+++ linux/drivers/video/cfbfillrect.c	2002-12-27 14:38:32.000000000 +0000
@@ -397,6 +397,10 @@
 	dst_idx += rect->dy*p->fix.line_length*8+rect->dx*bpp;
 	/* FIXME For now we support 1-32 bpp only */
 	left = BITS_PER_LONG % bpp;
+
+	if (p->fbops->fb_sync)
+		p->fbops->fb_sync(p);
+
 	if (!left) {
 		u32 pat = pixel_to_pat32(p, fg);
 		void (*fill_op32)(unsigned long *dst, int dst_idx, u32 pat, u32 n) = NULL;
diff -Nuar linux-2.4.52/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.4.52/drivers/video/cfbimgblt.c	2002-12-27 14:39:23.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2002-12-27 14:38:22.000000000 +0000
@@ -322,6 +322,9 @@
 	bitstart &= ~(bpl - 1);
 	dst1 = p->screen_base + bitstart;
 
+	if (p->fbops->fb_sync)
+		p->fbops->fb_sync(p);
+
 	if (image->depth == 1) {
 		if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 		    p->fix.visual == FB_VISUAL_DIRECTCOLOR) {
diff -Nuar linux-2.4.52/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.4.52/drivers/video/console/fbcon.c	2002-12-27 14:39:13.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2002-12-27 14:38:09.000000000 +0000
@@ -378,16 +378,26 @@
 	info->fbops->fb_fillrect(info, &region);
 }	
 
+static inline void syswriteb(u8 val, u8 *addr)
+{
+	*addr = val;
+}
+
+static inline void iowriteb(u8 val, u8 *addr) 
+{
+	fb_writeb(val, addr);
+}
+
 void accel_putcs(struct vc_data *vc, struct display *p,
 			const unsigned short *s, int count, int yy, int xx)
 {
+	static char pixmap[8192];
 	struct fb_info *info = p->fb_info;
 	unsigned short charmask = p->charmask;
 	unsigned int width = ((vc->vc_font.width + 7)/8);
 	unsigned int cellsize = vc->vc_font.height * width;
 	struct fb_image image;
 	u16 c = scr_readw(s);
-	static u8 pixmap[8192];
 	
 	image.fg_color = attr_fgcol(p, c);
 	image.bg_color = attr_bgcol(p, c);
@@ -396,30 +406,60 @@
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-/*	pixmap = kmalloc((info->var.bits_per_pixel + 7) >> 3 *
-				vc->vc_font.height, GFP_KERNEL); 
-*/
-				
-	if (!(vc->vc_font.width & 7) && pixmap != NULL) {
-		unsigned int pitch = width * count, i, j;
+	if (!(vc->vc_font.width & 7)) {
+		unsigned int pitch, i, j;
 		char *src, *dst, *dst0;
+		void (*write_op)(u8 val, u8 *addr) = syswriteb;
+
+		if (info->pixmap.addr != NULL) {
+			unsigned int align = (info->pixmap.align) ?
+				info->pixmap.align - 1 : 0;
+
+			pitch = (width * count + align) & ~(align);
+			if (pitch * vc->vc_font.height > info->pixmap.size)
+				/* 
+				 * FIXME: do multiple blit's instead
+				 *        of exiting
+				 */
+				return;
+
+			dst0 = info->pixmap.addr;
+			image.data = info->pixmap.addr;
+			switch (info->pixmap.loc) {
+			case FB_PIXMAP_IOMEM:
+				write_op = iowriteb;
+				break;
+			case FB_PIXMAP_SYSMEM:
+			default:
+				write_op = syswriteb;
+				break;
+			}
+		}
+		else {
+			pitch = width * count;
+			dst0 = pixmap;
+			image.data = pixmap;
+			if (pitch * vc->vc_font.height > 8192) 
+				/* 
+				 * FIXME: do multiple blit's instead
+				 *        of exiting
+				 */
+				return;
+		}
 
-		dst0 = pixmap;
 		image.width = vc->vc_font.width * count;
-		image.data = pixmap;
 		while (count--) {
 			src = p->fontdata + (scr_readw(s++) & charmask) * cellsize;
 			dst = dst0;
 			for (i = image.height; i--; ) {
 				for (j = 0; j < width; j++) 
-					dst[j] = *src++;
+					write_op(*src++, dst + j);
 				dst += pitch;
 			}
 			dst0 += width;
 		}
 		info->fbops->fb_imageblit(info, &image);
-		if (info->fbops->fb_sync)
-			info->fbops->fb_sync(info);
+		
 	} else {
 		image.width = vc->vc_font.width;
 		while (count--) {
@@ -429,10 +469,6 @@
 			image.dx += vc->vc_font.width;
 		}	
 	}
-	/*
-	if (pixmap);
-		kfree(pixmap);
-	*/	
 }
 
 void accel_clear_margins(struct vc_data *vc, struct display *p,
diff -Nuar linux-2.4.52/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.4.52/drivers/video/fbmem.c	2002-12-27 14:39:19.000000000 +0000
+++ linux/drivers/video/fbmem.c	2002-12-27 14:41:30.000000000 +0000
@@ -392,6 +392,9 @@
 	if (!info || ! info->screen_base)
 		return -ENODEV;
 
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
+
 	if (info->fbops->fb_read)
 		return info->fbops->fb_read(file, buf, count, ppos);
 	
@@ -425,6 +428,9 @@
 	if (!info || !info->screen_base)
 		return -ENODEV;
 
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
+
 	if (info->fbops->fb_write)
 		return info->fbops->fb_write(file, buf, count, ppos);
 	
diff -Nuar linux-2.4.52/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.4.52/include/linux/fb.h	2002-12-27 14:39:43.000000000 +0000
+++ linux/include/linux/fb.h	2002-12-27 14:41:31.000000000 +0000
@@ -294,6 +294,16 @@
 	struct fb_cmap cmap;	/* color map info */
 };
 
+#define FB_PIXMAP_SYSMEM    0
+#define FB_PIXMAP_IOMEM     1
+
+struct fb_pixmap {
+	__u32 loc;              /* location of buffer */
+	__u8  *addr;            /* address of buffer */
+	__u32 size;             /* size of buffer */
+	__u32 align;            /* byte alignment per scanline */
+};
+
 /*
  * hardware cursor control
  */
@@ -386,6 +396,7 @@
    struct fb_monspecs monspecs;         /* Current Monitor specs */
    struct fb_cursor cursor;		/* Current cursor */	
    struct fb_cmap cmap;                 /* Current cmap */
+   struct fb_pixmap pixmap;             /* Current pixmap */
    struct fb_ops *fbops;
    char *screen_base;                   /* Virtual address */
    struct vc_data *display_fg;		/* Console visible on this display */




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
