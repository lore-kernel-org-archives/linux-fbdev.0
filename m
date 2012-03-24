From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Sat, 24 Mar 2012 16:40:48 +0000
Subject: [PATCH v3 4/4] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <1332606528-32338-5-git-send-email-thomas.abraham@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332606528-32338-1-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1332606528-32338-1-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

For all the Samsung SoC based boards which have the platform data for
s3c-fb driver, the 'default_win' element in the platform data is removed
and the lcd panel video timing values are moved out of individual window
configuration data.

Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: JeongHyeon Kim <jhkim@insignal.co.kr>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Darius Augulis <augulis.darius@gmail.com>
Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mach-nuri.c           |   26 ++++++++------
 arch/arm/mach-exynos/mach-origen.c         |   24 +++++++-----
 arch/arm/mach-exynos/mach-smdkv310.c       |   28 ++++++++------
 arch/arm/mach-exynos/mach-universal_c210.c |   26 ++++++++------
 arch/arm/mach-s3c24xx/mach-smdk2416.c      |   27 ++++++++------
 arch/arm/mach-s3c64xx/mach-anw6410.c       |   25 +++++++------
 arch/arm/mach-s3c64xx/mach-crag6410.c      |   25 +++++++------
 arch/arm/mach-s3c64xx/mach-hmt.c           |   24 +++++++-----
 arch/arm/mach-s3c64xx/mach-mini6410.c      |   54 ++++++++++++++++-----------
 arch/arm/mach-s3c64xx/mach-real6410.c      |   52 +++++++++++++++-----------
 arch/arm/mach-s3c64xx/mach-smartq5.c       |   26 ++++++++------
 arch/arm/mach-s3c64xx/mach-smartq7.c       |   26 ++++++++------
 arch/arm/mach-s3c64xx/mach-smdk6410.c      |   25 +++++++------
 arch/arm/mach-s5p64x0/mach-smdk6440.c      |   24 +++++++-----
 arch/arm/mach-s5p64x0/mach-smdk6450.c      |   24 +++++++-----
 arch/arm/mach-s5pc100/mach-smdkc100.c      |   27 ++++++++------
 arch/arm/mach-s5pv210/mach-aquila.c        |   36 ++++++++----------
 arch/arm/mach-s5pv210/mach-goni.c          |   26 ++++++++------
 arch/arm/mach-s5pv210/mach-smdkv210.c      |   24 +++++++-----
 19 files changed, 311 insertions(+), 238 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 7ac81ce..a7e6731 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -212,25 +212,29 @@ static struct platform_device nuri_gpio_keys = {
 
 /* Frame Buffer */
 static struct s3c_fb_pd_win nuri_fb_win0 = {
-	.win_mode = {
-		.left_margin	= 64,
-		.right_margin	= 16,
-		.upper_margin	= 64,
-		.lower_margin	= 1,
-		.hsync_len	= 48,
-		.vsync_len	= 3,
-		.xres		= 1024,
-		.yres		= 600,
-		.refresh	= 60,
-	},
 	.max_bpp	= 24,
 	.default_bpp	= 16,
+	.xres		= 1024,
+	.yres		= 600,
 	.virtual_x	= 1024,
 	.virtual_y	= 2 * 600,
 };
 
+static struct fb_videomode nuri_lcd_timing = {
+	.left_margin	= 64,
+	.right_margin	= 16,
+	.upper_margin	= 64,
+	.lower_margin	= 1,
+	.hsync_len	= 48,
+	.vsync_len	= 3,
+	.xres		= 1024,
+	.yres		= 600,
+	.refresh	= 60,
+};
+
 static struct s3c_fb_platdata nuri_fb_pdata __initdata = {
 	.win[0]		= &nuri_fb_win0,
+	.vtiming	= &nuri_lcd_timing,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB |
 			  VIDCON0_CLKSEL_LCD,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 25c9b46..de71237 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -583,22 +583,26 @@ static struct platform_device origen_lcd_hv070wsa = {
 };
 
 static struct s3c_fb_pd_win origen_fb_win0 = {
-	.win_mode = {
-		.left_margin	= 64,
-		.right_margin	= 16,
-		.upper_margin	= 64,
-		.lower_margin	= 16,
-		.hsync_len	= 48,
-		.vsync_len	= 3,
-		.xres		= 1024,
-		.yres		= 600,
-	},
+	.xres			= 1024,
+	.yres			= 600,
 	.max_bpp		= 32,
 	.default_bpp		= 24,
 };
 
+static struct fb_videomode origen_lcd_timing = {
+	.left_margin	= 64,
+	.right_margin	= 16,
+	.upper_margin	= 64,
+	.lower_margin	= 16,
+	.hsync_len	= 48,
+	.vsync_len	= 3,
+	.xres		= 1024,
+	.yres		= 600,
+};
+
 static struct s3c_fb_platdata origen_lcd_pdata __initdata = {
 	.win[0]		= &origen_fb_win0,
+	.vtiming	= &origen_lcd_timing,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC |
 				VIDCON1_INV_VCLK,
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index f08529f..6c00fa6 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -157,22 +157,26 @@ static struct platform_device smdkv310_lcd_lte480wv = {
 };
 
 static struct s3c_fb_pd_win smdkv310_fb_win0 = {
-	.win_mode = {
-		.left_margin	= 13,
-		.right_margin	= 8,
-		.upper_margin	= 7,
-		.lower_margin	= 5,
-		.hsync_len	= 3,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-	},
-	.max_bpp		= 32,
-	.default_bpp		= 24,
+	.max_bpp	= 32,
+	.default_bpp	= 24,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode smdkv310_lcd_timing = {
+	.left_margin	= 13,
+	.right_margin	= 8,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
 };
 
 static struct s3c_fb_platdata smdkv310_lcd0_pdata __initdata = {
 	.win[0]		= &smdkv310_fb_win0,
+	.vtiming	= &smdkv310_lcd_timing,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 	.setup_gpio	= exynos4_fimd0_gpio_setup_24bpp,
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 57e4418..67a9547 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -813,25 +813,29 @@ static struct i2c_board_info i2c1_devs[] __initdata = {
 
 /* Frame Buffer */
 static struct s3c_fb_pd_win universal_fb_win0 = {
-	.win_mode = {
-		.left_margin	= 16,
-		.right_margin	= 16,
-		.upper_margin	= 2,
-		.lower_margin	= 28,
-		.hsync_len	= 2,
-		.vsync_len	= 1,
-		.xres		= 480,
-		.yres		= 800,
-		.refresh	= 55,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 480,
+	.yres		= 800,
 	.virtual_x	= 480,
 	.virtual_y	= 2 * 800,
 };
 
+static struct fb_videomode universal_lcd_timing = {
+	.left_margin	= 16,
+	.right_margin	= 16,
+	.upper_margin	= 2,
+	.lower_margin	= 28,
+	.hsync_len	= 2,
+	.vsync_len	= 1,
+	.xres		= 480,
+	.yres		= 800,
+	.refresh	= 55,
+};
+
 static struct s3c_fb_platdata universal_lcd_pdata __initdata = {
 	.win[0]		= &universal_fb_win0,
+	.vtiming	= &universal_lcd_timing,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB |
 			  VIDCON0_CLKSEL_LCD,
 	.vidcon1	= VIDCON1_INV_VCLK | VIDCON1_INV_VDEN
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index 30a44f8..c3100a0 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -148,23 +148,25 @@ static struct s3c24xx_hsudc_platdata smdk2416_hsudc_platdata = {
 
 static struct s3c_fb_pd_win smdk2416_fb_win[] = {
 	[0] = {
-		/* think this is the same as the smdk6410 */
-		.win_mode	= {
-			.pixclock	= 41094,
-			.left_margin	= 8,
-			.right_margin	= 13,
-			.upper_margin	= 7,
-			.lower_margin	= 5,
-			.hsync_len	= 3,
-			.vsync_len	= 1,
-			.xres           = 800,
-			.yres           = 480,
-		},
 		.default_bpp	= 16,
 		.max_bpp	= 32,
+		.xres           = 800,
+		.yres           = 480,
 	},
 };
 
+static struct fb_videomode smdk2416_lcd_timing = {
+	.pixclock	= 41094,
+	.left_margin	= 8,
+	.right_margin	= 13,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres           = 800,
+	.yres           = 480,
+};
+
 static void s3c2416_fb_gpio_setup_24bpp(void)
 {
 	unsigned int gpio;
@@ -187,6 +189,7 @@ static void s3c2416_fb_gpio_setup_24bpp(void)
 
 static struct s3c_fb_platdata smdk2416_fb_platdata = {
 	.win[0]		= &smdk2416_fb_win[0],
+	.vtiming	= &smdk2416_lcd_timing,
 	.setup_gpio	= s3c2416_fb_gpio_setup_24bpp,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index b86f277..58fd0e3 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -134,24 +134,27 @@ static struct platform_device anw6410_lcd_powerdev = {
 };
 
 static struct s3c_fb_pd_win anw6410_fb_win0 = {
-	/* this is to ensure we use win0 */
-	.win_mode	= {
-		.left_margin	= 8,
-		.right_margin	= 13,
-		.upper_margin	= 7,
-		.lower_margin	= 5,
-		.hsync_len	= 3,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode anw6410_lcd_timing = {
+	.left_margin	= 8,
+	.right_margin	= 13,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
 };
 
 /* 405566 clocks per frame => 60Hz refresh requires 24333960Hz clock */
 static struct s3c_fb_platdata anw6410_lcd_pdata __initdata = {
 	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+	.vtiming	= &anw6410_lcd_timing,
 	.win[0]		= &anw6410_fb_win0,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index e20bf58..c1ef57e 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -151,26 +151,29 @@ static struct platform_device crag6410_lcd_powerdev = {
 
 /* 640x480 URT */
 static struct s3c_fb_pd_win crag6410_fb_win0 = {
-	/* this is to ensure we use win0 */
-	.win_mode	= {
-		.left_margin	= 150,
-		.right_margin	= 80,
-		.upper_margin	= 40,
-		.lower_margin	= 5,
-		.hsync_len	= 40,
-		.vsync_len	= 5,
-		.xres		= 640,
-		.yres		= 480,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 640,
+	.yres		= 480,
 	.virtual_y	= 480 * 2,
 	.virtual_x	= 640,
 };
 
+static struct fb_videomode crag6410_lcd_timing = {
+	.left_margin	= 150,
+	.right_margin	= 80,
+	.upper_margin	= 40,
+	.lower_margin	= 5,
+	.hsync_len	= 40,
+	.vsync_len	= 5,
+	.xres		= 640,
+	.yres		= 480,
+};
+
 /* 405566 clocks per frame => 60Hz refresh requires 24333960Hz clock */
 static struct s3c_fb_platdata crag6410_lcd_pdata __initdata = {
 	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+	.vtiming	= &crag6410_lcd_timing,
 	.win[0]		= &crag6410_fb_win0,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 521e07b..4e9b1ac 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -129,23 +129,27 @@ static struct platform_device hmt_backlight_device = {
 };
 
 static struct s3c_fb_pd_win hmt_fb_win0 = {
-	.win_mode	= {
-		.left_margin	= 8,
-		.right_margin	= 13,
-		.upper_margin	= 7,
-		.lower_margin	= 5,
-		.hsync_len	= 3,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode hmt_lcd_timing = {
+	.left_margin	= 8,
+	.right_margin	= 13,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
 };
 
 /* 405566 clocks per frame => 60Hz refresh requires 24333960Hz clock */
 static struct s3c_fb_platdata hmt_lcd_pdata __initdata = {
 	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+	.vtiming	= &hmt_lcd_timing,
 	.win[0]		= &hmt_fb_win0,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 34f5195..2f425d5 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -152,43 +152,53 @@ static struct s3c2410_platform_nand mini6410_nand_info = {
 };
 
 static struct s3c_fb_pd_win mini6410_lcd_type0_fb_win = {
-	.win_mode	= {	/* 4.3" 480x272 */
-		.left_margin	= 3,
-		.right_margin	= 2,
-		.upper_margin	= 1,
-		.lower_margin	= 1,
-		.hsync_len	= 40,
-		.vsync_len	= 1,
-		.xres		= 480,
-		.yres		= 272,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 480,
+	.yres		= 272,
+};
+
+static struct fb_videomode mini6410_lcd_type0_timing = {
+	/* 4.3" 480x272 */
+	.left_margin	= 3,
+	.right_margin	= 2,
+	.upper_margin	= 1,
+	.lower_margin	= 1,
+	.hsync_len	= 40,
+	.vsync_len	= 1,
+	.xres		= 480,
+	.yres		= 272,
 };
 
 static struct s3c_fb_pd_win mini6410_lcd_type1_fb_win = {
-	.win_mode	= {	/* 7.0" 800x480 */
-		.left_margin	= 8,
-		.right_margin	= 13,
-		.upper_margin	= 7,
-		.lower_margin	= 5,
-		.hsync_len	= 3,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode mini6410_lcd_type1_timing = {
+	/* 7.0" 800x480 */
+	.left_margin	= 8,
+	.right_margin	= 13,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
 };
 
 static struct s3c_fb_platdata mini6410_lcd_pdata[] __initdata = {
 	{
 		.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+		.vtiming	= &mini6410_lcd_type0_timing,
 		.win[0]		= &mini6410_lcd_type0_fb_win,
 		.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 		.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 	}, {
 		.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+		.vtiming	= &mini6410_lcd_type1_timing,
 		.win[0]		= &mini6410_lcd_type1_fb_win,
 		.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 		.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
@@ -316,8 +326,8 @@ static void __init mini6410_machine_init(void)
 	mini6410_parse_features(&features, mini6410_features_str);
 
 	printk(KERN_INFO "MINI6410: selected LCD display is %dx%d\n",
-		mini6410_lcd_pdata[features.lcd_index].win[0]->win_mode.xres,
-		mini6410_lcd_pdata[features.lcd_index].win[0]->win_mode.yres);
+		mini6410_lcd_pdata[features.lcd_index].win[0]->xres,
+		mini6410_lcd_pdata[features.lcd_index].win[0]->yres);
 
 	s3c_nand_set_platdata(&mini6410_nand_info);
 	s3c_fb_set_platdata(&mini6410_lcd_pdata[features.lcd_index]);
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index 21f91e5..0fbd32c 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -118,43 +118,51 @@ static struct platform_device real6410_device_eth = {
 };
 
 static struct s3c_fb_pd_win real6410_lcd_type0_fb_win = {
-	.win_mode	= {	/* 4.3" 480x272 */
-		.left_margin	= 3,
-		.right_margin	= 2,
-		.upper_margin	= 1,
-		.lower_margin	= 1,
-		.hsync_len	= 40,
-		.vsync_len	= 1,
-		.xres		= 480,
-		.yres		= 272,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 480,
+	.yres		= 272,
+};
+
+static struct fb_videomode real6410_lcd_type0_timing = {
+	/* 4.3" 480x272 */
+	.left_margin	= 3,
+	.right_margin	= 2,
+	.upper_margin	= 1,
+	.lower_margin	= 1,
+	.hsync_len	= 40,
+	.vsync_len	= 1,
 };
 
 static struct s3c_fb_pd_win real6410_lcd_type1_fb_win = {
-	.win_mode	= {	/* 7.0" 800x480 */
-		.left_margin	= 8,
-		.right_margin	= 13,
-		.upper_margin	= 7,
-		.lower_margin	= 5,
-		.hsync_len	= 3,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode real6410_lcd_type1_timing = {
+	/* 7.0" 800x480 */
+	.left_margin	= 8,
+	.right_margin	= 13,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
 };
 
 static struct s3c_fb_platdata real6410_lcd_pdata[] __initdata = {
 	{
 		.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+		.vtiming	= &real6410_lcd_type0_timing,
 		.win[0]		= &real6410_lcd_type0_fb_win,
 		.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 		.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 	}, {
 		.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+		.vtiming	= &real6410_lcd_type1_timing,
 		.win[0]		= &real6410_lcd_type1_fb_win,
 		.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 		.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
@@ -297,8 +305,8 @@ static void __init real6410_machine_init(void)
 	real6410_parse_features(&features, real6410_features_str);
 
 	printk(KERN_INFO "REAL6410: selected LCD display is %dx%d\n",
-		real6410_lcd_pdata[features.lcd_index].win[0]->win_mode.xres,
-		real6410_lcd_pdata[features.lcd_index].win[0]->win_mode.yres);
+		real6410_lcd_pdata[features.lcd_index].win[0]->xres,
+		real6410_lcd_pdata[features.lcd_index].win[0]->yres);
 
 	s3c_fb_set_platdata(&real6410_lcd_pdata[features.lcd_index]);
 	s3c_nand_set_platdata(&real6410_nand_info);
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 3f42431..03a2f88 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -108,23 +108,27 @@ static struct platform_device smartq5_buttons_device  = {
 };
 
 static struct s3c_fb_pd_win smartq5_fb_win0 = {
-	.win_mode	= {
-		.left_margin	= 216,
-		.right_margin	= 40,
-		.upper_margin	= 35,
-		.lower_margin	= 10,
-		.hsync_len	= 1,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-		.refresh	= 80,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode smartq5_lcd_timing = {
+	.left_margin	= 216,
+	.right_margin	= 40,
+	.upper_margin	= 35,
+	.lower_margin	= 10,
+	.hsync_len	= 1,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
+	.refresh	= 80,
 };
 
 static struct s3c_fb_platdata smartq5_lcd_pdata __initdata = {
 	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+	.vtiming	= &smartq5_lcd_timing,
 	.win[0]		= &smartq5_fb_win0,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC |
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index e5c09b6..4e3b038 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -124,23 +124,27 @@ static struct platform_device smartq7_buttons_device  = {
 };
 
 static struct s3c_fb_pd_win smartq7_fb_win0 = {
-	.win_mode	= {
-		.left_margin	= 3,
-		.right_margin	= 5,
-		.upper_margin	= 1,
-		.lower_margin	= 20,
-		.hsync_len	= 10,
-		.vsync_len	= 3,
-		.xres		= 800,
-		.yres		= 480,
-		.refresh	= 80,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode smartq7_lcd_timing = {
+	.left_margin	= 3,
+	.right_margin	= 5,
+	.upper_margin	= 1,
+	.lower_margin	= 20,
+	.hsync_len	= 10,
+	.vsync_len	= 3,
+	.xres		= 800,
+	.yres		= 480,
+	.refresh	= 80,
 };
 
 static struct s3c_fb_platdata smartq7_lcd_pdata __initdata = {
 	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+	.vtiming	= &smartq7_lcd_timing,
 	.win[0]		= &smartq7_fb_win0,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC |
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d55bc96..3cfc90f 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -146,26 +146,29 @@ static struct platform_device smdk6410_lcd_powerdev = {
 };
 
 static struct s3c_fb_pd_win smdk6410_fb_win0 = {
-	/* this is to ensure we use win0 */
-	.win_mode	= {
-		.left_margin	= 8,
-		.right_margin	= 13,
-		.upper_margin	= 7,
-		.lower_margin	= 5,
-		.hsync_len	= 3,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 800,
+	.yres		= 480,
 	.virtual_y	= 480 * 2,
 	.virtual_x	= 800,
 };
 
+static struct fb_videomode smdk6410_lcd_timing = {
+	.left_margin	= 8,
+	.right_margin	= 13,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
+};
+
 /* 405566 clocks per frame => 60Hz refresh requires 24333960Hz clock */
 static struct s3c_fb_platdata smdk6410_lcd_pdata __initdata = {
 	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
+	.vtiming	= &smdk6410_lcd_timing,
 	.win[0]		= &smdk6410_fb_win0,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6440.c b/arch/arm/mach-s5p64x0/mach-smdk6440.c
index a40e325..92fefad 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6440.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c
@@ -103,22 +103,26 @@ static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
 
 /* Frame Buffer */
 static struct s3c_fb_pd_win smdk6440_fb_win0 = {
-	.win_mode = {
-		.left_margin	= 8,
-		.right_margin	= 13,
-		.upper_margin	= 7,
-		.lower_margin	= 5,
-		.hsync_len	= 3,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 24,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode smdk6440_lcd_timing = {
+	.left_margin	= 8,
+	.right_margin	= 13,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
 };
 
 static struct s3c_fb_platdata smdk6440_lcd_pdata __initdata = {
 	.win[0]		= &smdk6440_fb_win0,
+	.vtiming	= &smdk6440_lcd_timing,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 	.setup_gpio	= s5p64x0_fb_gpio_setup_24bpp,
diff --git a/arch/arm/mach-s5p64x0/mach-smdk6450.c b/arch/arm/mach-s5p64x0/mach-smdk6450.c
index efb69e2..e2335ec 100644
--- a/arch/arm/mach-s5p64x0/mach-smdk6450.c
+++ b/arch/arm/mach-s5p64x0/mach-smdk6450.c
@@ -121,22 +121,26 @@ static struct s3c2410_uartcfg smdk6450_uartcfgs[] __initdata = {
 
 /* Frame Buffer */
 static struct s3c_fb_pd_win smdk6450_fb_win0 = {
-	.win_mode	= {
-		.left_margin	= 8,
-		.right_margin	= 13,
-		.upper_margin	= 7,
-		.lower_margin	= 5,
-		.hsync_len	= 3,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 24,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode smdk6450_lcd_timing = {
+	.left_margin	= 8,
+	.right_margin	= 13,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
 };
 
 static struct s3c_fb_platdata smdk6450_lcd_pdata __initdata = {
 	.win[0]		= &smdk6450_fb_win0,
+	.vtiming	= &smdk6450_lcd_timing,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 	.setup_gpio	= s5p64x0_fb_gpio_setup_24bpp,
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 674d229..0c3ae38 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -136,24 +136,27 @@ static struct platform_device smdkc100_lcd_powerdev = {
 
 /* Frame Buffer */
 static struct s3c_fb_pd_win smdkc100_fb_win0 = {
-	/* this is to ensure we use win0 */
-	.win_mode	= {
-		.left_margin	= 8,
-		.right_margin	= 13,
-		.upper_margin	= 7,
-		.lower_margin	= 5,
-		.hsync_len	= 3,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-		.refresh	= 80,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode smdkc100_lcd_timing = {
+	.left_margin	= 8,
+	.right_margin	= 13,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
+	.refresh	= 80,
 };
 
 static struct s3c_fb_platdata smdkc100_lcd_pdata __initdata = {
 	.win[0]		= &smdkc100_fb_win0,
+	.vtiming	= &smdkc100_lcd_timing,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 	.setup_gpio	= s5pc100_fb_gpio_setup_24bpp,
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index a9ea64e..7b91bbf 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -96,38 +96,34 @@ static struct s3c2410_uartcfg aquila_uartcfgs[] __initdata = {
 
 /* Frame Buffer */
 static struct s3c_fb_pd_win aquila_fb_win0 = {
-	.win_mode = {
-		.left_margin = 16,
-		.right_margin = 16,
-		.upper_margin = 3,
-		.lower_margin = 28,
-		.hsync_len = 2,
-		.vsync_len = 2,
-		.xres = 480,
-		.yres = 800,
-	},
 	.max_bpp = 32,
 	.default_bpp = 16,
+	.xres = 480,
+	.yres = 800,
 };
 
 static struct s3c_fb_pd_win aquila_fb_win1 = {
-	.win_mode = {
-		.left_margin = 16,
-		.right_margin = 16,
-		.upper_margin = 3,
-		.lower_margin = 28,
-		.hsync_len = 2,
-		.vsync_len = 2,
-		.xres = 480,
-		.yres = 800,
-	},
 	.max_bpp = 32,
 	.default_bpp = 16,
+	.xres = 480,
+	.yres = 800,
+};
+
+static struct fb_videomode aquila_lcd_timing = {
+	.left_margin = 16,
+	.right_margin = 16,
+	.upper_margin = 3,
+	.lower_margin = 28,
+	.hsync_len = 2,
+	.vsync_len = 2,
+	.xres = 480,
+	.yres = 800,
 };
 
 static struct s3c_fb_platdata aquila_lcd_pdata __initdata = {
 	.win[0]		= &aquila_fb_win0,
 	.win[1]		= &aquila_fb_win1,
+	.vtiming	= &aquila_lcd_timing,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC |
 			  VIDCON1_INV_VCLK | VIDCON1_INV_VDEN,
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 2cf5ed7..07a840d 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -105,25 +105,29 @@ static struct s3c2410_uartcfg goni_uartcfgs[] __initdata = {
 
 /* Frame Buffer */
 static struct s3c_fb_pd_win goni_fb_win0 = {
-	.win_mode = {
-		.left_margin	= 16,
-		.right_margin	= 16,
-		.upper_margin	= 2,
-		.lower_margin	= 28,
-		.hsync_len	= 2,
-		.vsync_len	= 1,
-		.xres		= 480,
-		.yres		= 800,
-		.refresh	= 55,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.xres		= 480,
+	.yres		= 800,
 	.virtual_x	= 480,
 	.virtual_y	= 2 * 800,
 };
 
+static struct fb_videomode goni_lcd_timing = {
+	.left_margin	= 16,
+	.right_margin	= 16,
+	.upper_margin	= 2,
+	.lower_margin	= 28,
+	.hsync_len	= 2,
+	.vsync_len	= 1,
+	.xres		= 480,
+	.yres		= 800,
+	.refresh	= 55,
+};
+
 static struct s3c_fb_platdata goni_lcd_pdata __initdata = {
 	.win[0]		= &goni_fb_win0,
+	.vtiming	= &goni_lcd_timing,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB |
 			  VIDCON0_CLKSEL_LCD,
 	.vidcon1	= VIDCON1_INV_VCLK | VIDCON1_INV_VDEN
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 91d4ad8..5e0c955 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -189,22 +189,26 @@ static struct platform_device smdkv210_lcd_lte480wv = {
 };
 
 static struct s3c_fb_pd_win smdkv210_fb_win0 = {
-	.win_mode = {
-		.left_margin	= 13,
-		.right_margin	= 8,
-		.upper_margin	= 7,
-		.lower_margin	= 5,
-		.hsync_len	= 3,
-		.vsync_len	= 1,
-		.xres		= 800,
-		.yres		= 480,
-	},
 	.max_bpp	= 32,
 	.default_bpp	= 24,
+	.xres		= 800,
+	.yres		= 480,
+};
+
+static struct fb_videomode smdkv210_lcd_timing = {
+	.left_margin	= 13,
+	.right_margin	= 8,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
 };
 
 static struct s3c_fb_platdata smdkv210_lcd0_pdata __initdata = {
 	.win[0]		= &smdkv210_fb_win0,
+	.vtiming	= &smdkv210_lcd_timing,
 	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
-- 
1.6.6.rc2

