From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Aug 2016 08:55:59 +0000
Subject: Re: [PATCH] video: ARM CLCD: export symbols for driver module
Message-Id: <a32cc9c5-7440-2f79-b714-a60a830ab926@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8cDuiSqlkO4ClgFtGUgNVUbGqjJMWlGwv"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160826153500.768744-1-arnd@arndb.de>
In-Reply-To: <20160826153500.768744-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--8cDuiSqlkO4ClgFtGUgNVUbGqjJMWlGwv
Content-Type: multipart/mixed; boundary="PDSsE4tELrevMi0twcH69OT6J87fNcD53";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <a32cc9c5-7440-2f79-b714-a60a830ab926@ti.com>
Subject: Re: [PATCH] video: ARM CLCD: export symbols for driver module
References: <20160826153500.768744-1-arnd@arndb.de>
In-Reply-To: <20160826153500.768744-1-arnd@arndb.de>

--PDSsE4tELrevMi0twcH69OT6J87fNcD53
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26/08/16 18:34, Arnd Bergmann wrote:
> The amba-clcd-versatile.c code is always built-in and has to
> be done that way because it gets called by platform code that is
> also built-in. However, it now also gets called from the
> core CLCD driver through the .init_panel callback function,
> which leads to a build error when the framebuffer is configured
> as a loadable module:
>=20
> ERROR: "versatile_clcd_init_panel" [drivers/video/fbdev/amba-clcd-mod.k=
o] undefined!
>=20
> The same thing happens for the nomadik driver, although that
> could be linked into the core module if we want to:
>=20
> ERROR: "nomadik_clcd_init_panel" [drivers/video/fbdev/amba-clcd.ko] und=
efined!
> ERROR: "nomadik_clcd_init_board" [drivers/video/fbdev/amba-clcd.ko] und=
efined!
>=20
> For consistency, I'm taking the same approach in both cases here
> and just export the functions to make them usable by the driver.
>=20
> Alternatively, we could split out the CONFIG_OF-code from amba-clcd-ver=
satile.c
> into a new file and link those two together with the core driver as one=

> module.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 1d3f0cbe0d3a ("video: ARM CLCD: add special board and panel hook=
s for Nomadik")
> Fixes: 25348160e9a4 ("video: ARM CLCD: add special panel hook for Versa=
tiles")
> ---
>  drivers/video/fbdev/amba-clcd-nomadik.c   | 2 ++
>  drivers/video/fbdev/amba-clcd-versatile.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Thanks, queued for 4.9.

 Tomi


--PDSsE4tELrevMi0twcH69OT6J87fNcD53--

--8cDuiSqlkO4ClgFtGUgNVUbGqjJMWlGwv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxUofAAoJEPo9qoy8lh71HcwP/1dbKkoASTrR+WeSwIUK12FU
wK9eusQzXbvUEqbhYb17obgcy+YZwn8PbFLr0ho0Q3qamARk/mvn8NwPJtDcOzrZ
hsOdKa9APkl+6gQArjLnBJ/53DeiUdS1Q3Y/UIVHQWGPRPFdnRc42i8sFic4NIWd
9dU0ZDWvpp264wThDzU3cBxPySVlauiaSASqlSpyRW4ifkE5bL3l1bLt3pq5MUq8
obbvAGfWAmo/BfZR9McKsW6EkltxoXALrh83OFC8318dryFZnYdx1OMWpIMZ0d64
D+tZQZy8X7rFj8tAfYPHrjlQlqvnmvkjch9ng0/d8zjlJAhFb2G0GI6KooTaHz/H
pqaPFjW/wHzDZdgwIlQNFlneK3qprtfaI76BSs17VMNQJhE83/+jrWr/96MI1pEn
A1nN23mEDkcFipcGczHIULvSDAqXKlUWeowg2JbZ/H384tswaxW6OJHvsT1VtI/5
Na/wG9Bzq796A+f9xP3WVDgm4EQh/moNLnSSzlYjD/eOW7wc9pQN49clQbCA1BOy
Wv/guDHpvPy4EgK+Dc7R6avDuT2r+3nolHrikkrIIxhpAYUjUX7FPIhBH8fflIA9
Jx7M5il+ah3eupIfWnWzuH6dtNKjJNZfH9vA+eTQ04NoyWwTW0xUiO0mCenpOXXu
al+uDsAHW128wI9FPDvZ
=BMp5
-----END PGP SIGNATURE-----

--8cDuiSqlkO4ClgFtGUgNVUbGqjJMWlGwv--
