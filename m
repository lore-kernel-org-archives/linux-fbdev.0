From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 05 May 2015 08:27:54 +0000
Subject: Re: [PATCH 1/4] video: backlight: da9052: Constify platform_device_id
Message-Id: <20150505082754.GU4047@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
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
>  drivers/video/backlight/da9052_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backligh=
t/da9052_bl.c
> index b1943e7735a1..fd2be417aa64 100644
> --- a/drivers/video/backlight/da9052_bl.c
> +++ b/drivers/video/backlight/da9052_bl.c
> @@ -152,7 +152,7 @@ static int da9052_backlight_remove(struct platform_de=
vice *pdev)
>  	return 0;
>  }
> =20
> -static struct platform_device_id da9052_wled_ids[] =3D {
> +static const struct platform_device_id da9052_wled_ids[] =3D {
>  	{
>  		.name		=3D "da9052-wled1",
>  		.driver_data	=3D DA9052_TYPE_WLED1,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
