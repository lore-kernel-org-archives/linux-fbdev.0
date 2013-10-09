From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 09 Oct 2013 11:06:52 +0000
Subject: Re: [PATCH v2 1/3] video: xilinxfb: Use standard variable name convention
Message-Id: <20131009110651.GH4981@e106331-lin.cambridge.arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <631df9a44b366af4129d00f1d4e1d3baad7d4903.1381315928.git.michal.simek@xilinx.com>
In-Reply-To: <631df9a44b366af4129d00f1d4e1d3baad7d4903.1381315928.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org" <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Oct 09, 2013 at 11:52:12AM +0100, Michal Simek wrote:
> s/op/pdev/ in xilinxfb_of_probe().
> No functional chagnes.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> Changes in v2: None
> 
>  drivers/video/xilinxfb.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index 0e1dd33..d12345f 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -411,7 +411,7 @@ static int xilinxfb_release(struct device *dev)
>   * OF bus binding
>   */
> 
> -static int xilinxfb_of_probe(struct platform_device *op)
> +static int xilinxfb_of_probe(struct platform_device *pdev)
>  {
>  	const u32 *prop;
>  	u32 tft_access = 0;
> @@ -425,7 +425,7 @@ static int xilinxfb_of_probe(struct platform_device *op)
>  	/* Allocate the driver data region */
>  	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata) {
> -		dev_err(&op->dev, "Couldn't allocate device private record\n");
> +		dev_err(&pdev->dev, "Couldn't allocate device private record\n");
>  		return -ENOMEM;
>  	}
> 
> @@ -433,7 +433,7 @@ static int xilinxfb_of_probe(struct platform_device *op)
>  	 * To check whether the core is connected directly to DCR or BUS
>  	 * interface and initialize the tft_access accordingly.
>  	 */
> -	of_property_read_u32(op->dev.of_node, "xlnx,dcr-splb-slave-if",
> +	of_property_read_u32(pdev->dev.of_node, "xlnx,dcr-splb-slave-if",
>  			     &tft_access);
> 
>  	/*
> @@ -457,29 +457,29 @@ static int xilinxfb_of_probe(struct platform_device *op)
>  	}
>  #endif
> 
> -	prop = of_get_property(op->dev.of_node, "phys-size", &size);
> +	prop = of_get_property(pdev->dev.of_node, "phys-size", &size);
>  	if ((prop) && (size >= sizeof(u32)*2)) {
>  		pdata.screen_width_mm = prop[0];
>  		pdata.screen_height_mm = prop[1];
>  	}

While you're changing these lines, it would be nice to change this
pattern (here and elsewhere) to use of_property_read_u32_array, so that
it's endian-safe and consistent with other devicetree parsing code:

  of_property_read_u32_array(pdev->dev.of_node, "phys-size", prop, 2);

It won't read the values if the property data's too short, so that
should be consistent with the existing code.

It would also make the diffstat negative :)

> 
> -	prop = of_get_property(op->dev.of_node, "resolution", &size);
> +	prop = of_get_property(pdev->dev.of_node, "resolution", &size);
>  	if ((prop) && (size >= sizeof(u32)*2)) {
>  		pdata.xres = prop[0];
>  		pdata.yres = prop[1];
>  	}
> 
> -	prop = of_get_property(op->dev.of_node, "virtual-resolution", &size);
> +	prop = of_get_property(pdev->dev.of_node, "virtual-resolution", &size);
>  	if ((prop) && (size >= sizeof(u32)*2)) {
>  		pdata.xvirt = prop[0];
>  		pdata.yvirt = prop[1];
>  	}
> 
> -	if (of_find_property(op->dev.of_node, "rotate-display", NULL))
> +	if (of_find_property(pdev->dev.of_node, "rotate-display", NULL))
>  		pdata.rotate_screen = 1;

Similarly, this could use of_property_read_bool:

  pdata.rotate_screen = of_property_read_bool(pdev->dev.of_node,
                                              "rotate-display");

It won't help the diffstat, but it makes the intent clearer.

Cheers,
Mark.
