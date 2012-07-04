From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 04 Jul 2012 12:27:33 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <20120704122733.GA30698@sirena.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340976167-27298-1-git-send-email-acourbot@nvidia.com>
 <20120704104840.GJ24458@pengutronix.de>
 <4FF43692.2040805@nvidia.com>
In-Reply-To: <4FF43692.2040805-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Jul 04, 2012 at 09:26:58PM +0900, Alex Courbot wrote:
> On 07/04/2012 07:48 PM, Sascha Hauer wrote:>> +

> > This looses several resources allocated earlier, like the enable gpio
> > and the pwm. This is really bad here since I have no regulator specified
> > and devm_regulator_get returns with -EPROBE_DEFER. Next time the core
> > tries to probe the driver the driver bails out because the gpio and the
> > pwm is already requested.

> That's very bad indeed. I assumed that the kernel would free
> devm-allocated resources after probe returned -EPROBE_DEFER, so that
> probe could reallocate them the next time it is called. Apparently
> that was wrong. Do you know what would the right approach be in this
> case? Does the kernel preserve the device structure and its
> associated data between the two calls to probe? If so, I could just
> check whether the private data has already been constructed to know
> which state we are in and continue from there.

I'd really expect the devm_ functions to behave as you expect - if they
don't currently we should probably fix them so that they do otherwise
we're going to be in for a lot of surprises and probe deferral becomes a
lot more cumbersome to use.
