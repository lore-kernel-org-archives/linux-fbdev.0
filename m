From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Dec 2015 16:10:04 +0000
Subject: Re: [PATCH] fbdev: auo_k190x: avoid unused function warnings
Message-Id: <5665AF5C.4060801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MkFllKAJtiJ2o5M61QwqIu6hSWFBrt0St"
List-Id: <linux-fbdev.vger.kernel.org>
References: <3917686.rD8ezhD468@wuerfel>
In-Reply-To: <3917686.rD8ezhD468@wuerfel>
To: linux-arm-kernel@lists.infradead.org

--MkFllKAJtiJ2o5M61QwqIu6hSWFBrt0St
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 20/11/15 23:47, Arnd Bergmann wrote:
> The auo_k190x framebuffer driver encloses the power-management
> functions in #ifdef CONFIG_PM, but the auok190x_suspend/resume
> functions are only really used when CONFIG_PM_SLEEP is also
> set, as a frequent gcc warning shows:
>=20
> drivers/video/fbdev/auo_k190x.c:859:12: warning: 'auok190x_suspend' def=
ined but not used
> drivers/video/fbdev/auo_k190x.c:899:12: warning: 'auok190x_resume' defi=
ned but not used
>=20
> This changes the driver to remove the #ifdef and instead mark
> the functions as __maybe_unused, which is a nicer anyway, as it
> provides build testing for all the code in all configurations
> and is harder to get wrong.

Applied for 4.5.

Btw, do you know if the linker will optimize the __maybe_unused funcs
away if they are not used? I presume so.

 Tomi


--MkFllKAJtiJ2o5M61QwqIu6hSWFBrt0St
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZa9cAAoJEPo9qoy8lh71rooP/19NwCUejjMhIYSQ0PHxl2NK
ArOu/sfHi87wNrRWv3l2KsdJrsqRyuzGJxYtdiMMY0Oj41w2rdQH4Zs1LtZE1cug
P9bG64mtOCoKYEMdPy2kDJ8LDx3kHU8MAOZ1W0ZMEiqvtN3dWmkV+EMzCZotmGS1
xVxgYrrQHSOpr0KIs57jC26rlxI9JXRd33pSDqSrbxJR/JmQgnB/QdBloeIveSo6
ekas03CXO3VPhhmUJKG41AMLUdZ9yjitkumyNaE8CmxgwYr+IdZMihKN8HdWV14g
mGX4BprOpq7KWTLCA/GnTNIaQ3iOAS4Kp5107JHvixNQtQpM/KH189ZiErws0sFp
knadKOxvmP7ZZ4CN4OEhY0rNtlxUAxFqzSrScH1WpPwmFy/NkbeNkiAZjkBJ1Fdy
6FPmX1vZIRoXEksAbcEq9hvndv02bGVtI6krZbFN5Gr6WGS2IEhT/p52GQ8rMAlL
odijuTDNQTgsEerH4F7oc1xHy0gdQH2H0l8Y8/mB7sm+UZ5MAnMlQDsVeY+HJPeY
MOeSOYt2DgzTpk7TmFXJxlWOHjwOiiOKbee8E5OHDIIDQqoKZPwtnxzek0dJZ5UZ
n8qhdyLwJjfhXlNIwWpTjO/WBhVQMbDZqzasltYVPiCedXfqtmAqSt2GBUbEzmn2
JV/C7E5czbPzf03r7GgO
=81Pj
-----END PGP SIGNATURE-----

--MkFllKAJtiJ2o5M61QwqIu6hSWFBrt0St--
