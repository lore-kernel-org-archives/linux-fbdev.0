From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 06 Dec 2013 07:06:22 +0000
Subject: Re: [PATCHv13][ 3/4] video: Kconfig: Allow more broad selection of the imxfb framebuffer driver.
Message-Id: <20131206070622.GW24559@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386258219-26437-1-git-send-email-denis@eukrea.com>
 <1386258219-26437-3-git-send-email-denis@eukrea.com>
In-Reply-To: <1386258219-26437-3-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 05, 2013 at 04:43:38PM +0100, Denis Carikli wrote:
> Without that patch, a user can't select the imxfb driver when the i.MX25 =
and/or
>   the i.MX27 device tree board are selected and that no boards that selec=
ts
>   IMX_HAVE_PLATFORM_IMX_FB are compiled in.
>=20
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Eric B=E9nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>


Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> ChangeLog v10->v11:
> - moved my signed-off-by.
>=20
> ChangeLog v8->v9:
> - Added Jean-Christophe PLAGNIOL-VILLARD's ACK.
> ---
>  drivers/video/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 4f2e1b3..22adaee 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -363,7 +363,7 @@ config FB_SA1100
> =20
>  config FB_IMX
>  	tristate "Freescale i.MX1/21/25/27 LCD support"
> -	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
> +	depends on FB && ARCH_MXC
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> --=20
> 1.7.9.5
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
