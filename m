From: Lee Jones <lee.jones@linaro.org>
Date: Sun, 20 Sep 2015 04:20:25 +0000
Subject: Re: [PATCH 1/2] backlight: adp8860: Remove unnecessary MODULE_ALIAS()
Message-Id: <20150920042025.GY3039@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440970465-11651-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1440970465-11651-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Sun, 30 Aug 2015, Javier Martinez Canillas wrote:

> The driver has a I2C device id table that is used to create the modaliases
> and also "adp8860-backlight" is not a supported I2C id, so it's never use=
d.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> ---
>=20
>  drivers/video/backlight/adp8860_bl.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlig=
ht/adp8860_bl.c
> index 71147f4461b8..98ffe71e8af2 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -819,4 +819,3 @@ module_i2c_driver(adp8860_driver);
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
>  MODULE_DESCRIPTION("ADP8860 Backlight driver");
> -MODULE_ALIAS("i2c:adp8860-backlight");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
