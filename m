From: Antonino Daplas <adaplas@pol.net>
Subject: RFC: Optimizing putcs()
Date: 06 Aug 2002 06:04:19 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1028584418.556.29.camel@daplas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-5xc7sWHM0WKGzHwvVA6M"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17bpu4-000511-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 05 Aug 2002 15:00:40 -0700
Received: from AP-203.167.30.105.sysads.com (cwd105.compass.com.ph [203.167.30.105])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id GAA54244
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 6 Aug 2002 06:00:32 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>


--=-5xc7sWHM0WKGzHwvVA6M
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

With fbcon-accel and the new drawing functions in linux-2.5, console
performance degraded compared to the linux-2.4 implementation.  This is
because putcs() has to to do 1 fb_imageblit() per character to be
drawn.  

This can be optimized by letting putcs() initially construct the row of
text to be drawn into an offscreen buffer, then do a single
fb_imageblit() in the end.  Performance wil increase for several
reasons:

	1. Drawing can be done in "bursts" instead of "trickles"

	2. For drivers that support accelerated drawing functions, the
offscreen buffer can be optionally placed in graphics (or AGP) memory,
which is better suited for most hardware that can only do blit's from
video memory to video memory.
	
	3.  Some level of asynchronicity can be achieved, ie, the hardware can
be blitting while fbcon-accel is constructing bitmaps.  This would
require "walking" the offscreen buffer, and support for hardware
graphics sync'ing on demand.

I have included a patch for 2.5.27 that implements it in fbcon-accel. 
It's preliminary, but I have tested it with cfb_imageblit and with
hardware imageblit, with buffers in System or Video memory.  

The code is also present for hardware syncing on demand, though
unimplemented.

For drivers that uses cfb_imageblit or similar, a code such as the one
below can be inserted during initialization:

info->pixmap.addr = (unsigned long) kmalloc(BUFFER_SIZE, GFP_KERNEL);
info->pixmap.size = BUFFER_SIZE;
info->pixmap.offset = 0;
info->pixmap.buf_align = 1;
info->pixmap.scan_align = 1;

Some benchmarks:

time cat /usr/src/linux/MAINTAINERS (40K text file)
mode: 1024x768@8bpp, y-panning disabled.

cfb_imageblit - no offscreen buffer (default)

real    0m13.586s
user    0m0.001s
sys     0m13.585s

cfb_imageblit - with offscreen buffer in system memory

real    0m10.708s
user    0m0.001s
sys     0m10.707s

hardware imageblit - no offscreen buffer

real    0m6.036s
user    0m0.001s
sys     0m6.035s

hardware imageblit - with offscreen buffer in graphics memory

real    0m3.160s
user    0m0.001s
sys     0m3.160s

hardware imageblit - graphics offscreen buffer + hardware sync on demand

real    0m1.843s
user    0m0.000s
sys     0m1.843s

Tony

--=-5xc7sWHM0WKGzHwvVA6M
Content-Disposition: attachment; filename=fb-pixmap.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=fb-pixmap.diff; charset=ISO-8859-1

diff -Naur linux-2.5.27/drivers/video/fbcon-accel.c linux/drivers/video/fbc=
on-accel.c
--- linux-2.5.27/drivers/video/fbcon-accel.c	Mon Aug  5 21:15:56 2002
+++ linux/drivers/video/fbcon-accel.c	Mon Aug  5 21:17:22 2002
@@ -70,9 +70,47 @@
 	image.width =3D fontwidth(p);
 	image.height =3D fontheight(p);
 	image.depth =3D 1;
-	image.data =3D p->fontdata + (c & charmask)*fontheight(p)*width;
+	if (!info->pixmap.addr) {
+		image.data =3D p->fontdata + (c & charmask)*fontheight(p)*width;
+		info->fbops->fb_imageblit(info, &image);
+	}
+	else {
+		unsigned int d_size, d_pitch, i, j;=20
+		unsigned int scan_align =3D (info->pixmap.scan_align) ? info->pixmap.sca=
n_align - 1 : 0;
+		unsigned int buf_align =3D (info->pixmap.buf_align) ? info->pixmap.buf_a=
lign - 1 : 0;
+		char *d_addr, *s_addr;
+
+		d_pitch =3D (width + scan_align) & ~scan_align;
+		d_size =3D d_pitch * image.height;
+
+		if (d_size > info->pixmap.size) {
+			BUG();
+			return;
+		}
+	=09
+		info->pixmap.offset =3D (info->pixmap.offset + buf_align) & ~buf_align;
=20
-	info->fbops->fb_imageblit(info, &image);
+		if (info->pixmap.offset + d_size > info->pixmap.size) {
+#if 0
+			/* Some form of hardware sync'ing may be necessary here */
+			if (info->fbops->fb_sync)=20
+				info->fbops->fb_sync(info);
+#endif
+			info->pixmap.offset =3D 0;
+		}
+		s_addr =3D p->fontdata + (c & charmask)*fontheight(p)*width;
+		image.data =3D (char *) (info->pixmap.addr + info->pixmap.offset);
+		d_addr =3D image.data;
+
+		for (i =3D image.height; i--; ) {
+			for (j =3D 0; j < width; j++)=20
+				d_addr[j] =3D *s_addr++;
+			d_addr +=3D d_pitch;
+		}
+
+		info->fbops->fb_imageblit(info, &image);
+		info->pixmap.offset +=3D d_size;
+	}
 }
