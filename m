From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 16 Jun 2011 06:34:12 +0000
Subject: Re: [PATCH V2] video: Add GRVGA framebuffer device driver
Message-Id: <20110616063411.GC7252@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308139443-15661-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1308139443-15661-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jun 15, 2011 at 02:04:03PM +0200, Kristoffer Glembo wrote:
> +#define GRVGA_REGLOAD(a)	    (__raw_readl(&(a)))
> +#define GRVGA_REGSAVE(a, v)         (__raw_writel(v, &(a)))
> +#define GRVGA_REGORIN(a, v)         (GRVGA_REGSAVE(a, (GRVGA_REGLOAD(a) | (v))))
> +#define GRVGA_REGANDIN(a, v)        (GRVGA_REGSAVE(a, (GRVGA_REGLOAD(a) & (v))))
> +
I would recommend just getting rid of these completely, they don't really
buy you much of anything, other than forcing people to scroll to the top
to figure out what exactly it's supposed to be doing.

> +#define	GRVGA_FBINFO_DEFAULT	(FBINFO_DEFAULT \
> +				 | FBINFO_PARTIAL_PAN_OK \
> +				 | FBINFO_HWACCEL_YPAN)
> +
Same with this.

> +	switch (info->var.bits_per_pixel) {
> +	case 8:
> +		var->red   = (struct fb_bitfield) {0, 8, 0};      /* offset, length, msb-right */
> +		var->green = (struct fb_bitfield) {0, 8, 0};
> +		var->blue  = (struct fb_bitfield) {0, 8, 0};
> +		var->transp = (struct fb_bitfield) {0, 0, 0};
> +		break;
> +	case 16:
> +		var->red   = (struct fb_bitfield) {11, 5, 0};
> +		var->green = (struct fb_bitfield) {5, 6, 0};
> +		var->blue  = (struct fb_bitfield) {0, 5, 0};
> +		var->transp = (struct fb_bitfield) {0, 0, 0};
> +		break;
> +	case 24:
> +	case 32:
> +		var->red   = (struct fb_bitfield) {16, 8, 0};
> +		var->green = (struct fb_bitfield) {8, 8, 0};
> +		var->blue  = (struct fb_bitfield) {0, 8, 0};
> +		var->transp = (struct fb_bitfield) {24, 8, 0};
> +		break;

This is also a bit unconventional. var should already be zeroed out, so
you can just establish the .length values for each one as necessary.

> +static int __init grvga_parse_custom(char *options,
> +				     struct fb_var_screeninfo *screendata)
> +{
> +	char *this_opt;
> +	int count = 0;
> +	if (!options || !*options)
> +		return -1;
> +
> +	while ((this_opt = strsep(&options, " ")) != NULL) {
> +		if (!*this_opt)
> +			continue;
> +
> +		switch (count) {
> +		case 0:
> +			screendata->pixclock = simple_strtoul(this_opt, NULL, 0);
> +			count++;
> +			break;
> +		case 1:
> +			screendata->xres = screendata->xres_virtual = simple_strtoul(this_opt, NULL, 0);
> +			count++;
> +			break;

If you have open firmware available then why do you have a need to have
this bizarre "custom" command line option for parsing all of the geometry
information?

> +static int __devinit grvga_probe(struct platform_device *dev)
> +{
> +	struct fb_info *info;
> +	int retval = -ENOMEM;
> +	unsigned long virtual_start;
> +	unsigned long grvga_fix_addr = 0;
> +	unsigned long physical_start = 0;
> +	unsigned long grvga_mem_size = 0;
> +	struct grvga_par *par;
> +	char *options = NULL, *mode_opt = NULL;
> +
> +	info = framebuffer_alloc(sizeof(struct grvga_par), &dev->dev);
> +	if (!info) {
> +		dev_err(&dev->dev, "framebuffer_alloc failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Expecting: "grvga: modestring, [addr:<framebuffer physical address>], [size:<framebuffer size>]
> +	 *
> +	 * If modestring is custom:<custom mode string> we parse the string which then contains all videoparameters
> +	 * If address is left out, we allocate memory,
> +	 * if size is left out we only allocate enough to support the given mode.
> +	 */
> +	if (fb_get_options("grvga", &options)) {
> +		retval = -ENODEV;
> +		goto err;
> +	}
> +
> +	if (!options || !*options)
> +		options =  "640x480-8@60";
> +
> +	while (1) {
> +		char *this_opt = strsep(&options, ",");
> +
> +		if (!this_opt)
> +			break;
> +
> +		if (!strncmp(this_opt, "custom", 6))
> +			grvga_parse_custom(this_opt, &info->var);
> +		else if (!strncmp(this_opt, "addr:", 5))
> +			grvga_fix_addr = simple_strtoul(this_opt + 5, NULL, 16);
> +		else if (!strncmp(this_opt, "size:", 5))
> +			grvga_mem_size = simple_strtoul(this_opt + 5, NULL, 0);
> +		else
> +			mode_opt = this_opt;
> +	}
> +
You would probably benefit from ripping all of this out and stashing it
in a grvga_setup() function.

> +	par = info->par;
> +	info->fbops = &grvga_ops;
> +	info->fix = grvga_fix;
> +	info->pseudo_palette = par->color_palette;
> +	info->flags = GRVGA_FBINFO_DEFAULT;
> +	info->fix.smem_len = grvga_mem_size;
> +
> +	par->regs = of_ioremap(&dev->resource[0], 0,
> +			       resource_size(&dev->resource[0]),
> +			       "grlib-svgactrl regs");
> +
> +	retval = fb_alloc_cmap(&info->cmap, 256, 0);
> +	if (retval < 0) {
> +		dev_err(&dev->dev, "failed to allocate mem with fb_alloc_cmap\n");
> +		retval = -ENOMEM;
> +		goto err1;
> +	}
> +
Can of_ioremap() fail?

> +	if (mode_opt) {
> +		retval = fb_find_mode(&info->var, info, mode_opt,
> +				      grvga_modedb, sizeof(grvga_modedb), &grvga_modedb[0], 8);
> +		if (!retval || retval = 4) {
> +			retval = -EINVAL;
> +			goto err2;
> +		}
> +	}
> +
> +	if (!grvga_mem_size)
> +		grvga_mem_size = info->var.xres_virtual * info->var.yres_virtual * info->var.bits_per_pixel/8;
> +
> +	if (grvga_fix_addr) {
> +		/* Got framebuffer base address from argument list */
> +
> +		physical_start = grvga_fix_addr;
> +
> +		if (!request_mem_region(physical_start, grvga_mem_size, dev->name)) {
> +			dev_err(&dev->dev, "request mem region failed\n");
> +			retval = -ENOMEM;
> +			goto err2;
> +		}
> +
> +		virtual_start = (unsigned long) ioremap(physical_start, grvga_mem_size);
> +
> +		if (!virtual_start) {
> +			dev_err(&dev->dev, "error mapping memory\n");
> +			retval = -ENOMEM;
> +			goto err3;
> +		}
> +	} else {	/* Allocate frambuffer memory */
> +
> +		unsigned long page;
> +
> +		virtual_start = (unsigned long) __get_free_pages(GFP_ATOMIC | GFP_DMA,
> +								 get_order(grvga_mem_size));

GFP_ATOMIC?

> +		if (!virtual_start) {
> +			dev_err(&dev->dev,
> +				"unable to allocate framebuffer memory (%lu bytes)\n",
> +				grvga_mem_size);
> +			retval = -ENOMEM;
> +			goto err2;
> +		}
> +
> +
> +		physical_start = __pa(virtual_start);
> +
> +		/* Set page reserved so that mmap will work. This is necessary
> +		 * since we'll be remapping normal memory.
> +		 */
> +		for (page = virtual_start;
> +		     page < PAGE_ALIGN(virtual_start + grvga_mem_size);
> +		     page += PAGE_SIZE) {
> +			SetPageReserved(virt_to_page(page));
> +		}
> +	}
> +
This all looks like a good candidate for dma_alloc_coherent().

> +static int __devexit grvga_remove(struct platform_device *device)
> +{
> +	struct fb_info *info = dev_get_drvdata(&device->dev);
> +	struct grvga_par *par = info->par;
> +
> +	if (info) {
> +		unregister_framebuffer(info);
> +		fb_dealloc_cmap(&info->cmap);
> +		of_iounmap(&device->resource[0], par->regs,
> +			   resource_size(&device->resource[0]));
> +		framebuffer_release(info);
> +		dev_set_drvdata(&device->dev, NULL);
> +	}
> +
You seem to be missing a release_mem_region() in here.

> +	return 0;
> +}
> +
> +static struct of_device_id svgactrl_of_match[] = {
> +	{
> +		.name = "GAISLER_SVGACTRL",
> +	},
> +	{
> +		.name = "01_063",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, svgactrl_of_match);
> +
> +static struct platform_driver grvga_driver = {
> +	.driver = {
> +		.name = "grlib-svgactrl",
> +		.owner = THIS_MODULE,
> +		.of_match_table = svgactrl_of_match,
> +	},
> +	.probe		= grvga_probe,
> +	.remove		= __devexit_p(grvga_remove),
> +};
> +
> +
> +int __init grvga_init(void)
> +{
> +	return platform_driver_register(&grvga_driver);
> +}
> +
static?
