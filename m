From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] tdfxfb: 3 fixes
Date: Fri, 20 Jul 2007 06:32:54 +0200
Message-ID: <20070720063254.f3887791.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBk88-00042Z-BA for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Jul 2007 21:30:16 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBk87-0005YG-H7
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Jul 2007 21:30:16 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	20 Jul 2007 06:30:10 +0200
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes 3 issues:
- transparency handling in tdfxfb
- panning with more than 4096 virtual height and acceleration (acceleration with x & y > 4096)
- exit paths on errors in tdfxfb_probe()

Additionally it sets a FBINFO_READS_FAST flag to use smart blitter scrolling (speed up on tdfxfb).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This patch was done against tdfxfb.c with cleanup patch I sent last week.

Regards,
Krzysztof

--- linux-2.6.22.old/drivers/video/tdfxfb.c	2007-07-20 06:18:25.000000000 +0200
+++ linux-2.6.22/drivers/video/tdfxfb.c	2007-07-20 06:19:35.000000000 +0200
@@ -502,6 +502,8 @@ static int tdfxfb_check_var(struct fb_va
 		return -EINVAL;
 	}
 
+	var->transp.offset = 0;
+	var->transp.length = 0;
 	switch (var->bits_per_pixel) {
 	case 8:
 		var->red.length = var->green.length = var->blue.length = 8;
@@ -515,10 +517,12 @@ static int tdfxfb_check_var(struct fb_va
 		var->blue.length  = 5;
 		break;
 	case 32:
+		var->transp.offset = 24;
+		var->transp.length = 8;
 	case 24:
-		var->red.offset=16;
-		var->green.offset=8;
-		var->blue.offset=0;
+		var->red.offset = 16;
+		var->green.offset = 8;
+		var->blue.offset = 0;
 		var->red.length = var->green.length = var->blue.length = 8;
 		break;
 	}
@@ -874,13 +878,26 @@ static void tdfxfb_fillrect(struct fb_in
 	u32 stride = info->fix.line_length;
 	u32 fmt= stride | ((bpp + ((bpp == 8) ? 0 : 8)) << 13);
 	int tdfx_rop;
+	u32 dx = rect->dx;
+	u32 dy = rect->dy;
+	u32 dstbase = 0;
  
 	if (rect->rop == ROP_COPY)
 		tdfx_rop = TDFX_ROP_COPY;
 	else
 		tdfx_rop = TDFX_ROP_XOR;
 
-	banshee_make_room(par, 5);
+	/* asume always rect->height < 4096 */
+	if (dy + rect->height > 4095) {
+		dstbase = stride * dy;
+		dy = 0;
+	}
+	/* asume always rect->width < 4096 */
+	if (dx + rect->width > 4095) {
+		dstbase += dx * bpp >> 3;
+		dx = 0;
+	}
+	banshee_make_room(par, 6);
 	tdfx_outl(par, DSTFORMAT, fmt);
 	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
 		tdfx_outl(par, COLORFORE, rect->color);
@@ -888,8 +905,9 @@ static void tdfxfb_fillrect(struct fb_in
 		tdfx_outl(par, COLORFORE, par->palette[rect->color]);
 	}
 	tdfx_outl(par, COMMAND_2D, COMMAND_2D_FILLRECT | (tdfx_rop << 24));
+	tdfx_outl(par, DSTBASE, dstbase);
 	tdfx_outl(par, DSTSIZE, rect->width | (rect->height << 16));
-	tdfx_outl(par, LAUNCH_2D, rect->dx | (rect->dy << 16));
+	tdfx_outl(par, LAUNCH_2D, dx | (dy << 16));
 }
 
 /*
@@ -904,6 +922,30 @@ static void tdfxfb_copyarea(struct fb_in
 	u32 stride = info->fix.line_length;
 	u32 blitcmd = COMMAND_2D_S2S_BITBLT | (TDFX_ROP_COPY << 24);
 	u32 fmt = stride | ((bpp + ((bpp == 8) ? 0 : 8)) << 13);
+	u32 dstbase = 0;
+	u32 srcbase = 0;
+
+	/* asume always area->height < 4096 */
+	if (sy + area->height > 4095) {
+		srcbase = stride * sy;
+		sy = 0;
+	}
+	/* asume always area->width < 4096 */
+	if (sx + area->width > 4095) {
+		srcbase += sx * bpp >> 3;
+		sx = 0;
+	}
+	/* asume always area->height < 4096 */
+	if (dy + area->height > 4095) {
+		dstbase = stride * dy;
+		dy = 0;
+	}
+	/* asume always area->width < 4096 */
+	if (dx + area->width > 4095) {
+		dstbase += dx * bpp >> 3;
+		dx = 0;
+	}
+
 
 	if (area->sx <= area->dx) {
 		//-X
@@ -918,13 +960,15 @@ static void tdfxfb_copyarea(struct fb_in
 		dy += area->height - 1;
 	}
 
-	banshee_make_room(par, 6);
+	banshee_make_room(par, 8);
 
 	tdfx_outl(par, SRCFORMAT, fmt);
 	tdfx_outl(par, DSTFORMAT, fmt);
 	tdfx_outl(par, COMMAND_2D, blitcmd);
 	tdfx_outl(par, DSTSIZE, area->width | (area->height << 16));
 	tdfx_outl(par, DSTXY, dx | (dy << 16));
+	tdfx_outl(par, SRCBASE, srcbase);
+	tdfx_outl(par, DSTBASE, dstbase);
 	tdfx_outl(par, LAUNCH_2D, sx | (sy << 16));
 }
 
@@ -938,35 +982,48 @@ static void tdfxfb_imageblit(struct fb_i
 	u32 dstfmt = stride | ((bpp + ((bpp == 8) ? 0 : 8)) << 13);
 	u8 *chardata = (u8 *) image->data;
 	u32 srcfmt;
+	u32 dx = image->dx;
+	u32 dy = image->dy;
+	u32 dstbase = 0;
 
 	if (image->depth != 1) {
 		//banshee_make_room(par, 6 + ((size + 3) >> 2));
 		//srcfmt = stride | ((bpp+((bpp==8) ? 0 : 8)) << 13) | 0x400000;
 		cfb_imageblit(info, image);
 		return;
-	} else {
-		banshee_make_room(par, 8);
-		switch (info->fix.visual) {
-		case FB_VISUAL_PSEUDOCOLOR:
-			tdfx_outl(par, COLORFORE, image->fg_color);
-			tdfx_outl(par, COLORBACK, image->bg_color);
-			break;
-		case FB_VISUAL_TRUECOLOR:
-		default:
-			tdfx_outl(par, COLORFORE,
-				  par->palette[image->fg_color]);
-			tdfx_outl(par, COLORBACK,
-				  par->palette[image->bg_color]);
-		}
+	}
+	banshee_make_room(par, 9);
+	switch (info->fix.visual) {
+	case FB_VISUAL_PSEUDOCOLOR:
+		tdfx_outl(par, COLORFORE, image->fg_color);
+		tdfx_outl(par, COLORBACK, image->bg_color);
+		break;
+	case FB_VISUAL_TRUECOLOR:
+	default:
+		tdfx_outl(par, COLORFORE,
+			  par->palette[image->fg_color]);
+		tdfx_outl(par, COLORBACK,
+			  par->palette[image->bg_color]);
+	}
 #ifdef __BIG_ENDIAN
-		srcfmt = 0x400000 | BIT(20);
+	srcfmt = 0x400000 | BIT(20);
 #else
-		srcfmt = 0x400000;
+	srcfmt = 0x400000;
 #endif
+	/* asume always image->height < 4096 */
+	if (dy + image->height > 4095) {
+		dstbase = stride * dy;
+		dy = 0;
+	}
+	/* asume always image->width < 4096 */
+	if (dx + image->width > 4095) {
+		dstbase += dx * bpp >> 3;
+		dx = 0;
 	}
 
+	tdfx_outl(par, DSTBASE, dstbase);
 	tdfx_outl(par, SRCXY, 0);
-	tdfx_outl(par, DSTXY, image->dx | (image->dy << 16));
+	tdfx_outl(par, DSTXY, dx | (dy << 16));
 	tdfx_outl(par, COMMAND_2D, COMMAND_2D_H2S_BITBLT | (TDFX_ROP_COPY << 24));
 	tdfx_outl(par, SRCFORMAT, srcfmt);
 	tdfx_outl(par, DSTFORMAT, dstfmt);
@@ -1211,44 +1268,36 @@ static int __devinit tdfxfb_probe(struct
 
 	tdfx_fix.mmio_start = pci_resource_start(pdev, 0);
 	tdfx_fix.mmio_len = pci_resource_len(pdev, 0);
+	if (!request_mem_region(tdfx_fix.mmio_start, tdfx_fix.mmio_len,
+				"tdfx regbase")) {
+		printk(KERN_WARNING "tdfxfb: Can't reserve regbase\n");
+		goto out_err;
+	}
+
 	default_par->regbase_virt =
 		ioremap_nocache(tdfx_fix.mmio_start, tdfx_fix.mmio_len);
 	if (!default_par->regbase_virt) {
 		printk("fb: Can't remap %s register area.\n", tdfx_fix.id);
-		goto out_err;
-	}
-
-	if (!request_mem_region(pci_resource_start(pdev, 0),
-				pci_resource_len(pdev, 0), "tdfx regbase")) {
-		printk(KERN_WARNING "tdfxfb: Can't reserve regbase\n");
-		goto out_err;
+		goto out_err_regbase;
 	}
 
 	tdfx_fix.smem_start = pci_resource_start(pdev, 1);
 	if (!(tdfx_fix.smem_len = do_lfb_size(default_par, pdev->device))) {
 		printk("fb: Can't count %s memory.\n", tdfx_fix.id);
-		release_mem_region(pci_resource_start(pdev, 0),
-				   pci_resource_len(pdev, 0));
-		goto out_err;
+		goto out_err_regbase;
 	}
 
-	if (!request_mem_region(pci_resource_start(pdev, 1),
+	if (!request_mem_region(tdfx_fix.smem_start,
 				pci_resource_len(pdev, 1), "tdfx smem")) {
 		printk(KERN_WARNING "tdfxfb: Can't reserve smem\n");
-		release_mem_region(pci_resource_start(pdev, 0),
-				   pci_resource_len(pdev, 0));
-		goto out_err;
+		goto out_err_regbase;
 	}
 
 	info->screen_base = ioremap_nocache(tdfx_fix.smem_start,
 					    tdfx_fix.smem_len);
 	if (!info->screen_base) {
 		printk("fb: Can't remap %s framebuffer.\n", tdfx_fix.id);
-		release_mem_region(pci_resource_start(pdev, 1),
-				   pci_resource_len(pdev, 1));
-		release_mem_region(pci_resource_start(pdev, 0),
-				   pci_resource_len(pdev, 0));
-		goto out_err;
+		goto out_err_screenbase;
 	}
 
 	default_par->iobase = pci_resource_start(pdev, 2);
@@ -1256,11 +1305,7 @@ static int __devinit tdfxfb_probe(struct
 	if (!request_region(pci_resource_start(pdev, 2),
 			    pci_resource_len(pdev, 2), "tdfx iobase")) {
 		printk(KERN_WARNING "tdfxfb: Can't reserve iobase\n");
-		release_mem_region(pci_resource_start(pdev, 1),
-				   pci_resource_len(pdev, 1));
-		release_mem_region(pci_resource_start(pdev, 0),
-				   pci_resource_len(pdev, 0));
-		goto out_err;
+		goto out_err_screenbase;
 	}
 
 	printk("fb: %s memory = %dK\n", tdfx_fix.id, tdfx_fix.smem_len >> 10);
@@ -1274,7 +1319,9 @@ static int __devinit tdfxfb_probe(struct
 	info->flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 #ifdef CONFIG_FB_3DFX_ACCEL
 	info->flags             |= FBINFO_HWACCEL_FILLRECT |
-		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_IMAGEBLIT;
+				   FBINFO_HWACCEL_COPYAREA |
+				   FBINFO_HWACCEL_IMAGEBLIT |
+				   FBINFO_READS_FAST;
 #endif
 
 	if (!mode_option)
@@ -1288,27 +1335,17 @@ static int __devinit tdfxfb_probe(struct
 	lpitch = info->var.xres_virtual * ((info->var.bits_per_pixel + 7) >> 3);
 	info->var.yres_virtual = info->fix.smem_len / lpitch;
 	if (info->var.yres_virtual < info->var.yres)
-		goto out_err;
-
-#ifdef CONFIG_FB_3DFX_ACCEL
-	/*
-	 * FIXME: Limit var->yres_virtual to 4096 because of screen artifacts
-	 * during scrolling. This is only present if 2D acceleration is
-	 * enabled.
-	 */
-	if (info->var.yres_virtual > 4096)
-		info->var.yres_virtual = 4096;
-#endif /* CONFIG_FB_3DFX_ACCEL */
+		goto out_err_iobase;
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		printk(KERN_WARNING "tdfxfb: Can't allocate color map\n");
-		goto out_err;
+		goto out_err_iobase;
 	}
 
 	if (register_framebuffer(info) < 0) {
 		printk("tdfxfb: can't register framebuffer\n");
 		fb_dealloc_cmap(&info->cmap);
-		goto out_err;
+		goto out_err_iobase;
 	}
 	/*
 	 * Our driver data
@@ -1316,14 +1353,21 @@ static int __devinit tdfxfb_probe(struct
 	pci_set_drvdata(pdev, info);
 	return 0;
 
-out_err:
+out_err_iobase:
+	release_mem_region(pci_resource_start(pdev, 2),
+			   pci_resource_len(pdev, 2));
+out_err_screenbase:
+	if (info->screen_base)
+		iounmap(info->screen_base);
+	release_mem_region(tdfx_fix.smem_start, pci_resource_len(pdev, 1));
+out_err_regbase:
 	/*
 	 * Cleanup after anything that was remapped/allocated.
 	 */
 	if (default_par->regbase_virt)
 		iounmap(default_par->regbase_virt);
-	if (info->screen_base)
-		iounmap(info->screen_base);
+	release_mem_region(tdfx_fix.mmio_start, tdfx_fix.mmio_len);
+out_err:
 	framebuffer_release(info);
 	return -ENXIO;
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
