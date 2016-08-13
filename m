From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 13 Aug 2016 18:45:25 +0000
Subject: Re: [PATCH] video: fbdev: mb862xx: mb862xx-i2c: delete now unused "int ret" variable
Message-Id: <20160813184525.GA1690@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160813183913.30635-1-paul.gortmaker@windriver.com>
In-Reply-To: <20160813183913.30635-1-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 13, 2016 at 02:39:13PM -0400, Paul Gortmaker wrote:
> In commit 6b610e004baf ("video: fbdev: mb862xx: mb862xx-i2c: don't
> print error when adding adapter fails") the users of the variable
> were removed, resulting in:
>=20
> drivers/video/fbdev/mb862xx/mb862xx-i2c.c: In function =E2=80=98mb862xx_i=
2c_init=E2=80=99:
> drivers/video/fbdev/mb862xx/mb862xx-i2c.c:160:6: warning: unused variable=
 =E2=80=98ret=E2=80=99 [-Wunused-variable]
>   int ret;
>       ^
>=20
> ...so here we remove the variable as well.
>=20
> Fixes: 6b610e004baf ("video: fbdev: mb862xx: mb862xx-i2c: don't print err=
or when adding adapter fails)"
> Cc: Wolfram Sang <wsa-dev@sang-engineering.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

Acked-by: Wolfram Sang <wsa-dev@sang-engineering.com>

Thanks! I wonder how this slipped through my and the buildbot checks.
Will investigate...


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXr2rFAAoJEBQN5MwUoCm2KpMP/3FZos24iDQ1UZbkyU7eXMmZ
kGhG+5Looty9u4dacm/j8sBRbkJSVxHZOZZ+f5wazxi0x6jDe0W2OZSKRrWJi6fM
TE9dZU3oQfFjh6zTJDKONB0ABrQiLeiEBa/NsMidRwDEnemcMmPkrnbX+01PsS8a
s5BkDbytz0VMav7GgTxoBji7bLyFaOZgUzwo/H2A/6yyaMis76SYGuRH6YGcZCDq
2Z6b4JroNH/lsKAwdyzdD3Wiq5LkjNAQrSh3b1Ivt7zw3rah0nq5A30t2sbkD9sW
7FqfIYsNWJaiqd+dKG5Z2NJGLE4/tbQmEchd4HDu2MyhZjO+BdPXM3Ty0N6c3n+C
Ysk6QD/B++0qoZTBrtF6Ys/r79d/XYQ9JbhM9NAbJ6Ueen0PpUrADbM41sa543Jx
rsiHJXbUbb/SOHTh5WRUf2y/TPZ6IgOcjC+P9f42ocmYiERIPyVirBLYQI4kR1Wu
GQnyxRc8OUHcqCFmLMAQeZWon2OKqXv9aLJ5xZrWOLyND84NRCZmWRyNyecx6evv
ppIOg5BFmYzN8RGcWtSO+lWTbuk6PZogAUKUOFwAJ9Ru0t5l0xJXzzaOs3CTCqWY
lVKXiiCptQhO9ECOROzeZWVwsHBh8AXnI04y/G3HhpTbayALh112lq83RbXubgt0
FSEgT+5UHTOCuq6ienb8
=U8jl
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
