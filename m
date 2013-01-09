From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 09 Jan 2013 20:37:05 +0000
Subject: Re: [PATCHv16 0/7] of: add display helper
Message-Id: <20130109203705.GA12241@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355850256-16135-1-git-send-email-s.trumtrar@pengutronix.de>
 <20130109201541.GB4780@pengutronix.de>
In-Reply-To: <20130109201541.GB4780-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2013 at 09:15:41PM +0100, Steffen Trumtrar wrote:
> On Tue, Dec 18, 2012 at 06:04:09PM +0100, Steffen Trumtrar wrote:
> > Hi!
> >=20
> > Finally, right in time before the end of the world on friday, v16 of the
> > display helpers.
> >=20
>=20
> So, any more criticism on the series? Any takers for the series as is?
> I guess it could be merged via the fbdev-tree if David Airlie can agree
> to the DRM patches ?! Does that sound about right?
>=20
> I think the series was tested at least with
> 	- imx6q: sabrelite, sabresd
> 	- imx53: tqma53/mba53
> 	- omap: DA850 EVM, AM335x EVM, EVM-SK
>=20
> I don't know what Laurent Pinchart, Marek Vasut and Leela Krishna Amudala
> are using. Those are the people I know from the top of my head, that use
> or at least did use the patches in one of its iterations. If I forgot
> anyone, please speak up and possibly add your new HW to the list of tested
> devices.

I tested earlier versions on Tegra. The latest one was v15 I think.

Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ7dTxAAoJEN0jrNd/PrOh5lQQAI8l7hnwRQDo8iK0z/dLI5O7
yKKZX3m4zB1AQhusMQmBNIrRpVjOHwmrf7O6nDdIzCK+Rx8jirT//n11JpxZt3ys
2YhNddAE+tMjUq/T/Bnud+WJFX/5sXk/KNZUXP9V6KqUHV0AJUCZAgkR9Q1XBAhU
UuwC4x3d/FTv1ITXqUxoJQZ6M1sPKKJP3saDaufeYVunuy5JrUiNxQZkxw5PcyAk
SdVi8dkTYzt/MPFWgwJ9afQ3zlxT0+Tk9oX/7unEs+91SuA8NjgCXPKgtgIn46+V
sEDdd0W0iAR/Fc7+mxBVubRxhMTx1Qz65XJXxeeIjOzyRwMlYV8Ze1zTXPV1jfZz
gIdWKbMbtMAPUq1g0GM1xyR543CRwN5uF4HbcNoM5ERD83r1Qk2oECNN+58p7Vsg
qTA+4kk4cSd9h0ADLFD0LRS34EFFqtoWPbo8SknZXcgjm2T9JlGrd3pSWpaN3NnU
tuOjeze+krqt+nf8NHtJXBepB9WTo8YkNRvCA8tSmn2ONpGBhqoS3rX7rW3NXL20
vS6RUf+HRxtsRhTFeC1OrYnB1jA7EhlxLU4GLqsNFUopgkrMn1olbM8d2hj4/wal
N11OQfe3ACXHm9mpRP0o3jK+3w3Ozg5EAMsGGk+z9YEywYzIBScowa28MYdmCbF2
0ajONkatxHNnwBjpVuw5
=r8SB
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
