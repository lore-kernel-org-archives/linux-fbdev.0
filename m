From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Wed, 11 Feb 2015 18:02:53 +0000
Subject: Odp: [PATCH 3/4] fb_ddc: Allow I2C adapters without SCL read capability
Message-Id: <54db994ddb8657.74556624@wp.pl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Dnia Sobota, 7 Lutego 2015 21:53 Ondrej Zary <linux@rainbow-software.org> n=
apisa=B3(a)=20
> i2c-algo-bit allows I2C adapters without SCL read capability to work but
> fb_ddc_read fails to work on them.
>=20
> Fix fb_ddc_read to work with I2C adapters not capable of reading SCL.
>=20
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> ---
>  drivers/video/fbdev/core/fb_ddc.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fb_ddc.c b/drivers/video/fbdev/core=
/fb_ddc.c
> index 94322cc..22c694a 100644
> --- a/drivers/video/fbdev/core/fb_ddc.c
> +++ b/drivers/video/fbdev/core/fb_ddc.c
> @@ -69,10 +69,11 @@ unsigned char *fb_ddc_read(struct i2c_adapter *adapte=
r)
>  		algo_data->setscl(algo_data->data, 1);
>  		for (j =3D 0; j < 5; j++) {
>  			msleep(10);
> -			if (algo_data->getscl(algo_data->data))
> +			if (algo_data->getscl &&
> +			    algo_data->getscl(algo_data->data))
>  				break;
>  		}
> -		if (j =3D 5)
> +		if (algo_data->getscl && j =3D 5)
>  			continue;
> =20
>  		algo_data->setsda(algo_data->data, 0);
> @@ -91,7 +92,8 @@ unsigned char *fb_ddc_read(struct i2c_adapter *adapter)
>  		algo_data->setscl(algo_data->data, 1);
>  		for (j =3D 0; j < 10; j++) {
>  			msleep(10);
> -			if (algo_data->getscl(algo_data->data))
> +			if (algo_data->getscl &&
> +			    algo_data->getscl(algo_data->data))
>  				break;
>  		}
> =20
> --=20
> Ondrej Zary



