From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Oct 2013 08:48:33 +0000
Subject: Re: [PATCH 1/3] video: ssd1307fb: Remove redundant of_match_ptr
Message-Id: <52551861.1090208@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rjmkNAtkrnAVHaJCnqfJF9SgID6voNNPO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380530733-9070-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380530733-9070-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--rjmkNAtkrnAVHaJCnqfJF9SgID6voNNPO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/09/13 11:45, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/video/ssd1307fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/ssd1307fb.c b/drivers/video/ssd1307fb.c
> index 44967c8..f4daa59 100644
> --- a/drivers/video/ssd1307fb.c
> +++ b/drivers/video/ssd1307fb.c
> @@ -569,7 +569,7 @@ static struct i2c_driver ssd1307fb_driver =3D {
>  	.id_table =3D ssd1307fb_i2c_id,
>  	.driver =3D {
>  		.name =3D "ssd1307fb",
> -		.of_match_table =3D of_match_ptr(ssd1307fb_of_match),
> +		.of_match_table =3D ssd1307fb_of_match,
>  		.owner =3D THIS_MODULE,
>  	},
>  };
>=20

Thanks, queuing this series for 3.13.

 Tomi



--rjmkNAtkrnAVHaJCnqfJF9SgID6voNNPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVRhhAAoJEPo9qoy8lh71fLkQAK/2uX/GxC0uFpbwOMXXXZ5i
Gw3CesWjdGhBg0dQP+N3jPOnGtlXj6nT8PaNc7ABHg1AqUM5lPhUOPsxKbcoT5mY
/R+ivrIh7dfEyTO+J7ZinsMnNoul//2SlZyB5RuJhwWhErtAClQxk+JCmZiUZGh4
Rx0a9rJEOPP9HWMRIy+6ZqWQjADdpvBb72oRHVxEMWLUfxBS6CCbSXV6MT/SP0l4
Qy9crSDVAOJpMxRVQv0CcSETrVG21FpRFC9fnpClVa2Fro+E9WLk6zfMVavuzws1
JZsDqIfXffU1O7Zn/8kYB2WdoI14xAWHOcVUZSn2flPUQ7+3ItOhf8V4owUvrsg/
br//oDaAA7iOe4vm3D/hRWQZuc/n+DxAhPlRulL5Q4AjHb9mS/ZgTHXqik6c0+ec
Kk2uMzLyPfMuCX4kNtS5NdxcCPGyUqUmGJymDgaF9VttC4eF9lK/Wl4VXuxkG/yu
vqqJf55v/Ez+wg1Hty8Rt7Kirr8C5dm9MKPjNAKnyV3KDS0+Re0MlEicDSGxfTr+
KfTLJm9XAihQypYKvz2HtcUMVzqr5LkQwX9apYdtzjjZAk10QI8NngjB+p7ZDROh
04mWR/B0dxp4N6xLfYCn3twcR6EZM8GJyZudG+mdTjwGBtbhR1zCMKbBd+MfYsCd
IYPOJ5Jo9/l0CE7bJ2QS
=ZXy/
-----END PGP SIGNATURE-----

--rjmkNAtkrnAVHaJCnqfJF9SgID6voNNPO--
