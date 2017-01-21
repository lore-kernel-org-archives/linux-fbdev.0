From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sat, 21 Jan 2017 15:16:22 +0000
Subject: [PATCH 2/3] fbdev: omap/lcd: Staticize non-exported lcd_panel structs
Message-Id: <1485011783-22521-2-git-send-email-lars@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

None of the lcd_panel structs defined by the OMAP LCD drivers are
referenced outside of their compilation unit. Follow best practices and
mark them as static.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/video/fbdev/omap/lcd_h3.c        | 2 +-
 drivers/video/fbdev/omap/lcd_htcherald.c | 2 +-
 drivers/video/fbdev/omap/lcd_inn1510.c   | 2 +-
 drivers/video/fbdev/omap/lcd_inn1610.c   | 2 +-
 drivers/video/fbdev/omap/lcd_osk.c       | 2 +-
 drivers/video/fbdev/omap/lcd_palmte.c    | 2 +-
 drivers/video/fbdev/omap/lcd_palmtt.c    | 2 +-
 drivers/video/fbdev/omap/lcd_palmz71.c   | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap/lcd_h3.c b/drivers/video/fbdev/omap/lcd_h3.c
index a38af2f..4281906 100644
--- a/drivers/video/fbdev/omap/lcd_h3.c
+++ b/drivers/video/fbdev/omap/lcd_h3.c
@@ -68,7 +68,7 @@ static unsigned long h3_panel_get_caps(struct lcd_panel *panel)
 	return 0;
 }
 
-struct lcd_panel h3_panel = {
+static struct lcd_panel h3_panel = {
 	.name		= "h3",
 	.config		= OMAP_LCDC_PANEL_TFT,
 
diff --git a/drivers/video/fbdev/omap/lcd_htcherald.c b/drivers/video/fbdev/omap/lcd_htcherald.c
index a2ca5e9..dd2ce69 100644
--- a/drivers/video/fbdev/omap/lcd_htcherald.c
+++ b/drivers/video/fbdev/omap/lcd_htcherald.c
@@ -56,7 +56,7 @@ static unsigned long htcherald_panel_get_caps(struct lcd_panel *panel)
 }
 
 /* Found on WIZ200 (miknix) and some HERA110 models (darkstar62) */
-struct lcd_panel htcherald_panel_1 = {
+static struct lcd_panel htcherald_panel_1 = {
 	.name		= "lcd_herald",
 	.config		= OMAP_LCDC_PANEL_TFT |
 			  OMAP_LCDC_INV_HSYNC |
diff --git a/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
index a549337..dd1f99a 100644
--- a/drivers/video/fbdev/omap/lcd_inn1510.c
+++ b/drivers/video/fbdev/omap/lcd_inn1510.c
@@ -53,7 +53,7 @@ static unsigned long innovator1510_panel_get_caps(struct lcd_panel *panel)
 	return 0;
 }
 
-struct lcd_panel innovator1510_panel = {
+static struct lcd_panel innovator1510_panel = {
 	.name		= "inn1510",
 	.config		= OMAP_LCDC_PANEL_TFT,
 
diff --git a/drivers/video/fbdev/omap/lcd_inn1610.c b/drivers/video/fbdev/omap/lcd_inn1610.c
index 7319563..2f72eca 100644
--- a/drivers/video/fbdev/omap/lcd_inn1610.c
+++ b/drivers/video/fbdev/omap/lcd_inn1610.c
@@ -74,7 +74,7 @@ static unsigned long innovator1610_panel_get_caps(struct lcd_panel *panel)
 	return 0;
 }
 
-struct lcd_panel innovator1610_panel = {
+static struct lcd_panel innovator1610_panel = {
 	.name		= "inn1610",
 	.config		= OMAP_LCDC_PANEL_TFT,
 
diff --git a/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/omap/lcd_osk.c
index 3f4a18b..4b01c4e 100644
--- a/drivers/video/fbdev/omap/lcd_osk.c
+++ b/drivers/video/fbdev/omap/lcd_osk.c
@@ -73,7 +73,7 @@ static unsigned long osk_panel_get_caps(struct lcd_panel *panel)
 	return 0;
 }
 
-struct lcd_panel osk_panel = {
+static struct lcd_panel osk_panel = {
 	.name		= "osk",
 	.config		= OMAP_LCDC_PANEL_TFT,
 
diff --git a/drivers/video/fbdev/omap/lcd_palmte.c b/drivers/video/fbdev/omap/lcd_palmte.c
index c0cee37..fef7e45 100644
--- a/drivers/video/fbdev/omap/lcd_palmte.c
+++ b/drivers/video/fbdev/omap/lcd_palmte.c
@@ -49,7 +49,7 @@ static unsigned long palmte_panel_get_caps(struct lcd_panel *panel)
 	return 0;
 }
 
-struct lcd_panel palmte_panel = {
+static struct lcd_panel palmte_panel = {
 	.name		= "palmte",
 	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
 			  OMAP_LCDC_INV_HSYNC | OMAP_LCDC_HSVS_RISING_EDGE |
diff --git a/drivers/video/fbdev/omap/lcd_palmtt.c b/drivers/video/fbdev/omap/lcd_palmtt.c
index 621952b..bd06314 100644
--- a/drivers/video/fbdev/omap/lcd_palmtt.c
+++ b/drivers/video/fbdev/omap/lcd_palmtt.c
@@ -56,7 +56,7 @@ static unsigned long palmtt_panel_get_caps(struct lcd_panel *panel)
 	return OMAPFB_CAPS_SET_BACKLIGHT;
 }
 
-struct lcd_panel palmtt_panel = {
+static struct lcd_panel palmtt_panel = {
 	.name		= "palmtt",
 	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
 			OMAP_LCDC_INV_HSYNC | OMAP_LCDC_HSVS_RISING_EDGE |
diff --git a/drivers/video/fbdev/omap/lcd_palmz71.c b/drivers/video/fbdev/omap/lcd_palmz71.c
index ccb556d..bff7425 100644
--- a/drivers/video/fbdev/omap/lcd_palmz71.c
+++ b/drivers/video/fbdev/omap/lcd_palmz71.c
@@ -51,7 +51,7 @@ static unsigned long palmz71_panel_get_caps(struct lcd_panel *panel)
 	return OMAPFB_CAPS_SET_BACKLIGHT;
 }
 
-struct lcd_panel palmz71_panel = {
+static struct lcd_panel palmz71_panel = {
 	.name		= "palmz71",
 	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
 			  OMAP_LCDC_INV_HSYNC | OMAP_LCDC_HSVS_RISING_EDGE |
-- 
2.1.4

