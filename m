From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 05 Jul 2012 06:47:42 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <20120705064742.GL30009@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340976167-27298-1-git-send-email-acourbot@nvidia.com>
 <20120704104840.GJ24458@pengutronix.de>
 <4FF43692.2040805@nvidia.com>
 <20120704130056.GC30009@pengutronix.de>
 <4FF45DDF.9000306@nvidia.com>
 <20120704152451.GA7333@sirena.org.uk>
 <4FF4FDC0.8020405@nvidia.com>
 <20120705062011.GI30009@pengutronix.de>
 <4FF53368.6090805@nvidia.com>
In-Reply-To: <4FF53368.6090805-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Jul 05, 2012 at 03:25:44PM +0900, Alex Courbot wrote:
> On 07/05/2012 03:20 PM, Sascha Hauer wrote:
> >>Oh, that is a mistake of mine then. Driver probe should continue if
> >>no regulator is declared (but should fail if some other error
> >>occured). I want to maintain backward compatibility with current
> >>users of the driver, so regulator/gpio specification should be
> >>optional.
> >
> >I think the only way doing this is to add a flag to platform_data. I
> >don't know if that's accepted though.
> 
> I thought about just checking if devm_get_regulator returned -ENODEV
> and happily continue if that was the case, assuming no regulator was
> declared.

And that's the problem. The get_regulator won't return -ENODEV. It will
return -EPROBE_DEFER which tells you nothing about whether a regulator
will ever be available or not.

Having a flag in platform data would be fine with me, but I know other
people think differently.

BTW in devicetree this flag implicitely exists with the power-supply
property. The regulator core could look if a power-supply property
is given and

- if it is given, a regulator is mandatory and the core either
  returns the regulator or -EPROBE_DEFER if it cannot find one.
- If it is not given, there is no regulator and the core could either
  return a special error code or a dummy regulator.

Right now the regulator core will just return -EPROBE_DEFER in both
cases. This could easily be changed in the regulator core.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
