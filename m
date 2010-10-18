From: Sangbeom Kim <sbkim73@samsung.com>
Date: Mon, 18 Oct 2010 12:55:28 +0000
Subject: [PATCH 4/4] ARM: S5PV310: Add platform data for S5PV310 FIMD and LTE480WV platform-lcd
Message-Id: <1287406528-15324-5-git-send-email-sbkim73@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1287406528-15324-1-git-send-email-sbkim73@samsung.com>
In-Reply-To: <1287406528-15324-1-git-send-email-sbkim73@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Jonghun Han <jonghun.han@samsung.com>

Some platform data for S5PV310 FIMD0 are added.
LTE480WV lcd pannel used by SMDKV310 are added via platform-lcd interface.
extern helper functions used by machine file are added.

Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5pv310/mach-smdkv310.c   |   72 +++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/fb.h |   14 ++++++
 2 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 10f8056..8a83eec 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -9,7 +9,9 @@
 */
 
 #include <linux/serial_core.h>
+#include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/lcd.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 
@@ -17,13 +19,17 @@
 #include <asm/mach-types.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#include <video/platform_lcd.h>
+
 #include <plat/regs-serial.h>
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/fb.h>
 #include <plat/sdhci.h>
 
 #include <mach/map.h>
+#include <mach/regs-fb.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -106,7 +112,71 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
+static void lcd_lte480wv_set_power(struct plat_lcd_data *pd,
+				   unsigned int power)
+{
+	if (power) {
+#if !defined(CONFIG_BACKLIGHT_PWM)
+		gpio_request(S5PV310_GPD0(1), "GPD0");
+		gpio_direction_output(S5PV310_GPD0(1), 1);
+		gpio_free(S5PV310_GPD0(1));
+#endif
+		/* fire nRESET on power up */
+		gpio_request(S5PV310_GPX0(6), "GPX0");
+
+		gpio_direction_output(S5PV310_GPX0(6), 1);
+		mdelay(100);
+
+		gpio_set_value(S5PV310_GPX0(6), 0);
+		mdelay(10);
+
+		gpio_set_value(S5PV310_GPX0(6), 1);
+		mdelay(10);
+
+		gpio_free(S5PV310_GPX0(6));
+	} else {
+#if !defined(CONFIG_BACKLIGHT_PWM)
+		gpio_request(S5PV310_GPD0(1), "GPD0");
+		gpio_direction_output(S5PV310_GPD0(1), 0);
+		gpio_free(S5PV310_GPD0(1));
+#endif
+	}
+}
+
+static struct plat_lcd_data smdkv310_lcd_lte480wv_data = {
+	.set_power	= lcd_lte480wv_set_power,
+};
+
+static struct platform_device smdkv310_lcd_lte480wv = {
+	.name			= "platform-lcd",
+	.dev.parent		= &s5p_device_fimd0.dev,
+	.dev.platform_data	= &smdkv310_lcd_lte480wv_data,
+};
+
+static struct s3c_fb_pd_win smdkv310_fb_win0 = {
+	.win_mode = {
+		.left_margin	= 13,
+		.right_margin	= 8,
+		.upper_margin	= 7,
+		.lower_margin	= 5,
+		.hsync_len	= 3,
+		.vsync_len	= 1,
+		.xres	= 800,
+		.yres	= 480,
+	},
+	.max_bpp	= 32,
+	.default_bpp	= 24,
+};
+static struct s3c_fb_platdata smdkv310_lcd0_pdata __initdata = {
+	.win[0]		= &smdkv310_fb_win0,
+	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
+	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
+	.setup_gpio	= s5pv310_fimd0_gpio_setup_24bpp,
+};
+
 static struct platform_device *smdkv310_devices[] __initdata = {
+	&s5p_device_fimd0,
+	&smdkv310_lcd_lte480wv,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
@@ -133,6 +203,8 @@ static void __init smdkv310_machine_init(void)
 	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
 #endif
 
+	s5p_fimd0_set_platdata(&smdkv310_lcd0_pdata);
+
 	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
 }
 
diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index cb3ca3a..67733b5 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -74,6 +74,14 @@ struct s3c_fb_platdata {
 extern void s3c_fb_set_platdata(struct s3c_fb_platdata *pd);
 
 /**
+ * s5p_fimd0_set_platdata() - Setup the FB device with platform data.
+ * @pd: The platform data to set. The data is copied from the passed structure
+ *      so the machine data can mark the data __initdata so that any unused
+ *      machines will end up dumping their data at runtime.
+ */
+extern void s5p_fimd0_set_platdata(struct s3c_fb_platdata *pd);
+
+/**
  * s3c64xx_fb_gpio_setup_24bpp() - S3C64XX setup function for 24bpp LCD
  *
  * Initialise the GPIO for an 24bpp LCD display on the RGB interface.
@@ -94,4 +102,10 @@ extern void s5pc100_fb_gpio_setup_24bpp(void);
  */
 extern void s5pv210_fb_gpio_setup_24bpp(void);
 
+/**
+ * s5pv310_fimd0_gpio_setup_24bpp() - S5PV310/S5PC210 setup function for 24bpp LCD0
+ *
+ * Initialise the GPIO for an 24bpp LCD display on the RGB interface 0.
+ */
+extern void s5pv310_fimd0_gpio_setup_24bpp(void);
 #endif /* __PLAT_S3C_FB_H */
-- 
1.6.2.5

