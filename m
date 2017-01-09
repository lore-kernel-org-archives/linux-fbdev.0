From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 09 Jan 2017 08:31:16 +0000
Subject: Re: [PATCH v3 2/2] backlight arcxcnn devicetree bindings for ArcticSand
Message-Id: <20170109083116.GA2155@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1483735714-5500-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1483735714-5500-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Olimpiu Dejeu <olimpiu@arcticsand.com>
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, jingoohan1@gmail.com, bdodge@arcticsand.com

On Fri, 06 Jan 2017, Olimpiu Dejeu wrote:

> backlight: Add devicetree bindings for the Arctic Sand backlight driver
> This patch provides devicetree bindings for the Arctic Sand
>     driver submitted in the previous patch
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> ---
>=20
> v2 =3D> v3:
> - Version updated to match other patch in set. No other changes.
> v1 =3D> v2:
> - Version updated to match other patch in set. No other changes.
>=20
>  .../bindings/leds/backlight/arcxcnn_bl.txt         | 31 ++++++++++++++++=
++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/arcx=
cnn_bl.txt
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.=
txt b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> new file mode 100644
> index 0000000..a7b6ff2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> @@ -0,0 +1,33 @@
> +Binding for ArcticSand arc2c0608 LED driver
> +
> +Required properties:
> +- compatible: should be "arc,arc2c0608"
> +- reg: slave address
> +
> +Optional properties:
> +- default-brightness: brightness value on boot, value from: 0-4095
> +- label: The name of the backlight device
> +			See Documentation/devicetree/bindings/leds/common.txt
> +- led-sources: List of enabled channels from 0 to 5.
> +			See Documentation/devicetree/bindings/leds/common.txt
> +
> +- arc,led-config-0: setting for register ILED_CONFIG_0
> +- arc,led-config-1: setting for register ILED_CONFIG_1
> +- arc,dim-freq: PWM mode frequence setting (bits [3:0] used)
> +- arc,comp-config: setting for register CONFIG_COMP
> +- arc,filter-config: setting for register FILTER_CONFIG
> +- arc,trim-config: setting for register IMAXTUNE

Nit: Don't you think this is easier to read?

Required properties:
- compatible:		should be "arc,arc2c0608"
- reg:			slave address

Optional properties:
- default-brightness:	brightness value on boot, value from: 0-4095
- label:		The name of the backlight device
			See Documentation/devicetree/bindings/leds/common.txt
- led-sources:		List of enabled channels from 0 to 5.
			See Documentation/devicetree/bindings/leds/common.txt

- arc,led-config-0:	setting for register ILED_CONFIG_0
- arc,led-config-1:	setting for register ILED_CONFIG_1
- arc,dim-freq:		PWM mode frequence setting (bits [3:0] used)
- arc,comp-config:	setting for register CONFIG_COMP
- arc,filter-config:	setting for register FILTER_CONFIG
- arc,trim-config:	setting for register IMAXTUNE

> +
> +Note: Optional properties not specified will default to values in IC EPR=
OM
> +
> +Example:
> +
> +arc2c0608@30 {
> +	compatible =3D "arc,arc2c0608";
> +	reg =3D <0x30>;
> +	default-brightness =3D <500>;
> +	label =3D "lcd-backlight";
> +	linux,default-trigger =3D "backlight";
> +	led-sources =3D <0 1 2 5>;
> +};
> +

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
