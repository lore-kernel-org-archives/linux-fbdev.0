From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 22 Oct 2014 06:58:23 +0000
Subject: Re: [PATCH] video/console: Resolve several shadow warnings
Message-Id: <5447558F.90706@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EtotUrbCTSE98j2H7LcTr1hSaxDg22Ngt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413287629-11749-1-git-send-email-jeffrey.t.kirsher@intel.com>
In-Reply-To: <1413287629-11749-1-git-send-email-jeffrey.t.kirsher@intel.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, plagnioj@jcrosoft.com
Cc: Mark Rustad <mark.d.rustad@intel.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--EtotUrbCTSE98j2H7LcTr1hSaxDg22Ngt
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/10/14 14:53, Jeff Kirsher wrote:
> From: Mark Rustad <mark.d.rustad@intel.com>
>=20
> Resolve shadow warnings that appear in W=3D2 builds by renaming
> the "state" global to "vgastate".
>=20
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/video/console/vgacon.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Thanks, queued for 3.18 fixes.

 Tomi



--EtotUrbCTSE98j2H7LcTr1hSaxDg22Ngt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUR1WPAAoJEPo9qoy8lh71diQP/2avyd7NGmGHXsylUl0Rdb0v
Zuy1AQowkK1icClbVlOIeZrLdka3N0xMEnGaDfHsUST8IIYME+P9X3x5QTyNwqCf
qRATfzDBwQJcJWHQS/hyHhInSwycYYeaxP+1Wg8zSZxa6XSPAI/mT6wDPLtRY0Uk
VQxq/dKbg+ly2b4Ov8NnlwQo6s0hwNEAcRtnXhwcch5k0yzHIU66YXBbQWu8IBYN
hZS18sPlJlXZKHlbykr+Jd3ZeiWSeigUC++K2BOELI5BL2Z/C5sxQTWgeMuFJX3f
w1T2QO+ymO29EWTSfTvzhBVL/iqHZ67iKpwnLOLjq+F25SuKVQbHvMh+QphOXGWH
cZOc8u6+bsPUdRgEi7ut1DR3mrbMP02Gu7xnLosLkk2WM7HorHQ23mghfVqGKrJ3
TuiqazsiJmv5MPcfzS7pJ3nxWFEv7h04J/S3F2A3psdK3qTEg0dfuc1cZmHJOPrz
VFyYwfD/QR6+wIQGulYHop/2/CZ8O8z1hs279BZ8/JANET9JgSDpOqBRTBBAdo2T
wkjVcbJuH3E0OBaie8EF7seE0DelvHgim8k9szqMyKd6XodfmgsT1Fm9wJ5TlYoA
daqv3R4C3aLrh+uY2t3Kh7e/SzAQsDOkiyeJt7OkRcL3zNBJ+1NSvbUHvswxuSjS
N4ZRPjsbq/KHfRm/9t1e
=3T40
-----END PGP SIGNATURE-----

--EtotUrbCTSE98j2H7LcTr1hSaxDg22Ngt--
