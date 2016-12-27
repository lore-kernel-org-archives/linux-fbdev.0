From: "Jingoo Han" <jingoohan1@gmail.com>
Date: Tue, 27 Dec 2016 18:39:13 +0000
Subject: Re: [PATCH V2 2/2] backlight arcxcnn devicetree bindings for ArcticSand
Message-Id: <002801d26070$85a3e4c0$90ebae40$@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1481298573-15463-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1481298573-15463-1-git-send-email-olimpiu@arcticsand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Olimpiu Dejeu' <olimpiu@arcticsand.com>, robh@kernel.org
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, bdodge@arcticsand.com

On Friday, December 9, 2016 10:50 AM, Olimpiu Dejeu wrote:
> 

Please add the commit message here.

Best regards,
Jingoo Han

> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> ---
> 
> v1 => v2:
> - Version updated to match other patch in set. No other changes.
> 
>  .../bindings/leds/backlight/arcxcnn_bl.txt         | 31
> ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
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
> +			See
Documentation/devicetree/bindings/leds/common.txt
> +- led-sources: List of enabled channels from 0 to 5.
> +			See
Documentation/devicetree/bindings/leds/common.txt
> +
> +- arc,led-config-0: setting for register ILED_CONFIG_0
> +- arc,led-config-1: setting for register ILED_CONFIG_1
> +- arc,dim-freq: PWM mode frequence setting (bits [3:0] used)
> +- arc,comp-config: setting for register CONFIG_COMP
> +- arc,filter-config: setting for register FILTER_CONFIG
> +- arc,trim-config: setting for register IMAXTUNE
> +
> +Note: Optional properties not specified will default to values in IC
> EPROM
> +
> +Example:
> +
> +arc2c0608@30 {
> +	compatible = "arc,arc2c0608";
> +	reg = <0x30>;
> +	default-brightness = <500>;
> +	label = "lcd-backlight";
> +	linux,default-trigger = "backlight";
> +	led-sources = <0 1 2 5>;
> +};
> +
> --
> 2.7.4


