From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: add imageblit acceleration
	for Blade3D family
Date: Thu, 3 Jul 2008 18:47:17 +0200
Message-ID: <20080703184717.4125a274.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KERu0-0003cJ-NP for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Jul 2008 09:43:24 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KERty-0001Vr-QB
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Jul 2008 09:43:24 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add imageblit acceleration for the Blade3D family
of cores. The code is based on code from 
the cyblafb driver.

It is a step toward assimilating back the cyblafb driver
into the tridentfb driver. The cyblafb driver handles
a subfamily of the Trident Blade3d cores.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
diff -urp linux-old/drivers/video/tridentfb.c linux-mm/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-07-03 07:20:18.234182701 +0200
+++ linux-mm/drivers/video/tridentfb.c	2008-07-03 18:44:11.469138946 +0200
@@ -35,11 +35,12 @@ struct tridentfb_par {
 		(struct tridentfb_par *par, u32, u32, u32, u32, u32, u32);
 	void (*copy_rect)
 		(struct tridentfb_par *par, u32, u32, u32, u32, u32, u32);
+	void (*image_blit)
+		(struct tridentfb_par *par, const char*,
+		 u32, u32, u32, u32, u32, u32);
 	unsigned char eng_oper;	/* engine operation... */
 };
 
-static struct fb_ops tridentfb_ops;
-
 static struct fb_fix_screeninfo tridentfb_fix = {
 	.id = "Trident",
 	.type = FB_TYPE_PACKED_PIXELS,
@@ -212,6 +213,21 @@ static void blade_fill_rect(struct tride
 	writemmr(par, DST2, point(x + w - 1, y + h - 1));
 }
 
+static void blade_image_blit(struct tridentfb_par *par, const char *data,
+			     u32 x, u32 y, u32 w, u32 h, u32 c, u32 b)
+{
+	unsigned size = ((w + 31) >> 5) * h;
+
+	writemmr(par, COLOR, c);
+	writemmr(par, BGCOLOR, b);
+	writemmr(par, CMD, 0xa0000000 | 3 << 19);
+
+	writemmr(par, DST1, point(x, y));
+	writemmr(par, DST2, point(x + w - 1, y + h - 1));
+
+	memcpy(par->io_virt + 0x10000, data, 4 * size);
+}
+
 static void blade_copy_rect(struct tridentfb_par *par,
 			    u32 x1, u32 y1, u32 x2, u32 y2, u32 w, u32 h)
 {
@@ -497,6 +513,36 @@ static void tridentfb_fillrect(struct fb
 		       fr->height, col, fr->rop);
 }
 
+static void tridentfb_imageblit(struct fb_info *info,
+				const struct fb_image *img)
+{
+	struct tridentfb_par *par = info->par;
+	int col, bgcol;
+
+	if ((info->flags & FBINFO_HWACCEL_DISABLED) || img->depth != 1) {
+		cfb_imageblit(info, img);
+		return;
+	}
+	if (info->var.bits_per_pixel == 8) {
+		col = img->fg_color;
+		col |= col << 8;
+		col |= col << 16;
+		bgcol = img->bg_color;
+		bgcol |= bgcol << 8;
+		bgcol |= bgcol << 16;
+	} else {
+		col = ((u32 *)(info->pseudo_palette))[img->fg_color];
+		bgcol = ((u32 *)(info->pseudo_palette))[img->bg_color];
+	}
+
+	par->wait_engine(par);
+	if (par->image_blit)
+		par->image_blit(par, img->data, img->dx, img->dy,
+				img->width, img->height, col, bgcol);
+	else
+		cfb_imageblit(info, img);
+}
+
 static void tridentfb_copyarea(struct fb_info *info,
 			       const struct fb_copyarea *ca)
 {
@@ -522,6 +568,7 @@ static int tridentfb_sync(struct fb_info
 #else
 #define tridentfb_fillrect cfb_fillrect
 #define tridentfb_copyarea cfb_copyarea
+#define tridentfb_imageblit cfb_imageblit
 #endif /* CONFIG_FB_TRIDENT_ACCEL */
 
 /*
@@ -1285,7 +1332,7 @@ static struct fb_ops tridentfb_ops = {
 	.fb_set_par = tridentfb_set_par,
 	.fb_fillrect = tridentfb_fillrect,
 	.fb_copyarea = tridentfb_copyarea,
-	.fb_imageblit = cfb_imageblit,
+	.fb_imageblit = tridentfb_imageblit,
 #ifdef CONFIG_FB_TRIDENT_ACCEL
 	.fb_sync = tridentfb_sync,
 #endif
@@ -1369,6 +1416,7 @@ static int __devinit trident_pci_probe(s
 		default_par->wait_engine = blade_wait_engine;
 		default_par->fill_rect = blade_fill_rect;
 		default_par->copy_rect = blade_copy_rect;
+		default_par->image_blit = blade_image_blit;
 		tridentfb_fix.accel = FB_ACCEL_TRIDENT_BLADE3D;
 	} else if (chip3D) {			/* 3DImage family left */
 		default_par->init_accel = image_init_accel;
@@ -1446,6 +1494,29 @@ static int __devinit trident_pci_probe(s
 	} else
 		info->flags |= FBINFO_HWACCEL_DISABLED;
 
+	info->pixmap.addr = kmalloc(4096, GFP_KERNEL);
+	if (!info->pixmap.addr) {
+		err = -ENOMEM;
+		goto out_unmap2;
+	}
+
+	info->pixmap.size = 4096;
+	info->pixmap.buf_align = 4;
+	info->pixmap.scan_align = 1;
+	info->pixmap.access_align = 32;
+	info->pixmap.flags = FB_PIXMAP_SYSTEM;
+
+	if (default_par->image_blit) {
+		info->flags |= FBINFO_HWACCEL_IMAGEBLIT;
+		info->pixmap.scan_align = 4;
+	}
+
+	if (noaccel) {
+		printk(KERN_DEBUG "disabling acceleration\n");
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+		info->pixmap.scan_align = 1;
+	}
+
 	if (!fb_find_mode(&info->var, info,
 			  mode_option, NULL, 0, NULL, bpp)) {
 		err = -EINVAL;
@@ -1471,6 +1542,7 @@ static int __devinit trident_pci_probe(s
 	return 0;
 
 out_unmap2:
+	kfree(info->pixmap.addr);
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
@@ -1494,6 +1566,7 @@ static void __devexit trident_pci_remove
 	release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
 	release_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len);
 	pci_set_drvdata(dev, NULL);
+	kfree(info->pixmap.addr);
 	framebuffer_release(info);
 }
 
diff -urp linux-old/include/video/trident.h linux-mm/include/video/trident.h
--- linux-old/include/video/trident.h	2008-07-03 07:20:35.458174660 +0200
+++ linux-mm/include/video/trident.h	2008-07-02 20:52:46.726771811 +0200
@@ -135,6 +135,7 @@
 #define CMD	0x2144
 #define ROP	0x2148
 #define COLOR	0x2160
+#define BGCOLOR	0x2164
 #define SRC1	0x2100
 #define SRC2	0x2104
 #define DST1	0x2108

----------------------------------------------------------------------
Masz czas tylko do 10 lipca.
Przystap on-line do ING OFE!
Sprawdz >> http://link.interia.pl/f1e54


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
