From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: accelerated imageblit
Date: Thu, 21 Jun 2007 17:21:34 +0200
Message-ID: <467A977E.5070105@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070802000806090206020202"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I1ORi-0003NQ-0X for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Jun 2007 08:19:42 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I1ORc-0006sk-VX
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Jun 2007 08:19:41 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	21 Jun 2007 17:19:30 +0200
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
--------------070802000806090206020202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds accelerated imageblit function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This patch requires all previous pm2fb patches I sent to the list (and one from the current mm tree).

Tony, please do not knock down my pm3fb patches because they do not apply cleanly. They do apply correctly (I have checked it). The mistake is due to the Adrian Bunk's patch which I forgot to use.

Regards,
Krzysztof


--- linux-2.6.21/drivers/video/pm2fb.c	2007-06-21 16:55:22.143307171 +0200
+++ linux-2.6.22/drivers/video/pm2fb.c	2007-06-21 17:10:14.194142205 +0200
@@ -60,6 +60,8 @@
 #define DPRINTK(a,b...)
 #endif
 
+#define PM2_PIXMAP_SIZE	(1600 * 4)
+
 /*
  * Driver data
  */
@@ -1166,6 +1168,104 @@ static void pm2fb_copyarea(struct fb_inf
 			modded.width, modded.height, 0);
 }
 
