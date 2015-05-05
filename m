From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 05 May 2015 08:28:35 +0000
Subject: Re: [PATCH 4/4] video: fbdev: s3c-fb: Constify platform_device_id
Message-Id: <20150505082835.GX4047@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430494721-30793-4-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430494721-30793-4-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Sat, 02 May 2015, Krzysztof Kozlowski wrote:

> The platform_device_id is not modified by the driver and core uses it as
> const.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/video/fbdev/s3c-fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
> index 7e3a05fc47aa..f72dd12456f9 100644
> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -1938,7 +1938,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s3c2443=
 =3D {
>  	},
>  };
> =20
> -static struct platform_device_id s3c_fb_driver_ids[] =3D {
> +static const struct platform_device_id s3c_fb_driver_ids[] =3D {
>  	{
>  		.name		=3D "s3c-fb",
>  		.driver_data	=3D (unsigned long)&s3c_fb_data_64xx,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
