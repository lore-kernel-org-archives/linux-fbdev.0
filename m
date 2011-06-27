From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 27 Jun 2011 10:50:58 +0000
Subject: [PATCH V7 5/5] ARM: EXYNOS4: Add platform data for EXYNOS4 FIMD and LTE480WV platform-lcd
Message-Id: <1309171858-30397-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Anand Kumar N <anand.kn@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Inki Dae <inki.dae@samsung.com>, ARM Linux <linux@arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>, Jonghun Han <jonghun.han@samsung.com>, Jingoo Han <jg1.han@samsung.com>

From: Jonghun Han <jonghun.han@samsung.com>

This patch adds support EXYNOS4 FIMD0 and LTE480WV LCD pannel.

Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mach-exynos4/mach-smdkc210.c |   71 +++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos4/mach-smdkv310.c |   71 +++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-smdkc210.c b/arch/arm/mach-exynos4/mach-smdkc210.c
index e645f7a..6528dec 100644
--- a/arch/arm/mach-exynos4/mach-smdkc210.c
+++ b/arch/arm/mach-exynos4/mach-smdkc210.c
@@ -9,7 +9,9 @@
 */
 
 #include <linux/serial_core.h>
+#include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/lcd.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
@@ -19,16 +21,20 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
+#include <video/platform_lcd.h>
+
 #include <plat/regs-serial.h>
 #include <plat/regs-srom.h>
 #include <plat/exynos4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/fb.h>
 #include <plat/sdhci.h>
 #include <plat/iic.h>
 #include <plat/pd.h>
 
 #include <mach/map.h>
