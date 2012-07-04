From: Alex Courbot <acourbot@nvidia.com>
Date: Wed, 04 Jul 2012 15:14:39 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <4FF45DDF.9000306@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340976167-27298-1-git-send-email-acourbot@nvidia.com> <20120704104840.GJ24458@pengutronix.de> <4FF43692.2040805@nvidia.com> <20120704130056.GC30009@pengutronix.de>
In-Reply-To: <20120704130056.GC30009-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed 04 Jul 2012 10:00:56 PM JST, Sascha Hauer wrote:
>> That's very bad indeed. I assumed that the kernel would free
>> devm-allocated resources after probe returned -EPROBE_DEFER,
>
> It indeed does free devm allocated resources, but neither the gpio nor
> the pwm are devm allocated.

As far as I can tell the gpio is allocated through devm as well:

 > +		ret = devm_gpio_request_one(&pdev->dev, data->enable_gpio,
 > +				GPIOF_OUT_INIT_HIGH, "backlight_enable");

Thus if it is not reclaimed with probe returns with -EPROBE_DEFER, then 
I guess something is going wrong elsewhere. You are right that the PWM 
should be freed by the driver thought.

> Also please be aware that using a regulator in the pwm backlight will
> instantly break all existing users. That's hardly your fault though.

Sorry, I don't see why. Could you elaborate on this?

Thanks,
Alex.

