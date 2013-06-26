From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 08:15:27 +0000
Subject: Re: [PATCH 13/23] video: da8xx-fb: enable sync lost intr for v2 ip
Message-Id: <51CAA31F.7080801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2DSISEJNKPXCBBBQUSLCT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170171-9561-14-git-send-email-detheridge@ti.com>
In-Reply-To: <1372170171-9561-14-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

------enig2DSISEJNKPXCBBBQUSLCT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/13 17:22, Darren Etheridge wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> interrupt handler is checking for sync lost interrupt, but it was not
> enabled, enable it.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>

If the patch is a fix, say that it's a fix. Tell what the bug is, what
symptoms it causes and how it's fixed.

I really dislike too terse commit descriptions. The descriptions should
be as short as possible, but no shorter! =3D). For this one, I guess just=

a few more lines would be enough.

 Tomi



------enig2DSISEJNKPXCBBBQUSLCT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyqMfAAoJEPo9qoy8lh711/MP/ik2WSaXz9Jcu2kpUAjkgewN
EigqVyeS9EY97mo49DZRlVT1HYOkom2IWbKJx1FFbpufgAkzt4HL8GkaaBPH/Wyi
zPpURcFuA4qmNI7W5il7eSFWn2c5FjNuTuWduF5nXcBoOorLWrEEJVpYLY992+ra
N64B4k25fQfKRqEOA4keHcqSYUNlTq/OixeYxo1xWs6NO8ULQFC3lMT24wuaFDAn
HY35IJUFpdaUcOJAndoeiUqVnRoIL9eIqgQ/aFkIlNjQe4yAfF9w93r0d9skiYHb
7CWkjna01a76It09OFzjC1BaP1bJQnT7FXMS3mDvP2xcMYdGVcKKbWmIVdPy/N94
IXMGkhkmUngQ7y0yZxr16twXQPGqD9LAD7lITG9Nmk1su6IQeDVuXXkfZwCTqjew
U2qT9ZSbbl42XRU9ksifQj5F+Y6+0wiNysw+pMx3KKU+6qDFiunVPuYJAS+QDoMT
fmywdNI5zNo5EJI4aqsg+kszpx/EViHnMBDkMu5v1X/MUNRNHWC8s7WyWq2hohka
bSOcX4/nOOQMBtZmDSxBYNpKvI5hPgkQCiMN3qbp11vpeegLYVCCuXA2fxIsKCrz
26WIVA9qvOvdGWhZz+ctzpqF2OrhmuZi8tKO/gslKhuG6jUqoRFBt9Pi5XJcZSVQ
EsEeHU0q7dz+zkllyEAG
=RhU6
-----END PGP SIGNATURE-----

------enig2DSISEJNKPXCBBBQUSLCT--
