From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:34:14 +0000
Subject: [PATCH 22/33] arm: omap: board-omap3pandora: use tpo panel's gpio handling
Message-Id: <1360765345-19312-23-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The omap3pandora board file currently passes the reset gpio number to the
tpo-td043mtea1 panel driver via the reset_gpio field in omap_dss_device.

Platform related information should be passed via the panel driver's platform
data struct.

Add the reset gpio information to panel_tpo_td043_data so that it's passed to
the panel driver.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index a53a668..ddd6322 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -43,6 +43,7 @@
 
 #include "common.h"
 #include <video/omapdss.h>
+#include <video/omap-panel-data.h>
 #include <linux/platform_data/mtd-nand-omap2.h>
 
 #include "mux.h"
@@ -229,12 +230,16 @@ static struct twl4030_keypad_data pandora_kp_data = {
 	.rep		= 1,
 };
 
+static struct panel_tpo_td043_data lcd_data = {
+	.nreset_gpio		= 157,
+};
+
 static struct omap_dss_device pandora_lcd_device = {
 	.name			= "lcd",
 	.driver_name		= "tpo_td043mtea1_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
-	.reset_gpio		= 157,
+	.data			= &lcd_data,
 };
 
 static struct omap_dss_device pandora_tv_device = {
-- 
1.7.9.5

