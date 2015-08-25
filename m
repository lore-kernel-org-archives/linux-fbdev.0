From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 25 Aug 2015 07:32:49 +0000
Subject: Re: [RESEND PATCH 2/7] backlight: tosa: Export I2C module alias information
Message-Id: <20150825073249.GB19409@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440484277-32675-1-git-send-email-javier@osg.samsung.com>
 <1440484277-32675-3-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1440484277-32675-3-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Tue, 25 Aug 2015, Javier Martinez Canillas wrote:

> The I2C core always reports the MODALIAS uevent as "i2c:<modalias>"
> regardless of the mechanism that was used to register the device
> (i.e: OF or board code) and the table that is used later to match
> the driver with the device (i.e: I2C id table or OF match table).
>=20
> So drivers needs to export the I2C id table and this be built into
> the module or udev won't have the necessary information to autoload
> the needed driver module when the device is added.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> ---
>=20
>  drivers/video/backlight/tosa_bl.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

> diff --git a/drivers/video/backlight/tosa_bl.c b/drivers/video/backlight/=
tosa_bl.c
> index 3ad676558c80..83742d806391 100644
> --- a/drivers/video/backlight/tosa_bl.c
> +++ b/drivers/video/backlight/tosa_bl.c
> @@ -158,6 +158,7 @@ static const struct i2c_device_id tosa_bl_id[] =3D {
>  	{ "tosa-bl", 0 },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(i2c, tosa_bl_id);
> =20
>  static struct i2c_driver tosa_bl_driver =3D {
>  	.driver =3D {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