+static void pm2fb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+	struct pm2fb_par *par = info->par;
+	u32 height = image->height;
+	u32 fgx, bgx;
+	const u32 *src = (const u32*)image->data;
+	u32 xres = (info->var.xres + 31) & ~31;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if (info->flags & FBINFO_HWACCEL_DISABLED || image->depth != 1) {
+		cfb_imageblit(info, image);
+		return;
+	}
+	switch (info->fix.visual) {
+		case FB_VISUAL_PSEUDOCOLOR:
+			fgx = image->fg_color;
+			bgx = image->bg_color;
+			break;
+		case FB_VISUAL_TRUECOLOR:
+		default:
+			fgx = par->palette[image->fg_color];
+			bgx = par->palette[image->bg_color];
+			break;
+	}
+	if (info->var.bits_per_pixel == 8) {
+		fgx |= fgx << 8;
+		bgx |= bgx << 8;
+	}
+	if (info->var.bits_per_pixel <= 16) {
+		fgx |= fgx << 16;
+		bgx |= bgx << 16;
+	}
+
+	WAIT_FIFO(par, 13);
+	pm2_WR(par, PM2R_FB_READ_MODE, partprod(xres));
+	pm2_WR(par, PM2R_SCISSOR_MIN_XY,
+			((image->dy & 0xfff) << 16) | (image->dx & 0x0fff));
+	pm2_WR(par, PM2R_SCISSOR_MAX_XY,
+			(((image->dy + image->height) & 0x0fff) << 16) |
+			((image->dx + image->width) & 0x0fff));
+	pm2_WR(par, PM2R_SCISSOR_MODE, 1);
+	/* GXcopy & UNIT_ENABLE */
+	pm2_WR(par, PM2R_LOGICAL_OP_MODE, (0x3 << 1) | 1 );
+	pm2_WR(par, PM2R_RECTANGLE_ORIGIN,
+			((image->dy & 0xfff) << 16) | (image->dx & 0x0fff));
+	pm2_WR(par, PM2R_RECTANGLE_SIZE,
+			((image->height & 0x0fff) << 16) |
+			((image->width) & 0x0fff));
+	if (info->var.bits_per_pixel == 24) {
+		pm2_WR(par, PM2R_COLOR_DDA_MODE, 1);
+		/* clear area */
+		pm2_WR(par, PM2R_CONSTANT_COLOR, bgx);
+		pm2_WR(par, PM2R_RENDER,
+			PM2F_RENDER_RECTANGLE |
+			PM2F_INCREASE_X | PM2F_INCREASE_Y );
+		/* BitMapPackEachScanline & invert bits and byte order*/
+		/* force background */
+		pm2_WR(par, PM2R_RASTERIZER_MODE,  (1<<9) | 1 | (3<<7));
+		pm2_WR(par, PM2R_CONSTANT_COLOR, fgx);
+		pm2_WR(par, PM2R_RENDER,
+			PM2F_RENDER_RECTANGLE |
+			PM2F_INCREASE_X | PM2F_INCREASE_Y |
+			PM2F_RENDER_SYNC_ON_BIT_MASK);
+	} else {
+		pm2_WR(par, PM2R_COLOR_DDA_MODE, 0);
+		/* clear area */
+		pm2_WR(par, PM2R_FB_BLOCK_COLOR, bgx);
+		pm2_WR(par, PM2R_RENDER,
+			PM2F_RENDER_RECTANGLE |
+			PM2F_RENDER_FASTFILL |
+			PM2F_INCREASE_X | PM2F_INCREASE_Y );
+		/* invert bits and byte order*/
+		pm2_WR(par, PM2R_RASTERIZER_MODE,  1 | (3<<7) );
+		pm2_WR(par, PM2R_FB_BLOCK_COLOR, fgx);
+		pm2_WR(par, PM2R_RENDER,
+			PM2F_RENDER_RECTANGLE |
+			PM2F_INCREASE_X | PM2F_INCREASE_Y |
+			PM2F_RENDER_FASTFILL |
+			PM2F_RENDER_SYNC_ON_BIT_MASK);
+	}
+
+	while (height--) {
+		int width = ((image->width + 7) >> 3)
+				+ info->pixmap.scan_align - 1;
+		width >>= 2;
+		WAIT_FIFO(par, width);
+		while (width--) {
+			pm2_WR(par, PM2R_BIT_MASK_PATTERN, *src);
+			src++;
+		}
+	}
+	WAIT_FIFO(par, 3);
+	pm2_WR(par, PM2R_RASTERIZER_MODE, 0);
+	pm2_WR(par, PM2R_COLOR_DDA_MODE, 0);
+	pm2_WR(par, PM2R_SCISSOR_MODE, 0);
+}
+
 /* ------------ Hardware Independent Functions ------------ */
 
 /*
@@ -1181,7 +1281,7 @@ static struct fb_ops pm2fb_ops = {
 	.fb_pan_display	= pm2fb_pan_display,
 	.fb_fillrect	= pm2fb_fillrect,
 	.fb_copyarea	= pm2fb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
+	.fb_imageblit	= pm2fb_imageblit,
 	.fb_sync	= pm2fb_sync,
 };
 
@@ -1340,11 +1440,24 @@ static int __devinit pm2fb_probe(struct 
 	info->flags		= FBINFO_DEFAULT |
 				  FBINFO_HWACCEL_YPAN |
 				  FBINFO_HWACCEL_COPYAREA |
+				  FBINFO_HWACCEL_IMAGEBLIT |
 				  FBINFO_HWACCEL_FILLRECT;
 
+	info->pixmap.addr = kmalloc(PM2_PIXMAP_SIZE, GFP_KERNEL);
+	if (!info->pixmap.addr) {
+		err_retval = -ENOMEM;
+		goto err_exit_pixmap;
+	}
+	info->pixmap.size = PM2_PIXMAP_SIZE;
+	info->pixmap.buf_align = 4;
+	info->pixmap.scan_align = 4;
+	info->pixmap.access_align = 32;
+	info->pixmap.flags = FB_PIXMAP_SYSTEM;
+
 	if (noaccel) {
-	    	printk(KERN_DEBUG "disabling acceleration\n");
-  		info->flags |= FBINFO_HWACCEL_DISABLED;
+		printk(KERN_DEBUG "disabling acceleration\n");
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+		info->pixmap.scan_align = 1;
 	}
 
 	if (!mode)
@@ -1373,6 +1486,8 @@ static int __devinit pm2fb_probe(struct 
  err_exit_all:
 	fb_dealloc_cmap(&info->cmap);
  err_exit_both:
+	kfree(info->pixmap.addr);
+ err_exit_pixmap:
 	iounmap(info->screen_base);
 	release_mem_region(pm2fb_fix.smem_start, pm2fb_fix.smem_len);
  err_exit_mmio:
@@ -1409,6 +1524,8 @@ static void __devexit pm2fb_remove(struc
 	release_mem_region(fix->mmio_start, fix->mmio_len);
 
 	pci_set_drvdata(pdev, NULL);
+	if (info->pixmap.addr)
+		kfree(info->pixmap.addr);
 	kfree(info);
 }
 
--- linux-2.6.21/include/video/permedia2.h	2007-06-21 16:40:54.593868383 +0200
+++ linux-2.6.22/include/video/permedia2.h	2007-06-19 23:47:48.938974026 +0200
@@ -68,11 +68,14 @@
 #define PM2R_D_Y					0x8028
 #define PM2R_COUNT					0x8030
 #define PM2R_RENDER					0x8038
+#define PM2R_BIT_MASK_PATTERN				0x8068
 #define PM2R_RASTERIZER_MODE				0x80a0
 #define PM2R_RECTANGLE_ORIGIN				0x80d0
 #define PM2R_RECTANGLE_SIZE				0x80d8
 #define PM2R_PACKED_DATA_LIMITS				0x8150
 #define PM2R_SCISSOR_MODE				0x8180
+#define PM2R_SCISSOR_MIN_XY				0x8188
+#define PM2R_SCISSOR_MAX_XY				0x8190
 #define PM2R_SCREEN_SIZE				0x8198
 #define PM2R_AREA_STIPPLE_MODE				0x81a0
 #define PM2R_WINDOW_ORIGIN				0x81c8
@@ -83,7 +86,9 @@
 #define PM2R_TEXEL_LUT_MODE				0x8678
 #define PM2R_TEXTURE_COLOR_MODE				0x8680
 #define PM2R_FOG_MODE					0x8690
+#define PM2R_TEXEL0					0x8760
 #define PM2R_COLOR_DDA_MODE				0x87e0
+#define PM2R_CONSTANT_COLOR				0x87e8
 #define PM2R_ALPHA_BLEND_MODE				0x8810
 #define PM2R_DITHER_MODE				0x8818
 #define PM2R_FB_SOFT_WRITE_MASK				0x8820
@@ -169,6 +174,8 @@
 #define PM2F_RENDER_TRAPEZOID				(1L<<6)
 #define PM2F_RENDER_POINT				(2L<<6)
 #define PM2F_RENDER_RECTANGLE				(3L<<6)
+#define PM2F_RENDER_SYNC_ON_BIT_MASK			(1L<<11)
+#define PM2F_RENDER_TEXTURE_ENABLE			(1L<<13)
 #define PM2F_SYNCHRONIZATION				(1L<<10)
 #define PM2F_PLL_LOCKED					0x10
 #define PM2F_BEING_RESET				(1L<<31)

--------------070802000806090206020202
Content-Type: text/plain;
 name="pm2fb-imageblit-full.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm2fb-imageblit-full.diff"

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds accelerated imageblit function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This patch requires all previous pm2fb patches I sent to the list (and one from the mm tree).

--- linux-2.6.21/drivers/video/pm2fb.c	2007-06-21 16:55:22.143307171 +0200
+++ linux-2.6.22/drivers/video/pm2fb.c	2007-06-21 17:10:14.194142205 +0200
@@ -60,6 +60,8 @@
 #define DPRINTK(a,b...)
 #endif
 
+#define PM2_PIXMAP_SIZE	(1600 * 4)
+
 /*
  * Driver data
  */
