From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 12 Nov 2011 00:14:16 +0000
Subject: Re: [PATCH 1/2] atmel_lcdfb: Adjust HFP calculation so it matches
Message-Id: <4EBDBA58.9020208@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1317801598-23757-1-git-send-email-alexander.stein@systec-electronic.com>
In-Reply-To: <1317801598-23757-1-git-send-email-alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/05/2011 07:59 AM, Alexander Stein wrote:
> In the AT91SAM9263 Manual the HFP part in LCDTIM2 is described as follows:
>   * HFP: Horizontal Front Porch
>   Number of idle LCDDOTCK cycles at the end of the line.
>   Idle period is (HFP+2) LCDDOTCK cycles.
> 
> It is only a minor issue. I also changed all boards using atmel_lcdfb
> I found to respect the new calculation.

Applied both patches of this series.


Thanks,

Florian Tobias Schandinat

> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  arch/arm/mach-at91/board-cap9adk.c      |    2 +-
>  arch/arm/mach-at91/board-neocore926.c   |    2 +-
>  arch/arm/mach-at91/board-sam9261ek.c    |    4 ++--
>  arch/arm/mach-at91/board-sam9263ek.c    |    2 +-
>  arch/arm/mach-at91/board-sam9m10g45ek.c |    2 +-
>  arch/arm/mach-at91/board-sam9rlek.c     |    2 +-
>  drivers/video/atmel_lcdfb.c             |    4 ++--
>  7 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
> index 679b0b7..ae962bf 100644
> --- a/arch/arm/mach-at91/board-cap9adk.c
> +++ b/arch/arm/mach-at91/board-cap9adk.c
> @@ -304,7 +304,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
>  		.xres		= 240,		.yres		= 320,
>  		.pixclock	= KHZ2PICOS(4965),
>  
> -		.left_margin	= 1,		.right_margin	= 33,
> +		.left_margin	= 1,		.right_margin	= 34,
>  		.upper_margin	= 1,		.lower_margin	= 0,
>  		.hsync_len	= 5,		.vsync_len	= 1,
>  
> diff --git a/arch/arm/mach-at91/board-neocore926.c b/arch/arm/mach-at91/board-neocore926.c
> index 9bc6ab3..583878e 100644
> --- a/arch/arm/mach-at91/board-neocore926.c
> +++ b/arch/arm/mach-at91/board-neocore926.c
> @@ -235,7 +235,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
>  		.xres		= 240,		.yres		= 320,
>  		.pixclock	= KHZ2PICOS(5000),
>  
> -		.left_margin	= 1,		.right_margin	= 33,
> +		.left_margin	= 1,		.right_margin	= 34,
>  		.upper_margin	= 1,		.lower_margin	= 0,
>  		.hsync_len	= 5,		.vsync_len	= 1,
>  
> diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
> index 5096a0e..8dda83b 100644
> --- a/arch/arm/mach-at91/board-sam9261ek.c
> +++ b/arch/arm/mach-at91/board-sam9261ek.c
> @@ -370,7 +370,7 @@ static struct fb_videomode at91_stn_modes[] = {
>  		.xres           = 320,          .yres           = 240,
>  		.pixclock       = KHZ2PICOS(1440),
>  
> -		.left_margin    = 1,            .right_margin   = 1,
> +		.left_margin    = 1,            .right_margin   = 2,
>  		.upper_margin   = 0,            .lower_margin   = 0,
>  		.hsync_len      = 1,            .vsync_len      = 1,
>  
> @@ -431,7 +431,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
>  		.xres		= 240,		.yres		= 320,
>  		.pixclock	= KHZ2PICOS(4965),
>  
> -		.left_margin	= 1,		.right_margin	= 33,
> +		.left_margin	= 1,		.right_margin	= 34,
>  		.upper_margin	= 1,		.lower_margin	= 0,
>  		.hsync_len	= 5,		.vsync_len	= 1,
>  
> diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
> index ea8f185..e260070 100644
> --- a/arch/arm/mach-at91/board-sam9263ek.c
> +++ b/arch/arm/mach-at91/board-sam9263ek.c
> @@ -258,7 +258,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
>  		.xres		= 240,		.yres		= 320,
>  		.pixclock	= KHZ2PICOS(4965),
>  
> -		.left_margin	= 1,		.right_margin	= 33,
> +		.left_margin	= 1,		.right_margin	= 34,
>  		.upper_margin	= 1,		.lower_margin	= 0,
>  		.hsync_len	= 5,		.vsync_len	= 1,
>  
> diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
> index ad234cc..5e9a5ca 100644
> --- a/arch/arm/mach-at91/board-sam9m10g45ek.c
> +++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
> @@ -197,7 +197,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
>  		.xres		= 480,		.yres		= 272,
>  		.pixclock	= KHZ2PICOS(9000),
>  
> -		.left_margin	= 1,		.right_margin	= 1,
> +		.left_margin	= 1,		.right_margin	= 2,
>  		.upper_margin	= 40,		.lower_margin	= 1,
>  		.hsync_len	= 45,		.vsync_len	= 1,
>  
> diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
> index 4f14b54..ad9e5c9 100644
> --- a/arch/arm/mach-at91/board-sam9rlek.c
> +++ b/arch/arm/mach-at91/board-sam9rlek.c
> @@ -154,7 +154,7 @@ static struct fb_videomode at91_tft_vga_modes[] = {
>  		.xres		= 240,		.yres		= 320,
>  		.pixclock	= KHZ2PICOS(4965),
>  
> -		.left_margin	= 1,		.right_margin	= 33,
> +		.left_margin	= 1,		.right_margin	= 34,
>  		.upper_margin	= 1,		.lower_margin	= 0,
>  		.hsync_len	= 5,		.vsync_len	= 1,
>  
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 817ab60..816d528 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -393,7 +393,7 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
>  	var->lower_margin = min_t(u32, var->lower_margin,
>  			ATMEL_LCDC_VFP);
>  	var->right_margin = min_t(u32, var->right_margin,
> -			(ATMEL_LCDC_HFP >> ATMEL_LCDC_HFP_OFFSET) + 1);
> +			(ATMEL_LCDC_HFP >> ATMEL_LCDC_HFP_OFFSET) + 2);
>  	var->hsync_len = min_t(u32, var->hsync_len,
>  			(ATMEL_LCDC_HPW >> ATMEL_LCDC_HPW_OFFSET) + 1);
>  	var->left_margin = min_t(u32, var->left_margin,
> @@ -578,7 +578,7 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
>  	lcdc_writel(sinfo, ATMEL_LCDC_TIM1, value);
>  
>  	/* Horizontal timing */
> -	value = (info->var.right_margin - 1) << ATMEL_LCDC_HFP_OFFSET;
> +	value = (info->var.right_margin - 2) << ATMEL_LCDC_HFP_OFFSET;
>  	value |= (info->var.hsync_len - 1) << ATMEL_LCDC_HPW_OFFSET;
>  	value |= (info->var.left_margin - 1);
>  	dev_dbg(info->device, "  * LCDTIM2 = %08lx\n", value);

