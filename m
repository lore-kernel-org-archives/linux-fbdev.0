From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 26 Aug 2016 15:45:55 +0000
Subject: Re: [PATCH] video: fbdev: mb862xx: remove unused variable
Message-Id: <20160826154555.GA1608@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160826153252.722636-1-arnd@arndb.de>
In-Reply-To: <20160826153252.722636-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Wolfram Sang <wsa-dev@sang-engineering.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 26, 2016 at 05:32:33PM +0200, Arnd Bergmann wrote:
> A cleanup patch that removed some code left behind an unused
> variable:
>=20
> drivers/video/fbdev/mb862xx/mb862xx-i2c.c: In function 'mb862xx_i2c_init':
> drivers/video/fbdev/mb862xx/mb862xx-i2c.c:160:6: error: unused variable '=
ret' [-Werror=3Dunused-variable]
>=20
> This removes that variable as well.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6b610e004baf ("video: fbdev: mb862xx: mb862xx-i2c: don't print err=
or when adding adapter fails")

Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks! I already reworked my scripts to detect that better in the
future.


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXwGQzAAoJEBQN5MwUoCm2jKIP/1LBHZKY9U4VbguKncPIBwTM
sHk42nC+eCxND7lm0b/TwMuBXOl2tJAIHM1V4w9hJylvg/4VteE0b7xaFLQwnTfY
rN5r7PqglyP2mEBTPRUtMCuxGGEUenjI8MFHlKi1nBL+JH4WNE35ovxUg5eeCG6r
OjD1H416RDB0xhiRVfssljyF3VBLFPJ1ra/hiMKYQTZ72zmeV8p6Xmfpe6wygVXH
C+LKp4O/UBtn/QdVOUd0VMnSJb9//1P1QWM0jv1i0Ck9Uq6zPA5UMgqg5MG4ubol
MAN45T89a7ISCL5r8Hre/z1dfAcxGjrNjzaPwvfkD3+xpzSJdr6jpXrx+eMzv9Kw
7bVnUuDl2Sp3L2ri5/+3rkWGqn1FTsTggLh+p14MPDp4RSzOhyhGemy0pB4MVh9v
JQZoPCxPkKPIJ3P0CTKN6qLzQUA1W2naLY6v+rpWhcExw3J7zCpZ394yr0SPTbE3
J72RHN30ykNyZDpByvsMhsr8uDJOy7gvLASaDB7nqBX86fimi25HrfjKzCXv6YC2
7Xa8ZYErG9EBrZAcLuVNs3KGz7EoU6RrRpYUPSikVYOE3aGLc0kSl4sqmnVfb+l8
2KSfLoJJLB0o/cWnLCTtTmTUnR+hRKUug9wRHIyfF3jaRXqPeM+97LOLjNihsJ3f
SL3DeEQCpFHRQvv7xqaT
=z58C
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
