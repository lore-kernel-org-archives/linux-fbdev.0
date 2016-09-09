From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 09 Sep 2016 14:34:13 +0000
Subject: Re: [PATCH 3/6] drm/panel: simple: Add A10 EVB 5 inch panel support
Message-Id: <20160909143413.GA8881@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
 <20160831081817.5191-4-maxime.ripard@free-electrons.com>
 <CAGb2v66GsA8uNaaZfnnHFgBLA-LChCnO3vLhdtfzHNU0nHXH4Q@mail.gmail.com>
In-Reply-To: <CAGb2v66GsA8uNaaZfnnHFgBLA-LChCnO3vLhdtfzHNU0nHXH4Q@mail.gmail.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Alexander Kaplan <alex@nextthing.co>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 05, 2016 at 10:00:01PM +0800, Chen-Yu Tsai wrote:
> On Wed, Aug 31, 2016 at 4:18 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The A10-EVB from Allwinner comes with an unidentified panel, with the o=
nly
> > mark on the PCB being A10-SUB-EVB-5LCD.
> >
> > Add timings to simple panel to handle it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/pan=
el/panel-simple.c
> > index 85143d1b9b31..be371b053aab 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -386,6 +386,29 @@ static void panel_simple_shutdown(struct device *d=
ev)
> >         panel_simple_disable(&panel->base);
> >  }
> >
> > +static const struct drm_display_mode allwinner_a10_sub_evb_5lcd_mode =
=3D {
> > +       .clock =3D 33000,
> > +       .hdisplay =3D 800,
> > +       .hsync_start =3D 800 + 209,
> > +       .hsync_end =3D 800 + 209 + 1,
> > +       .htotal =3D 800 + 209 + 1 + 45,
> > +       .vdisplay =3D 480,
> > +       .vsync_start =3D 480 + 22,
> > +       .vsync_end =3D 480 + 22 + 1,
> > +       .vtotal =3D 480 + 22 + 1 + 22,
> > +       .vrefresh =3D 60,
>=20
> I assume the numbers came from the fex file? Allwinner LCD timing numbers
> aren't very precise. This seems to yield a refresh rate of 58.x Hz.
> The dot clock can go below MHz resolution, so it should be possible
> to set it to a more proper clock rate here.

Indeed.

Upon closer inspection, it seems (from the ribbon) that the display is
an hannstar, but there's no screen reference anywhere.

By looking into it using the available references, the date of
production found on that panel, and so on, it seems like it is an
HSD050IDW1-A, whose timings do not seem to far off. But it's pure
speculation at this point.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0shlAAoJEBx+YmzsjxAgi0MQAL+SGuCP/Ez+Bv8DhjHxciA5
7hY1NGYv6/5Ecv2XA5rRuPSDJC8EExt3YmUSmZe/ebgfpyhApbAL7VIsXnTyZuPg
nymd1+/BniM5Y5C+paAfCXRSbYdPOTpFkiHBVBehUmo+Zqn7ITqXbDLrWLrKABjD
c40qtxMCiZ1Apnj31HpaBl9XmcvpPc1QEcNT3DguCZA8Dl3Mq0UVhpmSl+eIhNPQ
1qnT9YTwg3el7pxqidUxYXNhr2HdOFuj3g+2/RWVTrCzUc0eh03An5SA3iiDXZnm
VEqfXfpa2C6OQd3hYrHupCzbKtLu/7Xcmi7dsFzs7IP7xh2/OA8j59+rccCyt0wI
bPKDdQ5f4mzDDDJX/pQvchcjs6qK8Pbvq75BPN4KIpu2X2OFD/xaSsc9RemKvJhB
55s2ycAAvvrIC/R9GNCZxaJQlnnmKjl/jtEvAPpv9glFUzo0D9Vw0cfom8Cet6/0
3wf/dyUA/xmTlOV7tQ6daEKchEunHcroP0rWq8qvWU4FunIooUMdnE0/aZbhGDwg
VNSQ6BHBmU76YchVWKG32M46uBaVCLVvLtb/FnnqboKKWJCwVnWi5p6pzmOyvfaV
vFSpWwDXIulc9dScsZKjvHydAEsRD04Z3pQCT0+O0n23gMk+uRm/y+qVprVWWxqT
tHobgud5s6Fgsy0pNAJH
=wPyb
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
