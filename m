From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/7] backlight: corgi_bl: Generalise to support other Sharp
 SL hardware
Date: Mon, 27 Mar 2006 21:04:21 +0800
Message-ID: <4427E2D5.5060404@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNrXe-0002c8-VC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:13:54 -0800
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FNrXe-0007zZ-F2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Mar 2006 05:13:54 -0800
Received: by xproxy.gmail.com with SMTP id t4so937073wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Mar 2006 05:13:54 -0800 (PST)
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
Cc: Richard Purdie <rpurdie@rpsys.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Richard Purdie <rpurdie@rpsys.net>

Generalise the Corgi backlight driver by moving the default intensity
and limit mask settings into the platform specific data structure. This
enables the driver to support other Zaurus hardware, specifically the
SL-6000x (Tosa) model.

Also change the spinlock to a mutex (the spinlock is overkill).

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/arm/mach-pxa/corgi.c          |    2 ++
 arch/arm/mach-pxa/spitz.c          |    2 ++
 drivers/video/backlight/Kconfig    |    4 ++--
 drivers/video/backlight/corgi_bl.c |   31 +++++++++++++------------------
 include/asm-arm/arch-pxa/sharpsl.h |    2 ++
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 99604a5..d6d7260 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -141,6 +141,8 @@ struct corgissp_machinfo corgi_ssp_machi
  */
 static struct corgibl_machinfo corgi_bl_machinfo = {
 	.max_intensity = 0x2f,
+	.default_intensity = 0x1f,
+	.limit_mask = 0x0b,
 	.set_bl_intensity = corgi_bl_set_intensity,
 };
 
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 3b0aabd..8b57285 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -220,6 +220,8 @@ struct corgissp_machinfo spitz_ssp_machi
  * Spitz Backlight Device
  */
 static struct corgibl_machinfo spitz_bl_machinfo = {
+	.default_intensity = 0x1f,
+	.limit_mask = 0x0b,
 	.max_intensity = 0x2f,
 };
 
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 9d996f2..b895eaa 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -43,11 +43,11 @@ config LCD_DEVICE
 	default y
 
 config BACKLIGHT_CORGI
-	tristate "Sharp Corgi Backlight Driver (SL-C7xx Series)"
+	tristate "Sharp Corgi Backlight Driver (SL Series)"
 	depends on BACKLIGHT_DEVICE && PXA_SHARPSL
 	default y
 	help
-	  If you have a Sharp Zaurus SL-C7xx, say y to enable the
+	  If you have a Sharp Zaurus SL-C7xx, SL-Cxx00 or SL-6000x say y to enable the
 	  backlight driver.
 
 config BACKLIGHT_HP680
diff --git a/drivers/video/backlight/corgi_bl.c b/drivers/video/backlight/corgi_bl.c
index f86213b..2ebbfd9 100644
--- a/drivers/video/backlight/corgi_bl.c
+++ b/drivers/video/backlight/corgi_bl.c
@@ -1,7 +1,7 @@
 /*
- *  Backlight Driver for Sharp Corgi
+ *  Backlight Driver for Sharp Zaurus Handhelds (various models)
  *
- *  Copyright (c) 2004-2005 Richard Purdie
+ *  Copyright (c) 2004-2006 Richard Purdie
  *
  *  Based on Sharp's 2.4 Backlight Driver
  *
@@ -15,21 +15,17 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/fb.h>
 #include <linux/backlight.h>
-
 #include <asm/arch/sharpsl.h>
 #include <asm/hardware/sharpsl_pm.h>
 
-#define CORGI_DEFAULT_INTENSITY		0x1f
-#define CORGI_LIMIT_MASK		0x0b
-
 static int corgibl_intensity;
-static void (*corgibl_mach_set_intensity)(int intensity);
-static spinlock_t bl_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_MUTEX(bl_mutex);
 static struct backlight_properties corgibl_data;
 static struct backlight_device *corgi_backlight_device;
+static struct corgibl_machinfo *bl_machinfo;
 
 static unsigned long corgibl_flags;
 #define CORGIBL_SUSPENDED     0x01
@@ -37,7 +33,6 @@ static unsigned long corgibl_flags;
 
 static int corgibl_send_intensity(struct backlight_device *bd)
 {
-	unsigned long flags;
 	void (*corgi_kick_batt)(void);
 	int intensity = bd->props->brightness;
 
@@ -48,13 +43,11 @@ static int corgibl_send_intensity(struct
 	if (corgibl_flags & CORGIBL_SUSPENDED)
 		intensity = 0;
 	if (corgibl_flags & CORGIBL_BATTLOW)
-		intensity &= CORGI_LIMIT_MASK;
-
-	spin_lock_irqsave(&bl_lock, flags);
-
-	corgibl_mach_set_intensity(intensity);
+		intensity &= bl_machinfo->limit_mask;
 
-	spin_unlock_irqrestore(&bl_lock, flags);
+ 	mutex_lock(&bl_mutex);
+	bl_machinfo->set_bl_intensity(intensity);
+	mutex_unlock(&bl_mutex);
 
 	corgibl_intensity = intensity;
 
@@ -122,8 +115,10 @@ static int __init corgibl_probe(struct p
 {
 	struct corgibl_machinfo *machinfo = pdev->dev.platform_data;
 
+	bl_machinfo = machinfo;
 	corgibl_data.max_brightness = machinfo->max_intensity;
-	corgibl_mach_set_intensity = machinfo->set_bl_intensity;
+	if (!machinfo->limit_mask)
+		machinfo->limit_mask = -1;
 
 	corgi_backlight_device = backlight_device_register ("corgi-bl",
 		NULL, &corgibl_data);
@@ -131,7 +126,7 @@ static int __init corgibl_probe(struct p
 		return PTR_ERR (corgi_backlight_device);
 
 	corgibl_data.power = FB_BLANK_UNBLANK;
-	corgibl_data.brightness = CORGI_DEFAULT_INTENSITY;
+	corgibl_data.brightness = machinfo->default_intensity;
 	corgibl_send_intensity(corgi_backlight_device);
 
 	printk("Corgi Backlight Driver Initialized.\n");
diff --git a/include/asm-arm/arch-pxa/sharpsl.h b/include/asm-arm/arch-pxa/sharpsl.h
index 0b43495..94cb498 100644
--- a/include/asm-arm/arch-pxa/sharpsl.h
+++ b/include/asm-arm/arch-pxa/sharpsl.h
@@ -27,6 +27,8 @@ struct corgits_machinfo {
  */
 struct corgibl_machinfo {
 	int max_intensity;
+	int default_intensity;
+	int limit_mask;
 	void (*set_bl_intensity)(int intensity);
 };
 extern void corgibl_limit_intensity(int limit);



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
