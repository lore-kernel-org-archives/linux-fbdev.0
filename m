From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] au1200fb: fixup PM support.
Date: Tue, 5 Aug 2008 14:42:21 +0200
Message-ID: <20080805124221.GA27469@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQLry-0003hE-1c for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 05:42:30 -0700
Received: from fnoeppeil43.netpark.at ([217.175.205.171]
	helo=roarinelk.homelinux.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQLru-0002R2-UI
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 05:42:29 -0700
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sf.net
Cc: L-M-O <linux-mips@linux-mips.org>, Kevin Hickey <khickey@rmicorp.com>

Remove last traces of the custom Alchemy linux-2.4 PM code, implement
suspend/resume callbacks.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/video/au1200fb.c |  164 ++++++++++++----------------------------------
 1 files changed, 41 insertions(+), 123 deletions(-)

diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 03e57ef..be945ab 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -45,10 +45,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include "au1200fb.h"
 
-#ifdef CONFIG_PM
-#include <asm/mach-au1x00/au1xxx_pm.h>
-#endif
-
 #ifndef CONFIG_FB_AU1200_DEVS
 #define CONFIG_FB_AU1200_DEVS 4
 #endif
@@ -204,12 +200,6 @@ struct window_settings {
 extern int board_au1200fb_panel_init (void);
 extern int board_au1200fb_panel_shutdown (void);
 
-#ifdef CONFIG_PM
-int au1200fb_pm_callback(au1xxx_power_dev_t *dev,
-		au1xxx_request_t request, void *data);
-au1xxx_power_dev_t *LCD_pm_dev;
-#endif
-
 /*
  * Default window configurations
  */
@@ -651,25 +641,6 @@ static struct panel_settings known_lcd_panels[] =
 
 /********************************************************************/
 
-#ifdef CONFIG_PM
-static int set_brightness(unsigned int brightness)
-{
-	unsigned int hi1, divider;
-
-	/* limit brightness pwm duty to >= 30/1600 */
-	if (brightness < 30) {
-		brightness = 30;
-	}
-	divider = (lcd->pwmdiv & 0x3FFFF) + 1;
-	hi1 = (lcd->pwmhi >> 16) + 1;
-	hi1 = (((brightness & 0xFF) + 1) * divider >> 8);
-	lcd->pwmhi &= 0xFFFF;
-	lcd->pwmhi |= (hi1 << 16);
-
-	return brightness;
-}
-#endif /* CONFIG_PM */
-
 static int winbpp (unsigned int winctrl1)
 {
 	int bits = 0;
@@ -1247,10 +1218,6 @@ static int au1200fb_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	unsigned long start=0, off;
 	struct au1200fb_device *fbdev = (struct au1200fb_device *) info;
 
-#ifdef CONFIG_PM
-	au1xxx_pm_access(LCD_pm_dev);
-#endif
-
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
 		return -EINVAL;
 	}
@@ -1460,10 +1427,6 @@ static int au1200fb_ioctl(struct fb_info *info, unsigned int cmd,
 	int plane;
 	int val;
 
-#ifdef CONFIG_PM
-	au1xxx_pm_access(LCD_pm_dev);
-#endif
-
 	plane = fbinfo2index(info);
 	print_dbg("au1200fb: ioctl %d on plane %d\n", cmd, plane);
 
@@ -1622,14 +1585,14 @@ static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
 
 /* AU1200 LCD controller device driver */
 
-static int au1200fb_drv_probe(struct device *dev)
+static int au1200fb_drv_probe(struct platform_device *pdev)
 {
 	struct au1200fb_device *fbdev;
 	unsigned long page;
 	int bpp, plane, ret;
 
-	if (!dev)
-		return -EINVAL;
+	/* Kickstart the panel */
+	au1200_setpanel(panel);
 
 	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane) {
 		bpp = winbpp(win->w[plane].mode_winctrl1);
@@ -1645,7 +1608,7 @@ static int au1200fb_drv_probe(struct device *dev)
 		/* Allocate the framebuffer to the maximum screen size */
 		fbdev->fb_len = (win->w[plane].xres * win->w[plane].yres * bpp) / 8;
 
-		fbdev->fb_mem = dma_alloc_noncoherent(dev,
+		fbdev->fb_mem = dma_alloc_noncoherent(&pdev->dev,
 				PAGE_ALIGN(fbdev->fb_len),
 				&fbdev->fb_phys, GFP_KERNEL);
 		if (!fbdev->fb_mem) {
@@ -1693,7 +1656,7 @@ static int au1200fb_drv_probe(struct device *dev)
 
 	/* Now hook interrupt too */
 	if ((ret = request_irq(AU1200_LCD_INT, au1200fb_handle_irq,
-		 	  IRQF_DISABLED | IRQF_SHARED, "lcd", (void *)dev)) < 0) {
+			IRQF_DISABLED | IRQF_SHARED, "lcd", (void *)pdev)) < 0) {
 		print_err("fail to request interrupt line %d (err: %d)",
 			  AU1200_LCD_INT, ret);
 		goto failed;
@@ -1704,25 +1667,22 @@ static int au1200fb_drv_probe(struct device *dev)
 failed:
 	/* NOTE: This only does the current plane/window that failed; others are still active */
 	if (fbdev->fb_mem)
-		dma_free_noncoherent(dev, PAGE_ALIGN(fbdev->fb_len),
+		dma_free_noncoherent(&pdev->dev, PAGE_ALIGN(fbdev->fb_len),
 				fbdev->fb_mem, fbdev->fb_phys);
 	if (fbdev->fb_info.cmap.len != 0)
 		fb_dealloc_cmap(&fbdev->fb_info.cmap);
 	if (fbdev->fb_info.pseudo_palette)
 		kfree(fbdev->fb_info.pseudo_palette);
 	if (plane == 0)
-		free_irq(AU1200_LCD_INT, (void*)dev);
+		free_irq(AU1200_LCD_INT, (void *)pdev);
 	return ret;
 }
 
-static int au1200fb_drv_remove(struct device *dev)
+static int au1200fb_drv_remove(struct platform_device *pdev)
 {
 	struct au1200fb_device *fbdev;
 	int plane;
 
-	if (!dev)
-		return -ENODEV;
-
 	/* Turn off the panel */
 	au1200_setpanel(NULL);
 
@@ -1733,7 +1693,8 @@ static int au1200fb_drv_remove(struct device *dev)
 		/* Clean up all probe data */
 		unregister_framebuffer(&fbdev->fb_info);
 		if (fbdev->fb_mem)
-			dma_free_noncoherent(dev, PAGE_ALIGN(fbdev->fb_len),
+			dma_free_noncoherent(&pdev->dev,
+					PAGE_ALIGN(fbdev->fb_len),
 					fbdev->fb_mem, fbdev->fb_phys);
 		if (fbdev->fb_info.cmap.len != 0)
 			fb_dealloc_cmap(&fbdev->fb_info.cmap);
@@ -1741,34 +1702,52 @@ static int au1200fb_drv_remove(struct device *dev)
 			kfree(fbdev->fb_info.pseudo_palette);
 	}
 
-	free_irq(AU1200_LCD_INT, (void *)dev);
+	free_irq(AU1200_LCD_INT, (void *)pdev);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int au1200fb_drv_suspend(struct device *dev, u32 state, u32 level)
-{
-	/* TODO */
+static int au1200fb_drv_suspend(struct platform_device *pdev,
+				pm_message_t state)
+ {
+	au1200_setpanel(NULL);
+
+	lcd->outmask = 0;
+	au_sync();
+
 	return 0;
 }
 
-static int au1200fb_drv_resume(struct device *dev, u32 level)
+static int au1200fb_drv_resume(struct platform_device *pdev)
 {
-	/* TODO */
+	struct au1200fb_device *fbdev;
+	int i;
+
+	/* Kickstart the panel */
+	au1200_setpanel(panel);
+
+	for (i = 0; i < CONFIG_FB_AU1200_DEVS; i++) {
+		fbdev = &_au1200fb_devices[i];
+		au1200fb_fb_set_par(&fbdev->fb_info);
+	}
+
 	return 0;
 }
+#else
+#define au1200fb_drv_suspend	NULL
+#define au1200fb_drv_resume	NULL
 #endif /* CONFIG_PM */
 
-static struct device_driver au1200fb_driver = {
-	.name		= "au1200-lcd",
-	.bus		= &platform_bus_type,
+static struct platform_driver au1200fb_driver = {
+	.driver	= {
+		.name	= "au1200-lcd",
+		.owner	= THIS_MODULE,
+	},
 	.probe		= au1200fb_drv_probe,
 	.remove		= au1200fb_drv_remove,
-#ifdef CONFIG_PM
 	.suspend	= au1200fb_drv_suspend,
 	.resume		= au1200fb_drv_resume,
-#endif
 };
 
 /*-------------------------------------------------------------------------*/
@@ -1831,56 +1810,6 @@ static void au1200fb_setup(void)
 	}
 }
 
-#ifdef CONFIG_PM
-static int au1200fb_pm_callback(au1xxx_power_dev_t *dev,
-		au1xxx_request_t request, void *data) {
-	int retval = -1;
-	unsigned int d = 0;
-	unsigned int brightness = 0;
-
-	if (request == AU1XXX_PM_SLEEP) {
-		board_au1200fb_panel_shutdown();
-	}
-	else if (request == AU1XXX_PM_WAKEUP) {
-		if(dev->prev_state == SLEEP_STATE)
-		{
-			int plane;
-			au1200_setpanel(panel);
-			for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane) 	{
-				struct au1200fb_device *fbdev;
-				fbdev = &_au1200fb_devices[plane];
-				au1200fb_fb_set_par(&fbdev->fb_info);
-			}
-		}
-
-		d = *((unsigned int*)data);
-		if(d <=10) brightness = 26;
-		else if(d<=20) brightness = 51;
-		else if(d<=30) brightness = 77;
-		else if(d<=40) brightness = 102;
-		else if(d<=50) brightness = 128;
-		else if(d<=60) brightness = 153;
-		else if(d<=70) brightness = 179;
-		else if(d<=80) brightness = 204;
-		else if(d<=90) brightness = 230;
-		else brightness = 255;
-		set_brightness(brightness);
-	} else if (request == AU1XXX_PM_GETSTATUS) {
-		return dev->cur_state;
-	} else if (request == AU1XXX_PM_ACCESS) {
-		if (dev->cur_state != SLEEP_STATE)
-			return retval;
-		else {
-			au1200_setpanel(panel);
-		}
-	} else if (request == AU1XXX_PM_IDLE) {
-	} else if (request == AU1XXX_PM_CLEANUP) {
-	}
-
-	return retval;
-}
-#endif
-
 static int __init au1200fb_init(void)
 {
 	print_info("" DRIVER_DESC "");
@@ -1895,23 +1824,12 @@ static int __init au1200fb_init(void)
 	printk(DRIVER_NAME ": Panel %d %s\n", panel_index, panel->name);
 	printk(DRIVER_NAME ": Win %d %s\n", window_index, win->name);
 
-	/* Kickstart the panel, the framebuffers/windows come soon enough */
-	au1200_setpanel(panel);
-
-	#ifdef CONFIG_PM
-	LCD_pm_dev = new_au1xxx_power_device("LCD", &au1200fb_pm_callback, NULL);
-	if ( LCD_pm_dev == NULL)
-		printk(KERN_INFO "Unable to create a power management device entry for the au1200fb.\n");
-	else
-		printk(KERN_INFO "Power management device entry for the au1200fb loaded.\n");
-	#endif
-
-	return driver_register(&au1200fb_driver);
+	return platform_driver_register(&au1200fb_driver);
 }
 
 static void __exit au1200fb_cleanup(void)
 {
-	driver_unregister(&au1200fb_driver);
+	platform_driver_unregister(&au1200fb_driver);
 }
 
 module_init(au1200fb_init);
-- 
1.5.6.4


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
