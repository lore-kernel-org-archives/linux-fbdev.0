From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Fri, 16 Aug 2019 19:47:54 +0000
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through sysfs
Message-Id: <20190816194754.ldzjqy2yjonfvaat@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de>
 <20190816175157.GT250418@google.com>
In-Reply-To: <20190816175157.GT250418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

On Fri, Aug 16, 2019 at 10:51:57AM -0700, Matthias Kaehlcke wrote:
> Hi Uwe,
>=20
> On Fri, Aug 16, 2019 at 06:51:48PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> > > Backlight brightness curves can have different shapes. The two main
> > > types are linear and non-linear curves. The human eye doesn't
> > > perceive linearly increasing/decreasing brightness as linear (see
> > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > linearly to human eye"), hence many backlights use non-linear (often
> > > logarithmic) brightness curves. The type of curve currently is opaque
> > > to userspace, so userspace often uses more or less reliable heuristics
> > > (like the number of brightness levels) to decide whether to treat a
> > > backlight device as linear or non-linear.
> > >=20
> > > Export the type of the brightness curve via the new sysfs attribute
> > > 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> > > 'unknown'. For devices that don't provide information about the scale
> > > of their brightness curve the value of the 'scale' attribute is 'unkn=
own'.
> > >=20
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >=20
> > I wonder what kind of problem you are solving here. Can you describe
> > that in a few words?
>=20
> The human eye perceives brightness in a logarithmic manner. For
> backlights with a linear brightness curve brightness controls like
> sliders need to use a mapping to achieve a behavior that is perceived
> as linear-ish (more details: http://www.pathwaylighting.com/products/down=
loads/brochure/technical_materials_1466797044_Linear+vs+Logarithmic+Dimming=
+White+Paper.pdf)
>=20
> As of now userspace doesn't have information about the type of the
> brightness curve, and often uses heuristics to make a guess, which may
> be right most of the time, but not always. The new attribute eliminates
> the need to guess.

This is about backlights right? So the kernel provides to userspace an
interval [0, x] for some x and depending on the physics of the the
backlight configuring x/2 (probably?) either means 50% measured light or
50% perceived light, right?

I wonder if it would be possible instead of giving different backlight
implementations the freedom to use either linear or logarithmic (or
quadratic?) scaling and tell userspace which of the options were picked
require the drivers to provide a (say) linear scaling and then userspace
wouldn't need to care about the exact physics.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
