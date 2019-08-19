From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 19 Aug 2019 10:21:27 +0000
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through sysfs
Message-Id: <20190819102127.wqudnbngottjakf5@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de>
 <20190816175157.GT250418@google.com>
 <20190816194754.ldzjqy2yjonfvaat@pengutronix.de>
 <20190816211051.GV250418@google.com>
 <20190819054628.asw3cxp46w3rpml7@pengutronix.de>
 <20190819095037.h3gig3quyhnzshm7@holly.lan>
In-Reply-To: <20190819095037.h3gig3quyhnzshm7@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, kernel@pengutronix.de, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

Hello Daniel,

On Mon, Aug 19, 2019 at 10:50:37AM +0100, Daniel Thompson wrote:
> On Mon, Aug 19, 2019 at 07:46:28AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Matthias,
> >=20
> > On Fri, Aug 16, 2019 at 02:10:51PM -0700, Matthias Kaehlcke wrote:
> > > On Fri, Aug 16, 2019 at 09:47:54PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Fri, Aug 16, 2019 at 10:51:57AM -0700, Matthias Kaehlcke wrote:
> > > > > Hi Uwe,
> > > > >=20
> > > > > On Fri, Aug 16, 2019 at 06:51:48PM +0200, Uwe Kleine-K=F6nig wrot=
e:
> > > > > > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wro=
te:
> > > > > > > Backlight brightness curves can have different shapes. The tw=
o main
> > > > > > > types are linear and non-linear curves. The human eye doesn't
> > > > > > > perceive linearly increasing/decreasing brightness as linear =
(see
> > > > > > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of L=
ED
> > > > > > > linearly to human eye"), hence many backlights use non-linear=
 (often
> > > > > > > logarithmic) brightness curves. The type of curve currently i=
s opaque
> > > > > > > to userspace, so userspace often uses more or less reliable h=
euristics
> > > > > > > (like the number of brightness levels) to decide whether to t=
reat a
> > > > > > > backlight device as linear or non-linear.
> > > > > > >=20
> > > > > > > Export the type of the brightness curve via the new sysfs att=
ribute
> > > > > > > 'scale'. The value of the attribute can be 'linear', 'non-lin=
ear' or
> > > > > > > 'unknown'. For devices that don't provide information about t=
he scale
> > > > > > > of their brightness curve the value of the 'scale' attribute =
is 'unknown'.
> > > > > > >=20
> > > > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > >=20
> > > > > > I wonder what kind of problem you are solving here. Can you des=
cribe
> > > > > > that in a few words?
> > > > >=20
> > > > > The human eye perceives brightness in a logarithmic manner. For
> > > > > backlights with a linear brightness curve brightness controls like
> > > > > sliders need to use a mapping to achieve a behavior that is perce=
ived
> > > > > as linear-ish (more details: http://www.pathwaylighting.com/produ=
cts/downloads/brochure/technical_materials_1466797044_Linear+vs+Logarithmic=
+Dimming+White+Paper.pdf)
> > > > >=20
> > > > > As of now userspace doesn't have information about the type of the
> > > > > brightness curve, and often uses heuristics to make a guess, whic=
h may
> > > > > be right most of the time, but not always. The new attribute elim=
inates
> > > > > the need to guess.
> > > >=20
> > > > This is about backlights right? So the kernel provides to userspace=
 an
> > > > interval [0, x] for some x and depending on the physics of the the
> > > > backlight configuring x/2 (probably?) either means 50% measured lig=
ht or
> > > > 50% perceived light, right?
> > >=20
> > > correct
> > >=20
> > > > I wonder if it would be possible instead of giving different backli=
ght
> > > > implementations the freedom to use either linear or logarithmic (or
> > > > quadratic?) scaling and tell userspace which of the options were pi=
cked
> > > > require the drivers to provide a (say) linear scaling and then user=
space
> > > > wouldn't need to care about the exact physics.
> > >=20
> > > In an ideal world the backlight interface would be consistent as you
> > > suggest, however there are plenty of existing devices which use the
> > > 'other' scaling (regardless of which is chosen as the 'correct'
> > > one). Userspace still has to deal with these. And changing previously
> > > 'logarithmic' drivers to linear (or viceversa) may 'break' userspace,
> > > when it keeps using its 'old' scaling, which now isn't correct anymor=
e.
> >=20
> > It might be subjective, or maybe I'm just too optimistic, but I think if
> > there was no policy before about the meaning of
> >=20
> > 	echo 17 > brightness
> >=20
> > other than "brighter than lower values and darker than higher ones"
> > introducing (say) the scale is intended to represent a linear brightness
> > curve is ok.
> >=20
> > Unless userspace jumps through hoops and tries to identify the actual
> > device it is running on it is wrong on some machines anyhow and we're
> > only shifting the set of affected machines with a tighter policy (until
> > that userspace application is fixed).
>=20
> I believe that there are two common approaches by userspace at present:
>=20
> 1. Assume the scale is perceptual and we can directly map a slider
>    to the backlight value. This is common simply because most ACPI
>    backlights are perceptual and therefore when tested in a laptop
>    it works OK.
>=20
> 2. Assume that is max brightness is small (e.g. ACPI) then the
>    scale is perceptual and if the max brightness is large (e.g.
>    a PWM) then the scale is linear and apply a correction
>    function between the slider and the control.
>=20
> That historic baggage makes is diffcult to "just define a standardized
> scale"... especially given that if we selected a standardized scale we
> would probably want a perceptual scale with lots of steps (e.g. break
> the heuristic).

With "perceptual" you mean that logarithmic stuff, right?

I would tend to go for linear because this is easily measureable and
also is straight forward to implement in the usual cases (attention: I
assume that "usual" means something like PWM and I don't know much about
the physics of backlights but just assume that a PWM will create a
linear mapping).

> > And the big upside is that in the end (i.e. when all kernel drivers and
> > userspace applications are adapted to provide/consume the "correct"
> > curve) the result is simpler.
>=20
> My view is that this convergence will eventually be achieved but it will
> happen through the obsolescence of the backlight sysfs interface. The
> sysfs interface has other flaws, in particular no integration with the
> DRM connector API.
>=20
> Thus I would expect an alternative interface to emerge, most likely as
> part of the DRM connector API. I'd expect such a new API to a
> perceptual scale and to have a fixed max brightness with enough
> steps to support animated backlight effects (IIRC 0..100 has been
> proposed in the past)=20

Then work on the new stuff instead of making the old stuff (that is
intended to die) harder to use correctly?

> In the mean time getting the existing collection of backlight drivers
> marked up as linear/logarithmic/etc will ease the introduction of that
> API because, within the kernel, we might have gathered enough knowledge
> to have some hope of correctly mapping each backlight onto a
> standardized scale.

It would be enough to do this in a code comment then. That would come
without the need to adapt the old userspace API. Also when the old
solution works at 95% instead of 90% before, it will resist harder to
dying.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
