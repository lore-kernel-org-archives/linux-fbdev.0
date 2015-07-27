From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon, 27 Jul 2015 15:49:44 +0000
Subject: Re: [PATCH] video: fbdev: atmel: fix warning for const return value
Message-Id: <55B65318.6070308@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438011701-18423-1-git-send-email-robh@kernel.org>
In-Reply-To: <1438011701-18423-1-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rob Herring <robh@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Le 27/07/2015 17:41, Rob Herring a =E9crit :
> A const on a return value is meaningless and generates a warning on some
> versions of gcc:
>=20
> drivers/video/fbdev/atmel_lcdfb.c:1003: warning: type qualifiers ignored =
on function return type
>=20
> This was found on 0-day with avr32 builds with CONFIG_OF enabled, but
> it doesn't seem to generate warnings for other arches.
>=20
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Sure:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks Rob!

> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/fbdev/atmel_lcdfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atme=
l_lcdfb.c
> index abadc49..66f4b70 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -999,7 +999,7 @@ static const char *atmel_lcdfb_wiring_modes[] =3D {
>  	[ATMEL_LCDC_WIRING_RGB]	=3D "RGB",
>  };
> =20
> -const int atmel_lcdfb_get_of_wiring_modes(struct device_node *np)
> +int atmel_lcdfb_get_of_wiring_modes(struct device_node *np)
>  {
>  	const char *mode;
>  	int err, i;
>=20


--=20
Nicolas Ferre
