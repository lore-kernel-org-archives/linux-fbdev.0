From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 08 Jan 2014 13:43:20 +0000
Subject: Re: [PATCH] video: vgacon: Don't build on arm64
Message-Id: <52CD55F8.8080707@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NFRh1sTv3MIDBrTbTNbpNIrjMdcwlbDVr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387323421-26126-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1387323421-26126-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org

--NFRh1sTv3MIDBrTbTNbpNIrjMdcwlbDVr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-18 01:37, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>=20
> arm64 is unlikely to have a VGA console and does not export screen_info=

> causing build failures if the driver is build, for example in all*confi=
g.
> Add a dependency on !ARM64 to prevent this.
>=20
> This list is getting quite long, it may be easier to depend on a symbol=

> which architectures that do support the driver can select.

I agree, that depends on looks horrible =3D).

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/video/console/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kcon=
fig
> index 846caab75a46..c39d6c42c3ef 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -8,7 +8,8 @@ config VGA_CONSOLE
>  	bool "VGA text console" if EXPERT || !X86
>  	depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && \
>  		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
> -		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER)
> +		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) \
> +		&& !ARM64
>  	default y
>  	help
>  	  Saying Y here will allow you to use Linux in text mode through a

I moved the && to the previous line as is the custom. Queued for 3.14.

 Tomi



--NFRh1sTv3MIDBrTbTNbpNIrjMdcwlbDVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzVX4AAoJEPo9qoy8lh71E7AP/Rvbsj1AnoSQIpbRTSOXf8pj
TYY063qWFPKus1Cdgfvh4RQApYne8s6X7QO2o+UGAZHsNatGdSebmG1suIJuc+Ub
68g9naoTBo0waqYtUzJY8C7bMfotkV2OnqbEz1EMnMw6JD9veIxuN42yaYmRZ+PT
KKHgabi2a9rNsMcloXz/Z91QPnvkooNhl4F63zIOPseXoXtkLjXQl3m0cbqzL+7T
l+dDLb6npBFIIR69p6OjIiYQe8EI2B7TBlhGF0yzk0VHzYNwA0MkYKe2KUwGNzYT
dQ+UpztxBxdS4qkw9RiVFCLepq6h+KEaCL71Q+D9X9VgiH1avNH0UC3OG4NG0lCb
G/Ott8zdMJt6VQvibqM8on/5JTVFp09fz0Z0uI7W0DtEDXTVWFqZ2sT+fbCQs7Ek
n/SzGceKzMX7dmuN8CWbjPp0SeTd2kmMf5VUOCVTEp1fDSA+P9BXxOd3x2Ri8TrA
O+oryKHXRn9goi8aPnIG77BYO1J8k2DVeeY0lHKxzx+ASqmSmT7zLq04NPcIo92n
/GzNhN5fdmRbe3eg2p+iy43v3R3GBklpK3HfFRJUPbUxXIWmg1zvB03L6Q2OeQIC
jKi7L2IWI2B7mLYkkDkWn0QR9H0UpZZM+XoUI006DvYke8WIj7auUqVL68+a4opn
kfgPGmHmtFwJUVusxbeD
=auTS
-----END PGP SIGNATURE-----

--NFRh1sTv3MIDBrTbTNbpNIrjMdcwlbDVr--
