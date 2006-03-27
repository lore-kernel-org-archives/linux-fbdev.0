From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/7] backlight: HP Jornada 680 Backlight driver updates/fixes
Date: Mon, 27 Mar 2006 21:02:59 +0800
Message-ID: <4427E283.3090205@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNrXZ-0002bj-OP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:13:49 -0800
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FNrXZ-0007zZ-7e
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:13:49 -0800
Received: by xproxy.gmail.com with SMTP id t4so937073wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Mar 2006 05:13:49 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Richard Purdie <rpurdie@rpsys.net>, askulysh@image.kiev.ua

From: Richard Purdie <rpurdie@rpsys.net>

Updates to the HP Jornada 680 Backlight driver:

* Correct the suspend/resume functions so the driver compiles
(SUSPEND_POWER_DOWN/RESUME_POWER_ON no longer exist).
* Convert the driver to match the recent platform device changes.
* Replace the unsafe static struct platform_device with dynamic
allocation.
* Convert the driver to the new backlight code.

This has not been tested on a device due to lack of hardware but
wouldn't compile beforehand.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/backlight/hp680_bl.c |  139 +++++++++++++++---------------------
 1 files changed, 59 insertions(+), 80 deletions(-)

diff --git a/drivers/video/backlight/hp680_bl.c b/drivers/video/backlight/hp680_bl.c
index 95da4c9..a71e984 100644
--- a/drivers/video/backlight/hp680_bl.c
+++ b/drivers/video/backlight/hp680_bl.c
@@ -13,7 +13,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/fb.h>
 #include <linux/backlight.h>
@@ -25,66 +25,58 @@
 #define HP680_MAX_INTENSITY 255
 #define HP680_DEFAULT_INTENSITY 10
 
-static int hp680bl_powermode = FB_BLANK_UNBLANK;
+static int hp680bl_suspended;
 static int current_intensity = 0;
 static spinlock_t bl_lock = SPIN_LOCK_UNLOCKED;
+static struct backlight_device *hp680_backlight_device;
 
-static void hp680bl_send_intensity(int intensity)
+static void hp680bl_send_intensity(struct backlight_device *bd)
 {
 	unsigned long flags;
+	u16 v;
+	int intensity = bd->props->brightness;
 
-	if (hp680bl_powermode != FB_BLANK_UNBLANK)
+	if (bd->props->power != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (bd->props->fb_blank != FB_BLANK_UNBLANK)
+		intensity = 0;
+	if (hp680bl_suspended)
 		intensity = 0;
 
 	spin_lock_irqsave(&bl_lock, flags);
-	sh_dac_output(255-(u8)intensity, DAC_LCD_BRIGHTNESS);
+	if (intensity && current_intensity == 0) {
+		sh_dac_enable(DAC_LCD_BRIGHTNESS);
+		v = inw(HD64461_GPBDR);
+		v &= ~HD64461_GPBDR_LCDOFF;
+		outw(v, HD64461_GPBDR);
+		sh_dac_output(255-(u8)intensity, DAC_LCD_BRIGHTNESS);
+	} else if (intensity == 0 && current_intensity != 0) {
+		sh_dac_output(255-(u8)intensity, DAC_LCD_BRIGHTNESS);
+		sh_dac_disable(DAC_LCD_BRIGHTNESS);
+		v = inw(HD64461_GPBDR);
+		v |= HD64461_GPBDR_LCDOFF;
+		outw(v, HD64461_GPBDR);
+	} else if (intensity) {
+		sh_dac_output(255-(u8)intensity, DAC_LCD_BRIGHTNESS);
+	}
 	spin_unlock_irqrestore(&bl_lock, flags);
-}
-
-static void hp680bl_blank(int blank)
-{
-	u16 v;
 
-	switch(blank) {
-
-	case FB_BLANK_NORMAL:
-	case FB_BLANK_VSYNC_SUSPEND:
-	case FB_BLANK_HSYNC_SUSPEND:
-	case FB_BLANK_POWERDOWN:
-		if (hp680bl_powermode == FB_BLANK_UNBLANK) {
-			hp680bl_send_intensity(0);
-			hp680bl_powermode = blank;
-			sh_dac_disable(DAC_LCD_BRIGHTNESS);
-			v = inw(HD64461_GPBDR);
-			v |= HD64461_GPBDR_LCDOFF;
-			outw(v, HD64461_GPBDR);
-		}
-		break;
-	case FB_BLANK_UNBLANK:
-		if (hp680bl_powermode != FB_BLANK_UNBLANK) {
-			sh_dac_enable(DAC_LCD_BRIGHTNESS);
-			v = inw(HD64461_GPBDR);
-			v &= ~HD64461_GPBDR_LCDOFF;
-			outw(v, HD64461_GPBDR);
-			hp680bl_powermode = blank;
-			hp680bl_send_intensity(current_intensity);
-		}
-		break;
-	}
+	current_intensity = intensity;
 }
 
+
 #ifdef CONFIG_PM
-static int hp680bl_suspend(struct device *dev, pm_message_t state, u32 level)
+static int hp680bl_suspend(struct platform_device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN)
-		hp680bl_blank(FB_BLANK_POWERDOWN);
+	hp680bl_suspended = 1;
+	hp680bl_send_intensity(hp680_backlight_device);
 	return 0;
 }
 
