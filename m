From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 19 Apr 2012 02:49:47 +0000
Subject: Re: [PATCH] blackfin: fix compile error in bfin-lq035q1-fb.c
Message-Id: <201204182249.48604.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1387560.p4X01MFeeG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334803401-26780-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1334803401-26780-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-fbdev@vger.kernel.org

--nextPart1387560.p4X01MFeeG
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 April 2012 22:43:21 Paul Gortmaker wrote:
> This file has an implicit dependency on GPIO stuff, showing
> up as the following build failure:
>=20
> drivers/video/bfin-lq035q1-fb.c:369:6: error: 'GPIOF_OUT_INIT_LOW'
> undeclared
>=20
> Other more global bfin build issues prevent an automated bisect, but
> it really doesn't matter - simply add in the appropriate header.

Acked-by: Mike Frysinger <vapier@gentoo.org>
=2Dmike

--nextPart1387560.p4X01MFeeG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPj31MAAoJEEFjO5/oN/WBInQP/3If9ybYn0uywsMYZXhovUZa
REbuSuxjnJIsjV9WYrzhF4l6LPzZQXPHSG3f5ugCzveZ7HWbJ1wP3ubjfmsazdN1
W/onB9gpD+d9wNpxB+YNWbJ8y+BluuTrtkoYiuf+Wbufj6+iMS/BoNsevzytdOUw
Xh544zYKDXCM+/ltSBrIjylhS68wIcIPjiFTE9tawtIKKCKuPjCDTJ8mdI+T/O9f
RndAiY0BpVWNVs00gUF1XflQ5SBg5aBXOIacdO1V/Qqyb1zC0wS6YVTO2BTaRy6b
+eM5kwe+wtLphQP0REaVOKSi2+pfNRslIglDSKnhTHd9PvS1X5GpJiu1CCwBKmGE
rmJS5fa2k8RAX+c2zGZtrRLHOilfLakgydeaIpz2tEL7Fsi61yPE2+gDbekXNsiO
J2rSEWv8d3KHtU8XM8EXBTG4Zg3dF18zaxjSJzmz0WoETWH7qXMAfaXKfMR1DitV
dbhbrLZo0w6bcfnnxrPBWODaSdxduDrj7Xm1cEYlFNHRQQGW0zhbEhE3e80JYzCk
OnnxlnLR6BLuJ0Y12m4jgDdr2PcltSdNjJdvyFIo/EwQ8A4rhCuWwmBAzbJUMgdo
2Z1uvRRhmoTxPhAkgwGW9xe01uzZNJPy2Hk90PDGbAYMyL05MOCKsCmyb1qsYRpk
0ewZAxKRQdKTE3jJCOB/
=L3/A
-----END PGP SIGNATURE-----

--nextPart1387560.p4X01MFeeG--
