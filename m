From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 06 Dec 2013 07:05:25 +0000
Subject: Re: [PATCHv13][ 2/4] video: imxfb: Also add pwmr for the device tree.
Message-Id: <20131206070525.GV24559@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386258219-26437-1-git-send-email-denis@eukrea.com>
 <1386258219-26437-2-git-send-email-denis@eukrea.com>
In-Reply-To: <1386258219-26437-2-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 05, 2013 at 04:43:37PM +0100, Denis Carikli wrote:
> pwmr has to be set to get the imxfb backlight work,
> though pwmr was only configurable trough the platform data.
>=20
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree@vger.kernel.org
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Eric B=E9nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> ---
>  .../devicetree/bindings/video/fsl,imx-fb.txt       |    3 +++
>  drivers/video/imxfb.c                              |    2 ++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Doc=
umentation/devicetree/bindings/video/fsl,imx-fb.txt
> index 46da08d..ac457ae 100644
> --- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> @@ -17,6 +17,9 @@ Required nodes:
>  Optional properties:
>  - fsl,dmacr: DMA Control Register value. This is optional. By default, t=
he
>  	register is not modified as recommended by the datasheet.
> +- fsl,pwmr:  LCDC PWM Contrast Control Register value. That property is
> +	optional, but defining it is necessary to get the backlight working. If=
 that
> +	property is ommited, the register is zeroed.

Why isn't this implemented as a backlight driver? Static devicetree
provided values is very limiting.

Sascha

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
