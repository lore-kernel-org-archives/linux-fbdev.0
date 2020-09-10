From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 10 Sep 2020 07:47:56 +0000
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during interpolation
Message-Id: <20200910074756.GE438822@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
 <20200904113822.xoyt4w5x7vwvh7cr@holly.lan>
 <20200907075018.GM2352366@phenom.ffwll.local>
 <20200909144537.daq2exfihhxm6bai@holly.lan>
 <CAKMK7uEK5afDHT9n0s+eDYA1Qztf9Xxibz_rZDzy5F6G9EOEVw@mail.gmail.com>
In-Reply-To: <CAKMK7uEK5afDHT9n0s+eDYA1Qztf9Xxibz_rZDzy5F6G9EOEVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Alexandru Stan <amstan@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Douglas Anderson <dianders@chromium.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>, Matthias Kaehlcke <mka@chromium.org>

On Wed, Sep 09, 2020 at 05:03:37PM +0200, Daniel Vetter wrote:
> On Wed, Sep 9, 2020 at 4:45 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Mon, Sep 07, 2020 at 09:50:18AM +0200, Daniel Vetter wrote:
> > > On Fri, Sep 04, 2020 at 12:38:22PM +0100, Daniel Thompson wrote:
> > > > On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> > > > > Some displays need the low end of the curve cropped in order to m=
ake
> > > > > them happy. In that case we still want to have the 0% point, even=
 though
> > > > > anything between 0% and 5%(example) would be skipped.
> > > >
> > > > For backlights it is not defined that 0 means off and, to be honest=
, 0
> > > > means off is actually rather weird for anything except transflexive
> > > > or front lit reflective displays[1]. There is a problem on several
> > > > systems that when the backlight slider is reduced to zero you can't
> > > > see the screen properly to turn it back up. This patch looks like it
> > > > would make that problem worse by hurting systems with will written
> > > > device trees.
> > > >
> > > > There is some nasty legacy here: some backlight displays that are o=
ff
> > > > at zero and that sucks because userspace doesn't know whether zero =
is
> > > > off or lowest possible setting.
> > > >
> > > > Nevertheless perhaps a better way to handle this case is for 0 to m=
ap to
> > > > 5% power and for the userspace to turn the backlight on/off as final
> > > > step in an animated backlight fade out (and one again for a fade in=
).
> > >
> > > Afaik chromeos encodes "0 means off" somewhere in there stack. We've
> > > gotten similar patches for the i915 backlight driver when we started
> > > obeying the panel's lower limit in our pwm backlight driver thing tha=
t's
> > > sometimes used instead of acpi.
> >
> > Out of interest... were they accepted?
> >
> > I did took a quick look at intel_panel.c and didn't see anything
> > that appeared to be special casing zero but I thought I might double
> > check.
>=20
> I don't think so. Just figured I bring this up since it might explain
> why this is coming back again from an @chromium.com address.

Thanks to Alexandru pointing at the right code it's clear this got fix,
over 5 years ago:

https://source.chromium.org/chromiumos/_/chromium/chromiumos/platform2/+/6e=
83a6a8bb772ed8a2f939da1c7a152147c12789

	power: Write to bl_power when backlight reaches or leaves 0.
=09
	Make InternalBacklight write FB_BLANK_UNBLANK to bl_power
	just before setting the internal backlight brightness to a
	nonzero value, and FB_BLANK_POWERDOWN to bl_power just
	before setting the brightness to 0.
=09
	This is needed for hardware that interprets a brightness
	level of 0 as meaning "dim" rather than "off".
=09
	BUG=3Dchromium:396218
	TEST=ADded unit tests
=09
	Change-Id: I914e333ab41db623564d5a67beac89f1a62bce9d
	Reviewed-on: https://chromium-review.googlesource.com/311010
	Commit-Ready: Dan Erat <derat@chromium.org>
	Tested-by: Dan Erat <derat@chromium.org>
	Reviewed-by: Dan Erat <derat@chromium.org>

Cheers, Daniel

> > > There's also the problem that with fancy panels with protocol (dsi, e=
dp,
> > > ...) shutting of the backlight completely out of the proper power seq=
uence
> > > hangs the panel (for some panels at least), so providing a backlight =
off
> > > that doesn't go through the drm modeset sequence isn't always possibl=
e.
> > >
> > > It's a bit a mess indeed :-/
> > > -Daniel
> > >
> > > >
> > > >
> > > > Daniel.
> > > >
> > > > >
> > > > > Signed-off-by: Alexandru Stan <amstan@chromium.org>
> > > > > ---
> > > > >
> > > > >  drivers/video/backlight/pwm_bl.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/bac=
klight/pwm_bl.c
> > > > > index 5193a72305a2..b24711ddf504 100644
> > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > @@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct dev=
ice *dev,
> > > > >                   /* Fill in the last point, since no line starts=
 here. */
> > > > >                   table[x2] =3D y2;
> > > > >
> > > > > +                 /*
> > > > > +                  * If we don't start at 0 yet we're increasing,=
 assume
> > > > > +                  * the dts wanted to crop the low end of the ra=
nge, so
> > > > > +                  * insert a 0 to provide a display off mode.
> > > > > +                  */
> > > > > +                 if (table[0] > 0 && table[0] < table[num_levels=
 - 1])
> > > > > +                         table[0] =3D 0;
> > > > > +
> > > > >                   /*
> > > > >                    * As we use interpolation lets remove current
> > > > >                    * brightness levels table and replace for the
> > > > > --
> > > > > 2.27.0
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20
>=20
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
