From: Alex Courbot <acourbot@nvidia.com>
Date: Thu, 05 Jul 2012 02:36:48 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <4FF4FDC0.8020405@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340976167-27298-1-git-send-email-acourbot@nvidia.com> <20120704104840.GJ24458@pengutronix.de> <4FF43692.2040805@nvidia.com> <20120704130056.GC30009@pengutronix.de> <4FF45DDF.9000306@nvidia.com> <20120704152451.GA7333@sirena.org.uk>
In-Reply-To: <20120704152451.GA7333-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/05/2012 12:24 AM, Mark Brown wrote:
> On Thu, Jul 05, 2012 at 12:14:39AM +0900, Alex Courbot wrote:
>> On Wed 04 Jul 2012 10:00:56 PM JST, Sascha Hauer wrote:
>
>>> Also please be aware that using a regulator in the pwm backlight will
>>> instantly break all existing users. That's hardly your fault though.
>
>> Sorry, I don't see why. Could you elaborate on this?
>
> All existing machines will start failing during probe as they won't be
> able to find the regulator - you should ideally make sure everyone in
> mainline gets an appropriate regulator set up.

Oh, that is a mistake of mine then. Driver probe should continue if no 
regulator is declared (but should fail if some other error occured). I 
want to maintain backward compatibility with current users of the 
driver, so regulator/gpio specification should be optional.

Thanks for all the feedback people - I will come back with a new version 
that addresses the points highlighted and also allows power on/off 
sequences to be specified in the device tree.

Alex.
