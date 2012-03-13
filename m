From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 13 Mar 2012 09:47:56 +0000
Subject: RE: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
Message-Id: <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Thomas Abraham [mailto:thomas.abraham@linaro.org]
> Sent: Tuesday, March 13, 2012 6:00 AM
> To: linux-fbdev@vger.kernel.org
> Cc: FlorianSchandinat@gmx.de; linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org;
> kgene.kim@samsung.com; jg1.han@samsung.com; ben-linux@fluff.org; patches@linaro.org; Kyungmin Park;
> JeongHyeon Kim; Heiko Stuebner; Kwangwoo Lee; Mark Brown; Peter Korsgaard; Darius Augulis; Maurus
> Cuelenaere
> Subject: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
> 
> For all the Samsung SoC based boards which have the platform data for
> s3c-fb driver, the 'default_win' element in the platform data is removed
> and the lcd panel video timing values are moved out of individual window
> configuration data.
> 
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: JeongHyeon Kim <jhkim@insignal.co.kr>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Darius Augulis <augulis.darius@gmail.com>
> Cc: Maurus Cuelenaere <mcuelenaere@gmail.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos/mach-nuri.c           |   26 ++++++++++-------
>  arch/arm/mach-exynos/mach-origen.c         |   24 ++++++++++-------
>  arch/arm/mach-exynos/mach-smdkv310.c       |   28 +++++++++++--------
>  arch/arm/mach-exynos/mach-universal_c210.c |   26 ++++++++++-------
>  arch/arm/mach-s3c24xx/mach-smdk2416.c      |   27 ++++++++++--------
>  arch/arm/mach-s3c64xx/mach-anw6410.c       |   25 ++++++++++-------
>  arch/arm/mach-s3c64xx/mach-crag6410.c      |   25 ++++++++++-------
>  arch/arm/mach-s3c64xx/mach-hmt.c           |   24 ++++++++++-------
>  arch/arm/mach-s3c64xx/mach-mini6410.c      |   40 ++++++++++++---------------
>  arch/arm/mach-s3c64xx/mach-real6410.c      |   40 ++++++++++++---------------
>  arch/arm/mach-s3c64xx/mach-smartq5.c       |   26 ++++++++++-------
>  arch/arm/mach-s3c64xx/mach-smartq7.c       |   26 ++++++++++-------
>  arch/arm/mach-s3c64xx/mach-smdk6410.c      |   25 ++++++++++-------
>  arch/arm/mach-s5p64x0/mach-smdk6440.c      |   24 ++++++++++-------
>  arch/arm/mach-s5p64x0/mach-smdk6450.c      |   24 ++++++++++-------
>  arch/arm/mach-s5pc100/mach-smdkc100.c      |   27 ++++++++++--------
>  arch/arm/mach-s5pv210/mach-aquila.c        |   36 +++++++++++--------------
>  arch/arm/mach-s5pv210/mach-goni.c          |   26 ++++++++++-------
>  arch/arm/mach-s5pv210/mach-smdkv210.c      |   24 ++++++++++-------
>  19 files changed, 285 insertions(+), 238 deletions(-)
> 

[.....]

> diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
> index c34c2ab..24dcdc9 100644
> --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> @@ -153,36 +153,32 @@ static struct s3c2410_platform_nand mini6410_nand_info = {
> 
>  static struct s3c_fb_pd_win mini6410_fb_win[] = {
>  	{
> -		.win_mode	= {	/* 4.3" 480x272 */
> -			.left_margin	= 3,
> -			.right_margin	= 2,
> -			.upper_margin	= 1,
> -			.lower_margin	= 1,
> -			.hsync_len	= 40,
> -			.vsync_len	= 1,
> -			.xres		= 480,
> -			.yres		= 272,
> -		},
>  		.max_bpp	= 32,
>  		.default_bpp	= 16,
> +		.xres		= 480,
> +		.yres		= 272,
>  	}, {
> -		.win_mode	= {	/* 7.0" 800x480 */
> -			.left_margin	= 8,
> -			.right_margin	= 13,
> -			.upper_margin	= 7,
> -			.lower_margin	= 5,
> -			.hsync_len	= 3,
> -			.vsync_len	= 1,
> -			.xres		= 800,
> -			.yres		= 480,
> -		},
>  		.max_bpp	= 32,
>  		.default_bpp	= 16,
> +		.xres		= 800,
> +		.yres		= 480,
>  	},
>  };
> 
> +static struct fb_videomode mini6410_lcd_timing = {
> +	.left_margin	= 8,
> +	.right_margin	= 13,
> +	.upper_margin	= 7,
> +	.lower_margin	= 5,
> +	.hsync_len	= 3,
> +	.vsync_len	= 1,
> +	.xres		= 800,
> +	.yres		= 480,
> +};
> +
>  static struct s3c_fb_platdata mini6410_lcd_pdata __initdata = {
>  	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
> +	.vtiming	= &mini6410_lcd_timing,
>  	.win[0]		= &mini6410_fb_win[0],
>  	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
>  	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> @@ -310,8 +306,8 @@ static void __init mini6410_machine_init(void)
>  	mini6410_lcd_pdata.win[0] = &mini6410_fb_win[features.lcd_index];
> 
>  	printk(KERN_INFO "MINI6410: selected LCD display is %dx%d\n",
> -		mini6410_lcd_pdata.win[0]->win_mode.xres,
> -		mini6410_lcd_pdata.win[0]->win_mode.yres);
> +		mini6410_lcd_pdata.win[0]->xres,
> +		mini6410_lcd_pdata.win[0]->yres);
> 
>  	s3c_nand_set_platdata(&mini6410_nand_info);
>  	s3c_fb_set_platdata(&mini6410_lcd_pdata);
> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
> index be2a9a2..41e4f74 100644
> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> @@ -119,36 +119,32 @@ static struct platform_device real6410_device_eth = {
> 
>  static struct s3c_fb_pd_win real6410_fb_win[] = {
>  	{
> -		.win_mode	= {	/* 4.3" 480x272 */
> -			.left_margin	= 3,
> -			.right_margin	= 2,
> -			.upper_margin	= 1,
> -			.lower_margin	= 1,
> -			.hsync_len	= 40,
> -			.vsync_len	= 1,
> -			.xres		= 480,
> -			.yres		= 272,
> -		},
>  		.max_bpp	= 32,
>  		.default_bpp	= 16,
> +		.xres		= 480,
> +		.yres		= 272,
>  	}, {
> -		.win_mode	= {	/* 7.0" 800x480 */
> -			.left_margin	= 8,
> -			.right_margin	= 13,
> -			.upper_margin	= 7,
> -			.lower_margin	= 5,
> -			.hsync_len	= 3,
> -			.vsync_len	= 1,
> -			.xres		= 800,
> -			.yres		= 480,
> -		},
>  		.max_bpp	= 32,
>  		.default_bpp	= 16,
> +		.xres		= 800,
> +		.yres		= 480,
>  	},
>  };
> 
> +static struct fb_videomode real6410_lcd_timing = {
> +	.left_margin	= 3,
> +	.right_margin	= 2,
> +	.upper_margin	= 1,
> +	.lower_margin	= 1,
> +	.hsync_len	= 40,
> +	.vsync_len	= 1,
> +	.xres		= 800,
> +	.yres		= 480,
> +};


What is the difference between mini6410_lcd_timing and real6410_lcd_timing?
In my opinion, it would be good as follows:

+static struct fb_videomode real6410_lcd_timing = {
+	.left_margin	= 8,
+	.right_margin	= 13,
+	.upper_margin	= 7,
+	.lower_margin	= 5,
+	.hsync_len	= 3,
+	.vsync_len	= 1,
+	.xres		= 800,
+	.yres		= 480,
+};


> +
>  static struct s3c_fb_platdata real6410_lcd_pdata __initdata = {
>  	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
> +	.vtiming	= &real6410_lcd_timing,
>  	.win[0]		= &real6410_fb_win[0],
>  	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
>  	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> @@ -291,8 +287,8 @@ static void __init real6410_machine_init(void)
>  	real6410_lcd_pdata.win[0] = &real6410_fb_win[features.lcd_index];
> 
>  	printk(KERN_INFO "REAL6410: selected LCD display is %dx%d\n",
> -		real6410_lcd_pdata.win[0]->win_mode.xres,
> -		real6410_lcd_pdata.win[0]->win_mode.yres);
> +		real6410_lcd_pdata.win[0]->xres,
> +		real6410_lcd_pdata.win[0]->yres);
> 
>  	s3c_fb_set_platdata(&real6410_lcd_pdata);
>  	s3c_nand_set_platdata(&real6410_nand_info);
[.....]


