From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 04 Jul 2012 13:00:56 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <20120704130056.GC30009@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340976167-27298-1-git-send-email-acourbot@nvidia.com>
 <20120704104840.GJ24458@pengutronix.de>
 <4FF43692.2040805@nvidia.com>
In-Reply-To: <4FF43692.2040805-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Jul 04, 2012 at 09:26:58PM +0900, Alex Courbot wrote:
> Hi Sascha,
> 
> On 07/04/2012 07:48 PM, Sascha Hauer wrote:>> +
> >> +	pb->power_reg = devm_regulator_get(&pdev->dev, "power");
> >> +	if (IS_ERR(pb->power_reg))
> >> +		return PTR_ERR(pb->power_reg);
> >
> > This looses several resources allocated earlier, like the enable gpio
> > and the pwm. This is really bad here since I have no regulator specified
> > and devm_regulator_get returns with -EPROBE_DEFER. Next time the core
> > tries to probe the driver the driver bails out because the gpio and the
> > pwm is already requested.
> 
> That's very bad indeed. I assumed that the kernel would free
> devm-allocated resources after probe returned -EPROBE_DEFER,

It indeed does free devm allocated resources, but neither the gpio nor
the pwm are devm allocated.

Also please be aware that using a regulator in the pwm backlight will
instantly break all existing users. That's hardly your fault though.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
