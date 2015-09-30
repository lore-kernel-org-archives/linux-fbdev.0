From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Sep 2015 07:38:20 +0000
Subject: Re: [PATCH v2] fbdev: broadsheetfb: fix memory leak
Message-Id: <560B916C.9060402@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="X4I3jxUhSWaSokPaKR3347IjQQl0EjmSQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443257530-26848-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1443257530-26848-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--X4I3jxUhSWaSokPaKR3347IjQQl0EjmSQ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 26/09/15 11:52, Sudip Mukherjee wrote:
> We have requested the firmware and it was loaded but we missed releasin=
g
> it both on success and error.
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Thanks, queued for 4.3 fixes.

 Tomi


--X4I3jxUhSWaSokPaKR3347IjQQl0EjmSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWC5FsAAoJEPo9qoy8lh718rIP/3p0fg3Q1TLDxJlEQqOFIZ3h
Sk2thoFFr1bDG7gE7XogCFkIuIMoJVjQaKOYiN09zpImUnVji6/ReL4W4vS7IjKO
zl1dyd8Swd7ldhmN327kf+saieUQTKGoEJ+r7zlkYW0zYBWFQEB9i3Im2gXT2GVP
ln9EVWWywLjHrKKk6xmMjameX6vLqmPCMJgiWP0O1AKGwVAMT7ScH/yCh0HjTYBY
D9ZSibXUDdEgewQDdOtFeiDg7vY7Es/RTHiUVmcPNW4DC6s/XuqnmOj0b11eavIc
b1zZRwTrMXf36cmG0czOlccOK35qMupfVHJaRfBFBNwjylHI86nAYLRdIJZfyFJp
KNcvqE0279TFcn7GcqlNUcoeN9RySxW9c474DTMYJt4fIhXVyxAs0a6x63cC0VlB
++eqSE3Q+5dgwuKIL9IzVdBYKljL2Y8e8Fg5wZAfuevqvPhvwoJUDeUeTNToWyOA
SdMktx4a3fokZ8NygRoxXtfodCdXAqMzFfloYIopC37OgNCs9LdEGBNufl/WTB/K
M+X+w7NRJi/zH6Zu1ORfM6BHUZXJeAY/HUaHVrlvC7uQl4Ep1g3jWDAAOU3hilrh
r4bGhQFuK8JKJA4QP5pPCHREn/LZmtSPw3NggwwCPSUd1X8of/RW2NiTJKXvmitp
vKZLZllBCrC29R4wq7DP
=FTzr
-----END PGP SIGNATURE-----

--X4I3jxUhSWaSokPaKR3347IjQQl0EjmSQ--
