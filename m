From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Fri, 10 Jun 2011 15:23:02 +0000
Subject: [PATCH 2/4] au1200fb: fixup PM
Message-Id: <1307719384-23702-3-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Remove last traces of the unused custom Alchemy PM code, implement
suspend/resume callbacks.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/video/au1200fb.c |  154 ++++++++++++------------------------------=
----
 1 files changed, 39 insertions(+), 115 deletions(-)

diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 442d005..480ecb1 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -46,10 +46,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include "au1200fb.h"
=20
-#ifdef CONFIG_PM
-#include <asm/mach-au1x00/au1xxx_pm.h>
-#endif
-
 #ifndef CONFIG_FB_AU1200_DEVS
 #define CONFIG_FB_AU1200_DEVS 4
 #endif
@@ -205,12 +201,6 @@ struct window_settings {
 extern int board_au1200fb_panel_init (void);
 extern int board_au1200fb_panel_shutdown (void);
=20
-#ifdef CONFIG_PM
-int au1200fb_pm_callback(au1xxx_power_dev_t *dev,
-		au1xxx_request_t request, void *data);
-au1xxx_power_dev_t *LCD_pm_dev;
-#endif
-
 /*
  * Default window configurations
  */
@@ -652,25 +642,6 @@ static struct panel_settings known_lcd_panels[] =20
 /********************************************************************/
=20
-#ifdef CONFIG_PM
-static int set_brightness(unsigned int brightness)
-{
-	unsigned int hi1, divider;
-
-	/* limit brightness pwm duty to >=3D 30/1600 */
-	if (brightness < 30) {
-		brightness =3D 30;
-	}
-	divider =3D (lcd->pwmdiv & 0x3FFFF) + 1;
-	hi1 =3D (lcd->pwmhi >> 16) + 1;
-	hi1 =3D (((brightness & 0xFF) + 1) * divider >> 8);
-	lcd->pwmhi &=3D 0xFFFF;
-	lcd->pwmhi |=3D (hi1 << 16);
-
-	return brightness;
-}
-#endif /* CONFIG_PM */
-
 static int winbpp (unsigned int winctrl1)
 {
 	int bits =3D 0;
@@ -1248,10 +1219,6 @@ static int au1200fb_fb_mmap(struct fb_info *info, st=
ruct vm_area_struct *vma)
 	unsigned long start=3D0, off;
 	struct au1200fb_device *fbdev =3D info->par;
=20
-#ifdef CONFIG_PM
-	au1xxx_pm_access(LCD_pm_dev);
-#endif
-
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
 		return -EINVAL;
 	}
@@ -1461,10 +1428,6 @@ static int au1200fb_ioctl(struct fb_info *info, unsi=
gned int cmd,
 	int plane;
 	int val;
=20
-#ifdef CONFIG_PM
-	au1xxx_pm_access(LCD_pm_dev);
-#endif
-
 	plane =3D fbinfo2index(info);
 	print_dbg("au1200fb: ioctl %d on plane %d\n", cmd, plane);
=20
@@ -1622,7 +1585,7 @@ static int au1200fb_init_fbinfo(struct au1200fb_devic=
e *fbdev)
=20
 /* AU1200 LCD controller device driver */
=20
-static int au1200fb_drv_probe(struct platform_device *dev)
+static int __devinit au1200fb_drv_probe(struct platform_device *dev)
 {
 	struct au1200fb_device *fbdev;
 	struct fb_info *fbi =3D NULL;
@@ -1633,6 +1596,9 @@ static int au1200fb_drv_probe(struct platform_device =
*dev)
 	ret =3D 0;
 	fbdev =3D NULL;
=20
+	/* Kickstart the panel */
+	au1200_setpanel(panel);
+
 	for (plane =3D 0; plane < CONFIG_FB_AU1200_DEVS; ++plane) {
 		bpp =3D winbpp(win->w[plane].mode_winctrl1);
 		if (win->w[plane].xres =3D 0)
@@ -1724,15 +1690,12 @@ failed:
 	return ret;
 }
=20
-static int au1200fb_drv_remove(struct platform_device *dev)
+static int __devexit au1200fb_drv_remove(struct platform_device *dev)
 {
 	struct au1200fb_device *fbdev;
 	struct fb_info *fbi;
 	int plane;
=20
-	if (!dev)
-		return -ENODEV;
-
 	/* Turn off the panel */
 	au1200_setpanel(NULL);
=20
@@ -1760,31 +1723,53 @@ static int au1200fb_drv_remove(struct platform_devi=
ce *dev)
 }
=20
 #ifdef CONFIG_PM
-static int au1200fb_drv_suspend(struct platform_device *dev,
-				pm_message_t state)
+static int au1200fb_drv_suspend(struct device *dev)
 {
-	/* TODO */
+	au1200_setpanel(NULL);
+
+	lcd->outmask =3D 0;
+	au_sync();
+
 	return 0;
 }
=20
-static int au1200fb_drv_resume(struct platform_device *dev)
+static int au1200fb_drv_resume(struct device *dev)
 {
-	/* TODO */
+	struct fb_info *fbi;
+	int i;
+
+	/* Kickstart the panel */
+	au1200_setpanel(panel);
+
+	for (i =3D 0; i < CONFIG_FB_AU1200_DEVS; i++) {
+		fbi =3D _au1200fb_infos[i];
+		au1200fb_fb_set_par(fbi);
+	}
+
 	return 0;
 }
+
+static const struct dev_pm_ops au1200fb_pmops =3D {
+	.suspend	=3D au1200fb_drv_suspend,
+	.resume		=3D au1200fb_drv_resume,
+	.freeze		=3D au1200fb_drv_suspend,
+	.thaw		=3D au1200fb_drv_resume,
+};
+
+#define AU1200FB_PMOPS	(&au1200fb_pmops)
+
+#else
+#define AU1200FB_PMOPS	NULL
 #endif /* CONFIG_PM */
=20
 static struct platform_driver au1200fb_driver =3D {
 	.driver =3D {
-		.name		=3D "au1200-lcd",
-		.owner          =3D THIS_MODULE,
+		.name	=3D "au1200-lcd",
+		.owner	=3D THIS_MODULE,
+		.pm	=3D AU1200FB_PMOPS,
 	},
 	.probe		=3D au1200fb_drv_probe,
-	.remove		=3D au1200fb_drv_remove,
-#ifdef CONFIG_PM
-	.suspend	=3D au1200fb_drv_suspend,
-	.resume		=3D au1200fb_drv_resume,
-#endif
+	.remove		=3D __devexit_p(au1200fb_drv_remove),
 };
=20
 /*------------------------------------------------------------------------=
-*/
@@ -1847,56 +1832,6 @@ static void au1200fb_setup(void)
 	}
 }
=20
-#ifdef CONFIG_PM
-static int au1200fb_pm_callback(au1xxx_power_dev_t *dev,
-		au1xxx_request_t request, void *data) {
-	int retval =3D -1;
-	unsigned int d =3D 0;
-	unsigned int brightness =3D 0;
-
-	if (request =3D AU1XXX_PM_SLEEP) {
-		board_au1200fb_panel_shutdown();
-	}
-	else if (request =3D AU1XXX_PM_WAKEUP) {
-		if(dev->prev_state =3D SLEEP_STATE)
-		{
-			int plane;
-			au1200_setpanel(panel);
-			for (plane =3D 0; plane < CONFIG_FB_AU1200_DEVS; ++plane) 	{
-				struct au1200fb_device *fbdev;
-				fbdev =3D &_au1200fb_devices[plane];
-				au1200fb_fb_set_par(&fbdev->fb_info);
-			}
-		}
-
-		d =3D *((unsigned int*)data);
-		if(d <=10) brightness =3D 26;
-		else if(d< ) brightness =3D 51;
-		else if(d<0) brightness =3D 77;
-		else if(d<@) brightness =3D 102;
-		else if(d<P) brightness =3D 128;
-		else if(d<`) brightness =3D 153;
-		else if(d<p) brightness =3D 179;
-		else if(d<=80) brightness =3D 204;
-		else if(d<=90) brightness =3D 230;
-		else brightness =3D 255;
-		set_brightness(brightness);
-	} else if (request =3D AU1XXX_PM_GETSTATUS) {
-		return dev->cur_state;
-	} else if (request =3D AU1XXX_PM_ACCESS) {
-		if (dev->cur_state !=3D SLEEP_STATE)
-			return retval;
-		else {
-			au1200_setpanel(panel);
-		}
-	} else if (request =3D AU1XXX_PM_IDLE) {
-	} else if (request =3D AU1XXX_PM_CLEANUP) {
-	}
-
-	return retval;
-}
-#endif
-
 static int __init au1200fb_init(void)
 {
 	print_info("" DRIVER_DESC "");
@@ -1911,17 +1846,6 @@ static int __init au1200fb_init(void)
 	printk(DRIVER_NAME ": Panel %d %s\n", panel_index, panel->name);
 	printk(DRIVER_NAME ": Win %d %s\n", window_index, win->name);
=20
-	/* Kickstart the panel, the framebuffers/windows come soon enough */
-	au1200_setpanel(panel);
-
-	#ifdef CONFIG_PM
-	LCD_pm_dev =3D new_au1xxx_power_device("LCD", &au1200fb_pm_callback, NULL=
);
-	if ( LCD_pm_dev =3D NULL)
-		printk(KERN_INFO "Unable to create a power management device entry for t=
he au1200fb.\n");
-	else
-		printk(KERN_INFO "Power management device entry for the au1200fb loaded.=
\n");
-	#endif
-
 	return platform_driver_register(&au1200fb_driver);
 }
=20
--=20
1.7.5.3

