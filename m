From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 20 Aug 2019 14:49:21 +0000
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through sysfs
Message-Id: <CAKMK7uEJptKgoAwTO+OuN0HrBiMMG21w0QAdgD=pHBLoKLi38Q@mail.gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

On Mon, Aug 19, 2019 at 11:50 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Aug 19, 2019 at 07:46:28AM +0200, Uwe Kleine-König wrote:
> > Hello Matthias,
> >
> > On Fri, Aug 16, 2019 at 02:10:51PM -0700, Matthias Kaehlcke wrote:
> > > On Fri, Aug 16, 2019 at 09:47:54PM +0200, Uwe Kleine-König wrote:
> > > > On Fri, Aug 16, 2019 at 10:51:57AM -0700, Matthias Kaehlcke wrote:
> > > > > Hi Uwe,
> > > > >
> > > > > On Fri, Aug 16, 2019 at 06:51:48PM +0200, Uwe Kleine-König wrote:
> > > > > > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
> > > > > > > Backlight brightness curves can have different shapes. The two main
> > > > > > > types are linear and non-linear curves. The human eye doesn't
> > > > > > > perceive linearly increasing/decreasing brightness as linear (see
> > > > > > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > > > > > linearly to human eye"), hence many backlights use non-linear (often
> > > > > > > logarithmic) brightness curves. The type of curve currently is opaque
> > > > > > > to userspace, so userspace often uses more or less reliable heuristics
> > > > > > > (like the number of brightness levels) to decide whether to treat a
> > > > > > > backlight device as linear or non-linear.
> > > > > > >
> > > > > > > Export the type of the brightness curve via the new sysfs attribute
> > > > > > > 'scale'. The value of the attribute can be 'linear', 'non-linear' or
> > > > > > > 'unknown'. For devices that don't provide information about the scale
> > > > > > > of their brightness curve the value of the 'scale' attribute is 'unknown'.
> > > > > > >
> > > > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > >
> > > > > > I wonder what kind of problem you are solving here. Can you describe
> > > > > > that in a few words?
> > > > >
> > > > > The human eye perceives brightness in a logarithmic manner. For
> > > > > backlights with a linear brightness curve brightness controls like
> > > > > sliders need to use a mapping to achieve a behavior that is perceived
> > > > > as linear-ish (more details: http://www.pathwaylighting.com/products/downloads/brochure/technical_materials_1466797044_Linear+vs+Logarithmic+Dimming+White+Paper.pdf)
> > > > >
> > > > > As of now userspace doesn't have information about the type of the
> > > > > brightness curve, and often uses heuristics to make a guess, which may
> > > > > be right most of the time, but not always. The new attribute eliminates
> > > > > the need to guess.
> > > >
> > > > This is about backlights right? So the kernel provides to userspace an
> > > > interval [0, x] for some x and depending on the physics of the the
> > > > backlight configuring x/2 (probably?) either means 50% measured light or
> > > > 50% perceived light, right?
> > >
> > > correct
> > >
> > > > I wonder if it would be possible instead of giving different backlight
> > > > implementations the freedom to use either linear or logarithmic (or
> > > > quadratic?) scaling and tell userspace which of the options were picked
> > > > require the drivers to provide a (say) linear scaling and then userspace
> > > > wouldn't need to care about the exact physics.
> > >
> > > In an ideal world the backlight interface would be consistent as you
> > > suggest, however there are plenty of existing devices which use the
> > > 'other' scaling (regardless of which is chosen as the 'correct'
> > > one). Userspace still has to deal with these. And changing previously
> > > 'logarithmic' drivers to linear (or viceversa) may 'break' userspace,
> > > when it keeps using its 'old' scaling, which now isn't correct anymore.
> >
> > It might be subjective, or maybe I'm just too optimistic, but I think if
> > there was no policy before about the meaning of
> >
> >       echo 17 > brightness
> >
> > other than "brighter than lower values and darker than higher ones"
> > introducing (say) the scale is intended to represent a linear brightness
> > curve is ok.
> >
> > Unless userspace jumps through hoops and tries to identify the actual
> > device it is running on it is wrong on some machines anyhow and we're
> > only shifting the set of affected machines with a tighter policy (until
> > that userspace application is fixed).
>
> I believe that there are two common approaches by userspace at present:
>
> 1. Assume the scale is perceptual and we can directly map a slider
>    to the backlight value. This is common simply because most ACPI
>    backlights are perceptual and therefore when tested in a laptop
>    it works OK.
>
> 2. Assume that is max brightness is small (e.g. ACPI) then the
>    scale is perceptual and if the max brightness is large (e.g.
>    a PWM) then the scale is linear and apply a correction
>    function between the slider and the control.
>
> That historic baggage makes is diffcult to "just define a standardized
> scale"... especially given that if we selected a standardized scale we
> would probably want a perceptual scale with lots of steps (e.g. break
> the heuristic).
>
>
> > And the big upside is that in the end (i.e. when all kernel drivers and
> > userspace applications are adapted to provide/consume the "correct"
> > curve) the result is simpler.
>
> My view is that this convergence will eventually be achieved but it will
> happen through the obsolescence of the backlight sysfs interface. The
> sysfs interface has other flaws, in particular no integration with the
> DRM connector API.
>
> Thus I would expect an alternative interface to emerge, most likely as
> part of the DRM connector API. I'd expect such a new API to a
> perceptual scale and to have a fixed max brightness with enough
> steps to support animated backlight effects (IIRC 0..100 has been
> proposed in the past)
>
> In the mean time getting the existing collection of backlight drivers
> marked up as linear/logarithmic/etc will ease the introduction of that
> API because, within the kernel, we might have gathered enough knowledge
> to have some hope of correctly mapping each backlight onto a
> standardized scale.

In case people wonder why the drm connector based backlight interface
hasn't happened ages ago, some more context:

- userspace (well libbacklight) selects the right backlight, using
some priority search. Plus blacklists in drivers to make sure they're
not overriding the real backlight driver (e.g. acpi has higher
priority in libbacklight, but on modern system it's not the backlight
driver you want. If we move that into the kernel it's going to be
somewhat a mess, since defacto you never know when loading is complete
and you actually have the right backlight driver.

This isn't a problem on DT platforms, but really just for x86/acpi
platforms. But if we don't fix them, then userspace adoption of these
new interfaces will likely be too low to matter.

- second issue is that right now the kms client is supposed to handle
backlight around modeset, like fbdev does through the fb notifier.
Except for drivers which do handle the backlight across modesets, but
maybe not the right backlight. If we move the backlight interface to
drm connectors then the right thing would be for the drm driver to
handle backlight enable/disable across modesets. But to make that
work, userspace needs to stop touching it (otherwise userspace first
disables, then the kernel and then on restore the two fight and
usually black screen wins), and that's a bit a tricky uapi problem of
not breaking existing userspace.

- finally there's some userspace which assumes the lowest backlight
setting is actually off, and uses that to do fast modesets. This
doesn't work on most ACPI backlights, so I think that problem isn't
widespread.

Anyway from watching from afar, I think this clarification on what the
backlight scale means internally should at least help us somewhat in
the long term. But the long term solution itself needs someone with
way too much time I fear, so lets not hold up anything on that.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
