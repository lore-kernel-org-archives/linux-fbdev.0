From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Fri, 10 Jun 2011 15:23:01 +0000
Subject: [PATCH 1/4] au1200fb: use framebuffer_alloc()
Message-Id: <1307719384-23702-2-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Convert to use framebuffer_alloc() instead of using fb_info embedded
into device context (which broke the driver in the past due to un-
initialized elements).

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/video/au1200fb.c |   80 ++++++++++++++++++++++++++-------------------
 1 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 5dff32a..442d005 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -150,7 +150,7 @@ struct au1200_lcd_iodata_t {
 
 /* Private, per-framebuffer management information (independent of the panel itself) */
 struct au1200fb_device {
-	struct fb_info fb_info;			/* FB driver info record */
+	struct fb_info *fb_info;		/* FB driver info record */
 
 	int					plane;
 	unsigned char* 		fb_mem;		/* FrameBuffer memory map */
@@ -158,7 +158,7 @@ struct au1200fb_device {
 	dma_addr_t    		fb_phys;
 };
 
-static struct au1200fb_device _au1200fb_devices[CONFIG_FB_AU1200_DEVS];
+static struct fb_info *_au1200fb_infos[CONFIG_FB_AU1200_DEVS];
 /********************************************************************/
 
 /* LCD controller restrictions */
@@ -713,7 +713,7 @@ static int fbinfo2index (struct fb_info *fb_info)
 	int i;
 
 	for (i = 0; i < CONFIG_FB_AU1200_DEVS; ++i) {
-		if (fb_info = (struct fb_info *)(&_au1200fb_devices[i].fb_info))
+		if (fb_info = _au1200fb_infos[i])
 			return i;
 	}
 	printk("au1200fb: ERROR: fbinfo2index failed!\n");
@@ -962,7 +962,7 @@ static void au1200_setmode(struct au1200fb_device *fbdev)
 	lcd->window[plane].winctrl2 = ( 0
 		| LCD_WINCTRL2_CKMODE_00
 		| LCD_WINCTRL2_DBM
-		| LCD_WINCTRL2_BX_N( fbdev->fb_info.fix.line_length)
+		| LCD_WINCTRL2_BX_N(fbdev->fb_info->fix.line_length)
 		| LCD_WINCTRL2_SCX_1
 		| LCD_WINCTRL2_SCY_1
 		) ;
@@ -1050,7 +1050,7 @@ static void au1200fb_update_fbinfo(struct fb_info *fbi)
 static int au1200fb_fb_check_var(struct fb_var_screeninfo *var,
 	struct fb_info *fbi)
 {
-	struct au1200fb_device *fbdev = (struct au1200fb_device *)fbi;
+	struct au1200fb_device *fbdev = fbi->par;
 	u32 pixclock;
 	int screen_size, plane;
 
@@ -1142,7 +1142,7 @@ static int au1200fb_fb_check_var(struct fb_var_screeninfo *var,
  */
 static int au1200fb_fb_set_par(struct fb_info *fbi)
 {
-	struct au1200fb_device *fbdev = (struct au1200fb_device *)fbi;
+	struct au1200fb_device *fbdev = fbi->par;
 
 	au1200fb_update_fbinfo(fbi);
 	au1200_setmode(fbdev);
@@ -1246,7 +1246,7 @@ static int au1200fb_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	unsigned int len;
 	unsigned long start=0, off;
-	struct au1200fb_device *fbdev = (struct au1200fb_device *) info;
+	struct au1200fb_device *fbdev = info->par;
 
 #ifdef CONFIG_PM
 	au1xxx_pm_access(LCD_pm_dev);
@@ -1561,10 +1561,9 @@ static irqreturn_t au1200fb_handle_irq(int irq, void* dev_id)
 
 static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
 {
-	struct fb_info *fbi = &fbdev->fb_info;
+	struct fb_info *fbi = fbdev->fb_info;
 	int bpp;
 
-	memset(fbi, 0, sizeof(struct fb_info));
 	fbi->fbops = &au1200fb_fb_ops;
 
 	bpp = winbpp(win->w[fbdev->plane].mode_winctrl1);
@@ -1626,11 +1625,13 @@ static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
 static int au1200fb_drv_probe(struct platform_device *dev)
 {
 	struct au1200fb_device *fbdev;
+	struct fb_info *fbi = NULL;
 	unsigned long page;
 	int bpp, plane, ret;
 
-	if (!dev)
-		return -EINVAL;
+	/* shut gcc up */
+	ret = 0;
+	fbdev = NULL;
 
 	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane) {
 		bpp = winbpp(win->w[plane].mode_winctrl1);
@@ -1639,8 +1640,15 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 		if (win->w[plane].yres = 0)
 			win->w[plane].yres = panel->Yres;
 
-		fbdev = &_au1200fb_devices[plane];
-		memset(fbdev, 0, sizeof(struct au1200fb_device));
+		fbi = framebuffer_alloc(sizeof(struct au1200fb_device),
+					&dev->dev);
+		if (!fbi)
+			goto failed;
+
+		_au1200fb_infos[plane] = fbi;
+		fbdev = fbi->par;
+		fbdev->fb_info = fbi;
+
 		fbdev->plane = plane;
 
 		/* Allocate the framebuffer to the maximum screen size */
@@ -1673,21 +1681,20 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 			goto failed;
 
 		/* Register new framebuffer */
-		if ((ret = register_framebuffer(&fbdev->fb_info)) < 0) {
+		ret = register_framebuffer(fbi);
+		if (ret < 0) {
 			print_err("cannot register new framebuffer");
 			goto failed;
 		}
 
-		au1200fb_fb_set_par(&fbdev->fb_info);
+		au1200fb_fb_set_par(fbi);
 
 #if !defined(CONFIG_FRAMEBUFFER_CONSOLE) && defined(CONFIG_LOGO)
 		if (plane = 0)
-			if (fb_prepare_logo(&fbdev->fb_info, FB_ROTATE_UR)) {
+			if (fb_prepare_logo(fbi, FB_ROTATE_UR)) {
 				/* Start display and show logo on boot */
-				fb_set_cmap(&fbdev->fb_info.cmap,
-						&fbdev->fb_info);
-
-				fb_show_logo(&fbdev->fb_info, FB_ROTATE_UR);
+				fb_set_cmap(&fbi->cmap, fbi);
+				fb_show_logo(fbi, FB_ROTATE_UR);
 			}
 #endif
 	}
@@ -1705,12 +1712,13 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 failed:
 	/* NOTE: This only does the current plane/window that failed; others are still active */
 	if (fbdev->fb_mem)
-		dma_free_noncoherent(dev, PAGE_ALIGN(fbdev->fb_len),
+		dma_free_noncoherent(&dev->dev, PAGE_ALIGN(fbdev->fb_len),
 				fbdev->fb_mem, fbdev->fb_phys);
-	if (fbdev->fb_info.cmap.len != 0)
-		fb_dealloc_cmap(&fbdev->fb_info.cmap);
-	if (fbdev->fb_info.pseudo_palette)
-		kfree(fbdev->fb_info.pseudo_palette);
+	if (fbi) {
+		if (fbi->cmap.len != 0)
+			fb_dealloc_cmap(&fbi->cmap);
+		kfree(fbi->pseudo_palette);
+	}
 	if (plane = 0)
 		free_irq(AU1200_LCD_INT, (void*)dev);
 	return ret;
@@ -1719,6 +1727,7 @@ failed:
 static int au1200fb_drv_remove(struct platform_device *dev)
 {
 	struct au1200fb_device *fbdev;
+	struct fb_info *fbi;
 	int plane;
 
 	if (!dev)
@@ -1727,20 +1736,22 @@ static int au1200fb_drv_remove(struct platform_device *dev)
 	/* Turn off the panel */
 	au1200_setpanel(NULL);
 
-	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane)
-	{
-		fbdev = &_au1200fb_devices[plane];
+	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane)	{
+		fbi = _au1200fb_infos[plane];
+		fbdev = fbi->par;
 
 		/* Clean up all probe data */
-		unregister_framebuffer(&fbdev->fb_info);
+		unregister_framebuffer(fbi);
 		if (fbdev->fb_mem)
 			dma_free_noncoherent(&dev->dev,
 					PAGE_ALIGN(fbdev->fb_len),
 					fbdev->fb_mem, fbdev->fb_phys);
-		if (fbdev->fb_info.cmap.len != 0)
-			fb_dealloc_cmap(&fbdev->fb_info.cmap);
-		if (fbdev->fb_info.pseudo_palette)
-			kfree(fbdev->fb_info.pseudo_palette);
+		if (fbi->cmap.len != 0)
+			fb_dealloc_cmap(&fbi->cmap);
+		kfree(fbi->pseudo_palette);
+
+		framebuffer_release(fbi);
+		_au1200fb_infos[plane] = NULL;
 	}
 
 	free_irq(AU1200_LCD_INT, (void *)dev);
@@ -1749,7 +1760,8 @@ static int au1200fb_drv_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM
-static int au1200fb_drv_suspend(struct platform_device *dev, u32 state)
+static int au1200fb_drv_suspend(struct platform_device *dev,
+				pm_message_t state)
 {
 	/* TODO */
 	return 0;
-- 
1.7.5.3

