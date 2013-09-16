From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Sep 2013 09:26:45 +0000
Subject: Re: [PATCH 1/2] aty128fb: Use pci_dev pm_cap
Message-Id: <5236CED5.6030203@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="546fIHMCau8WNTwVinARJqjl7OR66Kj1R"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378935306-16814-1-git-send-email-jdmason@kudzu.us>
In-Reply-To: <1378935306-16814-1-git-send-email-jdmason@kudzu.us>
To: linux-fbdev@vger.kernel.org

--546fIHMCau8WNTwVinARJqjl7OR66Kj1R
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/09/13 00:35, Jon Mason wrote:
> Use the already existing pm_cap variable in struct pci_dev for
> determining the power management offset.  This saves the driver from
> having to keep track of an extra variable.
>=20
> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/aty/aty128fb.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Thanks. Applied this, and the second patch, for 3.13.

 Tomi



--546fIHMCau8WNTwVinARJqjl7OR66Kj1R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNs7VAAoJEPo9qoy8lh71GO8P/jHxvV1wilHXNck3uJqlN4Zl
3pWXZTeD26Gwso6oOv2Bk4wn1NvQVckrN/brzv5L/l4VbVVBl8+J96iKgRyodOXs
3Tj9KNXpr9Dis2QxDLoQMxr6s2VWMMvcwoakGJ9vupjGGw3R2n+nBFptvRmUhUky
wH0XCheloGmwfmDJ81sXfg9lHxqvFm/D4kkwo2fgJvrEOQq+8pADD5T8X1yFw7OX
fPc4pXsRiSYbW/lEHr9Rde63O4RYm28c/86PmrKm8TpivXysJQHOkwbnFenkTozh
xmpCxLfN4yfjevpaKBynO9ihY7QpkuztpjGgEHPBf7k0SzKcw6brzTX6MpJmb5oR
7bWarxpbLtCPMiKlccWymaSqDfTaFVXNLPILe6xPa1L4Dlfav9DNuB51vrZMk/db
f4Bm/hcnq4ELtxQmgE2DNIXc10PEXMVTxN8NGuo0dDNuXxj32yGe/k1LpZgS4UNk
Xzs5L/UaHyge9ANE0R7FJL0dHZD3o7UUrrRFWZrsSQUS5FT7DtYa+a4Xr3oxi4oS
vOttXb2v25WQK23Ctu4Ou/rzSFpM0e/DrD+I2Qd+qG/lgmHDeRKNTmDJqy+m0RVQ
2v9Equ/rMxJ11TMJunYJVkMn5SqWf8diNoUDpG0EanBgzMbR/27abcZcQbJZQaPf
TXjSSYxL4JE55fzkKd+l
=DW11
-----END PGP SIGNATURE-----

--546fIHMCau8WNTwVinARJqjl7OR66Kj1R--
