From: Rob Herring <robh@kernel.org>
Date: Mon, 31 Oct 2016 04:37:59 +0000
Subject: Re: [PATCH 2/2] backlight: arcxcnn: devicetree bindings for ArticSand devices
Message-Id: <20161031043759.s5gmht6obqsqdn2d@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1477513801-31350-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1477513801-31350-1-git-send-email-olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org

On Wed, Oct 26, 2016 at 04:30:01PM -0400, Olimpiu Dejeu wrote:
> Resubmition of arcxcnn backliught driver bindings with added register
>  documentation
> 
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> 
> ---
>  .../bindings/leds/backlight/arcxcnn_bl.txt         | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> new file mode 100644
> index 0000000..a7b6ff2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> @@ -0,0 +1,31 @@
> +Binding for ArcticSand arc2c0608 LED driver
> +
> +Required properties:
> +- compatible: should be "arc,arc2c0608"

What's the correct vendor prefix? arc or arcticsand used below?

> +- reg: slave address
> +
> +Optional properties:
> +- default-brightness: brightness value on boot, value from: 0-4095
> +- label: The name of the backlight device
> +			See Documentation/devicetree/bindings/leds/common.txt
> +- led-sources: List of enabled channels from 0 to 5.
> +			See Documentation/devicetree/bindings/leds/common.txt
> +
> +- arcticsand,led-config-0: setting for register ILED_CONFIG_0
> +- arcticsand,led-config-1: setting for register ILED_CONFIG_1
> +- arcticsand,dim-freq: PWM mode frequence setting (bits [3:0] used)
> +- arcticsand,comp-config: setting for register CONFIG_COMP
> +- arcticsand,filter-config: setting for register FILTER_CONFIG
> +- arcticsand,trim-config: setting for register IMAXTUNE

What are the default values if not present?

What determines these settings? If the board design, then okay. If a 
an enduser wants to adjust, then they shouldn't be in DT.

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
> 
