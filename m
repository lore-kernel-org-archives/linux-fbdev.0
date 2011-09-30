From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Fri, 30 Sep 2011 18:49:43 +0000
Subject: [PATCH] fb: fix au1100fb bitrot.
Message-Id: <1317408583-7264-1-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Removes some bitrot from the au1100fb driver and fix it up so it works again.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Tested on a DB1100 board.

 drivers/video/au1100fb.c |  181 +++++++++++++++-------------------------------
 drivers/video/au1100fb.h |    6 +--
 2 files changed, 61 insertions(+), 126 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index 93b98bb..de9da67 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -98,12 +98,6 @@ static struct fb_var_screeninfo au1100fb_var __devinitdata = {
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static struct au1100fb_drv_info drv_info;
-
-static int nocursor = 0;
-module_param(nocursor, int, 0644);
-MODULE_PARM_DESC(nocursor, "cursor enable/disable");
-
 /* fb_blank
  * Blank the screen. Depending on the mode, the screen will be
  * activated with the backlight color, or desactivated
@@ -120,7 +114,7 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 			/* Turn on panel */
 			fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 #ifdef CONFIG_MIPS_PB1100
-			if (drv_info.panel_idx = 1) {
+			if (fbdev->panel_idx = 1) {
 				au_writew(au_readw(PB1100_G_CONTROL)
 					  | (PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
 			PB1100_G_CONTROL);
@@ -135,7 +129,7 @@ static int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 			/* Turn off panel */
 			fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
 #ifdef CONFIG_MIPS_PB1100
-			if (drv_info.panel_idx = 1) {
+			if (fbdev->panel_idx = 1) {
 				au_writew(au_readw(PB1100_G_CONTROL)
 				  	  & ~(PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
 			PB1100_G_CONTROL);
@@ -416,17 +410,6 @@ int au1100fb_fb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 	return 0;
 }
 
-/* fb_cursor
- * Used to disable cursor drawing...
- */
-int au1100fb_fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
-{
-	if (nocursor)
-		return 0;
-	else
-		return -EINVAL;	/* just to force soft_cursor() call */
-}
-
 static struct fb_ops au1100fb_ops  {
 	.owner			= THIS_MODULE,
@@ -438,13 +421,53 @@ static struct fb_ops au1100fb_ops  	.fb_imageblit		= cfb_imageblit,
 	.fb_rotate		= au1100fb_fb_rotate,
 	.fb_mmap		= au1100fb_fb_mmap,
-	.fb_cursor		= au1100fb_fb_cursor,
 };
 
 
 /*-------------------------------------------------------------------------*/
 
-/* AU1100 LCD controller device driver */
+static int au1100fb_setup(struct au1100fb_device *fbdev)
+{
+	char *this_opt, *options;
+	int num_panels = ARRAY_SIZE(known_lcd_panels);
+
+	if (num_panels <= 0) {
+		print_err("No LCD panels supported by driver!");
+		return -ENODEV;
+	}
+
+	if (fb_get_options(DRIVER_NAME, &options))
+		return -ENODEV;
+	if (!options)
+		return -ENODEV;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		/* Panel option */
+		if (!strncmp(this_opt, "panel:", 6)) {
+			int i;
+			this_opt += 6;
+			for (i = 0; i < num_panels; i++) {
+				if (!strncmp(this_opt, known_lcd_panels[i].name,
+					     strlen(this_opt))) {
+					fbdev->panel = &known_lcd_panels[i];
+					fbdev->panel_idx = i;
+					break;
+				}
+			}
+			if (i >= num_panels) {
+				print_warn("Panel '%s' not supported!", this_opt);
+				return -ENODEV;
+			}
+		}
+		/* Unsupported option */
+		else
+			print_warn("Unsupported option \"%s\"", this_opt);
+	}
+
+	print_info("Panel=%s", fbdev->panel->name);
+
+	return 0;
+}
 
 static int __devinit au1100fb_drv_probe(struct platform_device *dev)
 {
@@ -453,22 +476,21 @@ static int __devinit au1100fb_drv_probe(struct platform_device *dev)
 	unsigned long page;
 	u32 sys_clksrc;
 
-	if (!dev)
-			return -EINVAL;
-
 	/* Allocate new device private */
-	if (!(fbdev = kzalloc(sizeof(struct au1100fb_device), GFP_KERNEL))) {
+	fbdev = kzalloc(sizeof(struct au1100fb_device), GFP_KERNEL);
+	if (!fbdev) {
 		print_err("fail to allocate device private record");
 		return -ENOMEM;
 	}
 
-	fbdev->panel = &known_lcd_panels[drv_info.panel_idx];
+	if (au1100fb_setup(fbdev))
+		goto failed;
 
 	platform_set_drvdata(dev, (void *)fbdev);
 
 	/* Allocate region for our registers and map them */
-	if (!(regs_res = platform_get_resource(to_platform_device(dev),
-					IORESOURCE_MEM, 0))) {
+	regs_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!regs_res) {
 		print_err("fail to retrieve registers resource");
 		return -EFAULT;
 	}
@@ -488,13 +510,11 @@ static int __devinit au1100fb_drv_probe(struct platform_device *dev)
 	print_dbg("Register memory map at %p", fbdev->regs);
 	print_dbg("phys=0x%08x, size=%d", fbdev->regs_phys, fbdev->regs_len);
 
-
-
 	/* Allocate the framebuffer to the maximum screen size * nbr of video buffers */
 	fbdev->fb_len = fbdev->panel->xres * fbdev->panel->yres *
 		  	(fbdev->panel->bpp >> 3) * AU1100FB_NBR_VIDEO_BUFFERS;
 
-	fbdev->fb_mem = dma_alloc_coherent(dev, PAGE_ALIGN(fbdev->fb_len),
+	fbdev->fb_mem = dma_alloc_coherent(&dev->dev, PAGE_ALIGN(fbdev->fb_len),
 					&fbdev->fb_phys, GFP_KERNEL);
 	if (!fbdev->fb_mem) {
 		print_err("fail to allocate frambuffer (size: %dK))",
@@ -513,7 +533,7 @@ static int __devinit au1100fb_drv_probe(struct platform_device *dev)
 	     page < PAGE_ALIGN((unsigned long)fbdev->fb_mem + fbdev->fb_len);
 	     page += PAGE_SIZE) {
 #if CONFIG_DMA_NONCOHERENT
-		SetPageReserved(virt_to_page(CAC_ADDR(page)));
+		SetPageReserved(virt_to_page(CAC_ADDR((void *)page)));
 #else
 		SetPageReserved(virt_to_page(page));
 #endif
@@ -566,7 +586,8 @@ failed:
 		release_mem_region(fbdev->regs_phys, fbdev->regs_len);
 	}
 	if (fbdev->fb_mem) {
-		dma_free_noncoherent(dev, fbdev->fb_len, fbdev->fb_mem, fbdev->fb_phys);
+		dma_free_noncoherent(&dev->dev, fbdev->fb_len, fbdev->fb_mem,
+				     fbdev->fb_phys);
 	}
 	if (fbdev->info.cmap.len != 0) {
 		fb_dealloc_cmap(&fbdev->info.cmap);
@@ -596,7 +617,8 @@ int au1100fb_drv_remove(struct platform_device *dev)
 
 	release_mem_region(fbdev->regs_phys, fbdev->regs_len);
 
-	dma_free_coherent(dev, PAGE_ALIGN(fbdev->fb_len), fbdev->fb_mem, fbdev->fb_phys);
+	dma_free_coherent(&dev->dev, PAGE_ALIGN(fbdev->fb_len), fbdev->fb_mem,
+			  fbdev->fb_phys);
 
 	fb_dealloc_cmap(&fbdev->info.cmap);
 	kfree(fbdev->info.pseudo_palette);
@@ -663,101 +685,18 @@ static struct platform_driver au1100fb_driver = {
         .resume		= au1100fb_drv_resume,
 };
 
-/*-------------------------------------------------------------------------*/
-
-/* Kernel driver */
-
-int au1100fb_setup(char *options)
-{
-	char* this_opt;
-	int num_panels = ARRAY_SIZE(known_lcd_panels);
-	char* mode = NULL;
-	int panel_idx = 0;
-
-	if (num_panels <= 0) {
-		print_err("No LCD panels supported by driver!");
-		return -EFAULT;
-			}
-
-	if (options) {
-		while ((this_opt = strsep(&options,",")) != NULL) {
-			/* Panel option */
-			if (!strncmp(this_opt, "panel:", 6)) {
-				int i;
-				this_opt += 6;
-				for (i = 0; i < num_panels; i++) {
-					if (!strncmp(this_opt,
-					      	     known_lcd_panels[i].name,
-							strlen(this_opt))) {
-						panel_idx = i;
-						break;
-					}
-				}
-				if (i >= num_panels) {
- 					print_warn("Panel %s not supported!", this_opt);
-				}
-			}
-			if (!strncmp(this_opt, "nocursor", 8)) {
-				this_opt += 8;
-				nocursor = 1;
-				print_info("Cursor disabled");
-			}
-			/* Mode option (only option that start with digit) */
-			else if (isdigit(this_opt[0])) {
-				mode = kstrdup(this_opt, GFP_KERNEL);
-				if (!mode) {
-					print_err("memory allocation failed");
-					return -ENOMEM;
-				}
-			}
-			/* Unsupported option */
-			else {
-				print_warn("Unsupported option \"%s\"", this_opt);
-			}
-		}
-	}
-
-	drv_info.panel_idx = panel_idx;
-	drv_info.opt_mode = mode;
-
-	print_info("Panel=%s Mode=%s",
-			known_lcd_panels[drv_info.panel_idx].name,
-		      	drv_info.opt_mode ? drv_info.opt_mode : "default");
-
-	return 0;
-}
-
-int __init au1100fb_init(void)
+static int __init au1100fb_load(void)
 {
-	char* options;
-	int ret;
-
-	print_info("" DRIVER_DESC "");
-
-	memset(&drv_info, 0, sizeof(drv_info));
-
-	if (fb_get_options(DRIVER_NAME, &options))
-		return -ENODEV;
-
-	/* Setup driver with options */
-	ret = au1100fb_setup(options);
-	if (ret < 0) {
-		print_err("Fail to setup driver");
-		return ret;
-	}
-
 	return platform_driver_register(&au1100fb_driver);
 }
 
-void __exit au1100fb_cleanup(void)
+static void __exit au1100fb_unload(void)
 {
 	platform_driver_unregister(&au1100fb_driver);
-
-	kfree(drv_info.opt_mode);
 }
 
-module_init(au1100fb_init);
-module_exit(au1100fb_cleanup);
+module_init(au1100fb_load);
+module_exit(au1100fb_unload);
 
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/au1100fb.h b/drivers/video/au1100fb.h
index 164fe2f..12d9642 100644
--- a/drivers/video/au1100fb.h
+++ b/drivers/video/au1100fb.h
@@ -108,6 +108,7 @@ struct au1100fb_device {
 	unsigned char* 		fb_mem;		/* FrameBuffer memory map */
 	size_t	      		fb_len;
 	dma_addr_t    		fb_phys;
+	int			panel_idx;
 };
 
 /********************************************************************/
@@ -364,11 +365,6 @@ static struct au1100fb_panel known_lcd_panels[]  	},
 };
 
-struct au1100fb_drv_info {
-	int	panel_idx;
-	char 	*opt_mode;
-};
-
 /********************************************************************/
 
 /* Inline helpers */
-- 
1.7.6.1

