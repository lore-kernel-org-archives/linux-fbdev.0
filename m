From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 08 Mar 2016 07:55:30 +0000
Subject: Re: [PATCH 1/3] video: fbdev: imxfb: fix semantic of .get_power and .set_power
Message-Id: <1457423730.4174.4.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1457380425-20244-2-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi Uwe,

Am Montag, den 07.03.2016, 20:53 +0100 schrieb Uwe Kleine-König:
> .set_power gets passed an FB_BLANK_XXX value, not a bool. So 0 signals
> on; and >1 means off. The same applies for return values of .get_power.

I'd try to somehow work this information into the code to avoid future
confusion.

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/fbdev/imxfb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index cee88603efc9..c5fcedde2a60 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -759,9 +759,9 @@ static int imxfb_lcd_get_power(struct lcd_device *lcddev)
>  	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
>  
>  	if (!IS_ERR(fbi->lcd_pwr))
> -		return regulator_is_enabled(fbi->lcd_pwr);
> +		return !regulator_is_enabled(fbi->lcd_pwr);
>  
> -	return 1;
> +	return 0;

How about making it explicit:

	if (!IS_ERR(fbi->lcd_pwr) &&
	    !regulator_is_enabled(fbi->lcd_pwr))
		return FB_BLANK_POWERDOWN;

	return FB_BLANK_UNBLANK;

>  }
>  
>  static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
> @@ -769,7 +769,7 @@ static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
>  	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
>  
>  	if (!IS_ERR(fbi->lcd_pwr)) {
> -		if (power)
> +		if (!power)

Same here:
		if (power = FB_BLANK_UNBLANK)

>  			return regulator_enable(fbi->lcd_pwr);
>  		else
>  			return regulator_disable(fbi->lcd_pwr);

regards
Philipp

