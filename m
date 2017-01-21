From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sat, 21 Jan 2017 15:16:23 +0000
Subject: [PATCH 3/3] fbdev: omap/lcd: Make callbacks optional
Message-Id: <1485011783-22521-3-git-send-email-lars@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Most OMAP FB LCD drivers don't have anything to do in their panel
callbacks. This leads to a large set of empty boilerplate functions in the
panel drivers. Make those callbacks optional by checking if they are set
before calling them. This allows those boilerplate functions to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/video/fbdev/omap/lcd_ams_delta.c |  6 ------
 drivers/video/fbdev/omap/lcd_h3.c        | 17 -----------------
 drivers/video/fbdev/omap/lcd_htcherald.c | 30 ------------------------------
 drivers/video/fbdev/omap/lcd_inn1510.c   | 18 ------------------
 drivers/video/fbdev/omap/lcd_inn1610.c   |  6 ------
 drivers/video/fbdev/omap/lcd_osk.c       | 18 ------------------
 drivers/video/fbdev/omap/lcd_palmte.c    | 30 ------------------------------
 drivers/video/fbdev/omap/lcd_palmtt.c    | 23 -----------------------
 drivers/video/fbdev/omap/lcd_palmz71.c   | 24 ------------------------
 drivers/video/fbdev/omap/omapfb_main.c   | 31 ++++++++++++++++++++-----------
 10 files changed, 20 insertions(+), 183 deletions(-)

diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
index ef0ed74..a4ee947 100644
--- a/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
@@ -136,11 +136,6 @@ static void ams_delta_panel_disable(struct lcd_panel *panel)
 	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_NDISP, 0);
 }
 
