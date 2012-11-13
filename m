From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Tue, 13 Nov 2012 17:51:47 +0000
Subject: Re: [PATCH v8 2/6] video: add of helper for videomode
Message-Id: <20121113175147.GA2597@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352734626-27412-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352734626-27412-3-git-send-email-s.trumtrar@pengutronix.de>
 <20121113110837.GA30049@avionic-0098.mockup.avionic-design.de>
 <50A2878D.8020707@wwwdotorg.org>
In-Reply-To: <50A2878D.8020707-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2012 at 10:46:53AM -0700, Stephen Warren wrote:
> On 11/13/2012 04:08 AM, Thierry Reding wrote:
> > On Mon, Nov 12, 2012 at 04:37:02PM +0100, Steffen Trumtrar wrote:
> >> This adds support for reading display timings from DT or/and
> >> convert one of those timings to a videomode. The
> >> of_display_timing implementation supports multiple children where
> >> each property can have up to 3 values. All children are read into
> >> an array, that can be queried. of_get_videomode converts exactly
> >> one of that timings to a struct videomode.
>=20
> >> diff --git
> >> a/Documentation/devicetree/bindings/video/display-timings.txt
> >> b/Documentation/devicetree/bindings/video/display-timings.txt
>=20
> >> + - clock-frequency: displayclock in Hz
> >=20
> > "display clock"?
>=20
> I /think/ I had suggested naming this clock-frequency before so that
> the property name would be more standardized; other bindings use that
> same name. But I'm not too attached to the name I guess.

That's not what I meant. I think "displayclock" should be two words in
the description of the property. The property name is fine.

Thierry

--DocE+STaALJfprDB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQooizAAoJEN0jrNd/PrOhNKcP/1C+UHx+FDdiMbn1jonWqRmZ
Dk0byTBdCR4iGN3OAAwcPppuRnODYTD4chMbePdiLw2KaSWOi4OZU0Z5xiqluY7Q
S5oU1rKAe4CzfhW2+vknPsJMO33aEXERjhMrHoUnU2sLi5X5vjcgG+NsKX4vbA0x
Rj6wvraVo6B3h0jNU3mcLQBVj5wCeR/Vjg5924eQXFQTPkM0OeZ+0aLce79wg6pj
Gkv69BxYPEB1NWcXS7PS8gkJMwXDk5tyQqMmjLSpFBjaPgNJP4ts4XRNZR57MCl2
LCzbxFhGpv8AkQGd77RCUg2ZMT5qTa5ttif/2jyCQYqdh6S2B/Gxw2341dbUo1tl
K6FzbKQlCbrY0hCnRu7tp7PaUXBGKBcZb244ObxpVAlXScRBWgbJ+yl6soS2QE7J
JfNG90cTsANht1C3zYXteCQEH72tnqFZn/pFwOHTV+h438RnNzVlcBjZf/cJe5yL
e3zBuyTYDrq93Dpot57W53159L1Axyh32pocUpiQZ1AxxaJYob/ot2lHLTDTwBIB
6K8Pkl9YVBr+062P6p5aNOF0nedbkSZlg36U8C15QWFtqyN+Jt1mf5m8vMcTssh1
CHbiBx4sYs9wdN20OVoUi4WnzEfm4crFur6ocvbs2m8uyseG1ltVYj1B3GrZJefG
mm8vCkhKUqioeCgtpF3i
=LoKL
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
