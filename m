From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 05 Jul 2012 08:02:34 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <20120705080234.GQ30009@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120704104840.GJ24458@pengutronix.de>
 <4FF43692.2040805@nvidia.com>
 <20120704130056.GC30009@pengutronix.de>
 <4FF45DDF.9000306@nvidia.com>
 <20120704152451.GA7333@sirena.org.uk>
 <4FF4FDC0.8020405@nvidia.com>
 <20120705062011.GI30009@pengutronix.de>
 <4FF53368.6090805@nvidia.com>
 <20120705064742.GL30009@pengutronix.de>
 <4FF5459F.5090201@nvidia.com>
In-Reply-To: <4FF5459F.5090201-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Jul 05, 2012 at 04:43:27PM +0900, Alex Courbot wrote:
> On 07/05/2012 03:47 PM, Sascha Hauer wrote:
> >>I thought about just checking if devm_get_regulator returned -ENODEV
> >>and happily continue if that was the case, assuming no regulator was
> >>declared.
> >
> >And that's the problem. The get_regulator won't return -ENODEV. It will
> >return -EPROBE_DEFER which tells you nothing about whether a regulator
> >will ever be available or not.
> >
> >Having a flag in platform data would be fine with me, but I know other
> >people think differently.
> >
> >BTW in devicetree this flag implicitely exists with the power-supply
> >property.
> 
> One could actually question whether the whole regulator/gpio thing
> should be supported at all with platform data. The platform
> interface can use the function hooks in order to implement whatever
> behavior it wants when the light needs to be powered on and off. The
> reason for introducing optional regulator/gpio parameters is because
> the DT cannot use these. Since I have no plan to remove these
> function hooks, making the regulator/gpio option available in
> platform data might be redundant. Any thought about this?

sounds good.

> 
> >Right now the regulator core will just return -EPROBE_DEFER in both
> >cases. This could easily be changed in the regulator core.
> 
> Could this be because the regulator core cannot make the difference
> between a not-yet-available regulator and a missing one?

It could. In regulator_dev_lookup we have:

		if (node) {
			...
		} else {
			/*
			 * If we couldn't even get the node then it's
			 * not just that the device didn't register
			 * yet, there's no node and we'll never
			 * succeed.
			 */
			*ret = -ENODEV;
		}

So here the regulator core knows that there is no regulator and never
will be. All that needs to be done is to make _regulator_get look at
that value.
There may be some side effects if we just return ERR_PTR(-ENODEV) when
regulator_dev_lookup returns -ENODEV. Maybe Mark has some comments to
this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
