From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 9/9][TDFXFB]: Salvage tdfxfb from James' tree
Date: Sat, 21 Aug 2004 21:25:23 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408212123.21312.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByW0I-000889-JS
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:33:54 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1ByW0G-0005A2-SR
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:33:53 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id F25B27B1EEE
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 13:33:44 +0000 (UTC)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Took code from James'  tree to be hopefully included in the mm tree so it can
receive more testing.

Compile tested only.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/tdfxfb.c |  101 ++++++++++++++++++++++++++++++-------------------
 include/video/tdfx.h   |    1
 2 files changed, 63 insertions(+), 39 deletions(-)

diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/tdfxfb.c linux-2.6.8.1-mm3/drivers/video/tdfxfb.c
--- linux-2.6.8.1-mm3-orig/drivers/video/tdfxfb.c	2004-08-21 18:26:53.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/tdfxfb.c	2004-08-21 19:00:57.855427152 +0800
@@ -1,4 +1,3 @@
-
 /*
  *
  * tdfxfb.c
@@ -126,8 +125,9 @@ static struct fb_var_screeninfo tdfx_var
 /*
  * PCI driver prototypes
  */
-static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id);
-static void tdfxfb_remove(struct pci_dev *pdev);
+static int __devinit tdfxfb_probe(struct pci_dev *pdev,
+				  const struct pci_device_id *id);
+static void __devexit tdfxfb_remove(struct pci_dev *pdev);
 
 static struct pci_device_id tdfxfb_id_table[] = {
 	{ PCI_VENDOR_ID_3DFX, PCI_DEVICE_ID_3DFX_BANSHEE,
@@ -163,15 +163,13 @@ static int tdfxfb_setcolreg(u_int regno,
 			    u_int transp, struct fb_info *info); 
 static int tdfxfb_blank(int blank, struct fb_info *info); 
 static int tdfxfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
+static int banshee_wait_idle(struct fb_info *info);
+#ifdef CONFIG_FB_3DFX_ACCEL
 static void tdfxfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 static void tdfxfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);  
 static void tdfxfb_imageblit(struct fb_info *info, const struct fb_image *image); 
-#ifdef CONFIG_FB_3DFX_ACCEL
 static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor);
-#else /* !CONFIG_FB_3DFX_ACCEL */
-#define tdfxfb_cursor soft_cursor
 #endif /* CONFIG_FB_3DFX_ACCEL */
