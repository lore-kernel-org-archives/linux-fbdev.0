From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Thu, 29 Nov 2012 11:59:31 +0000
Subject: Re: [PATCH] video: mxsfb: fix typo: 'FAILING' instead of 'FALLING'
Message-Id: <20663.20003.18426.828567@ipc1.ka-ro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353588555-13168-1-git-send-email-LW@KARO-electronics.de>
 <1353588555-13168-2-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1353588555-13168-2-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi,

adding Juergen Beisert as the driver's author to the recipient list.

Lothar Waßmann writes:
> 
> Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
> ---
>  arch/arm/mach-mxs/mach-mxs.c |    6 +++---
>  drivers/video/mxsfb.c        |    6 +++---
>  include/linux/mxsfb.h        |    2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index d61b915..6c17cb7 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -42,7 +42,7 @@ static struct fb_videomode mx23evk_video_modes[] = {
>  		.hsync_len	= 1,
>  		.vsync_len	= 1,
>  		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT |
> -				  FB_SYNC_DOTCLK_FAILING_ACT,
> +				  FB_SYNC_DOTCLK_FALLING_ACT,
>  	},
>  };
>  
> @@ -60,7 +60,7 @@ static struct fb_videomode mx28evk_video_modes[] = {
>  		.hsync_len	= 10,
>  		.vsync_len	= 10,
>  		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT |
> -				  FB_SYNC_DOTCLK_FAILING_ACT,
> +				  FB_SYNC_DOTCLK_FALLING_ACT,
>  	},
>  };
>  
> @@ -96,7 +96,7 @@ static struct fb_videomode apx4devkit_video_modes[] = {
>  		.vsync_len	= 3,
>  		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT |
>  				  FB_SYNC_DATA_ENABLE_HIGH_ACT |
> -				  FB_SYNC_DOTCLK_FAILING_ACT,
> +				  FB_SYNC_DOTCLK_FALLING_ACT,
>  	},
>  };
>  
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index f2a49ef..eb45d32 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -107,7 +107,7 @@
>  #define VDCTRL0_ENABLE_PRESENT		(1 << 28)
>  #define VDCTRL0_VSYNC_ACT_HIGH		(1 << 27)
>  #define VDCTRL0_HSYNC_ACT_HIGH		(1 << 26)
> -#define VDCTRL0_DOTCLK_ACT_FAILING	(1 << 25)
> +#define VDCTRL0_DOTCLK_ACT_FALLING	(1 << 25)
>  #define VDCTRL0_ENABLE_ACT_HIGH		(1 << 24)
>  #define VDCTRL0_VSYNC_PERIOD_UNIT	(1 << 21)
>  #define VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	(1 << 20)
> @@ -458,8 +458,8 @@ static int mxsfb_set_par(struct fb_info *fb_info)
>  		vdctrl0 |= VDCTRL0_VSYNC_ACT_HIGH;
>  	if (fb_info->var.sync & FB_SYNC_DATA_ENABLE_HIGH_ACT)
>  		vdctrl0 |= VDCTRL0_ENABLE_ACT_HIGH;
> -	if (fb_info->var.sync & FB_SYNC_DOTCLK_FAILING_ACT)
> -		vdctrl0 |= VDCTRL0_DOTCLK_ACT_FAILING;
> +	if (fb_info->var.sync & FB_SYNC_DOTCLK_FALLING_ACT)
> +		vdctrl0 |= VDCTRL0_DOTCLK_ACT_FALLING;
>  
>  	writel(vdctrl0, host->base + LCDC_VDCTRL0);
>  
> diff --git a/include/linux/mxsfb.h b/include/linux/mxsfb.h
> index f14943d..a9eca68 100644
> --- a/include/linux/mxsfb.h
> +++ b/include/linux/mxsfb.h
> @@ -25,7 +25,7 @@
>  #define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24 bit width */
>  
>  #define FB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
> -#define FB_SYNC_DOTCLK_FAILING_ACT	(1 << 7) /* failing/negtive edge sampling */
> +#define FB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* falling/negative edge sampling */
>  
>  struct mxsfb_platform_data {
>  	struct fb_videomode *mode_list;
> -- 
> 1.7.2.5
> 
ping?


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
