From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 24 Apr 2019 18:55:08 +0000
Subject: Re: [PATCH v6 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <20190424185507.GB31600@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="s/l3CgOIzMHHjg/5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190424092505.6578-1-masneyb@onstation.org>
 <20190424092505.6578-3-masneyb@onstation.org>
 <20190424142037.GA20237@amd>
 <CAL_JsqJSpmG_TfNaxHKQMzVn0ig=HaBupQ22bbPAa9riuCU71Q@mail.gmail.com>
In-Reply-To: <CAL_JsqJSpmG_TfNaxHKQMzVn0ig=HaBupQ22bbPAa9riuCU71Q@mail.gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Brian Masney <masneyb@onstation.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>, Jonathan Marek <jonathan@marek.ca>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-24 10:57:50, Rob Herring wrote:
> On Wed, Apr 24, 2019 at 9:20 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backli=
ght.yaml
> > > @@ -0,0 +1,129 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/leds/backlight/lm3630a-backlight.=
yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >
> > I'm not a great fan on links to external websites. But this is comment
> > for Rob.
>=20
> This is simply how json-schema works. $schema says what meta-schema
> this file should validate against so it's versioned if we change the
> schema format. $id is just a unique identifier and is used to resolve
> $ref values. Note that these aren't live urls either (but could be at
> some point in the future).

Umm. Interesting design :-).

> > > +title: TI LM3630A High-Efficiency Dual-String White LED
> > > +
> > > +maintainers:
> > > +  - Lee Jones <lee.jones@linaro.org>
> > > +  - Daniel Thompson <daniel.thompson@linaro.org>
> > > +  - Jingoo Han <jingoohan1@gmail.com>
> >
> > Not a great fan of duplicating MAINTAINERS information here. But this
> > is a comment for Rob, again.
>=20
> Hopefully this is temporary until we move to per directory MAINTAINERS
> files. Not sure what happened with that.

Aha, ok.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAsQsACgkQMOfwapXb+vJp8ACdGjX/IOssab2MF8x50hnYcR2/
UrUAmgLyGXFRXLfDZyMk4DjDnq+tnC5a
=JBX0
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
