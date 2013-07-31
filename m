From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 31 Jul 2013 09:33:03 +0000
Subject: Re: [PATCH v2 21/24] video: da8xx-fb: setup struct lcd_ctrl_config for dt
Message-Id: <51F8D9CF.8020004@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XexuDIcixnJ3bmC7W4u0NvdkOicGn67wx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375208791-15781-22-git-send-email-detheridge@ti.com>
In-Reply-To: <1375208791-15781-22-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

--XexuDIcixnJ3bmC7W4u0NvdkOicGn67wx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/07/13 21:26, Darren Etheridge wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> strcut lcd_ctrl_config information required for driver is currently
> obtained via platform data. To handle DT probing, create
> lcd_ctrl_config and populate it with default values, these values are
> sufficient for the panels so far used with this controller to work.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> ---
>  drivers/video/da8xx-fb.c |   34 +++++++++++++++++++++++++++++++++-
>  1 files changed, 33 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 697b07c..fe3d79e 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c

<snip>

>  static struct fb_videomode *da8xx_fb_get_videomode(struct platform_dev=
ice *dev)
>  {
>  	struct da8xx_lcdc_platform_data *fb_pdata =3D dev->dev.platform_data;=

> @@ -1346,7 +1375,10 @@ static int fb_probe(struct platform_device *devi=
ce)
>  		break;
>  	}
> =20
> -	lcd_cfg =3D (struct lcd_ctrl_config *)fb_pdata->controller_data;

In the previous patch you allow fb_pdata=3D=3DNULL if booting with DT.
However, this patch shows that fb_pdata is still accessed. So I think
you need to move the previous patch after this to avoid a crash between
this and the previous patch.

> +	if (device->dev.of_node)
> +		lcd_cfg =3D da8xx_fb_create_cfg(device);
> +	else
> +		lcd_cfg =3D (struct lcd_ctrl_config *)fb_pdata->controller_data;

fb_pdata->controller_data is void *, so you don't need to cast it
explicitly.

 Tomi



--XexuDIcixnJ3bmC7W4u0NvdkOicGn67wx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+NnTAAoJEPo9qoy8lh71DecP/3mabHtSh87534Y/tD4Xa1z1
e4fwYV2Wdga2vDJSt/TIrXKSjuhHk8YFuBze0wfmdsOnLMJM59rCwR1vTiKodkBl
qk70DOtv+mhfVnJ0RW0wvNO+uRfKnE8jwIUaV9KzrWNRQs12MdEnVoWFJSg720rJ
mKLNAQT0aVrK7+I0Tbs9WDbO+wdb1uGnUUqc4sTEbgw2jiTYzgAea1z6cLXys5K7
n71eGoDqUWKFPFmZlhXPHYowWO362m/pdnJ9XG9MgnI5vRWlRwwGewbzqPPRbHzr
3CI/4gmyZ12qSFFG7B09tct4TtdI5x+fCljHjVxE/r9FgLcYEGROIa8AhG8rK7tx
jLF1tGr+4rHQg+Ou5pRHbZJ3CUEa+Szs7ozucu3ds5T+YqVJIEduuaMkRT7ztgVQ
a2AiosLkrYzW+KmScDoq8vyDBDlKirtbuStubGfnYRCAMfM9n0fm491+VhwMbhTb
e1ryS8t4bKZpfM+oyGgRT0G3bipzSdqbyS3rNiBV++DuNOau7RuS7Eg8QX7uybnM
fb7kWCa6DdcGfG0GWem3mONBnVUfJyV9aVltBg+B3wJ0YA/XONjindeXIB2O/ftp
6dPSfo8WehNbZt2LNoMvV4auahBbVfQ4tY/m2JbQrTuOOTEnrQmOD68zUBUat0E/
rg5gfRcdw6h7ci8PWJvg
=d9PT
-----END PGP SIGNATURE-----

--XexuDIcixnJ3bmC7W4u0NvdkOicGn67wx--