@@ -1166,6 +1168,104 @@ static void pm2fb_copyarea(struct fb_inf
 			modded.width, modded.height, 0);
 }
 
+static void pm2fb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+	struct pm2fb_par *par = info->par;
+	u32 height = image->height;
+	u32 fgx, bgx;
+	const u32 *src = (const u32*)image->data;
+	u32 xres = (info->var.xres + 31) & ~31;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if (info->flags & FBINFO_HWACCEL_DISABLED || image->depth != 1) {
+		cfb_imageblit(info, image);
+		return;
+	}
+	switch (info->fix.visual) {
+		case FB_VISUAL_PSEUDOCOLOR:
+			fgx = image->fg_color;
+			bgx = image->bg_color;
+			break;
+		case FB_VISUAL_TRUECOLOR:
+		default:
+			fgx = par->palette[image->fg_color];
+			bgx = par->palette[image->bg_color];
+			break;
+	}
+	if (info->var.bits_per_pixel == 8) {
+		fgx |= fgx << 8;
+		bgx |= bgx << 8;
+	}
+	if (info->var.bits_per_pixel <= 16) {
+		fgx |= fgx << 16;
+		bgx |= bgx << 16;
+	}
+
+	WAIT_FIFO(par, 13);
+	pm2_WR(par, PM2R_FB_READ_MODE, partprod(xres));
+	pm2_WR(par, PM2R_SCISSOR_MIN_XY,
+			((image->dy & 0xfff) << 16) | (image->dx & 0x0fff));
+	pm2_WR(par, PM2R_SCISSOR_MAX_XY,
+			(((image->dy + image->height) & 0x0fff) << 16) |
+			((image->dx + image->width) & 0x0fff));
+	pm2_WR(par, PM2R_SCISSOR_MODE, 1);
+	/* GXcopy & UNIT_ENABLE */
+	pm2_WR(par, PM2R_LOGICAL_OP_MODE, (0x3 << 1) | 1 );
+	pm2_WR(par, PM2R_RECTANGLE_ORIGIN,
+			((image->dy & 0xfff) << 16) | (image->dx & 0x0fff));
+	pm2_WR(par, PM2R_RECTANGLE_SIZE,
+			((image->height & 0x0fff) << 16) |
+			((image->width) & 0x0fff));
+	if (info->var.bits_per_pixel == 24) {
+		pm2_WR(par, PM2R_COLOR_DDA_MODE, 1);
+		/* clear area */
+		pm2_WR(par, PM2R_CONSTANT_COLOR, bgx);
+		pm2_WR(par, PM2R_RENDER,
+			PM2F_RENDER_RECTANGLE |
+			PM2F_INCREASE_X | PM2F_INCREASE_Y );
+		/* BitMapPackEachScanline & invert bits and byte order*/
+		/* force background */
+		pm2_WR(par, PM2R_RASTERIZER_MODE,  (1<<9) | 1 | (3<<7));
+		pm2_WR(par, PM2R_CONSTANT_COLOR, fgx);
+		pm2_WR(par, PM2R_RENDER,
+			PM2F_RENDER_RECTANGLE |
+			PM2F_INCREASE_X | PM2F_INCREASE_Y |
+			PM2F_RENDER_SYNC_ON_BIT_MASK);
+	} else {
+		pm2_WR(par, PM2R_COLOR_DDA_MODE, 0);
+		/* clear area */
+		pm2_WR(par, PM2R_FB_BLOCK_COLOR, bgx);
+		pm2_WR(par, PM2R_RENDER,
+			PM2F_RENDER_RECTANGLE |
+			PM2F_RENDER_FASTFILL |
+			PM2F_INCREASE_X | PM2F_INCREASE_Y );
+		/* invert bits and byte order*/
+		pm2_WR(par, PM2R_RASTERIZER_MODE,  1 | (3<<7) );
+		pm2_WR(par, PM2R_FB_BLOCK_COLOR, fgx);
+		pm2_WR(par, PM2R_RENDER,
+			PM2F_RENDER_RECTANGLE |
+			PM2F_INCREASE_X | PM2F_INCREASE_Y |
+			PM2F_RENDER_FASTFILL |
+			PM2F_RENDER_SYNC_ON_BIT_MASK);
+	}
+
+	while (height--) {
+		int width = ((image->width + 7) >> 3)
+				+ info->pixmap.scan_align - 1;
+		width >>= 2;
+		WAIT_FIFO(par, width);
+		while (width--) {
+			pm2_WR(par, PM2R_BIT_MASK_PATTERN, *src);
+			src++;
+		}
+	}
+	WAIT_FIFO(par, 3);
+	pm2_WR(par, PM2R_RASTERIZER_MODE, 0);
+	pm2_WR(par, PM2R_COLOR_DDA_MODE, 0);
+	pm2_WR(par, PM2R_SCISSOR_MODE, 0);
+}
+
 /* ------------ Hardware Independent Functions ------------ */
 
 /*
@@ -1181,7 +1281,7 @@ static struct fb_ops pm2fb_ops = {
 	.fb_pan_display	= pm2fb_pan_display,
 	.fb_fillrect	= pm2fb_fillrect,
 	.fb_copyarea	= pm2fb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
+	.fb_imageblit	= pm2fb_imageblit,
 	.fb_sync	= pm2fb_sync,
 };
 
@@ -1340,11 +1440,24 @@ static int __devinit pm2fb_probe(struct 
 	info->flags		= FBINFO_DEFAULT |
 				  FBINFO_HWACCEL_YPAN |
 				  FBINFO_HWACCEL_COPYAREA |
+				  FBINFO_HWACCEL_IMAGEBLIT |
 				  FBINFO_HWACCEL_FILLRECT;
 
+	info->pixmap.addr = kmalloc(PM2_PIXMAP_SIZE, GFP_KERNEL);
+	if (!info->pixmap.addr) {
+		err_retval = -ENOMEM;
+		goto err_exit_pixmap;
+	}
+	info->pixmap.size = PM2_PIXMAP_SIZE;
+	info->pixmap.buf_align = 4;
+	info->pixmap.scan_align = 4;
+	info->pixmap.access_align = 32;
+	info->pixmap.flags = FB_PIXMAP_SYSTEM;
+
 	if (noaccel) {
-	    	printk(KERN_DEBUG "disabling acceleration\n");
-  		info->flags |= FBINFO_HWACCEL_DISABLED;
+		printk(KERN_DEBUG "disabling acceleration\n");
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+		info->pixmap.scan_align = 1;
 	}
 
 	if (!mode)
@@ -1373,6 +1486,8 @@ static int __devinit pm2fb_probe(struct 
  err_exit_all:
 	fb_dealloc_cmap(&info->cmap);
  err_exit_both:
+	kfree(info->pixmap.addr);
+ err_exit_pixmap:
 	iounmap(info->screen_base);
 	release_mem_region(pm2fb_fix.smem_start, pm2fb_fix.smem_len);
  err_exit_mmio:
@@ -1409,6 +1524,8 @@ static void __devexit pm2fb_remove(struc
 	release_mem_region(fix->mmio_start, fix->mmio_len);
 
 	pci_set_drvdata(pdev, NULL);
+	if (info->pixmap.addr)
+		kfree(info->pixmap.addr);
 	kfree(info);
 }
 
--- linux-2.6.21/include/video/permedia2.h	2007-06-21 16:40:54.593868383 +0200
+++ linux-2.6.22/include/video/permedia2.h	2007-06-19 23:47:48.938974026 +0200
@@ -68,11 +68,14 @@
 #define PM2R_D_Y					0x8028
 #define PM2R_COUNT					0x8030
 #define PM2R_RENDER					0x8038
+#define PM2R_BIT_MASK_PATTERN				0x8068
 #define PM2R_RASTERIZER_MODE				0x80a0
 #define PM2R_RECTANGLE_ORIGIN				0x80d0
 #define PM2R_RECTANGLE_SIZE				0x80d8
 #define PM2R_PACKED_DATA_LIMITS				0x8150
 #define PM2R_SCISSOR_MODE				0x8180
+#define PM2R_SCISSOR_MIN_XY				0x8188
+#define PM2R_SCISSOR_MAX_XY				0x8190
 #define PM2R_SCREEN_SIZE				0x8198
 #define PM2R_AREA_STIPPLE_MODE				0x81a0
 #define PM2R_WINDOW_ORIGIN				0x81c8
@@ -83,7 +86,9 @@
 #define PM2R_TEXEL_LUT_MODE				0x8678
 #define PM2R_TEXTURE_COLOR_MODE				0x8680
 #define PM2R_FOG_MODE					0x8690
+#define PM2R_TEXEL0					0x8760
 #define PM2R_COLOR_DDA_MODE				0x87e0
+#define PM2R_CONSTANT_COLOR				0x87e8
 #define PM2R_ALPHA_BLEND_MODE				0x8810
 #define PM2R_DITHER_MODE				0x8818
 #define PM2R_FB_SOFT_WRITE_MASK				0x8820
@@ -169,6 +174,8 @@
 #define PM2F_RENDER_TRAPEZOID				(1L<<6)
 #define PM2F_RENDER_POINT				(2L<<6)
 #define PM2F_RENDER_RECTANGLE				(3L<<6)
+#define PM2F_RENDER_SYNC_ON_BIT_MASK			(1L<<11)
+#define PM2F_RENDER_TEXTURE_ENABLE			(1L<<13)
 #define PM2F_SYNCHRONIZATION				(1L<<10)
 #define PM2F_PLL_LOCKED					0x10
 #define PM2F_BEING_RESET				(1L<<31)

--------------070802000806090206020202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------070802000806090206020202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------070802000806090206020202--
