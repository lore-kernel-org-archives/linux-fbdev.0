From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 22 Jun 2011 06:41:44 +0000
Subject: [PATCH V5 5/5] ARM: EXYNOS4: Add platform data for EXYNOS4 FIMD and LTE480WV platform-lcd
Message-Id: <1308724904-31521-1-git-send-email-jg1.han@samsung.com>
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
 arch/arm/mach-exynos4/mach-smdkc210.c |  114 +++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos4/mach-smdkv310.c |  114 +++++++++++++++++++++++++++++++++
 2 files changed, 228 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/mach-smdkc210.c b/arch/arm/mach-exynos4/mach-smdkc210.c
index e645f7a..360a50a 100644
--- a/arch/arm/mach-exynos4/mach-smdkc210.c
+++ b/arch/arm/mach-exynos4/mach-smdkc210.c
@@ -9,26 +9,33 @@
 */
 
 #include <linux/serial_core.h>
+#include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/lcd.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
+#include <linux/clk.h>
 
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
@@ -111,6 +118,69 @@ static struct s3c_sdhci_platdata smdkc210_hsmmc3_pdata __initdata = {
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
+static void lcd_lte480wv_set_power(struct plat_lcd_data *pd,
+				   unsigned int power)
+{
+	if (power) {
+#if !defined(CONFIG_BACKLIGHT_PWM)
+		gpio_request(EXYNOS4_GPD0(1), "GPD0");
+		gpio_direction_output(EXYNOS4_GPD0(1), 1);
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
+		gpio_request(EXYNOS4_GPD0(1), "GPD0");
+		gpio_direction_output(EXYNOS4_GPD0(1), 0);
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
@@ -165,6 +235,8 @@ static struct platform_device *smdkc210_devices[] __initdata = {
 	&exynos4_device_pd[PD_GPS],
 	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
+	&s5p_device_fimd0,
+	&smdkc210_lcd_lte480wv,
 	&smdkc210_smsc911x,
 };
 
@@ -191,6 +263,44 @@ static void __init smdkc210_smsc911x_init(void)
 		     (0x1 << S5P_SROM_BCX__TACS__SHIFT), S5P_SROM_BC1);
 }
 
+static int __init smdkc210_fimd0_setup_clock(void)
+{
+	struct clk *sclk = NULL;
+	struct clk *mout_mpll = NULL;
+
+	u32 rate = 0;
+
+	sclk = clk_get(&s5p_device_fimd0.dev, "sclk_fimd");
+	if (IS_ERR(sclk)) {
+		printk(KERN_ERR "failed to get sclk for fimd\n");
+		goto err_clk2;
+	}
+
+	mout_mpll = clk_get(NULL, "mout_mpll");
+	if (IS_ERR(mout_mpll)) {
+		printk(KERN_ERR "failed to get mout_mpll\n");
+		goto err_clk1;
+	}
+
+	clk_set_parent(sclk, mout_mpll);
+	if (!rate)
+		rate = 134000000;
+
+	clk_set_rate(sclk, rate);
+
+	clk_put(sclk);
+	clk_put(mout_mpll);
+
+	return 0;
+
+err_clk1:
+	clk_put(mout_mpll);
+err_clk2:
+	clk_put(sclk);
+
+	return -EINVAL;
+}
+
 static void __init smdkc210_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -210,7 +320,11 @@ static void __init smdkc210_machine_init(void)
 	s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
 	s3c_sdhci3_set_platdata(&smdkc210_hsmmc3_pdata);
 
+	s5p_fimd0_set_platdata(&smdkc210_lcd0_pdata);
+
 	platform_add_devices(smdkc210_devices, ARRAY_SIZE(smdkc210_devices));
+
+	smdkc210_fimd0_setup_clock();
 }
 
 MACHINE_START(SMDKC210, "SMDKC210")
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index 1526764..7bc12b5 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -9,28 +9,35 @@
 */
 
 #include <linux/serial_core.h>
+#include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/lcd.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
+#include <linux/clk.h>
 
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
@@ -113,6 +120,69 @@ static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
 	.clk_type		= S3C_SDHCI_CLK_DIV_EXTERNAL,
 };
 
+static void lcd_lte480wv_set_power(struct plat_lcd_data *pd,
+				   unsigned int power)
+{
+	if (power) {
+#if !defined(CONFIG_BACKLIGHT_PWM)
+		gpio_request(EXYNOS4_GPD0(1), "GPD0");
+		gpio_direction_output(EXYNOS4_GPD0(1), 1);
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
+		gpio_request(EXYNOS4_GPD0(1), "GPD0");
+		gpio_direction_output(EXYNOS4_GPD0(1), 0);
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
@@ -187,6 +257,8 @@ static struct platform_device *smdkv310_devices[] __initdata = {
 	&exynos4_device_pd[PD_GPS],
 	&exynos4_device_sysmmu,
 	&samsung_asoc_dma,
+	&s5p_device_fimd0,
+	&smdkv310_lcd_lte480wv,
 	&smdkv310_smsc911x,
 };
 
@@ -213,6 +285,44 @@ static void __init smdkv310_smsc911x_init(void)
 		     (0x1 << S5P_SROM_BCX__TACS__SHIFT), S5P_SROM_BC1);
 }
 
+static int __init smdkv310_fimd0_setup_clock(void)
+{
+	struct clk *sclk = NULL;
+	struct clk *mout_mpll = NULL;
+
+	u32 rate = 0;
+
+	sclk = clk_get(&s5p_device_fimd0.dev, "sclk_fimd");
+	if (IS_ERR(sclk)) {
+		printk(KERN_ERR "failed to get sclk for fimd\n");
+		goto err_clk2;
+	}
+
+	mout_mpll = clk_get(NULL, "mout_mpll");
+	if (IS_ERR(mout_mpll)) {
+		printk(KERN_ERR "failed to get mout_mpll\n");
+		goto err_clk1;
+	}
+
+	clk_set_parent(sclk, mout_mpll);
+	if (!rate)
+		rate = 134000000;
+
+	clk_set_rate(sclk, rate);
+
+	clk_put(sclk);
+	clk_put(mout_mpll);
+
+	return 0;
+
+err_clk1:
+	clk_put(mout_mpll);
+err_clk2:
+	clk_put(sclk);
+
+	return -EINVAL;
+}
+
 static void __init smdkv310_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -232,9 +342,13 @@ static void __init smdkv310_machine_init(void)
 	s3c_sdhci2_set_platdata(&smdkv310_hsmmc2_pdata);
 	s3c_sdhci3_set_platdata(&smdkv310_hsmmc3_pdata);
 
+	s5p_fimd0_set_platdata(&smdkv310_lcd0_pdata);
+
 	samsung_keypad_set_platdata(&smdkv310_keypad_data);
 
 	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
+
+	smdkv310_fimd0_setup_clock();
 }
 
 MACHINE_START(SMDKV310, "SMDKV310")
-- 
1.7.1

