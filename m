From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 22 Aug 2012 08:44:27 +0000
Subject: Re: [PATCH V6 0/6] OMAPDSS: Cleanup cpu_is checks
Message-Id: <1345625067.3036.19.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-h6XDmBDIkbvuq3g8drL9"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1345468541.git.cmahapatra@ti.com>
 <cover.1345616887.git.cmahapatra@ti.com>
In-Reply-To: <cover.1345616887.git.cmahapatra@ti.com>
To: linux-arm-kernel@lists.infradead.org


--=-h6XDmBDIkbvuq3g8drL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-22 at 12:06 +0530, Chandrabhanu Mahapatra wrote:
> Hi everyone,
> this patch series aims at cleaning up of DSS of cpu_is checks thereby mak=
ing it
> more generic.
>=20
> The 1st patch cleans up cpu_is checks from DISPC code.
> The 2nd patch removes unused functions from DSS code.
> The 3rd patch cleans up cpu_is checks from DSS code.
> The 4th patch disables VENC support on OMAP4.
> The 5th patch removes cpu_is checks from VENC code.
> The 6th patch removes cpu_is checks from DPI code and replaces it with a
> dss feature.

Thanks, looks good. I'll apply this to omapdss tree.

 Tomi


--=-h6XDmBDIkbvuq3g8drL9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQNJvrAAoJEPo9qoy8lh71HE0P/j/XyQSVj5m+3L0RqaTK8SAb
tpqVNn5r+n/rvgmJXE6NAviS+4dTMJqePDs4KFss56PQgrbR76ArkrEVpawE1YyC
UOtq+lYp2eCC9LPZ5yxkAT2wQxvRPKfBrspj1MbynpL/Vvjj/G4Y/6tGXUTccY0I
OIvpTW+95VPkInViVsPqLRgNmBdVW/3bFh6YXIZnRISgSGhXKEyI9yBaalFwz+4K
34aq1x7mzdQHt69RNW4e31bffDQyVqfkfHqswW1tq0fwXn7mAE+VIyTwzTvja3Md
mM3UQpW/YWm1PuikcczBydw8rRgB6wqKeykkpAo7YHrHkNhs9DeC0BY094OexYHy
qH5SbFtMXkKB6fMISkQGAIYNTRm1NqC0xPTgZVLmGEOUMnXYeaeALgLzLhvvDCmc
vi1vkAuCGZOQ8S/TGuoqHLiqtZoWMWi6gm2NhgBUk6g6csm1irCZRjS5QD6jLMVB
3CHvVkOALZRPVxodSJmCaVKa9MoZhBJW0otpK+jF1RhYQ6nZPJZqQJQlPJFh/hel
FhytT9QU8MGM8FhP0A9Cs2zDXNgOXAONQ+ODl8qdq1mkW0cyOheupBbkUVXmI/jD
6IKCRqKQ4OMXXgT3HklUJBQFAYEOcBN7ZKGi7vZ40VI7vtHhamwLtL1fOcT3/R+X
QESAMXC9pVFCFkgy04G3
=WVaR
-----END PGP SIGNATURE-----

--=-h6XDmBDIkbvuq3g8drL9--

