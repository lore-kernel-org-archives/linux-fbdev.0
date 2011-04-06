From: Baruch Siach <baruch@tkos.co.il>
Date: Wed, 06 Apr 2011 17:31:51 +0000
Subject: Re: [PATCH] video: imx-fb: just depend on IMX_HAVE_PLATFORM_IMX_FB
Message-Id: <20110406173151.GA7592@nataf.siach.name>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Uwe,

On Wed, Apr 06, 2011 at 04:29:04PM +0200, Uwe Kleine-K=F6nig wrote:
> All machines having a imx-fb device now select IMX_HAVE_PLATFORM_IMX_FB,
> so HAVE_FB_IMX can go away and there is no need anymore to explicitly
> depend on ARCH_MX1 or ARCH_MX2.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---

Sascha has already sent a patch for this. See=20
http://article.gmane.org/gmane.linux.ports.arm.kernel/109067.

baruch

> Hello,
>=20
> should this go via Sascha's or Paul's tree?
>=20
> Best regards
> Uwe
>=20
>  arch/arm/plat-mxc/devices/Kconfig |    1 -
>  drivers/video/Kconfig             |    5 +----
>  2 files changed, 1 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/device=
s/Kconfig
> index b9ab1d5..e4dcf49 100644
> --- a/arch/arm/plat-mxc/devices/Kconfig
> +++ b/arch/arm/plat-mxc/devices/Kconfig
> @@ -24,7 +24,6 @@ config IMX_HAVE_PLATFORM_IMXDI_RTC
> =20
>  config IMX_HAVE_PLATFORM_IMX_FB
>  	bool
> -	select HAVE_FB_IMX
> =20
>  config IMX_HAVE_PLATFORM_IMX_I2C
>  	bool
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index e6a8d8c..62f337a 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -8,9 +8,6 @@ menu "Graphics support"
>  config HAVE_FB_ATMEL
>  	bool
> =20
> -config HAVE_FB_IMX
> -	bool
> -
>  config SH_MIPI_DSI
>  	tristate
>  	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
> @@ -359,7 +356,7 @@ config FB_SA1100
> =20
>  config FB_IMX
>  	tristate "Freescale i.MX LCD support"
> -	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
> +	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> --=20

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
