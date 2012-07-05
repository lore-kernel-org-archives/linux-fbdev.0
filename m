From: Alex Courbot <acourbot@nvidia.com>
Date: Thu, 05 Jul 2012 08:12:28 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <4FF54C6C.1060700@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120704104840.GJ24458@pengutronix.de> <4FF43692.2040805@nvidia.com> <20120704130056.GC30009@pengutronix.de> <4FF45DDF.9000306@nvidia.com> <20120704152451.GA7333@sirena.org.uk> <4FF4FDC0.8020405@nvidia.com> <20120705062011.GI30009@pengutronix.de> <4FF53368.6090805@nvidia.com> <20120705064742.GL30009@pengutronix.de> <4FF5459F.5090201@nvidia.com> <20120705075714.GA26428@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120705075714.GA26428@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On 07/05/2012 04:57 PM, Thierry Reding wrote:
> I agree. Non-DT platforms have always used the callbacks to execute this
> kind of code. As you've said before there are situations where it isn't
> just about setting a GPIO or enabling a regulator but it also requires a
> specific timing. Representing this in the platform data would become
> tedious.

That will settle the whole issue then.

> So I think for the DT case you can parse the power-on and power-off
> sequences directly and execute code based on it, while in non-DT cases
> the init and exit callbacks should be used instead. I think it even
> makes sense to reuse the platform data's init and exit functions in the
> DT case and implement the parser/interpreter within those.

It totally makes sense indeed.

> I case where the regulator comes from a DT it should assume that it will
> become available at some point, so -EPROBE_DEFER is correct. However if
> the DT doesn't even contain the power-supply property, then EPROBE_DEFER
> will never work because there's no regulator to become available.

Indeed. And as Sascha mentionned this could easily be fixed. Guess I can 
also submit a patch for that while I am at it.

Alex.
