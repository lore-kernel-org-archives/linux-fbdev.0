From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Sun, 09 Jan 2011 19:11:14 +0000
Subject: Re: [PATCH] video: imx: Update the manufacturer name
Message-Id: <20110109191114.GE8237@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294590818-5001-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1294590818-5001-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello Fabio,

On Sun, Jan 09, 2011 at 02:33:38PM -0200, Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/video/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 55dc6fb..0ac30ef 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -414,7 +414,7 @@ config FB_SA1100
>  	  Y here.
> =20
>  config FB_IMX
> -	tristate "Motorola i.MX LCD support"
> +	tristate "Freescale i.MX LCD support"
do you have an explanation why this is wrong?  Was it a copy&paste
error?  If it used to be correct I'd prefer to keep Motorola in there.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