+#include <mach/regs-fb.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKC210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -111,6 +117,67 @@ static struct s3c_sdhci_platdata smdkc210_hsmmc3_pdata __initdata = {
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
+static void lcd_lte480wv_set_power(struct plat_lcd_data *pd,
+				   unsigned int power)
+{
+	if (power) {
+#if !defined(CONFIG_BACKLIGHT_PWM)
+		gpio_request_one(EXYNOS4_GPD0(1), GPIOF_OUT_INIT_HIGH, "GPD0");
+		gpio_free(EXYNOS4_GPD0(1));
+#endif
+		/* fire nRESET on power up */
+		gpio_request(EXYNOS4_GPX0(6), "GPX0");
+
+		gpio_direction_output(EXYNOS4_GPX0(6), 1);
+		mdelay(100);
+
+		gpio_set_value(EXYNOS4_GPX0(6), 0);
+		mdelay(10);
+
+		gpio_set_value(EXYNOS4_GPX0(6), 1);
+		mdelay(10);
+
+		gpio_free(EXYNOS4_GPX0(6));
+	} else {
+#if !defined(CONFIG_BACKLIGHT_PWM)
+		gpio_request_one(EXYNOS4_GPD0(1), GPIOF_OUT_INIT_LOW, "GPD0");
+		gpio_free(EXYNOS4_GPD0(1));
+#endif
+	}
+}
+
+static struct plat_lcd_data smdkc210_lcd_lte480wv_data = {
+	.set_power      = lcd_lte480wv_set_power,
+};
+
+static struct platform_device smdkc210_lcd_lte480wv = {
+	.name                   = "platform-lcd",
+	.dev.parent             = &s5p_device_fimd0.dev,
+	.dev.platform_data      = &smdkc210_lcd_lte480wv_data,
+};
+
+static struct s3c_fb_pd_win smdkc210_fb_win0 = {
+	.win_mode = {
+		.left_margin    = 13,
+		.right_margin   = 8,
+		.upper_margin   = 7,
+		.lower_margin   = 5,
+		.hsync_len      = 3,
+		.vsync_len      = 1,
+		.xres   = 800,
+		.yres   = 480,
+	},
+	.max_bpp        = 32,
+	.default_bpp    = 24,
+};
+
+static struct s3c_fb_platdata smdkc210_lcd0_pdata __initdata = {
+	.win[0]		= &smdkc210_fb_win0,
+	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
+	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
+	.setup_gpio	= exynos4_fimd0_gpio_setup_24bpp,
+};
+
 static struct resource smdkc210_smsc911x_resources[] = {
 	[0] = {
 		.start	= EXYNOS4_PA_SROM_BANK(1),
@@ -165,6 +232,8 @@ static struct platform_device *smdkc210_devices[] __initdata = {
 	&exynos4_device_pd[PD_GPS],
 	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
+	&s5p_device_fimd0,
+	&smdkc210_lcd_lte480wv,
 	&smdkc210_smsc911x,
 };
 
@@ -210,6 +279,8 @@ static void __init smdkc210_machine_init(void)
 	s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
 	s3c_sdhci3_set_platdata(&smdkc210_hsmmc3_pdata);
 
+	s5p_fimd0_set_platdata(&smdkc210_lcd0_pdata);
+
 	platform_add_devices(smdkc210_devices, ARRAY_SIZE(smdkc210_devices));
 }
 
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index 1526764..a708276 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -9,7 +9,9 @@
 */
 
 #include <linux/serial_core.h>
+#include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/lcd.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
@@ -20,17 +22,21 @@
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
+#include <video/platform_lcd.h>
+
 #include <plat/regs-serial.h>
 #include <plat/regs-srom.h>
 #include <plat/exynos4.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
+#include <plat/fb.h>
 #include <plat/keypad.h>
 #include <plat/sdhci.h>
 #include <plat/iic.h>
 #include <plat/pd.h>
 
 #include <mach/map.h>
+#include <mach/regs-fb.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -113,6 +119,67 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
+static void lcd_lte480wv_set_power(struct plat_lcd_data *pd,
+				   unsigned int power)
+{
+	if (power) {
+#if !defined(CONFIG_BACKLIGHT_PWM)
+		gpio_request_one(EXYNOS4_GPD0(1), GPIOF_OUT_INIT_HIGH, "GPD0");
+		gpio_free(EXYNOS4_GPD0(1));
+#endif
+		/* fire nRESET on power up */
+		gpio_request(EXYNOS4_GPX0(6), "GPX0");
+
+		gpio_direction_output(EXYNOS4_GPX0(6), 1);
+		mdelay(100);
+
+		gpio_set_value(EXYNOS4_GPX0(6), 0);
+		mdelay(10);
+
+		gpio_set_value(EXYNOS4_GPX0(6), 1);
+		mdelay(10);
+
+		gpio_free(EXYNOS4_GPX0(6));
+	} else {
+#if !defined(CONFIG_BACKLIGHT_PWM)
+		gpio_request_one(EXYNOS4_GPD0(1), GPIOF_OUT_INIT_LOW, "GPD0");
+		gpio_free(EXYNOS4_GPD0(1));
+#endif
+	}
+}
+
+static struct plat_lcd_data smdkv310_lcd_lte480wv_data = {
+	.set_power      = lcd_lte480wv_set_power,
+};
+
+static struct platform_device smdkv310_lcd_lte480wv = {
+	.name                   = "platform-lcd",
+	.dev.parent             = &s5p_device_fimd0.dev,
+	.dev.platform_data      = &smdkv310_lcd_lte480wv_data,
+};
+
+static struct s3c_fb_pd_win smdkv310_fb_win0 = {
+	.win_mode = {
+		.left_margin    = 13,
+		.right_margin   = 8,
+		.upper_margin   = 7,
+		.lower_margin   = 5,
+		.hsync_len      = 3,
+		.vsync_len      = 1,
+		.xres   = 800,
+		.yres   = 480,
+	},
+	.max_bpp        = 32,
+	.default_bpp    = 24,
+};
+
+static struct s3c_fb_platdata smdkv310_lcd0_pdata __initdata = {
+	.win[0]		= &smdkv310_fb_win0,
+	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
+	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
+	.setup_gpio	= exynos4_fimd0_gpio_setup_24bpp,
+};
+
 static struct resource smdkv310_smsc911x_resources[] = {
 	[0] = {
 		.start	= EXYNOS4_PA_SROM_BANK(1),
@@ -187,6 +254,8 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&exynos4_device_pd[PD_GPS],
 	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
+	&s5p_device_fimd0,
+	&smdkv310_lcd_lte480wv,
 	&smdkv310_smsc911x,
 };
 
@@ -232,6 +301,8 @@ static void __init smdkv310_machine_init(void)
 	s3c_sdhci2_set_platdata(&smdkv310_hsmmc2_pdata);
 	s3c_sdhci3_set_platdata(&smdkv310_hsmmc3_pdata);
 
+	s5p_fimd0_set_platdata(&smdkv310_lcd0_pdata);
+
 	samsung_keypad_set_platdata(&smdkv310_keypad_data);
 
 	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
-- 
1.7.1

