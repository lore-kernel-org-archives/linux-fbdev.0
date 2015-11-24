From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 24 Nov 2015 16:31:57 +0000
Subject: Re: [PATCH] backlight: tps65217_bl: Add MODULE_DEVICE_TABLE.
Message-Id: <20151124163157.GB12874@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447417148-733-1-git-send-email-enric.balletbo@collabora.com>
In-Reply-To: <1447417148-733-1-git-send-email-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 13 Nov 2015, Enric Balletbo i Serra wrote:

> The device table is required to load modules based on modaliases.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/video/backlight/tps65217_bl.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backli=
ght/tps65217_bl.c
> index 61d72bf..37a9731 100644
> --- a/drivers/video/backlight/tps65217_bl.c
> +++ b/drivers/video/backlight/tps65217_bl.c
> @@ -320,10 +320,21 @@ static int tps65217_bl_probe(struct platform_device=
 *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_OF
> +static const struct of_device_id tps65217_bl_of_match[] =3D {
> +	{ .compatible =3D "ti,tps65217-bl", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, tps65217_bl_of_match);
> +#endif
> +
>  static struct platform_driver tps65217_bl_driver =3D {
>  	.probe		=3D tps65217_bl_probe,
>  	.driver		=3D {
>  		.name	=3D "tps65217-bl",
> +#ifdef CONFIG_OF
> +		.of_match_table =3D tps65217_bl_of_match,
> +#endif

Please use of_match_ptr() instead.

>  	},
>  };
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
