From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 09 Dec 2016 11:39:30 +0000
Subject: Re: [PATCH 02/12] ARM: dts: imx6qdl: rename ipu client nodes
Message-Id: <1481283570.2520.17.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1481158673-15937-1-git-send-email-steve_longerbeam@mentor.com>
         <1481158673-15937-3-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1481158673-15937-3-git-send-email-steve_longerbeam-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Steve Longerbeam <steve_longerbeam-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

Hi Steve,

Am Mittwoch, den 07.12.2016, 16:57 -0800 schrieb Steve Longerbeam:
> To allow for IPU client devices that are composed of more than one
> port for input and output (SMFC and IC), change the nodes from being
> a single port node to nodes that can contain multiple ports. Rename
> the nodes to use the following format: "ipu<id>_<subunit>".

Don't do this. These are not IPU client device nodes, they are input and
output port nodes according to the of graph bindings, as described in
Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt.

They happen to match to the CSI0/1 and DI0/1 modules, but really what is
described here are the external connections of the IPU. The IPU
internals are not described in the device tree at all.

regards
Philipp

> The IPUv3 driver will then need to lookup the client nodes by name
> rather than by port id.
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> ---
>  arch/arm/boot/dts/imx6q.dtsi   | 12 ++++++------
>  arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index e9a5d0b..2b261ba 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -141,18 +141,18 @@
>  			clock-names = "bus", "di0", "di1";
>  			resets = <&src 4>;
>  
> -			ipu2_csi0: port@0 {
> +			ipu2_csi0: ipu2_csi@0 {
>  				reg = <0>;
>  			};
>  
> -			ipu2_csi1: port@1 {
> +			ipu2_csi1: ipu2_csi@1 {
>  				reg = <1>;
>  			};
>  
> -			ipu2_di0: port@2 {
> +			ipu2_di0: ipu2_di@0 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				reg = <2>;
> +				reg = <0>;
>  
>  				ipu2_di0_disp0: disp0-endpoint {
>  				};
> @@ -174,10 +174,10 @@
>  				};
>  			};
>  
> -			ipu2_di1: port@3 {
> +			ipu2_di1: ipu2_di@1 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				reg = <3>;
> +				reg = <1>;
>  
>  				ipu2_di1_hdmi: hdmi-endpoint {
>  					remote-endpoint = <&hdmi_mux_3>;
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index e01e5d5..2465187 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -1226,18 +1226,18 @@
>  			clock-names = "bus", "di0", "di1";
>  			resets = <&src 2>;
>  
> -			ipu1_csi0: port@0 {
> +			ipu1_csi0: ipu1_csi@0 {
>  				reg = <0>;
>  			};
>  
> -			ipu1_csi1: port@1 {
> +			ipu1_csi1: ipu1_csi@1 {
>  				reg = <1>;
>  			};
>  
> -			ipu1_di0: port@2 {
> +			ipu1_di0: ipu1_di@0 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				reg = <2>;
> +				reg = <0>;
>  
>  				ipu1_di0_disp0: disp0-endpoint {
>  				};
> @@ -1259,10 +1259,10 @@
>  				};
>  			};
>  
> -			ipu1_di1: port@3 {
> +			ipu1_di1: ipu1_di@1 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				reg = <3>;
> +				reg = <1>;
>  
>  				ipu1_di1_disp1: disp1-endpoint {
>  				};


