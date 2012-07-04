From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 04 Jul 2012 10:48:40 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <20120704104840.GJ24458@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340976167-27298-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1340976167-27298-1-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Alexandre,

On Fri, Jun 29, 2012 at 10:22:47PM +0900, Alexandre Courbot wrote:
> @@ -221,8 +263,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	dev_dbg(&pdev->dev, "got pwm for backlight\n");
> -
>  	/*
>  	 * The DT case will set the pwm_period_ns field to 0 and store the
>  	 * period, parsed from the DT, in the PWM device. For the non-DT case,
> @@ -231,6 +271,22 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	if (data->pwm_period_ns > 0)
>  		pwm_set_period(pb->pwm, data->pwm_period_ns);
>  
> +
> +	pb->power_reg = devm_regulator_get(&pdev->dev, "power");
> +	if (IS_ERR(pb->power_reg))
> +		return PTR_ERR(pb->power_reg);

This looses several resources allocated earlier, like the enable gpio
and the pwm. This is really bad here since I have no regulator specified
and devm_regulator_get returns with -EPROBE_DEFER. Next time the core
tries to probe the driver the driver bails out because the gpio and the
pwm is already requested.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
