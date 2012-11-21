From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 21 Nov 2012 16:42:21 +0000
Subject: Re: [PATCH v12 1/6] video: add display_timing and videomode
Message-Id: <50AD046D.1050201@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig0CF1414206811AEE10D77671"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353426896-6045-1-git-send-email-s.trumtrar@pengutronix.de>
 <1353426896-6045-2-git-send-email-s.trumtrar@pengutronix.de>
 <50ACBCE4.60701@ti.com> <20121121161103.GA12657@pengutronix.de>
In-Reply-To: <20121121161103.GA12657-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--------------enig0CF1414206811AEE10D77671
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-21 18:11, Steffen Trumtrar wrote:
> Hi,
>=20
> On Wed, Nov 21, 2012 at 01:37:08PM +0200, Tomi Valkeinen wrote:

>>> +#include <linux/types.h>
>>
>> What is this needed for? u32? I don't see it defined in types.h
>>
>=20
> Yes, u32. What would be the right header for that if not types.h?

Yes, it looks like u32 comes via linux/types.h. It's defined elsewhere,
but linux/types.h sounds like the most reasonable header for it.

 Tomi



--------------enig0CF1414206811AEE10D77671
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQrQRtAAoJEPo9qoy8lh71eloP/juLnJjbo5y2FUJ04qMJ+df7
MkNVVYEtjD4rceufjzwihFGQ1EQX1HowLyFGe2/Wljn8xbFkNvNh20fnbq3O1p0I
KMcUUCGppacHs6kWu5RvFRVjHX6BOu4XkVMzfcFnbtFocHZiTSXWa+JxhFF7I96U
o4hkfJ8+Jy4znNmrfYPDMliEbFaM5JaeXbmPKQ81Oe75pvk+9mmDOONURmDS0xPB
Zi+kVZ70C4V1fWlu/vO+ukeUlKBRXgTdjGM0MUZUbHHKYio4KY8WN3j5Za2XDpN0
8PTJsLPvxaSouuXlXl6LznwxjkTET/bTj1FN4PIR/CEz4KybtjkVHx6zeo0NCyfp
Sp+GSVDmyN1psGhWtJyYj9d3IbZBCvplaXHiaKansq/BkiiQfrpmqTRQH5RDOpgn
ii4Odde5Hc98z2O/g+rZYMVKrk1V8cS70HwC02LCyLuc+39CVz8+YzhMTId6C4OX
lVMFPIN+vDtypsWim7HsFU97ZoNf7Mhh3SbQctkKdXfUTJXGvbFn6X36Tyzj1IUQ
QPud8W4NQ+wFafRiutcQ8FXmqsdoGngpWd35U6HgR/O3SreXH0kf/90P1HcGS7FZ
/kK5ojz/NheUeo4+MZtbul81f5fvktR5gKauWJ2Vfve7wf3Cn6gsrl3EWqUqGzWe
YHTfS+riAeffBkD2Bn9y
=5nJE
-----END PGP SIGNATURE-----

--------------enig0CF1414206811AEE10D77671--
