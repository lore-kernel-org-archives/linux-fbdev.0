From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 21 Nov 2013 05:09:22 +0000
Subject: Re: [PATCHv9][ 3/3] ARM: dts: cpuimx35 Add touchscreen support.
Message-Id: <20131121050922.GF18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
 <1383916659-9988-3-git-send-email-denis@eukrea.com>
In-Reply-To: <1383916659-9988-3-git-send-email-denis@eukrea.com>
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
> - Added Grant Likely in the cc list.
> - Adapted to the removal of the pinctrl properties in the tsc2007 documen=
tation.
> - Fixed the gpios property (before, it was set to active high by error).
>=20
> ChangeLog v7->v8:
> - Added Shawn Guo in the cc list.
> ---
>  arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi b/arch/arm/boot=
/dts/imx35-eukrea-cpuimx35.dtsi
> index b9cb5a5..f25a40f 100644
> --- a/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
> +++ b/arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
> @@ -36,6 +36,27 @@
>  		compatible =3D "nxp,pcf8563";
>  		reg =3D <0x51>;
>  	};
> +
> +	tsc2007: tsc2007@48 {
> +		compatible =3D "ti,tsc2007";
> +		reg =3D <0x48>;
> +		interrupt-parent =3D <&gpio3>;
> +		interrupts =3D <0x2 0x8>;
> +		gpios =3D <&gpio3 2 1>;
as explain on the binding drop this gpios this is an IRQ not a gpio

NACK

Best Regards,
J.
> +		ti,x-plate-ohms =3D <180>;
> +        };
> +
> +};
> +
> +&iomuxc {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_hog>;
> +
> +	imx35-eukrea {
> +		pinctrl_hog: hoggrp {
> +			fsl,pins =3D <MX35_PAD_ATA_DA2__GPIO3_2 0x80000000>;
> +		};
> +	};
>  };
> =20
>  &nfc {
> --=20
> 1.7.9.5
>=20
