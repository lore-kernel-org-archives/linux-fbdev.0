From: Daniel Drake <dsd@laptop.org>
Date: Tue, 10 May 2011 19:55:46 +0000
Subject: [PATCH v2] viafb: Automatic OLPC XO-1.5 configuration
Message-Id: <20110510195546.728739D401C@zog.reactivated.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Currently, a long set of viafb options are needed to get the XO-1.5
laptop to output video (there is only 1 configuration that works, that
can't really be autodetected).

This patch automatically detects and configures viafb for the XO-1.5
laptop, meaning all that is required for working display is that
viafb is loaded.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/video/via/viafbdev.c |   41 ++++++++++++++++++++++++++++++++---------
 1 files changed, 32 insertions(+), 9 deletions(-)

v2: incorporates all feedback from Florian

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 7b4390e..7a4dd0e 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/via-core.h>
+#include <asm/olpc.h>
 
 #define _MASTER_FILE
 #include "global.h"
@@ -1011,8 +1012,13 @@ static int __init parse_active_dev(void)
 	/*    Note: The previous of active_dev is primary device,
 	   and the following is secondary device. */
 	if (!viafb_active_dev) {
-		viafb_CRT_ON = STATE_ON;
-		viafb_SAMM_ON = STATE_OFF;
+		if (machine_is_olpc()) { /* LCD only */
+			viafb_LCD_ON = STATE_ON;
+			viafb_SAMM_ON = STATE_OFF;
+		} else {
+			viafb_CRT_ON = STATE_ON;
+			viafb_SAMM_ON = STATE_OFF;
+		}
 	} else if (!strcmp(viafb_active_dev, "CRT+DVI")) {
 		/* CRT+DVI */
 		viafb_CRT_ON = STATE_ON;
@@ -1665,8 +1671,13 @@ static int parse_mode(const char *str, u32 *xres, u32 *yres)
 	char *ptr;
 
 	if (!str) {
-		*xres = 640;
-		*yres = 480;
+		if (machine_is_olpc()) {
+			*xres = 1200;
+			*yres = 900;
+		} else {
+			*xres = 640;
+			*yres = 480;
+		}
 		return 0;
 	}
 
@@ -1922,11 +1933,16 @@ void __devexit via_fb_pci_remove(struct pci_dev *pdev)
 }
 
 #ifndef MODULE
-static int __init viafb_setup(char *options)
+static int __init viafb_setup(void)
 {
 	char *this_opt;
+	char *options;
+
 	DEBUG_MSG(KERN_INFO "viafb_setup!\n");
 
+	if (fb_get_options("viafb", &options))
+		return -ENODEV;
+
 	if (!options || !*options)
 		return 0;
 
@@ -2000,11 +2016,18 @@ static int __init viafb_setup(char *options)
 int __init viafb_init(void)
 {
 	u32 dummy_x, dummy_y;
+	int r;
+
+	if (machine_is_olpc()) {
+		/* Apply XO-1.5-specific configuration. */
+		viafb_lcd_panel_id = 23;
+		viafb_bpp = 24;
+	}
+
 #ifndef MODULE
-	char *option = NULL;
-	if (fb_get_options("viafb", &option))
-		return -ENODEV;
-	viafb_setup(option);
+	r = viafb_setup();
+	if (r < 0)
+		return r;
 #endif
 	if (parse_mode(viafb_mode, &dummy_x, &dummy_y)
 		|| !viafb_get_mode(dummy_x, dummy_y)
-- 
1.7.4.4

