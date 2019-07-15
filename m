From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Mon, 15 Jul 2019 14:27:44 +0000
Subject: Re: [PATCH 0/2] Staging: fbtft: Fix probing of gpio descriptor
Message-Id: <481382385e1916edef81cd1219d695b045e0a20a.camel@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-gKBUbqe+P9k3BDYCtp9q"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1562833913-10510-1-git-send-email-preid@electromag.com.au>
In-Reply-To: <1562833913-10510-1-git-send-email-preid@electromag.com.au>
To: Phil Reid <preid@electromag.com.au>, gregkh@linuxfoundation.org, bhanusreemahesh@gmail.com, leobras.c@gmail.com, nishadkamdar@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org


--=-gKBUbqe+P9k3BDYCtp9q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-11 at 16:31 +0800, Phil Reid wrote:
> GPIO probing and reset polarity are broken.
> Fix them.
>=20
> Fixes: c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor
> interface")
>=20
> Phil Reid (2):
>   Staging: fbtft: Fix probing of gpio descriptor
>   Staging: fbtft: Fix reset assertion when using gpio descriptor
>=20
>  drivers/staging/fbtft/fbtft-core.c | 43 ++++++++++++++++++--------------=
-----
> -
>  1 file changed, 20 insertions(+), 23 deletions(-)
>=20

You can add my:

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

The only issue I see is in the second patch, who should also have the same
'Fixes' tag.

BTW, while testing I found another issue, I'll send a fix shortly.

Kind regards,
Nicolas


--=-gKBUbqe+P9k3BDYCtp9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl0sjWAACgkQlfZmHno8
x/7ChAgAnqe9gOqVqsH2hZYK+itU2ED7RijpJpZvjzGHFbAKc6LK7YYhCkT6yUBG
uo98pK18pjUtaTdvhrnToLWqU1Utr87sDjVfwIdduDSmAnyM36P26NVtXPtr+atl
iL9BpNNhkG0/ZveKtm3zv1ql0kfDxgCfcSrAWnAo/nJ83jmeObEOrZHJY4EVZwB1
kQc4McdlGxqrmuvuY12a+ixc73AdlUArDJCWsbu/n1TKER3J6X5zFkZmZWDRqGZS
8i61Iz2TNQl+k9J/ts0Y5S3RguweADMj+Q+rMmTmdMsGduOp5T6KpXfQoq89HAtc
fO7UVjl6ssxy8EDCh6bO02G+Enw2+A==
=0/r6
-----END PGP SIGNATURE-----

--=-gKBUbqe+P9k3BDYCtp9q--
