From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:34:05 +0000
Subject: [PATCH 13/33] arm: omap: board-omap3evm: use sharp panel's gpio handling
Message-Id: <1360765345-19312-14-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The omap3evm board file currently requests gpios required by the sharp_ls dpi
panel, and provides platform_enable/disable callbacks to configure them.

These tasks have been moved to the sharp_ls panel driver itself and shouldn't
be done in the board files.

Remove the gpio requests and the platform callbacks from the board file.
Add the gpio information to panel_sharp_ls037v7dw01_data so that it's passed
to the panel driver.

Note: The GPIOs OMAP3EVM_LCD_PANEL_ENVDD and OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO
aren't directly connected to the sharp panel, hence they aren't passed to the
panel driver as platform data. These are set to a default value such that LCD
is enabled and backlight is on. These used to previously toggle through the
platform_enable/disable callbacks, but now these are always on. This needs to
be revisited.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   59 ++++++++++++----------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 335127d..dfb5e1b 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -154,61 +154,43 @@ static inline void __init omap3evm_init_smsc911x(void) { return; }
 #define OMAP3EVM_LCD_PANEL_LR		2
 #define OMAP3EVM_LCD_PANEL_UD		3
 #define OMAP3EVM_LCD_PANEL_INI		152
-#define OMAP3EVM_LCD_PANEL_ENVDD	153
 #define OMAP3EVM_LCD_PANEL_QVGA		154
 #define OMAP3EVM_LCD_PANEL_RESB		155
+
+#define OMAP3EVM_LCD_PANEL_ENVDD	153
 #define OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO	210
+
+/*
+ * OMAP3EVM DVI control signals
+ */
 #define OMAP3EVM_DVI_PANEL_EN_GPIO	199
 
-static struct gpio omap3_evm_dss_gpios[] __initdata = {
-	{ OMAP3EVM_LCD_PANEL_RESB,  GPIOF_OUT_INIT_HIGH, "lcd_panel_resb"  },
-	{ OMAP3EVM_LCD_PANEL_INI,   GPIOF_OUT_INIT_HIGH, "lcd_panel_ini"   },
-	{ OMAP3EVM_LCD_PANEL_QVGA,  GPIOF_OUT_INIT_LOW,  "lcd_panel_qvga"  },
-	{ OMAP3EVM_LCD_PANEL_LR,    GPIOF_OUT_INIT_HIGH, "lcd_panel_lr"    },
-	{ OMAP3EVM_LCD_PANEL_UD,    GPIOF_OUT_INIT_HIGH, "lcd_panel_ud"    },
-	{ OMAP3EVM_LCD_PANEL_ENVDD, GPIOF_OUT_INIT_LOW,  "lcd_panel_envdd" },
+static struct panel_sharp_ls037v7dw01_data omap3_evm_lcd_data = {
+	.resb_gpio = OMAP3EVM_LCD_PANEL_RESB,
+	.ini_gpio = OMAP3EVM_LCD_PANEL_INI,
+	.mo_gpio = OMAP3EVM_LCD_PANEL_QVGA,
+	.lr_gpio = OMAP3EVM_LCD_PANEL_LR,
+	.ud_gpio = OMAP3EVM_LCD_PANEL_UD,
 };
 
-static int lcd_enabled;
-static int dvi_enabled;
-
 static void __init omap3_evm_display_init(void)
 {
 	int r;
 
-	r = gpio_request_array(omap3_evm_dss_gpios,
-			       ARRAY_SIZE(omap3_evm_dss_gpios));
+	r = gpio_request_one(OMAP3EVM_LCD_PANEL_ENVDD, GPIOF_OUT_INIT_LOW,
+				"lcd_panel_envdd");
 	if (r)
-		printk(KERN_ERR "failed to get lcd_panel_* gpios\n");
-}
+		pr_err("failed to get lcd_panel_envdd GPIO\n");
 
-static int omap3_evm_enable_lcd(struct omap_dss_device *dssdev)
-{
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
-	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 0);
+	r = gpio_request_one(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO,
+				GPIOF_OUT_INIT_LOW, "lcd_panel_bklight");
+	if (r)
+		pr_err("failed to get lcd_panel_bklight GPIO\n");
 
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
 		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
 	else
 		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
-
-	lcd_enabled = 1;
-	return 0;
-}
-
-static void omap3_evm_disable_lcd(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 1);
-
-	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
-		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 1);
-	else
-		gpio_set_value_cansleep(OMAP3EVM_LCD_PANEL_BKLIGHT_GPIO, 0);
-
-	lcd_enabled = 0;
 }
 
 static struct omap_dss_device omap3_evm_lcd_device = {
@@ -216,8 +198,7 @@ static struct omap_dss_device omap3_evm_lcd_device = {
 	.driver_name		= "sharp_ls_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 18,
-	.platform_enable	= omap3_evm_enable_lcd,
-	.platform_disable	= omap3_evm_disable_lcd,
+	.data			= &omap3_evm_lcd_data,
 };
 
 static int omap3_evm_enable_tv(struct omap_dss_device *dssdev)
-- 
1.7.9.5