=20
 void fbcon_accel_putcs(struct vc_data *vc, struct display *p,
@@ -87,15 +125,61 @@
 	image.bg_color =3D attr_bgcol(p, *s);
 	image.dx =3D xx * fontwidth(p);
 	image.dy =3D yy * fontheight(p);
-	image.width =3D fontwidth(p);
 	image.height =3D fontheight(p);
 	image.depth =3D 1;
+	if (!info->pixmap.addr) {
+		image.width =3D fontwidth(p);
+		while (count--) {
+			image.data =3D p->fontdata +
+				(scr_readw(s++) & charmask) * fontheight(p) * width;
+			info->fbops->fb_imageblit(info, &image);
+			image.dx +=3D fontwidth(p);
+		}
+	}
+	else {
+		unsigned int d_pitch, d_size, i, j;=20
+		unsigned int scan_align =3D (info->pixmap.scan_align) ? info->pixmap.sca=
n_align - 1 : 0;
+		unsigned int buf_align =3D (info->pixmap.buf_align) ? info->pixmap.buf_a=
lign - 1 : 0;
+		char *s_addr, *d_addr, *d_addr0;
+
+		d_pitch =3D (width * count) + scan_align;
+		d_pitch &=3D ~scan_align;
+		d_size =3D d_pitch * image.height;
+
+		if (d_size > info->pixmap.size) {
+			BUG();
+			return;
+		}
+
+		info->pixmap.offset =3D (info->pixmap.offset + buf_align) & ~buf_align;
+
+		if (info->pixmap.offset + d_size > info->pixmap.size) {=20
+#if 0
+			/* Some form of hardware sync'ing may be necessary here */
+			if (info->fbops->fb_sync)
+				info->fbops->fb_sync(info);
+#endif
+			info->pixmap.offset =3D 0;
+		}
+
+		image.width =3D fontwidth(p) * count;
+		image.data =3D (char *) (info->pixmap.addr + info->pixmap.offset);
+		d_addr =3D image.data;
+
+		while (count--) {
+			s_addr =3D p->fontdata +=20
+				(scr_readw(s++) & charmask) * fontheight(p) * width;
+			d_addr0 =3D d_addr;
+			for (i =3D image.height; i--; ) {
+				for (j =3D 0; j < width; j++)
+					d_addr0[j] =3D *s_addr++;
+				d_addr0 +=3D d_pitch;
+			}
+			d_addr +=3D width;
+		}
=20
-	while (count--) {
-		image.data =3D p->fontdata +
-			(scr_readw(s++) & charmask) * fontheight(p) * width;
 		info->fbops->fb_imageblit(info, &image);
-		image.dx +=3D fontwidth(p);
+		info->pixmap.offset +=3D d_size;
 	}
 }
=20
diff -Naur linux-2.5.27/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.27/include/linux/fb.h	Mon Aug  5 21:16:16 2002
+++ linux/include/linux/fb.h	Mon Aug  5 21:17:48 2002
@@ -291,6 +291,14 @@
 	char  *data;	/* Pointer to image data */
 };
=20
+struct fb_pixmap {
+	__u32 addr;         /* buffer pointer (system or video), NULL if none */
+	__u32 offset;       /* offset to buffer */
+	__u32 size;         /* size of buffer */
+	__u32 buf_align;    /* buffer start alignment */
+	__u32 scan_align;   /* scanline alignment, should be <=3D buf_align */
+};
+
 #ifdef __KERNEL__
=20
 #if 1 /* to go away in 2.5.0 */
@@ -359,6 +367,10 @@
     int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area=
_struct *vma);
     /* switch to/from raster image mode */
     int (*fb_rasterimg)(struct fb_info *info, int start);
+#if 0=20
+    /* wait for blit idle, optional */
+    void (*fb_sync)(struct fb_info *info);	=20
+#endif
 };
=20
 struct fb_info {
@@ -371,6 +383,7 @@
    struct fb_fix_screeninfo fix;        /* Current fix */
    struct fb_monspecs monspecs;         /* Current Monitor specs */
    struct fb_cmap cmap;                 /* Current cmap */
+   struct fb_pixmap pixmap;             /* Offscreen pixmap */
    struct fb_ops *fbops;
    char *screen_base;                   /* Virtual address */
    struct display *disp;		/* initial display variable */

--=-5xc7sWHM0WKGzHwvVA6M--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
