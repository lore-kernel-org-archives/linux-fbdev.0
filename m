From: Donghwa Lee <dh09.lee@samsung.com>
Date: Tue, 14 Aug 2012 05:25:15 +0000
Subject: Re: [PATCH] video: exynos-mipi-dsi: Add missing static storage class specifiers
Message-Id: <5029E13B.9040606@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343888051-406-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343888051-406-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

This patch looks good to me.

Acked-by: Donghwa Lee <dh09.lee@samsung.com>

On Thursday, August 02, 2012=B3=E2 15:14, Sachin Kamat wrote:

> Fixes the following sparse warnings:
> drivers/video/exynos/exynos_mipi_dsi.c:208:22: warning:
> symbol 'exynos_mipi_dsi_find_lcd_device' was not declared. Should it be s=
tatic?
> drivers/video/exynos/exynos_mipi_dsi.c:268:22: warning:
> symbol 'exynos_mipi_dsi_bind_lcd_ddi' was not declared. Should it be stat=
ic?
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/exynos/exynos_mipi_dsi.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exyno=
s/exynos_mipi_dsi.c
> index 4bc2b8a..ef68228 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> @@ -205,7 +205,8 @@ int exynos_mipi_dsi_register_lcd_device(struct mipi_d=
sim_lcd_device *lcd_dev)
>  	return 0;
>  }
> =20
> -struct mipi_dsim_ddi *exynos_mipi_dsi_find_lcd_device(struct mipi_dsim_l=
cd_driver *lcd_drv)
> +static struct mipi_dsim_ddi *exynos_mipi_dsi_find_lcd_device(
> +					struct mipi_dsim_lcd_driver *lcd_drv)
>  {
>  	struct mipi_dsim_ddi *dsim_ddi, *next;
>  	struct mipi_dsim_lcd_device *lcd_dev;
> @@ -265,7 +266,8 @@ int exynos_mipi_dsi_register_lcd_driver(struct mipi_d=
sim_lcd_driver *lcd_drv)
> =20
>  }
> =20
> -struct mipi_dsim_ddi *exynos_mipi_dsi_bind_lcd_ddi(struct mipi_dsim_devi=
ce *dsim,
> +static struct mipi_dsim_ddi *exynos_mipi_dsi_bind_lcd_ddi(
> +						struct mipi_dsim_device *dsim,
>  						const char *name)
>  {
>  	struct mipi_dsim_ddi *dsim_ddi, *next;


