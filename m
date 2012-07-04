From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 04 Jul 2012 15:24:51 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <20120704152451.GA7333@sirena.org.uk>
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
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Jul 05, 2012 at 12:14:39AM +0900, Alex Courbot wrote:
> On Wed 04 Jul 2012 10:00:56 PM JST, Sascha Hauer wrote:

> >Also please be aware that using a regulator in the pwm backlight will
> >instantly break all existing users. That's hardly your fault though.

> Sorry, I don't see why. Could you elaborate on this?

All existing machines will start failing during probe as they won't be
able to find the regulator - you should ideally make sure everyone in
mainline gets an appropriate regulator set up.