-static int banshee_wait_idle(struct fb_info *info);
 
 static struct fb_ops tdfxfb_ops = {
 	.owner		= THIS_MODULE,
@@ -180,11 +178,18 @@ static struct fb_ops tdfxfb_ops = {
 	.fb_setcolreg	= tdfxfb_setcolreg,
 	.fb_blank	= tdfxfb_blank,
 	.fb_pan_display	= tdfxfb_pan_display,
+	.fb_sync	= banshee_wait_idle,
+#ifdef CONFIG_FB_3DFX_ACCEL
 	.fb_fillrect	= tdfxfb_fillrect,
 	.fb_copyarea	= tdfxfb_copyarea,
 	.fb_imageblit	= tdfxfb_imageblit,
-	.fb_sync	= banshee_wait_idle,
 	.fb_cursor	= tdfxfb_cursor,
+#else
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_cursor	= soft_cursor,
+#endif	
 };
 
 /*
@@ -512,8 +517,10 @@ static int tdfxfb_check_var(struct fb_va
 		return -EINVAL;
 	}
 
-	/* fixme: does Voodoo3 support interlace? Banshee doesn't */
-	if ((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) {
+	/* Banshee doesn't support interlace, but Voodoo4/5 and probably Voodoo3 do. */
+	/* no direct information about device id now? use max_pixclock for this... */
+	if (((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) &&
+			(par->max_pixclock < VOODOO3_MAX_PIXCLOCK)) {
 		DPRINTK("interlace not supported\n");
 		return -EINVAL;
 	}
@@ -584,7 +591,6 @@ static int tdfxfb_set_par(struct fb_info
 	int fout, freq;
 	u32 wd, cpp;
   
-	info->cmap.len = (info->var.bits_per_pixel == 8) ? 256 : 16;
 	par->baseline  = 0;
  
 	memset(&reg, 0, sizeof(reg));
@@ -620,10 +626,17 @@ static int tdfxfb_set_par(struct fb_info
 	hbs = hd;
 	hbe = ht;
 
-	vbs = vd = info->var.yres - 1;
-	vs  = vd + info->var.lower_margin;
-	ve  = vs + info->var.vsync_len;
-	vbe = vt = ve + info->var.upper_margin - 1;
+	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
+		vbs = vd = (info->var.yres << 1) - 1;
+		vs  = vd + (info->var.lower_margin << 1);
+		ve  = vs + (info->var.vsync_len << 1);
+		vbe = vt = ve + (info->var.upper_margin << 1) - 1;
+	} else {
+		vbs = vd = info->var.yres - 1;
+		vs  = vd + info->var.lower_margin;
+		ve  = vs + info->var.vsync_len;
+		vbe = vt = ve + info->var.upper_margin - 1;
+	}
   
 	/* this is all pretty standard VGA register stuffing */
 	reg.misc[0x00] = 0x0f | 
@@ -746,8 +759,16 @@ static int tdfxfb_set_par(struct fb_info
 	reg.gfxpll = do_calc_pll(..., &fout);
 #endif
 
-	reg.screensize = info->var.xres | (info->var.yres << 12);
-	reg.vidcfg &= ~VIDCFG_HALF_MODE;
+	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
+		reg.screensize = info->var.xres | (info->var.yres << 13);
+		reg.vidcfg |= VIDCFG_HALF_MODE;
+		reg.crt[0x09] |= 0x80;
+	} else {
+		reg.screensize = info->var.xres | (info->var.yres << 12);
+		reg.vidcfg &= ~VIDCFG_HALF_MODE;
+	}
+	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED)
+		reg.vidcfg |= VIDCFG_INTERLACE;
 	reg.miscinit0 = tdfx_inl(par, MISCINIT0);
 
 #if defined(__BIG_ENDIAN)
@@ -787,7 +808,7 @@ static int tdfxfb_setcolreg(unsigned reg
 	struct tdfx_par *par = (struct tdfx_par *) info->par;
 	u32 rgbcol;
    
-	if (regno >= info->cmap.len) return 1;
+	if (regno >= info->cmap.len || regno > 255) return 1;
    
 	switch (info->fix.visual) {
 		case FB_VISUAL_PSEUDOCOLOR:
@@ -876,6 +897,7 @@ static int tdfxfb_pan_display(struct fb_
 	return 0;
 }
 
+#ifdef CONFIG_FB_3DFX_ACCEL
 /*
  * FillRect 2D command (solidfill or invert (via ROP_XOR))   
  */
@@ -894,7 +916,11 @@ static void tdfxfb_fillrect(struct fb_in
 
 	banshee_make_room(par, 5);
 	tdfx_outl(par,	DSTFORMAT, fmt);
-	tdfx_outl(par,	COLORFORE, rect->color);
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
+		tdfx_outl(par,	COLORFORE, rect->color);
+	} else { /* FB_VISUAL_TRUECOLOR */
+		tdfx_outl(par, COLORFORE, ((u32*)(info->pseudo_palette))[rect->color]);
+	}
 	tdfx_outl(par,	COMMAND_2D, COMMAND_2D_FILLRECT | (tdfx_rop << 24));
 	tdfx_outl(par,	DSTSIZE,    rect->width | (rect->height << 16));
 	tdfx_outl(par,	LAUNCH_2D,  rect->dx | (rect->dy << 16));
@@ -1005,7 +1031,6 @@ static void tdfxfb_imageblit(struct fb_i
 	banshee_wait_idle(info);
 }
 
-#ifdef CONFIG_FB_3DFX_ACCEL
 static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct tdfx_par *par = (struct tdfx_par *) info->par;
@@ -1043,7 +1068,7 @@ static int tdfxfb_cursor(struct fb_info 
 		struct fb_cmap cmap = cursor->image.cmap;
 		unsigned long bg_color, fg_color;
 
-		cmap.len = 2;/* Voodoo 3+ only support 2 color cursors*/
+		cmap.len = 2; /* Voodoo 3+ only support 2 color cursors */
 		fg_color = ((cmap.red[cmap.start] << 16) |
 			    (cmap.green[cmap.start] << 8)  |
 			    (cmap.blue[cmap.start]));
@@ -1101,7 +1126,7 @@ static int tdfxfb_cursor(struct fb_info 
 		 */
 		u8 *cursorbase = (u8 *) info->cursor.image.data;
 		char *bitmap = (char *)cursor->image.data;
-		const char *mask = cursor->mask;
+		char *mask = (char *) cursor->mask;
 		int i, j, k, h = 0;
 
 		for (i = 0; i < 64; i++) {
@@ -1165,15 +1190,13 @@ static int __devinit tdfxfb_probe(struct
 		return err;
 	}
 
-	size = sizeof(struct fb_info)+sizeof(struct tdfx_par)+16*sizeof(u32);
+	size = sizeof(struct tdfx_par)+256*sizeof(u32);
 
-	info = kmalloc(size, GFP_KERNEL);
+	info = framebuffer_alloc(size, &pdev->dev);
 
 	if (!info)	return -ENOMEM;
 		
-	memset(info, 0, size);
-    
-	default_par = (struct tdfx_par *) (info + 1);
+	default_par = info->par;
  
 	/* Configure the default fb_fix_screeninfo first */
 	switch (pdev->device) {
@@ -1251,28 +1274,28 @@ static int __devinit tdfxfb_probe(struct
    
 	info->fbops		= &tdfxfb_ops;
 	info->fix		= tdfx_fix; 	
-	info->par		= default_par;
 	info->pseudo_palette	= (void *)(default_par + 1); 
-	info->flags		= FBINFO_DEFAULT |
-                                  FBINFO_HWACCEL_COPYAREA |
-                                  FBINFO_HWACCEL_FILLRECT |
-                                  FBINFO_HWACCEL_IMAGEBLIT |
-	                          FBINFO_HWACCEL_YPAN;
+	info->flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+#ifdef CONFIG_FB_3DFX_ACCEL
+	info->flags             |= FBINFO_HWACCEL_FILLRECT |
+		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_IMAGEBLIT;
+#endif
 
-#ifndef MODULE
 	if (!mode_option)
 		mode_option = "640x480@60";
 	 
 	err = fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL, 8); 
 	if (!err || err == 4)
-#endif
 		info->var = tdfx_var;
 
-	size = (info->var.bits_per_pixel == 8) ? 256 : 16;
-	fb_alloc_cmap(&info->cmap, size, 0);  
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		printk(KERN_WARNING "tdfxfb: Can't allocate color map\n");
+		goto out_err;
+	}	
 
 	if (register_framebuffer(info) < 0) {
 		printk("tdfxfb: can't register framebuffer\n");
+		fb_dealloc_cmap(&info->cmap);
 		goto out_err;
 	}
 	/*
@@ -1289,7 +1312,7 @@ out_err:
 		iounmap(default_par->regbase_virt);
 	if (info->screen_base)
 		iounmap(info->screen_base);
-	kfree(info);
+	framebuffer_release(info);
 	return -ENXIO;
 }
 
@@ -1319,7 +1342,7 @@ static void __devexit tdfxfb_remove(stru
 	release_mem_region(pci_resource_start(pdev, 0),
 			   pci_resource_len(pdev, 0));
 	pci_set_drvdata(pdev, NULL);
-	kfree(info);
+	framebuffer_release(info);
 }
 
 int __init tdfxfb_init(void)
diff -uprN linux-2.6.8.1-mm3-orig/include/video/tdfx.h linux-2.6.8.1-mm3/include/video/tdfx.h
--- linux-2.6.8.1-mm3-orig/include/video/tdfx.h	2004-05-10 10:32:27.000000000 +0800
+++ linux-2.6.8.1-mm3/include/video/tdfx.h	2004-08-21 19:00:57.857426848 +0800
@@ -114,6 +114,7 @@
 #define VGAINIT1_MASK                   0x1fffff
 #define VIDCFG_VIDPROC_ENABLE           BIT(0)
 #define VIDCFG_CURS_X11                 BIT(1)
+#define VIDCFG_INTERLACE                BIT(3)
 #define VIDCFG_HALF_MODE                BIT(4)
 #define VIDCFG_DESK_ENABLE              BIT(7)
 #define VIDCFG_CLUT_BYPASS              BIT(10)




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
