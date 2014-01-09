From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 09 Jan 2014 07:31:58 +0000
Subject: Re: [PATCH] video: mmp: add device tree support
Message-Id: <20140109073158.GM6750@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389244394-10779-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1389244394-10779-1-git-send-email-zzhu3@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jan 09, 2014 at 01:13:14PM +0800, Zhou Zhu wrote:
> add device tree support for mmp fb/controller
> the description at Documentation/devicetree/bindings/fb/mmp-disp.txt
> 
> Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
> ---
>  Documentation/devicetree/bindings/fb/mmp-disp.txt |   71 ++++++++++++
>  drivers/video/mmp/fb/mmpfb.c                      |   71 ++++++++----
>  drivers/video/mmp/hw/mmp_ctrl.c                   |  120 ++++++++++++++++-----
>  3 files changed, 217 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fb/mmp-disp.txt
> 
> diff --git a/Documentation/devicetree/bindings/fb/mmp-disp.txt b/Documentation/devicetree/bindings/fb/mmp-disp.txt
> new file mode 100644
> index 0000000..3cf2903
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fb/mmp-disp.txt
> @@ -0,0 +1,71 @@
> +* Marvell MMP Display (MMP_DISP)
> +
> +To config mmp display, 3 parts are required to be set in dts:
> +1. mmp fb
> +Required properties:
> +- compatible: Should be "marvell,mmp-fb".
> +- marvell,fb-name: Should be the name of this fb.
> +- marvell,path-name: Should be the name of path this fb connecting to.
> +- marvell,overlay-id: Should be the id of overlay this fb is on.
> +- marvell,dmafetch-id: Should be the dma fetch id this fb using.
> +- marvell,default-pixfmt: Should be the default pixel format when this fb is
> +turned on.
> +
> +2. mmp controller
> +Required properties:
> +- compatible: Should be "marvell,mmp-disp".
> +- reg: Should be address and length of the register set for this controller.
> +- interrupts: Should be interrupt of this controller.
> +- marvell,disp-name: Should be name of this controller
> +- marvell,path-num: Should be path number exists in this controller.
> +- marvell,clk-name: Should be name of clock this controller using.
> +
> +Required sub-node:
> +- path:
> +Required properties in this sub-node:
> +-- marvell,path-name: Should be name of this path, fb/panel uses this name to
> +connect to this path.
> +-- marvell,overlay_num: Should be number of overlay this path has.
> +-- marvell,output-type: Should be output-type settings
> +-- marvell,path-config: Should be path-config settings
> +-- marvell,link-config: Should be link-config settings
> +-- marvell,rbswap: Should be rbswap settings
> +
> +3. panel
> +Required properties:
> +- marvell,path-name: Should be path name that this panel connected to.
> +- other properties each panel has.
> +
> +Examples:
> +
> +fb: fb {
> +	compatible = "marvell,mmp-fb";

This compatible should have the specific SoC name in it, not just
'mmp'. Otherwise you can't properly distinguish between this version and
future versions of the mmp core.

> +	marvell,fb-name = "mmp_fb";
> +	marvell,path-name = "mmp_pnpath";

You're not going to use this string to reference to another node, do
you? We have phandles for this.

> +	marvell,overlay-id = <0>;
> +	marvell,dmafetch-id = <1>;
> +	marvell,default-pixfmt = <0x108>;
> +};
> +
> +disp: disp@d420b000 {
> +	compatible = "marvell,mmp-disp";
> +	reg = <0xd420b000 0x1fc>;
> +	interrupts = <0 41 0x4>;
> +	marvell,disp-name = "mmp_disp";
> +	marvell,path-num = <1>;
> +	marvell,clk-name = "LCDCIHCLK";

Don't pass clk names like this. We have a documented clock binding, use
it.

> +#ifdef CONFIG_OF
> +	struct device_node *np;
> +#else
>  	struct mmp_buffer_driver_mach_info *mi;
> +#endif
>  	struct fb_info *info = 0;
>  	struct mmpfb_info *fbi = 0;
> -	int ret, modes_num;
> -
> -	mi = pdev->dev.platform_data;
> -	if (mi = NULL) {
> -		dev_err(&pdev->dev, "no platform data defined\n");
> -		return -EINVAL;
> -	}
> +	int ret = -EINVAL, modes_num;
> +	int overlay_id, dmafetch_id;
> +	const char *path_name;
>  
>  	/* initialize fb */
>  	info = framebuffer_alloc(sizeof(struct mmpfb_info), &pdev->dev);
>  	if (info = NULL)
>  		return -ENOMEM;
>  	fbi = info->par;
> -	if (!fbi) {
> -		ret = -EINVAL;
> +	if (!fbi)
> +		goto failed;
> +
> +#ifdef CONFIG_OF

Just because your kernel build does have CONFIG_OF enabled doesn't mean
it's actually started with a devicetree. You need to make a runtime
decision, not compile time.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
