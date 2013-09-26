From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 08:50:31 +0000
Subject: Re: [PATCH 1/6] video: udlfb: Use NULL instead of 0
Message-Id: <5243F557.8060500@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tMlD1K0qs3NPoeBNJj3gF5Fjt1wpJr93N"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380108594-19090-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380108594-19090-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--tMlD1K0qs3NPoeBNJj3gF5Fjt1wpJr93N
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/09/13 14:29, Sachin Kamat wrote:
> new_back is a pointer. Use NULL instead of 0.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Bernie Thompson <bernie@plugable.com>
> ---
>  drivers/video/udlfb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
> index d2e5bc3..025f14e 100644
> --- a/drivers/video/udlfb.c
> +++ b/drivers/video/udlfb.c
> @@ -1166,7 +1166,7 @@ static int dlfb_realloc_framebuffer(struct dlfb_d=
ata *dev, struct fb_info *info)
>  	int new_len;
>  	unsigned char *old_fb =3D info->screen_base;
>  	unsigned char *new_fb;
> -	unsigned char *new_back =3D 0;
> +	unsigned char *new_back =3D NULL;
> =20
>  	pr_warn("Reallocating framebuffer. Addresses will change!\n");
> =20
>=20

Thanks, queuing this series for 3.13.

 Tomi



--tMlD1K0qs3NPoeBNJj3gF5Fjt1wpJr93N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQ/VXAAoJEPo9qoy8lh71TH8P/13bCN7fi959d2ypuQaMVLmM
F5MJR+l+/pnEt+1GI+2dlKpksKsQNI8SLBIahjl2L1CYapWPnnYN2a1MeOvwujTJ
VcgSI38dhoDMiSQNKsDvS9GTUI6T1tsbsW+DYBLHvovz9BsWVC3EVLIXR1UV+MyN
rwic76NebfM3/HiMaRYISzeYW/Zwl2O6CbxT0CWF4KOUKMDsQTKOIE99SB5YjeIz
xZAUcXMrqNjUBwsJvLNALPjtumONZCzKOCT0bt1Bgn2U++lmsQ7pInesy1X54Ez3
U38LPJAEu9+5CTk1aQt1Rwyu/EYkw0LVP4ikLg3ob/ViYlT+hkUK4UWDH+NqzWPE
7R5CeI9a87b06oohsPV/QcVJgRs+Dvrt0k7BIyIkfPAbYbdUWBMmawmfwlA1JyU+
6j5q52WRFidqmyIkxF2rPFJnnFPeJ6CiX/o3H/auNhZaa0iXHZkGSJM8POrgeH7L
zCrMfekrIjDyNc7L16i4JwRH7JTB+v7oMdn7wTdWiKGgxeY+CiiZdgORsYEF3w3r
iEHa2bKOm20hnpEk/bIJYCvciwSD5a5yNeYEVZK2YO2ekUSbML0HX1EY1IgFJ4AR
/3zbOnzounCXrOGhHxeJAdcfXpns2tBY5KAfGxYUkXCDl0yebi3tOnd7SJgS5h7l
rbzO7L7cv4VodHa7Y0IR
=XqqS
-----END PGP SIGNATURE-----

--tMlD1K0qs3NPoeBNJj3gF5Fjt1wpJr93N--
