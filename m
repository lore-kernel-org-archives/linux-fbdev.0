From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 21 Aug 2019 14:16:17 +0000
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through sysfs
Message-Id: <20190821141617.e5avfbyvooddixcd@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de>
 <20190816175157.GT250418@google.com>
 <20190816194754.ldzjqy2yjonfvaat@pengutronix.de>
 <20190816211051.GV250418@google.com>
 <20190819054628.asw3cxp46w3rpml7@pengutronix.de>
 <20190819095037.h3gig3quyhnzshm7@holly.lan>
 <CAKMK7uEJptKgoAwTO+OuN0HrBiMMG21w0QAdgD=pHBLoKLi38Q@mail.gmail.com>
In-Reply-To: <CAKMK7uEJptKgoAwTO+OuN0HrBiMMG21w0QAdgD=pHBLoKLi38Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

On Tue, Aug 20, 2019 at 04:49:21PM +0200, Daniel Vetter wrote:
> On Mon, Aug 19, 2019 at 11:50 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On Mon, Aug 19, 2019 at 07:46:28AM +0200, Uwe Kleine-K=F6nig wrote:
> > > And the big upside is that in the end (i.e. when all kernel drivers a=
nd
> > > userspace applications are adapted to provide/consume the "correct"
> > > curve) the result is simpler.
> >
> > My view is that this convergence will eventually be achieved but it will
> > happen through the obsolescence of the backlight sysfs interface. The
> > sysfs interface has other flaws, in particular no integration with the
> > DRM connector API.
> >
> > Thus I would expect an alternative interface to emerge, most likely as
> > part of the DRM connector API. I'd expect such a new API to a
> > perceptual scale and to have a fixed max brightness with enough
> > steps to support animated backlight effects (IIRC 0..100 has been
> > proposed in the past)
> >
> > In the mean time getting the existing collection of backlight drivers
> > marked up as linear/logarithmic/etc will ease the introduction of that
> > API because, within the kernel, we might have gathered enough knowledge
> > to have some hope of correctly mapping each backlight onto a
> > standardized scale.
>=20
> In case people wonder why the drm connector based backlight interface
> hasn't happened ages ago, some more context:
>=20
> - userspace (well libbacklight) selects the right backlight, using
> some priority search. Plus blacklists in drivers to make sure they're
> not overriding the real backlight driver (e.g. acpi has higher
> priority in libbacklight, but on modern system it's not the backlight
> driver you want. If we move that into the kernel it's going to be
> somewhat a mess, since defacto you never know when loading is complete
> and you actually have the right backlight driver.
>=20
> This isn't a problem on DT platforms, but really just for x86/acpi
> platforms. But if we don't fix them, then userspace adoption of these
> new interfaces will likely be too low to matter.
>=20
> - second issue is that right now the kms client is supposed to handle
> backlight around modeset, like fbdev does through the fb notifier.
> Except for drivers which do handle the backlight across modesets, but
> maybe not the right backlight. If we move the backlight interface to
> drm connectors then the right thing would be for the drm driver to
> handle backlight enable/disable across modesets. But to make that
> work, userspace needs to stop touching it (otherwise userspace first
> disables, then the kernel and then on restore the two fight and
> usually black screen wins), and that's a bit a tricky uapi problem of
> not breaking existing userspace.
>=20
> - finally there's some userspace which assumes the lowest backlight
> setting is actually off, and uses that to do fast modesets. This
> doesn't work on most ACPI backlights, so I think that problem isn't
> widespread.
>=20
> Anyway from watching from afar, I think this clarification on what the
> backlight scale means internally should at least help us somewhat in
> the long term. But the long term solution itself needs someone with
> way too much time I fear, so lets not hold up anything on that.

Thanks for sharing your views on this.


Daniel.
