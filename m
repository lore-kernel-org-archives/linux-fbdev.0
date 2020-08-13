From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 13 Aug 2020 13:45:53 +0000
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during interpolation
Message-Id: <20200813134553.2hykfvqjtgr4e2pl@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
 <20200807082113.GI6419@phenom.ffwll.local>
In-Reply-To: <20200807082113.GI6419@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandru Stan <amstan@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>

On Fri, Aug 07, 2020 at 10:21:13AM +0200, daniel@ffwll.ch wrote:
> On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> > Some displays need the low end of the curve cropped in order to make
> > them happy. In that case we still want to have the 0% point, even though
> > anything between 0% and 5%(example) would be skipped.
> > 
> > Signed-off-by: Alexandru Stan <amstan@chromium.org>
> > ---
> > 
> >  drivers/video/backlight/pwm_bl.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index 5193a72305a2..b24711ddf504 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
> >  			/* Fill in the last point, since no line starts here. */
> >  			table[x2] = y2;
> >  
> > +			/*
> > +			 * If we don't start at 0 yet we're increasing, assume
> > +			 * the dts wanted to crop the low end of the range, so
> > +			 * insert a 0 to provide a display off mode.
> > +			 */
> > +			if (table[0] > 0 && table[0] < table[num_levels - 1])
> > +				table[0] = 0;
> 
> Isn't that what the enable/disable switch in backlights are for? There's
> lots of backligh drivers (mostly the firmware variety) where setting the
> backlight to 0 does not shut it off, it's just the lowest setting.
> 
> But I've not been involved in the details of these discussions.

It's been a long standing complaint that the backlight drivers are not
consistent w.r.t. whether 0 means off or lowest. The most commonly used
backlights (ACPI in particular) do not adopt 0 means off but lots of
specific drivers do.

IMHO what is "right" depends on the display technology. For displays
that are essentially black when the backlight is off and become
difficult or impossible to read I'm a little dubious about standardizing
on zero means off. There are situations when zero means off
does make sense however. For example front-lit or transflexive displays
are readable when the "backlight" is off and on these displays it would
make sense.


Daniel.
