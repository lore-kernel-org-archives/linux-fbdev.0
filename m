From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH] [FBDEV]: accel_putcs() buffer overflow fix
Date: 02 Jan 2003 21:34:39 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1041514436.1002.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>

1. If size of bitmap exceeds size of pixmap buffer, subdivide and do
multiple imageblits.

2. Use generic fb_pan_display() instead of info->fbops->fb_pan_display()
in update_var()

Diff is against linux-2.5.54.

Tony

diff -Naur linux-2.5.54/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.54/drivers/video/console/fbcon.c	2003-01-02 13:11:06.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2003-01-02 13:10:32.000000000 +0000
@@ -378,6 +378,7 @@
 	info->fbops->fb_fillrect(info, &region);
 }	
 
+#define FB_PIXMAPSIZE 8192
 void accel_putcs(struct vc_data *vc, struct display *p,
 			const unsigned short *s, int count, int yy, int xx)
 {
@@ -387,7 +388,7 @@
 	unsigned int cellsize = vc->vc_font.height * width;
 	struct fb_image image;
 	u16 c = scr_readw(s);
-	static u8 pixmap[8192];
+	static u8 pixmap[FB_PIXMAPSIZE];
 	
 	image.fg_color = attr_fgcol(p, c);
 	image.bg_color = attr_bgcol(p, c);
@@ -396,43 +397,47 @@
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-/*	pixmap = kmalloc((info->var.bits_per_pixel + 7) >> 3 *
-				vc->vc_font.height, GFP_KERNEL); 
-*/
-				
-	if (!(vc->vc_font.width & 7) && pixmap != NULL) {
-		unsigned int pitch = width * count, i, j;
+	if (!(vc->vc_font.width & 7)) {
+		unsigned int pitch, cnt, i, j, k;
+		unsigned int maxcnt = FB_PIXMAPSIZE/(vc->vc_font.height * width);
 		char *src, *dst, *dst0;
 
-		dst0 = pixmap;
-		image.width = vc->vc_font.width * count;
 		image.data = pixmap;
-		while (count--) {
-			src = p->fontdata + (scr_readw(s++) & charmask) * cellsize;
-			dst = dst0;
-			for (i = image.height; i--; ) {
-				for (j = 0; j < width; j++) 
-					dst[j] = *src++;
-				dst += pitch;
-			}
-			dst0 += width;
-		}
-		info->fbops->fb_imageblit(info, &image);
-		if (info->fbops->fb_sync)
-			info->fbops->fb_sync(info);
+		while (count) {
+			if (count > maxcnt) 
+				cnt = k = maxcnt;
+			else
+				cnt = k = count;
+			
+			dst0 = pixmap;
+			pitch = width * cnt;
+			image.width = vc->vc_font.width * cnt;
+			while (k--) {
+				src = p->fontdata + (scr_readw(s++)&charmask)*
+					cellsize;
+				dst = dst0;
+				for (i = image.height; i--; ) {
+					for (j = 0; j < width; j++) 
+						dst[j] = *src++;
+					dst += pitch;
+				}
+				dst0 += width;
+			}
+
+			info->fbops->fb_imageblit(info, &image);
+			image.dx += cnt * vc->vc_font.width;
+			count -= cnt;
+		}
 	} else {
 		image.width = vc->vc_font.width;
 		while (count--) {
 			image.data = p->fontdata + 
-				(scr_readw(s++) & charmask) * vc->vc_font.height * width;
+				(scr_readw(s++) & charmask) * 
+				vc->vc_font.height * width;
 			info->fbops->fb_imageblit(info, &image);
 			image.dx += vc->vc_font.width;
 		}	
 	}
-	/*
-	if (pixmap);
-		kfree(pixmap);
-	*/	
 }
 
 void accel_clear_margins(struct vc_data *vc, struct display *p,
@@ -1271,16 +1276,9 @@
 
 int update_var(int con, struct fb_info *info)
 {
-	int err;
+	if (con == info->currcon) 
+		return fb_pan_display(&info->var, info);
 
-	if (con == info->currcon) {
-		if (info->fbops->fb_pan_display) {
-			if ((err =
-			     info->fbops->fb_pan_display(&info->var,
-							 info)))
-				return err;
-		}
-	}
 	return 0;
 }
 
diff -Naur linux-2.5.54/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.5.54/drivers/video/fbmem.c	2003-01-02 13:10:54.000000000 +0000
+++ linux/drivers/video/fbmem.c	2003-01-02 13:10:18.000000000 +0000
@@ -1188,5 +1188,6 @@
 EXPORT_SYMBOL(fb_show_logo);
 EXPORT_SYMBOL(fb_set_var);
 EXPORT_SYMBOL(fb_blank);
+EXPORT_SYMBOL(fb_pan_display);
 
 MODULE_LICENSE("GPL");
