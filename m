From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 Sep 2016 07:36:50 +0000
Subject: Re: [RESEND PATCH 0/3] fbdev: vfb: make VirtualFB more flexible
Message-Id: <f0b4931d-c145-d633-8348-65397e247cfb@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qfcBwhLWOBlDubjUSjNBUKT0XqIj54cna"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471255832-44793-1-git-send-email-vladimir.murzin@arm.com>
In-Reply-To: <1471255832-44793-1-git-send-email-vladimir.murzin@arm.com>
To: linux-fbdev@vger.kernel.org

--qfcBwhLWOBlDubjUSjNBUKT0XqIj54cna
Content-Type: multipart/mixed; boundary="veGHeQ6gqGDRW2bsS3hx6nlTbQgVQXoXe";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Vladimir Murzin <vladimir.murzin@arm.com>, linux-fbdev@vger.kernel.org
Cc: plagnioj@jcrosoft.com
Message-ID: <f0b4931d-c145-d633-8348-65397e247cfb@ti.com>
Subject: Re: [RESEND PATCH 0/3] fbdev: vfb: make VirtualFB more flexible
References: <1471255832-44793-1-git-send-email-vladimir.murzin@arm.com>
In-Reply-To: <1471255832-44793-1-git-send-email-vladimir.murzin@arm.com>

--veGHeQ6gqGDRW2bsS3hx6nlTbQgVQXoXe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15/08/16 13:10, Vladimir Murzin wrote:
> Hi,
>=20
> This short patch series is supposed to add some flexibility to the VFB
> which should help with testing in display-less environment.
>=20
> Thanks!
>=20
> Vladimir Murzin (3):
>   fbdev: vfb: add description to module parameters
>   fbdev: vfb: add option for video mode
>   fbdev: vfb: simplify memory management
>=20
>  drivers/video/fbdev/vfb.c |  129 ++++++++++---------------------------=
--------
>  1 file changed, 27 insertions(+), 102 deletions(-)

Looks fine to me. Can you check if the vfb_default can be constified? I
can make the change, so no need to resend.

 Tomi


--veGHeQ6gqGDRW2bsS3hx6nlTbQgVQXoXe--

--qfcBwhLWOBlDubjUSjNBUKT0XqIj54cna
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXz8OSAAoJEPo9qoy8lh71t7sP/0CoKG+hpcYoqNF/wJ5/JzUH
SflrRUWjo2uIPzXndFhhdcrhoedKxY6KhGd8UB8pNyJcaKezCq/Q2uPpZBaQ6SLl
bRIKeCFwIr/F/bTeqyXGSXCk310R3tTPkAR1yufveuIWf6RGiV2bxuGSx6P5LTHG
46Rpb5P0C+cFwZKIuciflINc2LU+4LdkguZSKdAykSsp4Y9T6x0zePOhvavOYiPB
iqGK88dfvI30Qt28kwLz+0LU+pbJVFF0pAYD9qWVpwiKgOjgrZpz0yKgAhSfkksD
q95YHtSga/m2Wjsxdp6RzPj4f+/B0TPejcLCmILTL2TyUSf5ENzecR3NacXvxm9A
ZBOjhFoIR7GoklmGwCrmLEIdh3HbjaI7JZBsuWXUHdMSCJtCD02Hm12VLX/kXBmd
enNqjfAqil09JxyDqZX+F/yKcXTdUqRRcBK5jfemNUmHOhYcr4Wkrk4wueCmHQUP
PDzP7F0LkX9T32x+U5gPnDZRrmPE0uyb/41zeIc+KU1uAOj0C2+vn3ovNS5Nn313
BNlOyPTr6a0Ss2c+5DaRbs/7179NJT9XjAg7QbWkddVga97ZiGTqBADxtfNRJKf2
Hv57bFdie8pDz9vrJ2HrhWqC2x9p9Ck30gx0X71YO4mmCGXPSFNKS/1XdkWZtVel
fC3iasJnQdlaLCAMnqE3
=yP4q
-----END PGP SIGNATURE-----

--qfcBwhLWOBlDubjUSjNBUKT0XqIj54cna--
