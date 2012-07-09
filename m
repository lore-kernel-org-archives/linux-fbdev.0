From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 09 Jul 2012 05:19:40 +0000
Subject: RE: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <00ae01cd5d92$70d1f9f0$5275edd0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120704104840.GJ24458@pengutronix.de>
 <4FF43692.2040805@nvidia.com> <20120704130056.GC30009@pengutronix.de>
 <4FF45DDF.9000306@nvidia.com> <20120704152451.GA7333@sirena.org.uk>
 <4FF4FDC0.8020405@nvidia.com> <20120705062011.GI30009@pengutronix.de>
 <4FF53368.6090805@nvidia.com> <20120705064742.GL30009@pengutronix.de>
 <4FF5459F.5090201@nvidia.com>
 <20120705075714.GA26428@avionic-0098.mockup.avionic-design.de>
 <4FF54C6C.1060700@nvidia.com> <4FF5BAEE.3020403@wwwdotorg.org>
In-Reply-To: <4FF5BAEE.3020403@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Alex Courbot' <acourbot@nvidia.com>
Cc: 'Thierry Reding' <thierry.reding@avionic-design.de>, 'Sascha Hauer' <s.hauer@pengutronix.de>, 'Stephen Warren' <swarren@wwwdotorg.org>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org



> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-owner@vger.kernel.org] On Behalf Of Stephen
> Warren
> Sent: Friday, July 06, 2012 1:04 AM
> To: Alex Courbot
> Cc: Thierry Reding; Sascha Hauer; Mark Brown; linux-tegra@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
> 
> On 07/05/2012 02:12 AM, Alex Courbot wrote:
> > On 07/05/2012 04:57 PM, Thierry Reding wrote:
> >> I agree. Non-DT platforms have always used the callbacks to execute this
> >> kind of code. As you've said before there are situations where it isn't
> >> just about setting a GPIO or enabling a regulator but it also requires a
> >> specific timing. Representing this in the platform data would become
> >> tedious.
> >
> > That will settle the whole issue then.
> >
> >> So I think for the DT case you can parse the power-on and power-off
> >> sequences directly and execute code based on it, while in non-DT cases
> >> the init and exit callbacks should be used instead. I think it even
> >> makes sense to reuse the platform data's init and exit functions in the
> >> DT case and implement the parser/interpreter within those.
> >
> > It totally makes sense indeed.
> 
> I don't agree here. It'd be best if non-DT and DT cases worked as
> similarly as possible. Relying on callbacks in one case and
> data-parsed-from-DT in the other isn't consistent with that. After all,
> in the DT case, you parse some data out of the DT and into some data
> structure. In the non-DT case, you can have that data structure passed
> in directly using platform data. Now, there's certainly a need to
> continue to support callbacks for backwards compatibility, at the very
> least temporarily before all clients are converted to the new model, but
> requiring different models rather than simply allowing it seems like a
> bad idea to me.

Hi Alex Courbot,

I couldn't agree with Stephen Warren more.
Could you support DT and non-DT case for backwards compatibility?

Best regards,
Jingoo Han

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