-static int hp680bl_resume(struct device *dev, u32 level)
+static int hp680bl_resume(struct platform_device *dev)
 {
-	if (level == RESUME_POWER_ON)
-		hp680bl_blank(FB_BLANK_UNBLANK);
+	hp680bl_suspended = 0;
+	hp680bl_send_intensity(hp680_backlight_device);
 	return 0;
 }
 #else
@@ -92,24 +84,9 @@ static int hp680bl_resume(struct device 
 #define hp680bl_resume	NULL
 #endif
 
-
-static int hp680bl_set_power(struct backlight_device *bd, int state)
-{
-	hp680bl_blank(state);
-	return 0;
-}
-
-static int hp680bl_get_power(struct backlight_device *bd)
-{
-	return hp680bl_powermode;
-}
-
-static int hp680bl_set_intensity(struct backlight_device *bd, int intensity)
+static int hp680bl_set_intensity(struct backlight_device *bd)
 {
-	if (intensity > HP680_MAX_INTENSITY)
-		intensity = HP680_MAX_INTENSITY;
-	hp680bl_send_intensity(intensity);
-	current_intensity = intensity;
+	hp680bl_send_intensity(bd);
 	return 0;
 }
 
@@ -120,65 +97,67 @@ static int hp680bl_get_intensity(struct 
 
 static struct backlight_properties hp680bl_data = {
 	.owner		= THIS_MODULE,
-	.get_power      = hp680bl_get_power,
-	.set_power      = hp680bl_set_power,
 	.max_brightness = HP680_MAX_INTENSITY,
 	.get_brightness = hp680bl_get_intensity,
-	.set_brightness = hp680bl_set_intensity,
+	.update_status  = hp680bl_set_intensity,
 };
 
-static struct backlight_device *hp680_backlight_device;
-
-static int __init hp680bl_probe(struct device *dev)
+static int __init hp680bl_probe(struct platform_device *dev)
 {
 	hp680_backlight_device = backlight_device_register ("hp680-bl",
 		NULL, &hp680bl_data);
 	if (IS_ERR (hp680_backlight_device))
 		return PTR_ERR (hp680_backlight_device);
 
-	hp680bl_set_intensity(NULL, HP680_DEFAULT_INTENSITY);
+	hp680_backlight_device->props->brightness = HP680_DEFAULT_INTENSITY;
+	hp680bl_send_intensity(hp680_backlight_device);
 
 	return 0;
 }
 
-static int hp680bl_remove(struct device *dev)
+static int hp680bl_remove(struct platform_device *dev)
 {
 	backlight_device_unregister(hp680_backlight_device);
 
 	return 0;
 }
 
-static struct device_driver hp680bl_driver = {
-	.name		= "hp680-bl",
-	.bus		= &platform_bus_type,
+static struct platform_driver hp680bl_driver = {
 	.probe		= hp680bl_probe,
 	.remove		= hp680bl_remove,
 	.suspend	= hp680bl_suspend,
 	.resume		= hp680bl_resume,
+	.driver		= {
+		.name	= "hp680-bl",
+	},
 };
 
-static struct platform_device hp680bl_device = {
-	.name	= "hp680-bl",
-	.id	= -1,
-};
+static struct platform_device *hp680bl_device;
 
 static int __init hp680bl_init(void)
 {
 	int ret;
 
-	ret=driver_register(&hp680bl_driver);
+	ret = platform_driver_register(&hp680bl_driver);
 	if (!ret) {
-		ret = platform_device_register(&hp680bl_device);
-		if (ret)
-			driver_unregister(&hp680bl_driver);
+		hp680bl_device = platform_device_alloc("hp680-bl", -1);
+		if (!hp680bl_device)
+			return -ENOMEM;
+
+		ret = platform_device_add(hp680bl_device);
+
+		if (ret) {
+			platform_device_put(hp680bl_device);
+			platform_driver_unregister(&hp680bl_driver);
+		}
 	}
 	return ret;
 }
 
 static void __exit hp680bl_exit(void)
 {
-	platform_device_unregister(&hp680bl_device);
- 	driver_unregister(&hp680bl_driver);
+	platform_device_unregister(hp680bl_device);
+ 	platform_driver_unregister(&hp680bl_driver);
 }
 
 module_init(hp680bl_init);



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
