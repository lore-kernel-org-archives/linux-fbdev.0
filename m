From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon, 09 Jan 2012 10:34:25 +0000
Subject: Re: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove unsupported
Message-Id: <4F0AC2B1.8010601@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
In-Reply-To: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/13/2011 04:52 PM, Peter Korsgaard :
> Allow framebuffer to be configured in 16bit mode when panel is wired in
> (the default) BGR configuration, and don't claim to support 15bit input
> modes, which the LCD controller cannot handle.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

Hi Peter,

Sorry for not having more responsive concerning the two patches that you
posted about atmel_lcdfb driver.


I have a question though about this one...


> ---
>  drivers/video/atmel_lcdfb.c |   12 +++---------
>  1 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 7ca3eaf..143f6d9 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -418,24 +418,18 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
>  		var->red.length = var->green.length = var->blue.length
>  			= var->bits_per_pixel;
>  		break;
> -	case 15:
>  	case 16:
>  		if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB) {
>  			/* RGB:565 mode */
>  			var->red.offset = 11;
>  			var->blue.offset = 0;
> -			var->green.length = 6;
> -		} else if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB555) {
> -			var->red.offset = 10;
> -			var->blue.offset = 0;
> -			var->green.length = 5;

Maybe I have missed something but I do not know why you are removing
this part of the configuration? A board at least is using this wiring
mode...


>  		} else {
> -			/* BGR:555 mode */
> +			/* BGR:565 mode */
>  			var->red.offset = 0;
> -			var->blue.offset = 10;
> -			var->green.length = 5;
> +			var->blue.offset = 11;
>  		}
>  		var->green.offset = 5;
> +		var->green.length = 6;
>  		var->red.length = var->blue.length = 5;
>  		break;

Maybe we can separate both 15 and 16 cases but I do not know if we can
remove completely the 15 RGB555 mode...

Best regards,
-- 
Nicolas Ferre
