From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 08:33:15 +0000
Subject: Re: [PATCH 18/23] video: da8xx-fb: invoke platform callback safely
Message-Id: <51CAA74B.3090602@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2ENGFJABASXBDXJGANCWN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170171-9561-19-git-send-email-detheridge@ti.com>
In-Reply-To: <1372170171-9561-19-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

------enig2ENGFJABASXBDXJGANCWN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/13 17:22, Darren Etheridge wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> Ensure that platform data is present before checking whether platform
> callback is present (the one used to control backlight). So far this
> was not an issue as driver was purely non-DT triggered, but now DT
> support has been added.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> ---
>  drivers/video/da8xx-fb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 08ee8eb..0beed20 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -1347,7 +1347,7 @@ static int fb_probe(struct platform_device *devic=
e)
>  	par->dev =3D &device->dev;
>  	par->lcdc_clk =3D fb_clk;
>  	par->lcd_fck_rate =3D clk_get_rate(fb_clk);
> -	if (fb_pdata->panel_power_ctrl) {
> +	if (fb_pdata && fb_pdata->panel_power_ctrl) {
>  		par->panel_power_ctrl =3D fb_pdata->panel_power_ctrl;
>  		par->panel_power_ctrl(1);
>  	}
>=20

This patch (and others too in case there are other "fix something to
make DT possible" patches) should be in the series before adding the
actual DT support.

 Tomi



------enig2ENGFJABASXBDXJGANCWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyqdLAAoJEPo9qoy8lh71SxoQAJ8EYUWO3I7xLDroidjqGNXf
EW15wncF/au7tX14lXwzynn7zQiYOEGvBQEpf1lsZdZP07rsPhRdHNpqvcTRsW7Y
XIGtgi95iVUblImn57dmmC9ddKA4tAha2/1+KclksVG+JtcWnJQvaI+bHvsph+EY
XeaGFAwJ1VXI9y1RWEJeSzoMjPF8zdsxqAOfN7UIb5IfrnYlIyV1OcAvBJSdc6U1
3MbgynS4nHE7YhNDsGliv7z6P+d4AUlt+gQ919xYykyau8m3lA87MUjMoMQaczDe
zsfn6o3HzKIM2ugJi3iFh+RbaELOLtxgeh8exxA2ISDOGp/zj4RlzCeX7jR5Kf2S
AFWFqHG1e6R0/c5Q4KWEkR4ndViu26gkYHt6suPWd8s2rJkKr/O9A8D4qK6WHfTE
bN8fJBjfcgck81mMf0ZN7+PyfD/0xX+xmfYBeCdkSHFRcupD17+V3IG7Puz+OtbI
KDn9gh4VZRDbBoAqfWv9ifMG/mn6ew9c2aWgsRGzOSceCp6IAo/XrL3XQhtFu/nT
J3Yut1nbl66WLzjz3RfWB1IJzo3Z1EDKm8J3MMeSs2J8Sxa99PrIT9HxFX97oO+u
S+BYSsdLdLG7O5bBBeXxZYozOAG80uUa9X7azMjOxmRW0OkTiV5puZZwXRZuXG1l
wPVS4FftnIBeou0ARoHh
=qVVM
-----END PGP SIGNATURE-----

------enig2ENGFJABASXBDXJGANCWN--
