From: Felipe Balbi <balbi@ti.com>
Date: Wed, 15 Oct 2014 14:37:57 +0000
Subject: Re: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing MODULE_ALIAS()
Message-Id: <20141015143757.GB10888@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KFztAG8eRSV9hGtP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <1413311335-25083-2-git-send-email-balbi@ti.com>
 <20141014183426.GA19491@saruman> <543E6C92.7090404@ti.com>
In-Reply-To: <543E6C92.7090404@ti.com>
To: linux-arm-kernel@lists.infradead.org

--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Wed, Oct 15, 2014 at 03:46:10PM +0300, Tomi Valkeinen wrote:
> On 14/10/14 21:34, Felipe Balbi wrote:
> > On Tue, Oct 14, 2014 at 01:28:54PM -0500, Felipe Balbi wrote:
> >> without MODULE_ALIAS(), omapfb won't get loaded
> >> automatically.
> >>
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >=20
> > little note here. This makes omapfb load automatically, but display
> > still doesn't work with DSS as modules. Backlight is working and pixel
> > clock is running just fine. Still, nothing on display.
> >=20
> > I thought I'd leave that for Tomi to deal with.
>=20
> I presume this is about am437x-sk. I don't have the board, so there's
> not too much I can do except send emails.
>=20
> So the panel works fine if display drivers are built-in?

yup.

> The compatible string seems to be wrong in the .dts file. It says
> "osddisplays,osd057T0559-34ts" which is not the panel used. But that
> shouldn't affect this.

I got that from Darren, IIRC. Still, if it's wrong, it's wrong. What
should it be ?

> What do you mean with "pixel clock is running"?

poking at the pixel clock with a scope, I can see it clocking.

--=20
balbi

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPobFAAoJEIaOsuA1yqRE8UQQAKYeUw0/RKg9L3w2PgsYR0Y9
tFx+QcYrPhLy3ujxV0Qm78OCAX5mesEfGY5koNn3E92Qe50RO1qD/zu75NUOdNhh
lywCWkGCpyyqQfa8hlLKsyS0pwjM+5loBGnMCBMYvLphieCG+qVCkAa+rV0eWCMu
ySyJ6HP6Vl9KxmwL6BEt/A416hlVuc8kPfbhA44aXbRUch9V8Lgd/MgH8qiVuPyb
jm7ussboLxSXeoEMGNbejCGCA6CBKlqxbBV1M3X1K17/3eTk15rva65uS2E3EIf4
YJCy7vaoso2OQKuMqXciK2b6NyoXoMGYU68f2E7H1dw4KCfgpIVtuGgsMP9BxE7t
RYu9ufyFUD8c1SCQKelJbJ6vS63fqspd3/2A6e/8FT8VD0sKn9I55vVCf2e+j0xz
SHEnt3LgZJU+JZCLbUvub4wsYB+WSSCph+06lsksdTfhhO/Ibv4glo/jdNbc0e6Q
PNYiiX1Uqke8h1X/6376X8K85UTMCRwwUQHp8QKxCBT8wAK1/Z0sBbVznjnnTSst
fZqWIJZ+lAdtmEy9awxBidtPW2pPs2Oz934X6ti6xv+r8btbpPZ7LAogFYIbLFD8
ib7dWNQ2NYY1Vj5n5Z80m0czVb6EGclaJwdvR5iMMlRoRf7IcAHEOMYLMypDIYP7
PNJGMQs8Jix6kF4mGLnI
=6kxA
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
