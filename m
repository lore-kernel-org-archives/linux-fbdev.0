From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 28 May 2013 11:09:27 +0000
Subject: Re: [PATCH v6] video: imxfb: Add DT support
Message-Id: <20130528110927.GA23653@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369564538-21835-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1369564538-21835-1-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 12:35 Sun 26 May     , Markus Pargmann wrote:
> Add devicetree support for imx framebuffer driver. It uses the generic
> display bindings and helper functions.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Applied thanks

Best Regards,
J.
> ---
> 
> Notes:
>     Changed in v6:
>     - Rebased onto v3.10-rc2
>     - Dropped alpha support patch in this series
>     
>     Changed in v5:
>     - Fix compatible property of the example
>     - Rename property fsl,bpp to bits-per-pixel
>     - Add selects for FB_MODE_HELPERS and VIDEOMODE_HELPERS to Kconfig FB_IMX
>     
>     Changes in v4:
>     - Remove eukrea specific dmacr property.
>     - Add optional dmacr property. If not present, the dmacr reset value is not
>       changed.
>     
>     Changes in v3:
>     - Fix returncodes of of_read_mode function and print error messages
>     - Introduce a lower bound check for bits per pixel
>     - Calculate correct bytes per pixel value before using it for the calculation of
>     	memory size
>     - Change DT property names
>     
>     Changes in v2:
>     - Removed pwmr register property
>     - Cleanup of devicetree binding documentation
>     - Use default values for pwmr and lscr1
> 
>  .../devicetree/bindings/video/fsl,imx-fb.txt       |  51 ++++++
>  drivers/video/Kconfig                              |   2 +
>  drivers/video/imxfb.c                              | 194 +++++++++++++++++----
>  3 files changed, 212 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> new file mode 100644
> index 0000000..46da08d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> @@ -0,0 +1,51 @@
> +Freescale imx21 Framebuffer
> +
> +This framebuffer driver supports devices imx1, imx21, imx25, and imx27.
> +
> +Required properties:
> +- compatible : "fsl,<chip>-fb", chip should be imx1 or imx21
> +- reg : Should contain 1 register ranges(address and length)
> +- interrupts : One interrupt of the fb dev
> +
> +Required nodes:
> +- display: Phandle to a display node as described in
> +	Documentation/devicetree/bindings/video/display-timing.txt
> +	Additional, the display node has to define properties:
> +	- bits-per-pixel: Bits per pixel
> +	- fsl,pcr: LCDC PCR value
> +
> +Optional properties:
> +- fsl,dmacr: DMA Control Register value. This is optional. By default, the
> +	register is not modified as recommended by the datasheet.
> +- fsl,lscr1: LCDC Sharp Configuration Register value.
> +
> +Example:
> +
> +	imxfb: fb@10021000 {
> +		compatible = "fsl,imx21-fb";
> +		interrupts = <61>;
> +		reg = <0x10021000 0x1000>;
> +		display = <&display0>;
> +	};
> +
> +	...
> +
> +	display0: display0 {
> +		model = "Primeview-PD050VL1";
> +		native-mode = <&timing_disp0>;
> +		bits-per-pixel = <16>;
> +		fsl,pcr = <0xf0c88080>;	/* non-standard but required */
> +		display-timings {
> +			timing_disp0: 640x480 {
> +				hactive = <640>;
> +				vactive = <480>;
> +				hback-porch = <112>;
> +				hfront-porch = <36>;
> +				hsync-len = <32>;
> +				vback-porch = <33>;
> +				vfront-porch = <33>;
> +				vsync-len = <2>;
> +				clock-frequency = <25000000>;
> +			};
> +		};
> +	};
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index d71d60f..588af1d 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -367,6 +367,8 @@ config FB_IMX
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> +	select FB_MODE_HELPERS
> +	select VIDEOMODE_HELPERS
>  
>  config FB_CYBER2000
>  	tristate "CyberPro 2000/2010/5000 support"
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 0abf2bf..a2ed71d 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -31,6 +31,12 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/math64.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#include <video/of_display_timing.h>
> +#include <video/of_videomode.h>
> +#include <video/videomode.h>
>  
>  #include <linux/platform_data/video-imxfb.h>
>  
> @@ -112,10 +118,11 @@
>  #define LCDISR_EOF	(1<<1)
>  #define LCDISR_BOF	(1<<0)
>  
> +#define IMXFB_LSCR1_DEFAULT 0x00120300
> +
>  /* Used fb-mode. Can be set on kernel command line, therefore file-static. */
>  static const char *fb_mode;
>  
> -
>  /*
>   * These are the bitfields for each
>   * display depth that we support.
> @@ -187,6 +194,19 @@ static struct platform_device_id imxfb_devtype[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, imxfb_devtype);
>  
> +static struct of_device_id imxfb_of_dev_id[] = {
> +	{
> +		.compatible = "fsl,imx1-fb",
> +		.data = &imxfb_devtype[IMX1_FB],
> +	}, {
> +		.compatible = "fsl,imx21-fb",
> +		.data = &imxfb_devtype[IMX21_FB],
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, imxfb_of_dev_id);
> +
>  static inline int is_imx1_fb(struct imxfb_info *fbi)
>  {
>  	return fbi->devtype = IMX1_FB;
> @@ -319,6 +339,9 @@ static const struct imx_fb_videomode *imxfb_find_mode(struct imxfb_info *fbi)
>  	struct imx_fb_videomode *m;
>  	int i;
>  
> +	if (!fb_mode)
> +		return &fbi->mode[0];
> +
>  	for (i = 0, m = &fbi->mode[0]; i < fbi->num_modes; i++, m++) {
>  		if (!strcmp(m->mode.name, fb_mode))
>  			return m;
> @@ -474,6 +497,9 @@ static int imxfb_bl_update_status(struct backlight_device *bl)
>  	struct imxfb_info *fbi = bl_get_data(bl);
>  	int brightness = bl->props.brightness;
>  
> +	if (!fbi->pwmr)
> +		return 0;
> +
>  	if (bl->props.power != FB_BLANK_UNBLANK)
>  		brightness = 0;
>  	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> @@ -684,10 +710,14 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
>  
>  	writel(fbi->pcr, fbi->regs + LCDC_PCR);
>  #ifndef PWMR_BACKLIGHT_AVAILABLE
> -	writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
> +	if (fbi->pwmr)
> +		writel(fbi->pwmr, fbi->regs + LCDC_PWMR);
>  #endif
>  	writel(fbi->lscr1, fbi->regs + LCDC_LSCR1);
> -	writel(fbi->dmacr, fbi->regs + LCDC_DMACR);
> +
> +	/* dmacr = 0 is no valid value, as we need DMA control marks. */
> +	if (fbi->dmacr)
> +		writel(fbi->dmacr, fbi->regs + LCDC_DMACR);
>  
>  	return 0;
>  }
> @@ -723,13 +753,12 @@ static int imxfb_resume(struct platform_device *dev)
>  #define imxfb_resume	NULL
>  #endif
>  
> -static int __init imxfb_init_fbinfo(struct platform_device *pdev)
> +static int imxfb_init_fbinfo(struct platform_device *pdev)
>  {
>  	struct imx_fb_platform_data *pdata = pdev->dev.platform_data;
>  	struct fb_info *info = dev_get_drvdata(&pdev->dev);
>  	struct imxfb_info *fbi = info->par;
> -	struct imx_fb_videomode *m;
> -	int i;
> +	struct device_node *np;
>  
>  	pr_debug("%s\n",__func__);
>  
> @@ -760,41 +789,95 @@ static int __init imxfb_init_fbinfo(struct platform_device *pdev)
>  	info->fbops			= &imxfb_ops;
>  	info->flags			= FBINFO_FLAG_DEFAULT |
>  					  FBINFO_READS_FAST;
> -	info->var.grayscale		= pdata->cmap_greyscale;
> -	fbi->cmap_inverse		= pdata->cmap_inverse;
> -	fbi->cmap_static		= pdata->cmap_static;
> -	fbi->lscr1			= pdata->lscr1;
> -	fbi->dmacr			= pdata->dmacr;
> -	fbi->pwmr			= pdata->pwmr;
> -	fbi->lcd_power			= pdata->lcd_power;
> -	fbi->backlight_power		= pdata->backlight_power;
> -
> -	for (i = 0, m = &pdata->mode[0]; i < pdata->num_modes; i++, m++)
> -		info->fix.smem_len = max_t(size_t, info->fix.smem_len,
> -				m->mode.xres * m->mode.yres * m->bpp / 8);
> +	if (pdata) {
> +		info->var.grayscale		= pdata->cmap_greyscale;
> +		fbi->cmap_inverse		= pdata->cmap_inverse;
> +		fbi->cmap_static		= pdata->cmap_static;
> +		fbi->lscr1			= pdata->lscr1;
> +		fbi->dmacr			= pdata->dmacr;
> +		fbi->pwmr			= pdata->pwmr;
> +		fbi->lcd_power			= pdata->lcd_power;
> +		fbi->backlight_power		= pdata->backlight_power;
> +	} else {
> +		np = pdev->dev.of_node;
> +		info->var.grayscale = of_property_read_bool(np,
> +						"cmap-greyscale");
> +		fbi->cmap_inverse = of_property_read_bool(np, "cmap-inverse");
> +		fbi->cmap_static = of_property_read_bool(np, "cmap-static");
> +
> +		fbi->lscr1 = IMXFB_LSCR1_DEFAULT;
> +		of_property_read_u32(np, "fsl,lscr1", &fbi->lscr1);
> +
> +		of_property_read_u32(np, "fsl,dmacr", &fbi->dmacr);
> +
> +		/* These two function pointers could be used by some specific
> +		 * platforms. */
> +		fbi->lcd_power = NULL;
> +		fbi->backlight_power = NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imxfb_of_read_mode(struct device *dev, struct device_node *np,
> +		struct imx_fb_videomode *imxfb_mode)
> +{
> +	int ret;
> +	struct fb_videomode *of_mode = &imxfb_mode->mode;
> +	u32 bpp;
> +	u32 pcr;
> +
> +	ret = of_property_read_string(np, "model", &of_mode->name);
> +	if (ret)
> +		of_mode->name = NULL;
> +
> +	ret = of_get_fb_videomode(np, of_mode, OF_USE_NATIVE_MODE);
> +	if (ret) {
> +		dev_err(dev, "Failed to get videomode from DT\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "bits-per-pixel", &bpp);
> +	ret |= of_property_read_u32(np, "fsl,pcr", &pcr);
> +
> +	if (ret) {
> +		dev_err(dev, "Failed to read bpp and pcr from DT\n");
> +		return -EINVAL;
> +	}
> +
> +	if (bpp < 1 || bpp > 255) {
> +		dev_err(dev, "Bits per pixel have to be between 1 and 255\n");
> +		return -EINVAL;
> +	}
> +
> +	imxfb_mode->bpp = bpp;
> +	imxfb_mode->pcr = pcr;
>  
>  	return 0;
>  }
>  
> -static int __init imxfb_probe(struct platform_device *pdev)
> +static int imxfb_probe(struct platform_device *pdev)
>  {
>  	struct imxfb_info *fbi;
>  	struct fb_info *info;
>  	struct imx_fb_platform_data *pdata;
>  	struct resource *res;
> +	struct imx_fb_videomode *m;
> +	const struct of_device_id *of_id;
>  	int ret, i;
> +	int bytes_per_pixel;
>  
>  	dev_info(&pdev->dev, "i.MX Framebuffer driver\n");
>  
> +	of_id = of_match_device(imxfb_of_dev_id, &pdev->dev);
> +	if (of_id)
> +		pdev->id_entry = of_id->data;
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res)
>  		return -ENODEV;
>  
>  	pdata = pdev->dev.platform_data;
> -	if (!pdata) {
> -		dev_err(&pdev->dev,"No platform_data available\n");
> -		return -ENOMEM;
> -	}
>  
>  	info = framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
>  	if (!info)
> @@ -802,15 +885,55 @@ static int __init imxfb_probe(struct platform_device *pdev)
>  
>  	fbi = info->par;
>  
> -	if (!fb_mode)
> -		fb_mode = pdata->mode[0].mode.name;
> -
>  	platform_set_drvdata(pdev, info);
>  
>  	ret = imxfb_init_fbinfo(pdev);
>  	if (ret < 0)
>  		goto failed_init;
>  
> +	if (pdata) {
> +		if (!fb_mode)
> +			fb_mode = pdata->mode[0].mode.name;
> +
> +		fbi->mode = pdata->mode;
> +		fbi->num_modes = pdata->num_modes;
> +	} else {
> +		struct device_node *display_np;
> +		fb_mode = NULL;
> +
> +		display_np = of_parse_phandle(pdev->dev.of_node, "display", 0);
> +		if (!display_np) {
> +			dev_err(&pdev->dev, "No display defined in devicetree\n");
> +			ret = -EINVAL;
> +			goto failed_of_parse;
> +		}
> +
> +		/*
> +		 * imxfb does not support more modes, we choose only the native
> +		 * mode.
> +		 */
> +		fbi->num_modes = 1;
> +
> +		fbi->mode = devm_kzalloc(&pdev->dev,
> +				sizeof(struct imx_fb_videomode), GFP_KERNEL);
> +		if (!fbi->mode) {
> +			ret = -ENOMEM;
> +			goto failed_of_parse;
> +		}
> +
> +		ret = imxfb_of_read_mode(&pdev->dev, display_np, fbi->mode);
> +		if (ret)
> +			goto failed_of_parse;
> +	}
> +
> +	/* Calculate maximum bytes used per pixel. In most cases this should
> +	 * be the same as m->bpp/8 */
> +	m = &fbi->mode[0];
> +	bytes_per_pixel = (m->bpp + 7) / 8;
> +	for (i = 0; i < fbi->num_modes; i++, m++)
> +		info->fix.smem_len = max_t(size_t, info->fix.smem_len,
> +				m->mode.xres * m->mode.yres * bytes_per_pixel);
> +
>  	res = request_mem_region(res->start, resource_size(res),
>  				DRIVER_NAME);
>  	if (!res) {
> @@ -843,7 +966,8 @@ static int __init imxfb_probe(struct platform_device *pdev)
>  		goto failed_ioremap;
>  	}
>  
> -	if (!pdata->fixed_screen_cpu) {
> +	/* Seems not being used by anyone, so no support for oftree */
> +	if (!pdata || !pdata->fixed_screen_cpu) {
>  		fbi->map_size = PAGE_ALIGN(info->fix.smem_len);
>  		fbi->map_cpu = dma_alloc_writecombine(&pdev->dev,
>  				fbi->map_size, &fbi->map_dma, GFP_KERNEL);
> @@ -868,18 +992,16 @@ static int __init imxfb_probe(struct platform_device *pdev)
>  		info->fix.smem_start = fbi->screen_dma;
>  	}
>  
> -	if (pdata->init) {
> +	if (pdata && pdata->init) {
>  		ret = pdata->init(fbi->pdev);
>  		if (ret)
>  			goto failed_platform_init;
>  	}
>  
> -	fbi->mode = pdata->mode;
> -	fbi->num_modes = pdata->num_modes;
>  
>  	INIT_LIST_HEAD(&info->modelist);
> -	for (i = 0; i < pdata->num_modes; i++)
> -		fb_add_videomode(&pdata->mode[i].mode, &info->modelist);
> +	for (i = 0; i < fbi->num_modes; i++)
> +		fb_add_videomode(&fbi->mode[i].mode, &info->modelist);
>  
>  	/*
>  	 * This makes sure that our colour bitfield
> @@ -909,10 +1031,10 @@ static int __init imxfb_probe(struct platform_device *pdev)
>  failed_register:
>  	fb_dealloc_cmap(&info->cmap);
>  failed_cmap:
> -	if (pdata->exit)
> +	if (pdata && pdata->exit)
>  		pdata->exit(fbi->pdev);
>  failed_platform_init:
> -	if (!pdata->fixed_screen_cpu)
> +	if (pdata && !pdata->fixed_screen_cpu)
>  		dma_free_writecombine(&pdev->dev,fbi->map_size,fbi->map_cpu,
>  			fbi->map_dma);
>  failed_map:
> @@ -921,6 +1043,7 @@ failed_ioremap:
>  failed_getclock:
>  	release_mem_region(res->start, resource_size(res));
>  failed_req:
> +failed_of_parse:
>  	kfree(info->pseudo_palette);
>  failed_init:
>  	platform_set_drvdata(pdev, NULL);
> @@ -945,7 +1068,7 @@ static int imxfb_remove(struct platform_device *pdev)
>  	unregister_framebuffer(info);
>  
>  	pdata = pdev->dev.platform_data;
> -	if (pdata->exit)
> +	if (pdata && pdata->exit)
>  		pdata->exit(fbi->pdev);
>  
>  	fb_dealloc_cmap(&info->cmap);
> @@ -974,6 +1097,7 @@ static struct platform_driver imxfb_driver = {
>  	.shutdown	= imxfb_shutdown,
>  	.driver		= {
>  		.name	= DRIVER_NAME,
> +		.of_match_table = imxfb_of_dev_id,
>  	},
>  	.id_table	= imxfb_devtype,
>  };
> -- 
> 1.8.2.1
> 
