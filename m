From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 21 Nov 2013 05:10:53 +0000
Subject: Re: [PATCHv9][ 2/3] ARM: dts: cpuimx51 Add touchscreen support.
Message-Id: <20131121051053.GG18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
 <1383916659-9988-2-git-send-email-denis@eukrea.com>
In-Reply-To: <1383916659-9988-2-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 14:17 Fri 08 Nov     , Denis Carikli wrote:
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: devicetree@vger.kernel.org
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Lothar Wa=DFmann <LW@KARO-electronics.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric B=E9nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v8->v9:
> - Added Grant Likely in the Cc list.
> - Adapted to the removal of the pinctrl properties in the tsc2007 documen=
tation.
> - Fixed the gpios property (before, it was set to active high by error).
>=20
> ChangeLog v7->v8:
> - Added Shawn Guo in the cc list.
> ---
>  arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi b/arch/arm/boot=
/dts/imx51-eukrea-cpuimx51.dtsi
> index b22841a..b04c65b 100644
> --- a/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
> +++ b/arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
> @@ -42,11 +42,23 @@
>  		compatible =3D "nxp,pcf8563";
>  		reg =3D <0x51>;
>  	};
> +
> +	tsc2007: tsc2007@49 {
> +		compatible =3D "ti,tsc2007";
> +		reg =3D <0x49>;
> +		interrupt-parent =3D <&gpio4>;
> +		interrupts =3D <0x0 0x8>;
> +		gpios =3D <&gpio4 0 1>;
> +		ti,x-plate-ohms =3D <180>;
as explain on the binding drop this gpios this is an IRQ not a gpio

NACK

Best Regards,
J.
> +	};
>  };
> =20
>  &iomuxc {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_hog>;
> +
>  	imx51-eukrea {
> -		pinctrl_tsc2007_1: tsc2007grp-1 {
> +		pinctrl_hog: hoggrp {
>  			fsl,pins =3D <
>  				MX51_PAD_GPIO_NAND__GPIO_NAND 0x1f5
>  				MX51_PAD_NANDF_D8__GPIO4_0 0x1f5
> --=20
> 1.7.9.5
>=20
