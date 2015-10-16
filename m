From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 16 Oct 2015 08:36:16 +0000
Subject: Re: [RESEND PATCH] pwm-backlight: fix the panel power sequence
Message-Id: <20151016083616.GA7858@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444959454-1516-1-git-send-email-yh.huang@mediatek.com>
In-Reply-To: <1444959454-1516-1-git-send-email-yh.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 16, 2015 at 09:37:34AM +0800, YH Huang wrote:
> In order to match the panel power sequence, disable the enable_gpio
> in the probe function. Also, reorder the code in the power_on and
> power_off function to match the timing.
> @@ -241,8 +242,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	pb->dev = &pdev->dev;
>  	pb->enabled = false;
>  
> -	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> -						  GPIOD_OUT_HIGH);
> +	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");

Please actually test your patches. This change here won't compile.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
