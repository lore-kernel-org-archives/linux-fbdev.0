From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 29 Sep 2016 19:21:12 +0000
Subject: Re: [PATCH 2/2] backlight: arcxcnn: devicetree bindings for ArticSand devices
Message-Id: <20160929191937.GA3405@remoulade>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1475166937-6299-1-git-send-email-olimpiu@arcticsand.com>
In-Reply-To: <1475166937-6299-1-git-send-email-olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org

On Thu, Sep 29, 2016 at 12:35:37PM -0400, Olimpiu Dejeu wrote:
> Resubmition of arcxcnn backliught driver bindings correcting the file 
>  location, device name, and proper use of reg for device address
> 
> Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
> 
> ---
>  .../bindings/leds/backlight/arcxcnn_bl.txt         | 30 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> new file mode 100644
> index 0000000..bcf5664
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> @@ -0,0 +1,30 @@
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
> +Example:
> +
> +arc2c0608@30 {
> +	compatible = "arc,arc2c0608";
> +	reg = <0x30>;
> +	default-brightness = <500>;
> +	label = "lcd-backlight";
> +	linux,default-trigger = "backlight";
> +	led-sources = <0 1 2 5>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	prog@6 {
> +		reg = <0x06>;
> +		val = <0x0F>;
> +	};

What is this prog@6 sub-node?

It isn't documented above, and its properties look incredibly suspicious --
this doesn't look right to me.

As a general note, please put binding patches earlier in the series than the
code implementing them, as per
Documentation/devicetree/bindings/submitting-patches.txt.

Thanks,
Mark.