-static unsigned long ams_delta_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
 static struct lcd_panel ams_delta_panel = {
 	.name		= "ams-delta",
 	.config		= 0,
@@ -163,7 +158,6 @@ static struct lcd_panel ams_delta_panel = {
 	.cleanup	= ams_delta_panel_cleanup,
 	.enable		= ams_delta_panel_enable,
 	.disable	= ams_delta_panel_disable,
-	.get_caps	= ams_delta_panel_get_caps,
 };
 
 
diff --git a/drivers/video/fbdev/omap/lcd_h3.c b/drivers/video/fbdev/omap/lcd_h3.c
index 4281906..9d2da14 100644
--- a/drivers/video/fbdev/omap/lcd_h3.c
+++ b/drivers/video/fbdev/omap/lcd_h3.c
@@ -28,15 +28,6 @@
 
 #define MODULE_NAME	"omapfb-lcd_h3"
 
-static int h3_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
-{
-	return 0;
-}
-
-static void h3_panel_cleanup(struct lcd_panel *panel)
-{
-}
-
 static int h3_panel_enable(struct lcd_panel *panel)
 {
 	int r = 0;
@@ -63,11 +54,6 @@ static void h3_panel_disable(struct lcd_panel *panel)
 		pr_err(MODULE_NAME ": Unable to turn off LCD panel\n");
 }
 
-static unsigned long h3_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
 static struct lcd_panel h3_panel = {
 	.name		= "h3",
 	.config		= OMAP_LCDC_PANEL_TFT,
@@ -85,11 +71,8 @@ static struct lcd_panel h3_panel = {
 	.vbp		= 0,
 	.pcd		= 0,
 
-	.init		= h3_panel_init,
-	.cleanup	= h3_panel_cleanup,
 	.enable		= h3_panel_enable,
 	.disable	= h3_panel_disable,
-	.get_caps	= h3_panel_get_caps,
 };
 
 static int h3_panel_probe(struct platform_device *pdev)
diff --git a/drivers/video/fbdev/omap/lcd_htcherald.c b/drivers/video/fbdev/omap/lcd_htcherald.c
index dd2ce69..9d692f5b 100644
--- a/drivers/video/fbdev/omap/lcd_htcherald.c
+++ b/drivers/video/fbdev/omap/lcd_htcherald.c
@@ -31,30 +31,6 @@
 
 #include "omapfb.h"
 
-static int htcherald_panel_init(struct lcd_panel *panel,
-					struct omapfb_device *fbdev)
-{
-	return 0;
-}
-
-static void htcherald_panel_cleanup(struct lcd_panel *panel)
-{
-}
-
-static int htcherald_panel_enable(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-static void htcherald_panel_disable(struct lcd_panel *panel)
-{
-}
-
-static unsigned long htcherald_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
 /* Found on WIZ200 (miknix) and some HERA110 models (darkstar62) */
 static struct lcd_panel htcherald_panel_1 = {
 	.name		= "lcd_herald",
@@ -74,12 +50,6 @@ static struct lcd_panel htcherald_panel_1 = {
 	.vsw		= 3,
 	.vfp		= 2,
 	.vbp		= 2,
-
-	.init		= htcherald_panel_init,
-	.cleanup	= htcherald_panel_cleanup,
-	.enable		= htcherald_panel_enable,
-	.disable	= htcherald_panel_disable,
-	.get_caps	= htcherald_panel_get_caps,
 };
 
 static int htcherald_panel_probe(struct platform_device *pdev)
diff --git a/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
index dd1f99a..b284050 100644
--- a/drivers/video/fbdev/omap/lcd_inn1510.c
+++ b/drivers/video/fbdev/omap/lcd_inn1510.c
@@ -27,16 +27,6 @@
 
 #include "omapfb.h"
 
-static int innovator1510_panel_init(struct lcd_panel *panel,
-				    struct omapfb_device *fbdev)
-{
-	return 0;
-}
-
-static void innovator1510_panel_cleanup(struct lcd_panel *panel)
-{
-}
-
 static int innovator1510_panel_enable(struct lcd_panel *panel)
 {
 	__raw_writeb(0x7, OMAP1510_FPGA_LCD_PANEL_CONTROL);
@@ -48,11 +38,6 @@ static void innovator1510_panel_disable(struct lcd_panel *panel)
 	__raw_writeb(0x0, OMAP1510_FPGA_LCD_PANEL_CONTROL);
 }
 
-static unsigned long innovator1510_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
 static struct lcd_panel innovator1510_panel = {
 	.name		= "inn1510",
 	.config		= OMAP_LCDC_PANEL_TFT,
@@ -70,11 +55,8 @@ static struct lcd_panel innovator1510_panel = {
 	.vbp		= 0,
 	.pcd		= 12,
 
-	.init		= innovator1510_panel_init,
-	.cleanup	= innovator1510_panel_cleanup,
 	.enable		= innovator1510_panel_enable,
 	.disable	= innovator1510_panel_disable,
-	.get_caps	= innovator1510_panel_get_caps,
 };
 
 static int innovator1510_panel_probe(struct platform_device *pdev)
diff --git a/drivers/video/fbdev/omap/lcd_inn1610.c b/drivers/video/fbdev/omap/lcd_inn1610.c
index 2f72eca..1841710 100644
--- a/drivers/video/fbdev/omap/lcd_inn1610.c
+++ b/drivers/video/fbdev/omap/lcd_inn1610.c
@@ -69,11 +69,6 @@ static void innovator1610_panel_disable(struct lcd_panel *panel)
 	gpio_set_value(15, 0);
 }
 
-static unsigned long innovator1610_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
 static struct lcd_panel innovator1610_panel = {
 	.name		= "inn1610",
 	.config		= OMAP_LCDC_PANEL_TFT,
@@ -95,7 +90,6 @@ static struct lcd_panel innovator1610_panel = {
 	.cleanup	= innovator1610_panel_cleanup,
 	.enable		= innovator1610_panel_enable,
 	.disable	= innovator1610_panel_disable,
-	.get_caps	= innovator1610_panel_get_caps,
 };
 
 static int innovator1610_panel_probe(struct platform_device *pdev)
diff --git a/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/omap/lcd_osk.c
index 4b01c4e..b0be577 100644
--- a/drivers/video/fbdev/omap/lcd_osk.c
+++ b/drivers/video/fbdev/omap/lcd_osk.c
@@ -29,16 +29,6 @@
 
 #include "omapfb.h"
 
-static int osk_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
-{
-	/* gpio2 was allocated in board init */
-	return 0;
-}
-
-static void osk_panel_cleanup(struct lcd_panel *panel)
-{
-}
-
 static int osk_panel_enable(struct lcd_panel *panel)
 {
 	/* configure PWL pin */
@@ -68,11 +58,6 @@ static void osk_panel_disable(struct lcd_panel *panel)
 	gpio_set_value(2, 0);
 }
 
-static unsigned long osk_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
 static struct lcd_panel osk_panel = {
 	.name		= "osk",
 	.config		= OMAP_LCDC_PANEL_TFT,
@@ -90,11 +75,8 @@ static struct lcd_panel osk_panel = {
 	.vbp		= 0,
 	.pcd		= 12,
 
-	.init		= osk_panel_init,
-	.cleanup	= osk_panel_cleanup,
 	.enable		= osk_panel_enable,
 	.disable	= osk_panel_disable,
-	.get_caps	= osk_panel_get_caps,
 };
 
 static int osk_panel_probe(struct platform_device *pdev)
diff --git a/drivers/video/fbdev/omap/lcd_palmte.c b/drivers/video/fbdev/omap/lcd_palmte.c
index fef7e45..cef9638 100644
--- a/drivers/video/fbdev/omap/lcd_palmte.c
+++ b/drivers/video/fbdev/omap/lcd_palmte.c
@@ -25,30 +25,6 @@
 
 #include "omapfb.h"
 
-static int palmte_panel_init(struct lcd_panel *panel,
-				struct omapfb_device *fbdev)
-{
-	return 0;
-}
-
-static void palmte_panel_cleanup(struct lcd_panel *panel)
-{
-}
-
-static int palmte_panel_enable(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-static void palmte_panel_disable(struct lcd_panel *panel)
-{
-}
-
-static unsigned long palmte_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
 static struct lcd_panel palmte_panel = {
 	.name		= "palmte",
 	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
@@ -67,12 +43,6 @@ static struct lcd_panel palmte_panel = {
 	.vfp		= 8,
 	.vbp		= 7,
 	.pcd		= 0,
-
-	.init		= palmte_panel_init,
-	.cleanup	= palmte_panel_cleanup,
-	.enable		= palmte_panel_enable,
-	.disable	= palmte_panel_disable,
-	.get_caps	= palmte_panel_get_caps,
 };
 
 static int palmte_panel_probe(struct platform_device *pdev)
diff --git a/drivers/video/fbdev/omap/lcd_palmtt.c b/drivers/video/fbdev/omap/lcd_palmtt.c
index bd06314..627f13d 100644
--- a/drivers/video/fbdev/omap/lcd_palmtt.c
+++ b/drivers/video/fbdev/omap/lcd_palmtt.c
@@ -32,25 +32,6 @@ GPIO13 - screen blanking
 
 #include "omapfb.h"
 
-static int palmtt_panel_init(struct lcd_panel *panel,
-	struct omapfb_device *fbdev)
-{
-	return 0;
-}
-
-static void palmtt_panel_cleanup(struct lcd_panel *panel)
-{
-}
-
-static int palmtt_panel_enable(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-static void palmtt_panel_disable(struct lcd_panel *panel)
-{
-}
-
 static unsigned long palmtt_panel_get_caps(struct lcd_panel *panel)
 {
 	return OMAPFB_CAPS_SET_BACKLIGHT;
@@ -74,10 +55,6 @@ static struct lcd_panel palmtt_panel = {
 	.vbp		= 7,
 	.pcd		= 0,
 
-	.init		= palmtt_panel_init,
-	.cleanup	= palmtt_panel_cleanup,
-	.enable		= palmtt_panel_enable,
-	.disable	= palmtt_panel_disable,
 	.get_caps	= palmtt_panel_get_caps,
 };
 
diff --git a/drivers/video/fbdev/omap/lcd_palmz71.c b/drivers/video/fbdev/omap/lcd_palmz71.c
index bff7425..c46d4db 100644
--- a/drivers/video/fbdev/omap/lcd_palmz71.c
+++ b/drivers/video/fbdev/omap/lcd_palmz71.c
@@ -26,26 +26,6 @@
 
 #include "omapfb.h"
 
-static int palmz71_panel_init(struct lcd_panel *panel,
-			      struct omapfb_device *fbdev)
-{
-	return 0;
-}
-
-static void palmz71_panel_cleanup(struct lcd_panel *panel)
-{
-
-}
-
-static int palmz71_panel_enable(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-static void palmz71_panel_disable(struct lcd_panel *panel)
-{
-}
-
 static unsigned long palmz71_panel_get_caps(struct lcd_panel *panel)
 {
 	return OMAPFB_CAPS_SET_BACKLIGHT;
@@ -69,10 +49,6 @@ static struct lcd_panel palmz71_panel = {
 	.vbp		= 7,
 	.pcd		= 0,
 
-	.init		= palmz71_panel_init,
-	.cleanup	= palmz71_panel_cleanup,
-	.enable		= palmz71_panel_enable,
-	.disable	= palmz71_panel_disable,
 	.get_caps	= palmz71_panel_get_caps,
 };
 
diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 6429f33..1abba07 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -337,7 +337,8 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 		if (fbdev->state = OMAPFB_SUSPENDED) {
 			if (fbdev->ctrl->resume)
 				fbdev->ctrl->resume();
-			fbdev->panel->enable(fbdev->panel);
+			if (fbdev->panel->enable)
+				fbdev->panel->enable(fbdev->panel);
 			fbdev->state = OMAPFB_ACTIVE;
 			if (fbdev->ctrl->get_update_mode() =
 					OMAPFB_MANUAL_UPDATE)
@@ -346,7 +347,8 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 		break;
 	case FB_BLANK_POWERDOWN:
 		if (fbdev->state = OMAPFB_ACTIVE) {
-			fbdev->panel->disable(fbdev->panel);
+			if (fbdev->panel->disable)
+				fbdev->panel->disable(fbdev->panel);
 			if (fbdev->ctrl->suspend)
 				fbdev->ctrl->suspend();
 			fbdev->state = OMAPFB_SUSPENDED;
@@ -1030,7 +1032,8 @@ static void omapfb_get_caps(struct omapfb_device *fbdev, int plane,
 {
 	memset(caps, 0, sizeof(*caps));
 	fbdev->ctrl->get_caps(plane, caps);
-	caps->ctrl |= fbdev->panel->get_caps(fbdev->panel);
+	if (fbdev->panel->get_caps)
+		caps->ctrl |= fbdev->panel->get_caps(fbdev->panel);
 }
 
 /* For lcd testing */
@@ -1549,7 +1552,8 @@ static void omapfb_free_resources(struct omapfb_device *fbdev, int state)
 	case 7:
 		omapfb_unregister_sysfs(fbdev);
 	case 6:
-		fbdev->panel->disable(fbdev->panel);
+		if (fbdev->panel->disable)
+			fbdev->panel->disable(fbdev->panel);
 	case 5:
 		omapfb_set_update_mode(fbdev, OMAPFB_UPDATE_DISABLED);
 	case 4:
@@ -1557,7 +1561,8 @@ static void omapfb_free_resources(struct omapfb_device *fbdev, int state)
 	case 3:
 		ctrl_cleanup(fbdev);
 	case 2:
-		fbdev->panel->cleanup(fbdev->panel);
+		if (fbdev->panel->cleanup)
+			fbdev->panel->cleanup(fbdev->panel);
 	case 1:
 		dev_set_drvdata(fbdev->dev, NULL);
 		kfree(fbdev);
@@ -1680,9 +1685,11 @@ static int omapfb_do_probe(struct platform_device *pdev,
 		goto cleanup;
 	}
 
-	r = fbdev->panel->init(fbdev->panel, fbdev);
-	if (r)
-		goto cleanup;
+	if (fbdev->panel->init) {
+		r = fbdev->panel->init(fbdev->panel, fbdev);
+		if (r)
+			goto cleanup;
+	}
 
 	pr_info("omapfb: configured for panel %s\n", fbdev->panel->name);
 
@@ -1725,9 +1732,11 @@ static int omapfb_do_probe(struct platform_device *pdev,
 				   OMAPFB_MANUAL_UPDATE : OMAPFB_AUTO_UPDATE);
 	init_state++;
 
-	r = fbdev->panel->enable(fbdev->panel);
-	if (r)
-		goto cleanup;
+	if (fbdev->panel->enable) {
+		r = fbdev->panel->enable(fbdev->panel);
+		if (r)
+			goto cleanup;
+	}
 	init_state++;
 
 	r = omapfb_register_sysfs(fbdev);
-- 
2.1.4

