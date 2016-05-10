From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2016 08:56:09 +0000
Subject: Re: [PATCH 0/2] fbdev: sh_mobile_meram: use ARCH_RENESAS
Message-Id: <5731A229.7010307@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CMmG3AJNd2wVRHI8vp0BQsBr9m4uHA6qC"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457663298-31973-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1457663298-31973-1-git-send-email-horms+renesas@verge.net.au>
To: Simon Horman <horms+renesas@verge.net.au>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org

--CMmG3AJNd2wVRHI8vp0BQsBr9m4uHA6qC
Content-Type: multipart/mixed; boundary="1dn961SD8DMFHI2SlOL3842C5n1tm0X3N"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Simon Horman <horms+renesas@verge.net.au>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Message-ID: <5731A229.7010307@ti.com>
Subject: Re: [PATCH 0/2] fbdev: sh_mobile_meram: use ARCH_RENESAS
References: <1457663298-31973-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1457663298-31973-1-git-send-email-horms+renesas@verge.net.au>

--1dn961SD8DMFHI2SlOL3842C5n1tm0X3N
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 11/03/16 04:28, Simon Horman wrote:
> Use ARCH_RENESAS in place of ARCH_SHMOBILE.
>=20
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a =
more
> appropriate name than SHMOBILE for the majority of Renesas ARM based So=
Cs.
>=20
> As a follow-up also depend on COMPILE_TEST to provided for increased
> compile testing.
>=20
> Based on v4.5-rc1
>=20
> Simon Horman (2):
>   fbdev: sh_mobile_meram: use ARCH_RENESAS
>   fbdev: sh_mobile_meram: depend on COMPILE_TEST
>=20
>  drivers/video/fbdev/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

What was the conclusion in this thread? Should I apply these?

 Tomi


--1dn961SD8DMFHI2SlOL3842C5n1tm0X3N--

--CMmG3AJNd2wVRHI8vp0BQsBr9m4uHA6qC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMaIpAAoJEPo9qoy8lh7137EP/iwwHMI6JI81ontEplVMxL+z
CpX2SpSS+HeeCXiKoiNy4fM9OFc3h1pselGd8FA5fFv2yV41E9OMfCdz3RhZWcnB
cbS9TT1Tn8PB9K7m168SOqee9FIprxe8oDROGIVVYKmEHDKrLYcDif3hV9MOII6K
F1meinSDO2ECIinyVs0JjNOxC5bEIPBm1lKyOowr5tgQwSaT8RTz5JubZYlGS0pE
BuZmSqKbQdNf2ZxZ9b2e3oBZQypLCjRiVy9IhmGocN+JwtkDIQLZhykuiopr5KFs
u+fmLXEIne3oLiwQ9S2PQ4ylSRZgGfln+3oyd9m2dyMP5HURWeyfT/bibgqv+jx9
zVeFmfXfZaI9kjsbgzvjlLZfJhZGCg8Dr14K1W7V6qHK+MFjh5TFxwKdOGSHl/XK
xl2zXcEPMLPHtjOSG1i+R0AWynS2gWISv71lckNyNoX5/jBtZHgYw7+vt2b6hLdZ
ZrHzG1tnkYgU8F1gMXp5ZjZA/3ERktTbUOVTLCM4XAez8KoQae/2d5MpoaW52HEY
kkq0q2YQTWt405zFK4XAH/WYBiNudDnl2jWDqSdL+ADLu3LDmoIlTlF9kLVEVs1A
dIZjSUJQzcbG6qSuVD60NYQ8+9E+mSxF9BRlsCoD18P9LlHlok8dNyy5dGEuNXFi
ovvL3kbMuJADZaHIFg0o
=iIRh
-----END PGP SIGNATURE-----

--CMmG3AJNd2wVRHI8vp0BQsBr9m4uHA6qC--
