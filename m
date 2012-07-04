From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 04 Jul 2012 20:26:44 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <20120704202644.GG30009@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340976167-27298-1-git-send-email-acourbot@nvidia.com>
 <20120704104840.GJ24458@pengutronix.de>
 <4FF43692.2040805@nvidia.com>
 <20120704130056.GC30009@pengutronix.de>
 <4FF45DDF.9000306@nvidia.com>
In-Reply-To: <4FF45DDF.9000306-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Jul 05, 2012 at 12:14:39AM +0900, Alex Courbot wrote:
> On Wed 04 Jul 2012 10:00:56 PM JST, Sascha Hauer wrote:
> >>That's very bad indeed. I assumed that the kernel would free
> >>devm-allocated resources after probe returned -EPROBE_DEFER,
> >
> >It indeed does free devm allocated resources, but neither the gpio nor
> >the pwm are devm allocated.
> 
> As far as I can tell the gpio is allocated through devm as well:
> 
> > +		ret = devm_gpio_request_one(&pdev->dev, data->enable_gpio,
> > +				GPIOF_OUT_INIT_HIGH, "backlight_enable");

You're right. For the GPIO it's ok the way it is.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
