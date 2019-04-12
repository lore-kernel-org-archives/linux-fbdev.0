From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Fri, 12 Apr 2019 12:34:04 +0000
Subject: Re: [PATCH] video: fbdev: imxfb: add COMPILE_TEST support
Message-Id: <20190412123404.kuijityhkeayy7l3@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190412105954eucas1p1072c6d28d5c48499df3bc1b35bbe2ed8@eucas1p1.samsung.com>
 <57884bfc-efc3-371c-f99c-7fd2ed02f5fc@samsung.com>
In-Reply-To: <57884bfc-efc3-371c-f99c-7fd2ed02f5fc@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org

Hello,

On Fri, Apr 12, 2019 at 12:59:53PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to imxfb driver for better compile
> testing coverage.
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: b/drivers/video/fbdev/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/Kconfig	2019-04-12 1=
2:35:07.322174869 +0200
> +++ b/drivers/video/fbdev/Kconfig	2019-04-12 12:35:07.306174869 +0200
> @@ -334,7 +334,7 @@ config FB_SA1100
> =20
>  config FB_IMX
>  	tristate "Freescale i.MX1/21/25/27 LCD support"
> -	depends on FB && ARCH_MXC
> +	depends on FB && (ARCH_MXC || COMPILE_TEST)
>  	select BACKLIGHT_LCD_SUPPORT
>  	select LCD_CLASS_DEVICE
>  	select FB_CFB_FILLRECT

I think you need something like this instead:

	depends FB && HAVE_CLK && HAS_IOMEM
	depends ARCH_MXC || COMPILE_TEST

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
