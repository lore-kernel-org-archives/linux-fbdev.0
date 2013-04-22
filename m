From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Mon, 22 Apr 2013 15:51:25 +0000
Subject: Re: [PATCH v4 2/2] video: imxfb: Add DT support
Message-Id: <20130422155125.GI4998@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366290183-367-1-git-send-email-mpa@pengutronix.de>
 <1366290183-367-3-git-send-email-mpa@pengutronix.de>
 <20130418160614.GF4998@game.jcrosoft.org>
 <20130421081115.GA31179@pengutronix.de>
In-Reply-To: <20130421081115.GA31179@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10:11 Sun 21 Apr     , Markus Pargmann wrote:
> On Thu, Apr 18, 2013 at 06:06:14PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 15:03 Thu 18 Apr     , Markus Pargmann wrote:
> > > Add devicetree support for imx framebuffer driver. It uses the generic
> > > display bindings and helper functions.
> > > 
> > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > Cc: Fabio Estevam <festevam@gmail.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > ---
> > > 
> > > Notes:
> > >     Changes in v4:
> > >     - Remove eukrea specific dmacr property.
> > >     - Add optional dmacr property. If not present, the dmacr reset value is not
> > >       changed.
> > >     
> > >     Changes in v3:
> > >     - Fix returncodes of of_read_mode function and print error messages
> > >     - Introduce a lower bound check for bits per pixel
> > >     - Calculate correct bytes per pixel value before using it for the calculation of
> > >     	memory size
> > >     - Change DT property names
> > >     
> > >     Changes in v2:
> > >     - Removed pwmr register property
> > >     - Cleanup of devicetree binding documentation
> > >     - Use default values for pwmr and lscr1
> > > 
> > >  .../devicetree/bindings/video/fsl,imx-fb.txt       |  51 ++++++
> > >  drivers/video/imxfb.c                              | 194 +++++++++++++++++----
> > >  2 files changed, 210 insertions(+), 35 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > > new file mode 100644
> > > index 0000000..aff16a4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > > @@ -0,0 +1,51 @@
> > > +Freescale imx21 Framebuffer
> > > +
> > > +This framebuffer driver supports devices imx1, imx21, imx25, and imx27.
> > > +
> > > +Required properties:
> > > +- compatible : "fsl,<chip>-fb", chip should be imx1 or imx21
> > > +- reg : Should contain 1 register ranges(address and length)
> > > +- interrupts : One interrupt of the fb dev
> > > +
> > > +Required nodes:
> > > +- display: Phandle to a display node as described in
> > > +	Documentation/devicetree/bindings/video/display-timing.txt
> > > +	Additional, the display node has to define properties:
> > > +	- fsl,bpp: Bits per pixel
> > > +	- fsl,pcr: LCDC PCR value
> > > +
> > > +Optional properties:
> > > +- fsl,dmacr: DMA Control Register value. This is optional. By default, the
> > > +	register is not modified as recommended by the datasheet.
> > > +- fsl,lscr1: LCDC Sharp Configuration Register value.
> > > +
> > > +Example:
> > > +
> > > +	imxfb: fb@10021000 {
> > > +		compatible = "fsl,imx27-fb", "fsl,imx21-fb";
> > you put both when in the doc you request one
> 
> Thanks, fixed.
> 
> > > +		interrupts = <61>;
> > > +		reg = <0x10021000 0x1000>;
> > > +		display = <&display0>;
> > > +	};
> > > +
> > > +	...
> > > +
> > > +	display0: display0 {
> > > +		model = "Primeview-PD050VL1";
> > > +		native-mode = <&timing_disp0>;
> > > +		fsl,bpp = <16>;		/* non-standard but required */
> > there is a generic binding bit-per-pixel use a cross other IP
> 
> I can't find a generic binding for that. There are only 2 other drivers
> using a "bpp" property, but they both use it within different contexts.
> tilcdc panel uses it within a "panel-info" property and via,vt8500-fb
> within modes. So I think it would be better to use a clear distinction
> because there is no generic binding. That was also suggested in comments
> on version 2 of this patch:
> https://patchwork.kernel.org/patch/2220511/

via use bits-per-pixel
atmel ditto
mxs ditto IIRC

Best Regards,
J.
> 
> Regards,
> 
> Markus
> 
> > > +		fsl,pcr = <0xf0c88080>;	/* non-standard but required */
> > > +		display-timings {
> > > +			timing_disp0: 640x480 {
> > > +				hactive = <640>;
> > > +				vactive = <480>;
> > > +				hback-porch = <112>;
> > > +				hfront-porch = <36>;
> > > +				hsync-len = <32>;
> > > +				vback-porch = <33>;
> > > +				vfront-porch = <33>;
> > > +				vsync-len = <2>;
> > > +				clock-frequency = <25000000>;
> > > +			};
> > > +		};
> > > +	};
> > > diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> > > index ef2b587..e0230f8 100644
> > > --- a/drivers/video/imxfb.c
> > > +++ b/drivers/video/imxfb.c
> > > @@ -32,6 +32,12 @@
> > >  #include <linux/io.h>
> > >  #include <linux/math64.h>
> > >  #include <linux/uaccess.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +
> > > +#include <video/of_display_timing.h>
> > > +#include <video/of_videomode.h>
> > > +#include <video/videomode.h>
> > >  
> > >  #include <linux/platform_data/video-imxfb.h>
> > >  
> > > @@ -117,10 +123,11 @@
> > >  #define LGWCR_GWAV(alpha)	(((alpha) & 0xff) << 24)
> > >  #define LGWCR_GWE	(1 << 22)
> > >  
> > > +#define IMXFB_LSCR1_DEFAULT 0x00120300
> > > +
> > >  /* Used fb-mode. Can be set on kernel command line, therefore file-static. */
> > >  static const char *fb_mode;
> > >  
> > > -
> > >  /*
> > >   * These are the bitfields for each
> > >   * display depth that we support.
> > > @@ -192,6 +199,19 @@ static struct platform_device_id imxfb_devtype[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(platform, imxfb_devtype);
> > >  
> > > +static struct of_device_id imxfb_of_dev_id[] = {
> > > +	{
> > > +		.compatible = "fsl,imx1-fb",
> > > +		.data = &imxfb_devtype[IMX1_FB],
> > > +	}, {
> > > +		.compatible = "fsl,imx21-fb",
> > > +		.data = &imxfb_devtype[IMX21_FB],
> > > +	}, {
> > > +		/* sentinel */
> > > +	}
> > > +};
> > > +MODULE_DEVICE_TABLE(of, imxfb_of_dev_id);
> > > +
> > >  static inline int is_imx1_fb(struct imxfb_info *fbi)
> > >  {
> > >  	return fbi->devtype = IMX1_FB;
> > > @@ -324,6 +344,9 @@ static const struct imx_fb_videomode *imxfb_find_mode(struct imxfb_info *fbi)
> > >  	struct imx_fb_videomode *m;
> > >  	int i;
> > >  
> > > +	if (!fb_mode)
> > > +		return &fbi->mode[0];
> > > +
> > >  	for (i = 0, m = &fbi->mode[0]; i < fbi->num_modes; i++, m++) {
> > >  		if (!strcmp(m->mode.name, fb_mode))
> > >  			return m;
> > > @@ -479,6 +502,9 @@ static int imxfb_bl_update_status(struct backlight_device *bl)
> > >  	struct imxfb_info *fbi = bl_get_data(bl);
> > >  	int brightness = bl->props.brightness;
> > >  
> > > +	if (!fbi->pwmr)
> > > +		return 0;
> > > +
> > >  	if (bl->props.power != FB_BLANK_UNBLANK)
> > >  		brightness = 0;
> > >  	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> > > @@ -719,10 +745,14 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
> > >  
> > >  	writel(fbi->pcr, fbi->regs + LCDC_PCR);
> > >  #ifndef PWMR_BACKLIGHT_AVAILABLE
> > > -	writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
> > > +	if (fbi->pwmr)
> > > +		writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
> > >  #endif
> > >  	writel(fbi->lscr1, fbi->regs + LCDC_LSCR1);
> > > -	writel(fbi->dmacr, fbi->regs + LCDC_DMACR);
> > > +
> > > +	/* dmacr = 0 is no valid value, as we need DMA control marks. */
> > > +	if (fbi->dmacr)
> > > +		writel(fbi->dmacr, fbi->regs + LCDC_DMACR);
> > >  
> > >  	return 0;
> > >  }
> > > @@ -758,13 +788,12 @@ static int imxfb_resume(struct platform_device *dev)
> > >  #define imxfb_resume	NULL
> > >  #endif
> > >  
> > > -static int __init imxfb_init_fbinfo(struct platform_device *pdev)
> > > +static int imxfb_init_fbinfo(struct platform_device *pdev)
> > >  {
> > >  	struct imx_fb_platform_data *pdata = pdev->dev.platform_data;
> > >  	struct fb_info *info = dev_get_drvdata(&pdev->dev);
> > >  	struct imxfb_info *fbi = info->par;
> > > -	struct imx_fb_videomode *m;
> > > -	int i;
> > > +	struct device_node *np;
> > >  
> > >  	pr_debug("%s\n",__func__);
> > >  
> > > @@ -795,41 +824,95 @@ static int __init imxfb_init_fbinfo(struct platform_device *pdev)
> > >  	info->fbops			= &imxfb_ops;
> > >  	info->flags			= FBINFO_FLAG_DEFAULT |
> > >  					  FBINFO_READS_FAST;
> > > -	info->var.grayscale		= pdata->cmap_greyscale;
> > > -	fbi->cmap_inverse		= pdata->cmap_inverse;
> > > -	fbi->cmap_static		= pdata->cmap_static;
> > > -	fbi->lscr1			= pdata->lscr1;
> > > -	fbi->dmacr			= pdata->dmacr;
> > > -	fbi->pwmr			= pdata->pwmr;
> > > -	fbi->lcd_power			= pdata->lcd_power;
> > > -	fbi->backlight_power		= pdata->backlight_power;
> > > -
> > > -	for (i = 0, m = &pdata->mode[0]; i < pdata->num_modes; i++, m++)
> > > -		info->fix.smem_len = max_t(size_t, info->fix.smem_len,
> > > -				m->mode.xres * m->mode.yres * m->bpp / 8);
> > > +	if (pdata) {
> > > +		info->var.grayscale		= pdata->cmap_greyscale;
> > > +		fbi->cmap_inverse		= pdata->cmap_inverse;
> > > +		fbi->cmap_static		= pdata->cmap_static;
> > > +		fbi->lscr1			= pdata->lscr1;
> > > +		fbi->dmacr			= pdata->dmacr;
> > > +		fbi->pwmr			= pdata->pwmr;
> > > +		fbi->lcd_power			= pdata->lcd_power;
> > > +		fbi->backlight_power		= pdata->backlight_power;
> > > +	} else {
> > > +		np = pdev->dev.of_node;
> > > +		info->var.grayscale = of_property_read_bool(np,
> > > +						"cmap-greyscale");
> > > +		fbi->cmap_inverse = of_property_read_bool(np, "cmap-inverse");
> > > +		fbi->cmap_static = of_property_read_bool(np, "cmap-static");
> > > +
> > > +		fbi->lscr1 = IMXFB_LSCR1_DEFAULT;
> > > +		of_property_read_u32(np, "fsl,lscr1", &fbi->lscr1);
> > > +
> > > +		of_property_read_u32(np, "fsl,dmacr", &fbi->dmacr);
> > > +
> > > +		/* These two function pointers could be used by some specific
> > > +		 * platforms. */
> > > +		fbi->lcd_power = NULL;
> > > +		fbi->backlight_power = NULL;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int imxfb_of_read_mode(struct device *dev, struct device_node *np,
> > > +		struct imx_fb_videomode *imxfb_mode)
> > > +{
> > > +	int ret;
> > > +	struct fb_videomode *of_mode = &imxfb_mode->mode;
> > > +	u32 bpp;
> > > +	u32 pcr;
> > > +
> > > +	ret = of_property_read_string(np, "model", &of_mode->name);
> > > +	if (ret)
> > > +		of_mode->name = NULL;
> > > +
> > > +	ret = of_get_fb_videomode(np, of_mode, OF_USE_NATIVE_MODE);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to get videomode from DT\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = of_property_read_u32(np, "fsl,bpp", &bpp);
> > > +	ret |= of_property_read_u32(np, "fsl,pcr", &pcr);
> > > +
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to read bpp and pcr from DT\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (bpp < 1 || bpp > 255) {
> > > +		dev_err(dev, "Bits per pixel have to be between 1 and 255\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	imxfb_mode->bpp = bpp;
> > > +	imxfb_mode->pcr = pcr;
> > >  
> > >  	return 0;
> > >  }
> > >  
> > > -static int __init imxfb_probe(struct platform_device *pdev)
> > > +static int imxfb_probe(struct platform_device *pdev)
> > >  {
> > >  	struct imxfb_info *fbi;
> > >  	struct fb_info *info;
> > >  	struct imx_fb_platform_data *pdata;
> > >  	struct resource *res;
> > > +	struct imx_fb_videomode *m;
> > > +	const struct of_device_id *of_id;
> > >  	int ret, i;
> > > +	int bytes_per_pixel;
> > >  
> > >  	dev_info(&pdev->dev, "i.MX Framebuffer driver\n");
> > >  
> > > +	of_id = of_match_device(imxfb_of_dev_id, &pdev->dev);
> > > +	if (of_id)
> > > +		pdev->id_entry = of_id->data;
> > > +
> > >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  	if (!res)
> > >  		return -ENODEV;
> > >  
> > >  	pdata = pdev->dev.platform_data;
> > > -	if (!pdata) {
> > > -		dev_err(&pdev->dev,"No platform_data available\n");
> > > -		return -ENOMEM;
> > > -	}
> > >  
> > >  	info = framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
> > >  	if (!info)
> > > @@ -837,15 +920,55 @@ static int __init imxfb_probe(struct platform_device *pdev)
> > >  
> > >  	fbi = info->par;
> > >  
> > > -	if (!fb_mode)
> > > -		fb_mode = pdata->mode[0].mode.name;
> > > -
> > >  	platform_set_drvdata(pdev, info);
> > >  
> > >  	ret = imxfb_init_fbinfo(pdev);
> > >  	if (ret < 0)
> > >  		goto failed_init;
> > >  
> > > +	if (pdata) {
> > > +		if (!fb_mode)
> > > +			fb_mode = pdata->mode[0].mode.name;
> > > +
> > > +		fbi->mode = pdata->mode;
> > > +		fbi->num_modes = pdata->num_modes;
> > > +	} else {
> > > +		struct device_node *display_np;
> > > +		fb_mode = NULL;
> > > +
> > > +		display_np = of_parse_phandle(pdev->dev.of_node, "display", 0);
> > > +		if (!display_np) {
> > > +			dev_err(&pdev->dev, "No display defined in devicetree\n");
> > > +			ret = -EINVAL;
> > > +			goto failed_of_parse;
> > > +		}
> > > +
> > > +		/*
> > > +		 * imxfb does not support more modes, we choose only the native
> > > +		 * mode.
> > > +		 */
> > > +		fbi->num_modes = 1;
> > > +
> > > +		fbi->mode = devm_kzalloc(&pdev->dev,
> > > +				sizeof(struct imx_fb_videomode), GFP_KERNEL);
> > > +		if (!fbi->mode) {
> > > +			ret = -ENOMEM;
> > > +			goto failed_of_parse;
> > > +		}
> > > +
> > > +		ret = imxfb_of_read_mode(&pdev->dev, display_np, fbi->mode);
> > > +		if (ret)
> > > +			goto failed_of_parse;
> > > +	}
> > > +
> > > +	/* Calculate maximum bytes used per pixel. In most cases this should
> > > +	 * be the same as m->bpp/8 */
> > > +	m = &fbi->mode[0];
> > > +	bytes_per_pixel = (m->bpp + 7) / 8;
> > > +	for (i = 0; i < fbi->num_modes; i++, m++)
> > > +		info->fix.smem_len = max_t(size_t, info->fix.smem_len,
> > > +				m->mode.xres * m->mode.yres * bytes_per_pixel);
> > > +
> > >  	res = request_mem_region(res->start, resource_size(res),
> > >  				DRIVER_NAME);
> > >  	if (!res) {
> > > @@ -878,7 +1001,8 @@ static int __init imxfb_probe(struct platform_device *pdev)
> > >  		goto failed_ioremap;
> > >  	}
> > >  
> > > -	if (!pdata->fixed_screen_cpu) {
> > > +	/* Seems not being used by anyone, so no support for oftree */
> > > +	if (!pdata || !pdata->fixed_screen_cpu) {
> > >  		fbi->map_size = PAGE_ALIGN(info->fix.smem_len);
> > >  		fbi->map_cpu = dma_alloc_writecombine(&pdev->dev,
> > >  				fbi->map_size, &fbi->map_dma, GFP_KERNEL);
> > > @@ -903,18 +1027,16 @@ static int __init imxfb_probe(struct platform_device *pdev)
> > >  		info->fix.smem_start = fbi->screen_dma;
> > >  	}
> > >  
> > > -	if (pdata->init) {
> > > +	if (pdata && pdata->init) {
> > >  		ret = pdata->init(fbi->pdev);
> > >  		if (ret)
> > >  			goto failed_platform_init;
> > >  	}
> > >  
> > > -	fbi->mode = pdata->mode;
> > > -	fbi->num_modes = pdata->num_modes;
> > >  
> > >  	INIT_LIST_HEAD(&info->modelist);
> > > -	for (i = 0; i < pdata->num_modes; i++)
> > > -		fb_add_videomode(&pdata->mode[i].mode, &info->modelist);
> > > +	for (i = 0; i < fbi->num_modes; i++)
> > > +		fb_add_videomode(&fbi->mode[i].mode, &info->modelist);
> > >  
> > >  	/*
> > >  	 * This makes sure that our colour bitfield
> > > @@ -944,10 +1066,10 @@ static int __init imxfb_probe(struct platform_device *pdev)
> > >  failed_register:
> > >  	fb_dealloc_cmap(&info->cmap);
> > >  failed_cmap:
> > > -	if (pdata->exit)
> > > +	if (pdata && pdata->exit)
> > >  		pdata->exit(fbi->pdev);
> > >  failed_platform_init:
> > > -	if (!pdata->fixed_screen_cpu)
> > > +	if (pdata && !pdata->fixed_screen_cpu)
> > >  		dma_free_writecombine(&pdev->dev,fbi->map_size,fbi->map_cpu,
> > >  			fbi->map_dma);
> > >  failed_map:
> > > @@ -956,6 +1078,7 @@ failed_ioremap:
> > >  failed_getclock:
> > >  	release_mem_region(res->start, resource_size(res));
> > >  failed_req:
> > > +failed_of_parse:
> > >  	kfree(info->pseudo_palette);
> > >  failed_init:
> > >  	platform_set_drvdata(pdev, NULL);
> > > @@ -980,7 +1103,7 @@ static int imxfb_remove(struct platform_device *pdev)
> > >  	unregister_framebuffer(info);
> > >  
> > >  	pdata = pdev->dev.platform_data;
> > > -	if (pdata->exit)
> > > +	if (pdata && pdata->exit)
> > >  		pdata->exit(fbi->pdev);
> > >  
> > >  	fb_dealloc_cmap(&info->cmap);
> > > @@ -1009,6 +1132,7 @@ static struct platform_driver imxfb_driver = {
> > >  	.shutdown	= imxfb_shutdown,
> > >  	.driver		= {
> > >  		.name	= DRIVER_NAME,
> > > +		.of_match_table = imxfb_of_dev_id,
> > >  	},
> > >  	.id_table	= imxfb_devtype,
> > >  };
> > > -- 
> > > 1.8.1.5
> > > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
