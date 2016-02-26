From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 10:18:00 +0000
Subject: Re: [PATCH] fbdev: n411: check return value
Message-Id: <56D02658.2060401@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ws15SUTqLr6w8wcQ9ghDviiPoTurGFL2m"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456231457-20806-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1456231457-20806-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--ws15SUTqLr6w8wcQ9ghDviiPoTurGFL2m
Content-Type: multipart/mixed; boundary="ibPc9N0GctlcrJuffRKhaPINCowPR8eTn"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Message-ID: <56D02658.2060401@ti.com>
Subject: Re: [PATCH] fbdev: n411: check return value
References: <1456231457-20806-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1456231457-20806-1-git-send-email-sudipm.mukherjee@gmail.com>

--ibPc9N0GctlcrJuffRKhaPINCowPR8eTn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23/02/16 14:44, Sudip Mukherjee wrote:
> We were not checking the return value of platform_device_add_data()
> which can fail.
>=20
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/video/fbdev/n411.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Thanks, queued for 4.6.

 Tomi


--ibPc9N0GctlcrJuffRKhaPINCowPR8eTn--

--ws15SUTqLr6w8wcQ9ghDviiPoTurGFL2m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0CZYAAoJEPo9qoy8lh71ZNcP/1Jm+ychdxt/TVJaCNdpV/4D
J9/ux+ip+I5BVpj3D9AyIHi6cQbn+PzvGAy10nE8GrbP28tbBVHP6FAF/JcDaHPD
c1YDJg/b06/ebEJtxodEoq1N4kolF9cfZpki6dV86R4r8qyHDwemt3MJrZ/mxIcK
voFJnJYHqK5ejEehwdQ/LJ/bqnuIxFTPdbC+mF1pPDe6O/kxIg2WyIzvInhgFTbn
xqhcelQATJAooV1/s4274ugdNhPlXu6v+5pOa2dfz2Q5iXmYl+QJ3VuR08Dz3TXN
AjGDm77z7hfPm0d8uYtv0m2qFQB4uVfJhyO2DMiKr52zUK/amY/9xGh/33msC6+9
xtKc6e1WkxcC4gUeKdpw6XOWTBQk1f2z8WRKLxqEFGPjNfN4izDrvKJRk66k5kBy
hzSempxqN80oQVDF0+876tIRTOIgixLT91c27y1PmsIyRJsSXR3OFf3FXmoJ8hrL
///1zx+/LLbPcNeJvV7ajTPNwCua2GCh/hE33CCIEIHkUsfljHAzPzJtYo7wARIG
WsfnryV+xPxOmtOrYq1h7F5RFNRCutYQiNrZUjoPidVqYAh3C+G0p3MBVZSVEDKc
OOuMcpeCwZvHjdQLrembkDZabkefqtjkAcWVAVRZJXPb49CLo3Ew9aLSc78icbF9
uWsjP6nCWBBg9dxpVYf9
=4cld
-----END PGP SIGNATURE-----

--ws15SUTqLr6w8wcQ9ghDviiPoTurGFL2m--
