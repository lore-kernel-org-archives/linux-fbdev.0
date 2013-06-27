From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 27 Jun 2013 08:48:19 +0000
Subject: Re: [PATCH 1/1] video: i740fb: Make i740fb_init static
Message-Id: <51CBFC53.3090708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2LTSUXRENPAGTDRMGDCGO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372317317-4649-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1372317317-4649-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

------enig2LTSUXRENPAGTDRMGDCGO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27/06/13 10:15, Sachin Kamat wrote:
> i740fb_init is referenced only in this function. Make it static.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Ondrej Zary <linux@rainbow-software.org>
> ---
>  drivers/video/i740fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
> index cfd0c52e..6c48388 100644
> --- a/drivers/video/i740fb.c
> +++ b/drivers/video/i740fb.c
> @@ -1302,7 +1302,7 @@ static int  __init i740fb_setup(char *options)
>  }
>  #endif
> =20
> -int __init i740fb_init(void)
> +static int __init i740fb_init(void)
>  {
>  #ifndef MODULE
>  	char *option =3D NULL;
>=20

Thanks, applied to fbdev-3.11 branch.

 Tomi



------enig2LTSUXRENPAGTDRMGDCGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRy/xTAAoJEPo9qoy8lh71q7UP/2gfn/7ztnDokRVXx/BjT/pb
ZjKjXp4hMoHTdyUTDLKmdcS0LblOGN0Q35BuVYt2BDwFOvEGeR0HMLKrpnnjGYN4
6b3s7vMOmGbhfemPPqH7Bq+QxvXMYQz4nR1SzlSC7ytR9hXsiDXyxXg7vMFndRNE
+Lwliwgc0+V07DZVoKYp68nvH082dK1GN9S0Mo/Ul+2BEq/CZ4Xp0bW2bEwYNom1
sEXH5Go7pZ/PObAPcHfdkU2iSs/GmQx3EKIipIY9I+DKGFjiBBvTOBT5OXdQUSTx
EGUncoaw18GNZn4f+SaiIc3r4hkTBZ+nmXDozz4UryCeurYWK+A3k89tdrO578j0
/EzAM1NtN1BYdlgwbBjFJCpzkpFXxv4gPsXInjPGMSw3HYSVg1hP+hvN00VDk+xA
lNY3wspG1YDd/QO5Pz69G3f2VS03+gX2zSEz3YojeRJy2xXN3t98DFC9qhqJiPJL
h9LfKeIjlEVaYbgA3IZR3ed71NZHGHALBMgkrcUxTEJKHJXSHvuA+kC6NSScXqNv
bezP8et7iE6UiSqus1soTKu3IhX0NF1ldLBv8yt06Au3l/BEtrb67OyI+d3eSSJA
W8EBJ9pvD52SeQvTgLjC7qDbMKouHqn14PabBQ+PEQK/hThHDzUvtTnnazImaoNz
qgcWX4qcUYLryXUopDkZ
=Fi1S
-----END PGP SIGNATURE-----

------enig2LTSUXRENPAGTDRMGDCGO--
