From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 04 May 2011 12:27:34 +0000
Subject: [PATCH 2/7] OMAP: RX51: Remove unused old omapfb stuff
Message-Id: <1304512059-10372-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

RX51 uses the new DSS2 display driver, but the board file still
contained some code for the old omapfb driver. The old code can be
removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-rx51.c |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index e964895..116e19b 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -75,29 +75,6 @@ static struct cpuidle_params rx51_cpuidle_params[] = {
 	{1, 7505, 15274, 484329},
 };
 
-static struct omap_lcd_config rx51_lcd_config = {
-	.ctrl_name	= "internal",
-};
-
-static struct omap_fbmem_config rx51_fbmem0_config = {
-	.size = 752 * 1024,
-};
-
-static struct omap_fbmem_config rx51_fbmem1_config = {
-	.size = 752 * 1024,
-};
-
-static struct omap_fbmem_config rx51_fbmem2_config = {
-	.size = 752 * 1024,
-};
-
-static struct omap_board_config_kernel rx51_config[] = {
-	{ OMAP_TAG_FBMEM,	&rx51_fbmem0_config },
-	{ OMAP_TAG_FBMEM,	&rx51_fbmem1_config },
-	{ OMAP_TAG_FBMEM,	&rx51_fbmem2_config },
-	{ OMAP_TAG_LCD,		&rx51_lcd_config },
-};
-
 static void __init rx51_init_early(void)
 {
 	struct omap_sdrc_params *sdrc_params;
@@ -124,8 +101,6 @@ static struct omap_musb_board_data musb_board_data = {
 static void __init rx51_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_board_config = rx51_config;
-	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
-- 
1.7.4.1

