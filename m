From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 17 Feb 2014 14:37:36 +0000
Subject: Re: [PATCH v2 4/4] video: mmp: add device tree support
Message-Id: <20140217143736.GC19308@e106331-lin.cambridge.arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com>
 <1389698184-28761-5-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1389698184-28761-5-git-send-email-zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhou Zhu <zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chao Xie <chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

On Tue, Jan 14, 2014 at 11:16:24AM +0000, Zhou Zhu wrote:
> add device tree support for mmp fb/controller
> the description of DT config is at
> Documentation/devicetree/bindings/fb/mmp-disp.txt
> 
> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> ---
>  Documentation/devicetree/bindings/fb/mmp-disp.txt |   60 ++++++++
>  drivers/video/mmp/fb/mmpfb.c                      |   73 ++++++----
>  drivers/video/mmp/hw/mmp_ctrl.c                   |  160 ++++++++++++++++-----
>  3 files changed, 235 insertions(+), 58 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt
> 
> diff --git a/Documentation/devicetree/bindings/fb/mmp-disp.txt b/Documentation/devicetree/bindings/fb/mmp-disp.txt
> new file mode 100644
> index 0000000..80702f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fb/mmp-disp.txt
> @@ -0,0 +1,60 @@
> +* Marvell MMP Display (MMP_DISP)
> +
> +To config mmp display, 3 parts are required to be set in dts:
> +1. mmp fb
> +Required properties:
> +- compatible: Should be "marvell,<soc>-fb".

Please list the precise values and when they should be used. It makes
searching for them _far_ easier.

> +- marvell,path: Should be the path this fb connecting to.

What type is this? The example implies a phandle.

What type of node does this point to?

It's not explained at this point and it's really unclear what this is.

> +- marvell,overlay-id: Should be the id of overlay this fb is on.
> +- marvell,dmafetch-id: Should be the dma fetch id this fb using.

Are these hardware properties?

Is there any documentation which could make this clearer?

> +- marvell,default-pixfmt: Should be the default pixel format when this fb is
> +turned on.

What format is this? The example is useless. If this is a standard
binding, please refer to the binding document.

> +
> +2. mmp controller
> +Required properties:
> +- compatible: Should be "marvell,<soc>-disp".

Please list the precise set of values.

> +- reg: Should be address and length of the register set for this controller.
> +- interrupts: Should be interrupt of this controller.

Just to check: the device only has on interrupt?

> +
> +Required sub-node:
> +- path:
> +Required properties in this sub-node:
> +-- marvell,overlay_num: Should be number of overlay this path has.

s/_/-/ in property names please.

num-overlays would be a clearer name.

> +-- marvell,output-type: Should be output-type settings
> +-- marvell,path-config: Should be path-config settings
> +-- marvell,link-config: Should be link-config settings
> +-- marvell,rbswap: Should be rbswap settings

These are completely opaque to me. Please describe what these are either
in place or in reference to standard bindings.

Is rbswap a boolean value?

[...]

> +       if (!path_np || of_property_read_u32(path_np, "marvell,overlay-num",
> +                               &path_info->output_type) ||
> +                       of_property_read_u32(path_np, "marvell,output-type",
> +                               &path_info->overlay_num)) {

These are reading into the wrong variables.

Cheers,
Mark.
