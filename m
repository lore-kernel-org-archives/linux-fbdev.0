From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 09 Jan 2012 02:49:59 +0000
Subject: Re: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove unsupported
Message-Id: <4F0A55D7.50707@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
 <87zke29yqj.fsf@macbook.be.48ers.dk>
In-Reply-To: <87zke29yqj.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Peter,

On 01/05/2012 11:26 AM, Peter Korsgaard wrote:
>>>>>> "Peter" = Peter Korsgaard <jacmet@sunsite.dk> writes:
> 
>  Peter> Allow framebuffer to be configured in 16bit mode when panel is
>  Peter> wired in (the default) BGR configuration, and don't claim to
>  Peter> support 15bit input modes, which the LCD controller cannot
>  Peter> handle.
> 
> Ping? Nicolas, you added it to your at91-lcd branch - But it doesn't seem
> to have gone any further.

I could also take care of this patch but I'd prefer if it gets an Acked-by of
someone at Atmel (or someone else who knows the hardware) as I cannot really
tell whether it is correct.


Best regards,

Florian Tobias Schandinat

> 
>  Peter> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>  Peter> ---
>  Peter>  drivers/video/atmel_lcdfb.c |   12 +++---------
>  Peter>  1 files changed, 3 insertions(+), 9 deletions(-)
> 
>  Peter> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
>  Peter> index 7ca3eaf..143f6d9 100644
>  Peter> --- a/drivers/video/atmel_lcdfb.c
>  Peter> +++ b/drivers/video/atmel_lcdfb.c
>  Peter> @@ -418,24 +418,18 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
>  var-> red.length = var->green.length = var->blue.length
>  Peter>  			= var->bits_per_pixel;
>  Peter>  		break;
>  Peter> -	case 15:
>  Peter>  	case 16:
>  Peter>  		if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB) {
>  Peter>  			/* RGB:565 mode */
>  var-> red.offset = 11;
>  var-> blue.offset = 0;
>  Peter> -			var->green.length = 6;
>  Peter> -		} else if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB555) {
>  Peter> -			var->red.offset = 10;
>  Peter> -			var->blue.offset = 0;
>  Peter> -			var->green.length = 5;
>  Peter>  		} else {
>  Peter> -			/* BGR:555 mode */
>  Peter> +			/* BGR:565 mode */
>  var-> red.offset = 0;
>  Peter> -			var->blue.offset = 10;
>  Peter> -			var->green.length = 5;
>  Peter> +			var->blue.offset = 11;
>  Peter>  		}
>  var-> green.offset = 5;
>  Peter> +		var->green.length = 6;
>  var-> red.length = var->blue.length = 5;
>  Peter>  		break;
>  Peter>  	case 32:
>  Peter> -- 
>  Peter> 1.7.6.3
> 

