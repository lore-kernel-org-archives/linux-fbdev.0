From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 28 Mar 2012 10:07:15 +0000
Subject: Re: [PATCH v3 3/4] ARM: s3c64xx: Decouple lcd type from display controller window data
Message-Id: <008801cd0cca$8d72cad0$a8586070$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1332606528-32338-1-git-send-email-thomas.abraham@linaro.org>
 <1332606528-32338-4-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1332606528-32338-4-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 25 March 2012 01:29, Thomas Abraham < thomas.abraham@linaro.org> wrote:
> Subject: [PATCH v3 3/4] ARM: s3c64xx: Decouple lcd type from display controller window data
> 
> The display controller window data should contain window configuration data
> for only one type of lcd panel. So, for real6410 and mini6410 boards, split
> the existing display controller window data, which contains window
> configuration data for two different types of lcd panels, into two seperate
> instances and register one of them depending on the type of the lcd panel
> detected at runtime.
> 
> This is a prerequisite change for a subsequent commit that reorders the
> platform data of display controller by moving video interface timing out
> of window setup data.
> 
> Cc: Darius Augulis <augulis.darius@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>

It looks good.

Acked-by: Jingoo Han <jg1.han@samsung.com>

> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-s3c64xx/mach-mini6410.c |   82 +++++++++++++++++---------------
>  arch/arm/mach-s3c64xx/mach-real6410.c |   82 +++++++++++++++++---------------
>  2 files changed, 88 insertions(+), 76 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
> index c34c2ab..34f5195 100644
> --- a/arch/arm/mach-s3c64xx/mach-mini6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
> @@ -151,41 +151,49 @@ static struct s3c2410_platform_nand mini6410_nand_info = {
>  	.sets		= mini6410_nand_sets,
>  };
> 
> -static struct s3c_fb_pd_win mini6410_fb_win[] = {
> -	{
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
> -		.max_bpp	= 32,
> -		.default_bpp	= 16,
> -	}, {
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
> -		.max_bpp	= 32,
> -		.default_bpp	= 16,
> +static struct s3c_fb_pd_win mini6410_lcd_type0_fb_win = {
> +	.win_mode	= {	/* 4.3" 480x272 */
> +		.left_margin	= 3,
> +		.right_margin	= 2,
> +		.upper_margin	= 1,
> +		.lower_margin	= 1,
> +		.hsync_len	= 40,
> +		.vsync_len	= 1,
> +		.xres		= 480,
> +		.yres		= 272,
>  	},
> +	.max_bpp	= 32,
> +	.default_bpp	= 16,
>  };
> 
> -static struct s3c_fb_platdata mini6410_lcd_pdata __initdata = {
> -	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
> -	.win[0]		= &mini6410_fb_win[0],
> -	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
> -	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> +static struct s3c_fb_pd_win mini6410_lcd_type1_fb_win = {
> +	.win_mode	= {	/* 7.0" 800x480 */
> +		.left_margin	= 8,
> +		.right_margin	= 13,
> +		.upper_margin	= 7,
> +		.lower_margin	= 5,
> +		.hsync_len	= 3,
> +		.vsync_len	= 1,
> +		.xres		= 800,
> +		.yres		= 480,
> +	},
> +	.max_bpp	= 32,
> +	.default_bpp	= 16,
> +};
> +
> +static struct s3c_fb_platdata mini6410_lcd_pdata[] __initdata = {
> +	{
> +		.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
> +		.win[0]		= &mini6410_lcd_type0_fb_win,
> +		.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
> +		.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> +	}, {
> +		.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
> +		.win[0]		= &mini6410_lcd_type1_fb_win,
> +		.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
> +		.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> +	},
> +	{ },
>  };
> 
>  static void mini6410_lcd_power_set(struct plat_lcd_data *pd,
> @@ -283,7 +291,7 @@ static void mini6410_parse_features(
>  					"screen type already set\n", f);
>  			} else {
>  				int li = f - '0';
> -				if (li >= ARRAY_SIZE(mini6410_fb_win))
> +				if (li >= ARRAY_SIZE(mini6410_lcd_pdata))
>  					printk(KERN_INFO "MINI6410: '%c' out "
>  						"of range LCD mode\n", f);
>  				else {
> @@ -307,14 +315,12 @@ static void __init mini6410_machine_init(void)
>  	/* Parse the feature string */
>  	mini6410_parse_features(&features, mini6410_features_str);
> 
> -	mini6410_lcd_pdata.win[0] = &mini6410_fb_win[features.lcd_index];
> -
>  	printk(KERN_INFO "MINI6410: selected LCD display is %dx%d\n",
> -		mini6410_lcd_pdata.win[0]->win_mode.xres,
> -		mini6410_lcd_pdata.win[0]->win_mode.yres);
> +		mini6410_lcd_pdata[features.lcd_index].win[0]->win_mode.xres,
> +		mini6410_lcd_pdata[features.lcd_index].win[0]->win_mode.yres);
> 
>  	s3c_nand_set_platdata(&mini6410_nand_info);
> -	s3c_fb_set_platdata(&mini6410_lcd_pdata);
> +	s3c_fb_set_platdata(&mini6410_lcd_pdata[features.lcd_index]);
>  	s3c24xx_ts_set_platdata(NULL);
> 
>  	/* configure nCS1 width to 16 bits */
> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
> index be2a9a2..21f91e5 100644
> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> @@ -117,41 +117,49 @@ static struct platform_device real6410_device_eth = {
>  	},
>  };
> 
> -static struct s3c_fb_pd_win real6410_fb_win[] = {
> -	{
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
> -		.max_bpp	= 32,
> -		.default_bpp	= 16,
> -	}, {
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
> -		.max_bpp	= 32,
> -		.default_bpp	= 16,
> +static struct s3c_fb_pd_win real6410_lcd_type0_fb_win = {
> +	.win_mode	= {	/* 4.3" 480x272 */
> +		.left_margin	= 3,
> +		.right_margin	= 2,
> +		.upper_margin	= 1,
> +		.lower_margin	= 1,
> +		.hsync_len	= 40,
> +		.vsync_len	= 1,
> +		.xres		= 480,
> +		.yres		= 272,
>  	},
> +	.max_bpp	= 32,
> +	.default_bpp	= 16,
>  };
> 
> -static struct s3c_fb_platdata real6410_lcd_pdata __initdata = {
> -	.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
> -	.win[0]		= &real6410_fb_win[0],
> -	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
> -	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> +static struct s3c_fb_pd_win real6410_lcd_type1_fb_win = {
> +	.win_mode	= {	/* 7.0" 800x480 */
> +		.left_margin	= 8,
> +		.right_margin	= 13,
> +		.upper_margin	= 7,
> +		.lower_margin	= 5,
> +		.hsync_len	= 3,
> +		.vsync_len	= 1,
> +		.xres		= 800,
> +		.yres		= 480,
> +	},
> +	.max_bpp	= 32,
> +	.default_bpp	= 16,
> +};
> +
> +static struct s3c_fb_platdata real6410_lcd_pdata[] __initdata = {
> +	{
> +		.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
> +		.win[0]		= &real6410_lcd_type0_fb_win,
> +		.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
> +		.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> +	}, {
> +		.setup_gpio	= s3c64xx_fb_gpio_setup_24bpp,
> +		.win[0]		= &real6410_lcd_type1_fb_win,
> +		.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
> +		.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
> +	},
> +	{ },
>  };
> 
>  static struct mtd_partition real6410_nand_part[] = {
> @@ -264,7 +272,7 @@ static void real6410_parse_features(
>  					"screen type already set\n", f);
>  			} else {
>  				int li = f - '0';
> -				if (li >= ARRAY_SIZE(real6410_fb_win))
> +				if (li >= ARRAY_SIZE(real6410_lcd_pdata))
>  					printk(KERN_INFO "REAL6410: '%c' out "
>  						"of range LCD mode\n", f);
>  				else {
> @@ -288,13 +296,11 @@ static void __init real6410_machine_init(void)
>  	/* Parse the feature string */
>  	real6410_parse_features(&features, real6410_features_str);
> 
> -	real6410_lcd_pdata.win[0] = &real6410_fb_win[features.lcd_index];
> -
>  	printk(KERN_INFO "REAL6410: selected LCD display is %dx%d\n",
> -		real6410_lcd_pdata.win[0]->win_mode.xres,
> -		real6410_lcd_pdata.win[0]->win_mode.yres);
> +		real6410_lcd_pdata[features.lcd_index].win[0]->win_mode.xres,
> +		real6410_lcd_pdata[features.lcd_index].win[0]->win_mode.yres);
> 
> -	s3c_fb_set_platdata(&real6410_lcd_pdata);
> +	s3c_fb_set_platdata(&real6410_lcd_pdata[features.lcd_index]);
>  	s3c_nand_set_platdata(&real6410_nand_info);
>  	s3c24xx_ts_set_platdata(NULL);
> 
> --
> 1.6.6.rc2

