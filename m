From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 17 Apr 2020 14:07:58 +0000
Subject: Re: [PATCH] video: fbdev: imxfb: ensure balanced regulator usage
Message-Id: <1dcf1273-ae01-02c6-d9a4-5eef744ab764@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200323211646eucas1p270ab02024c326adba5a50b908ef8ba8a@eucas1p2.samsung.com>
 <20200323211626.24812-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20200323211626.24812-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org


On 3/23/20 10:16 PM, Uwe Kleine-König wrote:
> The fbdev framework doesn't care to call the .set_power callback only on
> changes. So the driver has to care for itself that the regulator doesn't
> get disabled more often than enabled.
> 
> This fixes the regulator warning
> 
> 	unbalanced disables for lcd supply
> 
> which can be triggered by doing
> 
> 	echo 4 > /sys/class/lcd/imxfb-lcd/lcd_power
> 
> twice.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Patch queued for v5.8, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/imxfb.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index 370bf2553d43..884b16efa7e8 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -172,6 +172,7 @@ struct imxfb_info {
>  	int			num_modes;
>  
>  	struct regulator	*lcd_pwr;
> +	int			lcd_pwr_enabled;
>  };
>  
>  static const struct platform_device_id imxfb_devtype[] = {
> @@ -801,16 +802,30 @@ static int imxfb_lcd_get_power(struct lcd_device *lcddev)
>  	return FB_BLANK_UNBLANK;
>  }
>  
> +static int imxfb_regulator_set(struct imxfb_info *fbi, int enable)
> +{
> +	int ret;
> +
> +	if (enable = fbi->lcd_pwr_enabled)
> +		return 0;
> +
> +	if (enable)
> +		ret = regulator_enable(fbi->lcd_pwr);
> +	else
> +		ret = regulator_disable(fbi->lcd_pwr);
> +
> +	if (ret = 0)
> +		fbi->lcd_pwr_enabled = enable;
> +
> +	return ret;
> +}
> +
>  static int imxfb_lcd_set_power(struct lcd_device *lcddev, int power)
>  {
>  	struct imxfb_info *fbi = dev_get_drvdata(&lcddev->dev);
>  
> -	if (!IS_ERR(fbi->lcd_pwr)) {
> -		if (power = FB_BLANK_UNBLANK)
> -			return regulator_enable(fbi->lcd_pwr);
> -		else
> -			return regulator_disable(fbi->lcd_pwr);
> -	}
> +	if (!IS_ERR(fbi->lcd_pwr))
> +		return imxfb_regulator_set(fbi, power = FB_BLANK_UNBLANK);
>  
>  	return 0;
>  }
> 
