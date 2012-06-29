From: Stephen Warren <swarren@wwwdotorg.org>
Date: Fri, 29 Jun 2012 16:04:50 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <4FEDD222.7050905@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340976167-27298-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1340976167-27298-1-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/29/2012 07:22 AM, Alexandre Courbot wrote:
> Add support for an optional power regulator and enable/disable GPIO.
> This scheme is commonly used in embedded systems.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c

> -	dev_dbg(&pdev->dev, "got pwm for backlight\n");
> -

That seems like an unrelated change?

> @@ -231,6 +271,22 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	if (data->pwm_period_ns > 0)
>  		pwm_set_period(pb->pwm, data->pwm_period_ns);
>  
> +
> +	pb->power_reg = devm_regulator_get(&pdev->dev, "power");

There's an extra blank line there.

> +	if (IS_ERR(pb->power_reg))
> +		return PTR_ERR(pb->power_reg);
> +
> +	pb->enable_gpio = -EINVAL;
> +	if (data->use_enable_gpio) {
> +		ret = devm_gpio_request_one(&pdev->dev, data->enable_gpio,
> +				GPIOF_OUT_INIT_HIGH, "backlight_enable");
> +		if (ret)
> +			dev_warn(&pdev->dev,
> +				"error %d requesting control gpio\n", ret);

Shouldn't that be a hard error? If the user specified that some GPIO be
used, and the GPIO could not be requested, shouldn't the driver fail to
initialize?

> +		else
> +			pb->enable_gpio = data->enable_gpio;

Aside from that, this looks good to me.
