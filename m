From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Sep 2013 10:37:34 +0000
Subject: Re: [PATCH v2] video/matrox/matroxfb_maven: Use module_i2c_driver to register driver
Message-Id: <5236DF6E.4060707@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Dm9uQscrqLNPF0tom01a0RxjmFbqonNpC"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130913215150.16089f46@endymion.delvare>
In-Reply-To: <20130913215150.16089f46@endymion.delvare>
To: linux-fbdev@vger.kernel.org

--Dm9uQscrqLNPF0tom01a0RxjmFbqonNpC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/09/13 22:51, Jean Delvare wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
>=20
> Removing some boilerplate by using module_i2c_driver instead of calling=

> register and unregister in the otherwise empty init/exit functions.
> Also removed a useless comment as suggested by Jean Delvare.
>=20
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> Looks like this patch got lost so I am resending it.
>=20

Thanks, applying for 3.13.

 Tomi




--Dm9uQscrqLNPF0tom01a0RxjmFbqonNpC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNt9uAAoJEPo9qoy8lh71ul8QAJt16lvy8ITC6meL1b1yHWLX
EdvfT90V5qFjNeo6XL+earhZN0Vy6MlPIwZrLz66uA8XSDU2qXpvfiVYDVKXV/kp
GCjJwYHDqdLej59NtWtLqzvjZhgd0q8dut1q9NRyAu2LmraF75yfCF8fA8Q2ImIn
2zl6sWh2fPyuhQTR99FGcAmmRH4OvEK9FPEjF/VGRQCqc5ov6I0VCk3hBr7pkX4k
zd0u3fddkR5iAl4R/cnXMIncezMrUaVH7O8ptC7cxwQhjwfwLh6HCgfNqyCUbLA2
nUBvtQRRTCAjiOcGABmDMZOhShm1x+gnlKwXCzZ7gGzBCPkq0FeK1x2mbGm84Buu
U1hlK1HzpeREWkN/miie2q9j/Uyz1VTPzN3iq8rEt8XLhfJEdr5M85okeib3bMHH
WRZ4TQMQxUGnR/AKlHajgoo7lkXixqqwcxJbWEIZxJGOm3SCJsTOGzMYLFIRkbDN
xn+oIQXC+A9QSv+2mAAoqo6PjARfx+hHUdlqNDdBThS7kJy8psXo5wr/CXy/CPIy
5XyNbO4cxOJZVQ4PpR+KKyMnhTBB6Yw0GqqVotK8E8l2xfsY73jIMXrBwvGO6b9B
wnC6PmwSLcT1M91CsY/yXg8gLHLPpW+p+bDpXWCf7uAztZXZ0wFLoTwRL4tS5dTY
SPjnaqXajpM+Ad2E15g8
=Wlp7
-----END PGP SIGNATURE-----

--Dm9uQscrqLNPF0tom01a0RxjmFbqonNpC--
