From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm3fb: imageblit improved
Date: Wed, 13 Jun 2007 23:24:03 +0200
Message-ID: <46706073.9090501@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050704020008020008050706"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HyaIp-00076Z-Fw for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Jun 2007 14:22:55 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HyaIo-0004yo-Gm
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Jun 2007 14:22:55 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	13 Jun 2007 23:22:38 +0200
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050704020008020008050706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes the pm3_imageblit() restriction to blit only images with width divisable by 32.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires previous patches which added accelerated copyarea and fillrect.

--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-06-12 19:30:06.269593579 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-06-13 19:45:00.119603402 +0200
@@ -46,6 +46,8 @@
 #define DPRINTK(a,b...)
 #endif
 
+#define PM3_PIXMAP_SIZE	(2048 * 4)
+
 /*
  * Driver data
  */
@@ -513,7 +515,7 @@ static void pm3fb_imageblit(struct fb_in
 			bgx = par->palette[image->bg_color];
 			break;
 	}
-	if (image->depth != 1 || (image->width & 0x1f)) {
+	if (image->depth != 1) {
 		return cfb_imageblit(info, image);
 	}
 	if (info->var.bits_per_pixel == 8) {
@@ -525,18 +527,24 @@ static void pm3fb_imageblit(struct fb_in
 		bgx |= bgx << 16;
 	}
 
-	PM3_WAIT(par, 5);
+	PM3_WAIT(par, 7);
 
 	PM3_WRITE_REG(par, PM3ForegroundColor, fgx);
 	PM3_WRITE_REG(par, PM3BackgroundColor, bgx);
 
 	/* ROP Ox3 is GXcopy */
 	PM3_WRITE_REG(par, PM3Config2D,
+			PM3Config2D_UserScissorEnable |
 			PM3Config2D_UseConstantSource |
 			PM3Config2D_ForegroundROPEnable |
 			(PM3Config2D_ForegroundROP(0x3)) |
 			PM3Config2D_OpaqueSpan |
 			PM3Config2D_FBWriteEnable);
+	PM3_WRITE_REG(par, PM3ScissorMinXY,
+			((image->dy & 0x0fff) << 16) | (image->dx & 0x0fff));
+	PM3_WRITE_REG(par, PM3ScissorMaxXY,
+			(((image->dy + image->height) & 0x0fff) << 16) |
+			((image->dx + image->width) & 0x0fff));
 	PM3_WRITE_REG(par, PM3RectanglePosition,
 			(PM3RectanglePosition_XOffset(image->dx)) |
 			(PM3RectanglePosition_YOffset(image->dy)));
@@ -550,7 +558,8 @@ static void pm3fb_imageblit(struct fb_in
 
 
 	while (height--) {
-		u32 width = (image->width + 31) >> 5;
+		int width = ((image->width + 7) >> 3) + info->pixmap.scan_align;
+		width >>= 2;
 
 		while (width >= PM3_FIFO_SIZE) {
 			int i = PM3_FIFO_SIZE - 1;
@@ -1240,6 +1249,17 @@ static int __devinit pm3fb_probe(struct 
 			FBINFO_HWACCEL_IMAGEBLIT |
 			FBINFO_HWACCEL_FILLRECT;
 
+	info->pixmap.addr = kmalloc(PM3_PIXMAP_SIZE, GFP_KERNEL);
+	if (!info->pixmap.addr) {
+		retval = -ENOMEM;
+		goto err_exit_pixmap;
+	}
+	info->pixmap.size = PM3_PIXMAP_SIZE;
+	info->pixmap.buf_align = 4;
+	info->pixmap.scan_align = 4;
+	info->pixmap.access_align = 32;
+	info->pixmap.flags = FB_PIXMAP_SYSTEM;
+
 	/*
 	 * This should give a reasonable default video mode. The following is
 	 * done when we can set a video mode.
@@ -1276,6 +1296,8 @@ static int __devinit pm3fb_probe(struct 
  err_exit_all:
 	fb_dealloc_cmap(&info->cmap);
  err_exit_both:
+	kfree(info->pixmap.addr);
+ err_exit_pixmap:
 	iounmap(info->screen_base);
 	release_mem_region(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
  err_exit_mmio:
@@ -1306,6 +1328,7 @@ static void __devexit pm3fb_remove(struc
 		release_mem_region(fix->mmio_start, fix->mmio_len);
 
 		pci_set_drvdata(dev, NULL);
+		kfree(info->pixmap.addr);
 		framebuffer_release(info);
 	}
 }

--------------050704020008020008050706
Content-Type: text/plain;
 name="pm3fb-imageblit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm3fb-imageblit.diff"

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes pm3_imageblit restriction to blit only images with width divisable by 32.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires previous patches which added accelerated copyarea and fillrect.

--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-06-12 19:30:06.269593579 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-06-13 19:45:00.119603402 +0200
@@ -46,6 +46,8 @@
 #define DPRINTK(a,b...)
 #endif
 
+#define PM3_PIXMAP_SIZE	(2048 * 4)
+
 /*
  * Driver data
  */
@@ -513,7 +515,7 @@ static void pm3fb_imageblit(struct fb_in
 			bgx = par->palette[image->bg_color];
 			break;
 	}
-	if (image->depth != 1 || (image->width & 0x1f)) {
+	if (image->depth != 1) {
 		return cfb_imageblit(info, image);
 	}
 	if (info->var.bits_per_pixel == 8) {
@@ -525,18 +527,24 @@ static void pm3fb_imageblit(struct fb_in
 		bgx |= bgx << 16;
 	}
 
-	PM3_WAIT(par, 5);
+	PM3_WAIT(par, 7);
 
 	PM3_WRITE_REG(par, PM3ForegroundColor, fgx);
 	PM3_WRITE_REG(par, PM3BackgroundColor, bgx);
 
 	/* ROP Ox3 is GXcopy */
 	PM3_WRITE_REG(par, PM3Config2D,
+			PM3Config2D_UserScissorEnable |
 			PM3Config2D_UseConstantSource |
 			PM3Config2D_ForegroundROPEnable |
 			(PM3Config2D_ForegroundROP(0x3)) |
 			PM3Config2D_OpaqueSpan |
 			PM3Config2D_FBWriteEnable);
+	PM3_WRITE_REG(par, PM3ScissorMinXY,
+			((image->dy & 0x0fff) << 16) | (image->dx & 0x0fff));
+	PM3_WRITE_REG(par, PM3ScissorMaxXY,
+			(((image->dy + image->height) & 0x0fff) << 16) |
+			((image->dx + image->width) & 0x0fff));
 	PM3_WRITE_REG(par, PM3RectanglePosition,
 			(PM3RectanglePosition_XOffset(image->dx)) |
 			(PM3RectanglePosition_YOffset(image->dy)));
@@ -550,7 +558,8 @@ static void pm3fb_imageblit(struct fb_in
 
 
 	while (height--) {
-		u32 width = (image->width + 31) >> 5;
+		int width = ((image->width + 7) >> 3) + info->pixmap.scan_align;
+		width >>= 2;
 
 		while (width >= PM3_FIFO_SIZE) {
 			int i = PM3_FIFO_SIZE - 1;
@@ -1240,6 +1249,17 @@ static int __devinit pm3fb_probe(struct 
 			FBINFO_HWACCEL_IMAGEBLIT |
 			FBINFO_HWACCEL_FILLRECT;
 
+	info->pixmap.addr = kmalloc(PM3_PIXMAP_SIZE, GFP_KERNEL);
+	if (!info->pixmap.addr) {
+		retval = -ENOMEM;
+		goto err_exit_pixmap;
+	}
+	info->pixmap.size = PM3_PIXMAP_SIZE;
+	info->pixmap.buf_align = 4;
+	info->pixmap.scan_align = 4;
+	info->pixmap.access_align = 32;
+	info->pixmap.flags = FB_PIXMAP_SYSTEM;
+
 	/*
 	 * This should give a reasonable default video mode. The following is
 	 * done when we can set a video mode.
@@ -1276,6 +1296,8 @@ static int __devinit pm3fb_probe(struct 
  err_exit_all:
 	fb_dealloc_cmap(&info->cmap);
  err_exit_both:
+	kfree(info->pixmap.addr);
+ err_exit_pixmap:
 	iounmap(info->screen_base);
 	release_mem_region(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
  err_exit_mmio:
@@ -1306,6 +1328,7 @@ static void __devexit pm3fb_remove(struc
 		release_mem_region(fix->mmio_start, fix->mmio_len);
 
 		pci_set_drvdata(dev, NULL);
+		kfree(info->pixmap.addr);
 		framebuffer_release(info);
 	}
 }

--------------050704020008020008050706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------050704020008020008050706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------050704020008020008050706--
