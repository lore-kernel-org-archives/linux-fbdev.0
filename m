From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 21 Jan 2015 16:18:13 +0000
Subject: Re: [PATCH] backlight: da9052_bl: terminate da9052_wled_ids array with empty element
Message-Id: <20150121161813.GF22024@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421852768-29622-1-git-send-email-a.ryabinin@samsung.com>
In-Reply-To: <1421852768-29622-1-git-send-email-a.ryabinin@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Andrey Ryabinin <a.ryabinin@samsung.com>
Cc: linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

On Wed, 21 Jan 2015, Andrey Ryabinin wrote:

> Array of platform_device_id elements should be terminated
> with empty element.
>=20
> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
> ---
>  drivers/video/backlight/da9052_bl.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

> diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backligh=
t/da9052_bl.c
> index d4bd74bd..b1943e7 100644
> --- a/drivers/video/backlight/da9052_bl.c
> +++ b/drivers/video/backlight/da9052_bl.c
> @@ -165,6 +165,7 @@ static struct platform_device_id da9052_wled_ids[] =
=3D {
>  		.name		=3D "da9052-wled3",
>  		.driver_data	=3D DA9052_TYPE_WLED3,
>  	},
> +	{ },
>  };
> =20
>  static struct platform_driver da9052_wled_driver =3D {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
