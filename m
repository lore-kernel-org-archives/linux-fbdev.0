From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Wed, 10 Feb 2010 07:50:07 +0000
Subject: Re: [PATCH 1/3] imxfb: add support for i.MX25
Message-Id: <20100210075007.GA10185@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1265786237.git.baruch@tkos.co.il>
	<0bea69783cf8f6b04c64fed75f10c3dd3c567fb4.1265786237.git.baruch@tkos.co.il>
In-Reply-To: <0bea69783cf8f6b04c64fed75f10c3dd3c567fb4.1265786237.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi,

On Wed, Feb 10, 2010 at 09:25:18AM +0200, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/video/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 5a5c303..7ff9acc 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -402,7 +402,7 @@ config FB_SA1100
> =20
>  config FB_IMX
>  	tristate "Motorola i.MX LCD support"
> -	depends on FB && (ARCH_MX1 || ARCH_MX2)
> +	depends on FB && (ARCH_MX1 || ARCH_MX2 || ARCH_MX25)
Can we make this

	depends on FB && HAVE_FB_IMX

and let the archs select HAVE_FB_IMX?

And is "FB" really necessary?  The snipplet above is in an

	menuconfig FB
		...
	endmenu

block.  (And there are many other items depending explicitly on FB.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
