From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 11:45:07 +0000
Subject: Re: [PATCH V2] video: remove unnecessary platform_set_drvdata()
Message-Id: <51CAD443.8010701@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2FRURWTVJLWAAUNGGVREK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <000101ce7147$28bd62c0$7a382840$@samsung.com>
In-Reply-To: <000101ce7147$28bd62c0$7a382840$@samsung.com>
To: linux-fbdev@vger.kernel.org

------enig2FRURWTVJLWAAUNGGVREK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/13 04:56, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdec=
b4d
> (device-core: Ensure drvdata =3D NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL=
=2E
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

I've added this to my fbdev-3.11 branch.

 Tomi



------enig2FRURWTVJLWAAUNGGVREK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRytRDAAoJEPo9qoy8lh71hEcP/3FnddITNNtePMp54iHKFtrQ
ZVj3yzo/VT91RWsM7jpohGuGot1v0BC+/HC8lQfZlRwaghp5CsdvoATQF1LVmP53
j+9QrtTmO0HvNO/HdUg22DuUA5uaa0cJfhEcXcv4cHuQup9jQK3hqq1NmGtDJEeq
BGzAk/dLt10AWegwo4ZWyKy7LhDwXl5i+7aQfujfPIaMeb2hYv44Ycv/sj8h/R8Y
tG0rDL6hwuRbhDHutROfYIabM302SIer3pofvC4ipIKB30cZjoGWxnmhYDS6m0q1
CD6q4OTM8wJ1jA56B+wuI+50fU6gZh6kufHibI5iMmW2lFSKfCTqajS5vd3HlRk2
+AfPgqlL4BvOuSGXveseFLK3+xGiqSs1ooeB7oHXCGhkbzcRx8Pr5s50k8PzTbLT
sLDNtu/0fskj7NnxHfibxsvDZBmTgEReNWyfr7za8rW4/cAt8lt7QLWsPTYcqF7N
d7Z/Zv0omB2TGPXM7EQMAJ30ffYT1tVhY82TeRdw1TbKnJVKhuGO9NWgH5wi5wvd
G0tQ+VwmUKD4NQvZ6xLY9dPk+mewwT6E7bsdCRlRbuzNdrywDHAlYWgAsaYBqWpv
ZxrMQL6VK4KLrpCCwgI9f8xLwp3UXRyhJgG+ICLat3NRRywgJuWuSNDjCVEhxiCD
ApT/oWelvoFDgk8N7F9s
=iCEc
-----END PGP SIGNATURE-----

------enig2FRURWTVJLWAAUNGGVREK--
