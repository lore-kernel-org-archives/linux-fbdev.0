From: Michal Simek <monstr@monstr.eu>
Date: Wed, 24 Jul 2013 07:17:33 +0000
Subject: Re: [PATCH] video: xilinxfb: Fix compilation warning
Message-Id: <51EF7F8D.3070701@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2OFWEDIIUNNEIWSAGQTSE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <ed64cda456be840147ae1f04bec6a99733f41c24.1374643896.git.michal.simek@xilinx.com> <CAAY4GiVG-c63oJO1Kqv0Jf2Wa2Ba+hgLtHQYFqyuRW-f6hJ14Q@mail.gmail.com>
In-Reply-To: <CAAY4GiVG-c63oJO1Kqv0Jf2Wa2Ba+hgLtHQYFqyuRW-f6hJ14Q@mail.gmail.com>
To: Vivek Subbarao <vskerneldevel@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2OFWEDIIUNNEIWSAGQTSE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/24/2013 08:05 AM, Vivek Subbarao wrote:
> Why is there a necessity to type cast to unsigned long long ? Whats the=

> warning ?
>=20

Geerts: Build regressions/improvements in v3.11-rc2

  + drivers/video/xilinxfb.c: warning: format '%x' expects argument of ty=
pe 'unsigned int', but argument 4 has type 'phys_addr_t' [-Wformat]:  =3D=
> 344:3

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



------enig2OFWEDIIUNNEIWSAGQTSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHvf40ACgkQykllyylKDCH75wCfXSH33j+eymnpyy8wMzkjOiyO
dDIAn3osgQ+au5pI/OPTweCo/lBpPZQf
=RiC7
-----END PGP SIGNATURE-----

------enig2OFWEDIIUNNEIWSAGQTSE--
