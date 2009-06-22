From: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [Linux-fbdev-devel] [PATCH] Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Mon, 22 Jun 2009 09:58:24 +0530
Message-ID: <34307.9051854604$1245645023@news.gmane.org>
References: <1245336154-11554-1-git-send-email-sudhakar.raj@ti.com>
	<20090619113552.6c4f7b04.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20090619113552.6c4f7b04.krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Content-Type: text/plain; charset="us-ascii"
To: 'Krzysztof Helt' <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, 'Pavel Kiryukhin' <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

Hi,

On Fri, Jun 19, 2009 at 15:05:52, Krzysztof Helt wrote:
> HI,
> 
> This version of the driver is much cleaner however major issues still
remains.
> 
> 1. The driver seems not able to change graphics mode (depth or resolution)
> but check_var() and set_par() are defined. The set_par() function does not
> modify any register. You should move this few settings done there to
> lcd initialization functions and just remove the check_var() and
set_par().

Forgot to remove this in my last version. I'll do it this time.

> 
> 2. The driver does not set pseudo palette entries but uses true color mode
> (16-bit). See other driver show to do this (I advice tdfxfb.c).

Sorry, but I didn't understand this comment. By default this driver uses
PSEUDOCOLOR mode and this controller does not need palette data for
TRUECOLOR
mode.

> 
> 3. The request_mem_region() should be accompanied by the
release_mem_region()
> (I have not noticed it in my previous review).
> 
> 4. Check error paths in the probing functions. Not all already
requested/allocated
> resources are released correctly (e.g. the in one path there is no
clk_put() called).
> 

Will take care of both the above comments.

> Minor issues are in comments below.
> 
> If any of above issues is false let me know. I am not specialist in all
types of 
> embedded lcd controllers.
> 
> Kind regards,
> Krzysztof
> 
> On Thu, 18 Jun 2009 10:42:34 -0400
> "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org> wrote:
> 
> > Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx architecture.
> > LCDC specifications can be found at http://www.ti.com/litv/pdf/sprufm0a.
> > 
> > LCDC on DA8xx consists of two independent controllers, the Raster
Controller
> > and the LCD Interface Display Driver (LIDD) controller. LIDD further
supports
> > character and graphic displays.
> > 
> > This patch adds support for the graphic display (Sharp LQ035Q3DG01)
found on
> > the DA830 based EVM. The EVM details can be found at:
> > http://support.spectrumdigital.com/boards/dskda830/revc/.
> > 
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> > Signed-off-by: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> > ---

[. . . ]

> > +
> > +/* Palette Initialization */
> > +static int init_palette(struct fb_info *info)
> > +{
> > +	struct da8xx_fb_par *par = info->par;
> > +	unsigned short *palette = (unsigned short *)par->p_palette_base;
> > +	unsigned short i, size;
> > +
> > +	/* Palette Size */
> > +	size = (info->cmap.len / sizeof(*palette));
> > +
> > +	/* Clear the Palette */
> > +	memset(palette, 0, info->cmap.len);
> > +
> > +	/* Initialization of Palette for Default values */
> > +	for (i = 0; i < size; i++)
> > +		*(unsigned short *)(palette + i) = i;
> > +
> > +	/* Setup the BPP */
> > +	switch (info->var.bits_per_pixel) {
> > +	case 1:
> > +		palette[0] |= BIT(11);
> > +		break;
> > +	case 2:
> > +		palette[0] |= BIT(12);
> > +		break;
> > +	case 4:
> > +		palette[0] |= (2 << 12);
> > +		break;
> > +	case 8:
> > +		palette[0] |= (3 << 12);
> > +		break;
> > +	case 16:
> > +		palette[0] |= (4 << 12);
> > +		break;
> > +	default:
> > +		dev_dbg(info->dev, "GLCD: Unsupported Video BPP %d!\n",
> > +			info->var.bits_per_pixel);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0; i < size; i++)
> > +		par->pseudo_palette[i] = i;
> > +
> 
> The pseudo palette entries do not need to be initialized. Just handle them
> correctly in the fb_setcolreg.

Do you mean to say this whole function is not needed or just the above line?

> 
> > +	return 0;
> > +}

[. . .]

> > +
> > +
> > +static int __init fb_probe(struct platform_device *device)
> > +{
> > +	struct da8xx_lcdc_platform_data *fb_pdata =
> > +						device->dev.platform_data;
> > +	struct lcd_ctrl_config *lcd_cfg;
> > +	struct da8xx_panel *lcdc_info;
> > +	struct fb_info *da8xx_fb_info;
> > +	struct resource *lcdc_regs;
> > +	struct clk *fb_clk = NULL;
> > +	struct da8xx_fb_par *par;
> > +	resource_size_t len;
> > +	int ret, i;
> > +
> > +	if (fb_pdata == NULL) {
> > +		dev_err(&device->dev, "Can not get platform data\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
> > +	if (!lcdc_regs) {
> > +		dev_err(&device->dev,
> > +			"Can not get memory resource for LCD controller\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	len = lcdc_regs->end - lcdc_regs->start + 1;
> > +
> > +	lcdc_regs = request_mem_region(lcdc_regs->start, len,
lcdc_regs->name);
> > +	if (!lcdc_regs)
> > +		return -EBUSY;
> > +
> > +	da8xx_fb_reg_base = (resource_size_t)ioremap(lcdc_regs->start, len);
> > +
> > +	fb_clk = clk_get(&device->dev, NULL);
> > +	if (IS_ERR(fb_clk)) {
> > +		dev_err(&device->dev, "Can not get device clock\n");
> > +		return -ENODEV;
> > +	}
> > +	ret = clk_enable(fb_clk);
> > +	if (ret)
> > +		goto err_clk_put;
> > +
> > +	for (i = 0, lcdc_info = known_lcd_panels;
> > +		i < ARRAY_SIZE(known_lcd_panels);
> > +		i++, lcdc_info++) {
> > +		if (strcmp(fb_pdata->type, lcdc_info->name) == 0)
> > +			break;
> > +	}
> > +
> > +	if (i == ARRAY_SIZE(known_lcd_panels)) {
> > +		dev_err(&device->dev, "GLCD: No valid panel found\n");
> > +		return -ENODEV;
> 
> Missing the clk_put()/clk_disable() here.

I'll correct this.

> 
> > +	} else
> > +		dev_info(&device->dev, "GLCD: Found %s panel\n",
> > +					fb_pdata->type);
> > +
> > +	lcd_cfg = (struct lcd_ctrl_config *)fb_pdata->controller_data;
> > +
> > +	da8xx_fb_info = framebuffer_alloc(sizeof(struct da8xx_fb_par),
> > +					&device->dev);
> > +	if (!da8xx_fb_info) {
> > +		dev_dbg(&device->dev, "Memory allocation failed for
fb_info\n");
> > +		ret = -ENOMEM;
> > +		goto err_clk_disable;
> > +	}
> > +
> > +	par = da8xx_fb_info->par;
> > +
> > +	if (lcd_init(par, lcd_cfg, lcdc_info) < 0) {
> > +		dev_err(&device->dev, "lcd_init failed\n");
> > +		ret = -EFAULT;
> 
> The da8xx_fb_info should be released as well.

OK.

> 
> > +		goto err_clk_disable;
> > +	}
> > +
> > +	/* allocate frame buffer */
> > +	da8xx_fb_info->screen_base = dma_alloc_coherent(NULL,
> > +					par->databuf_sz + PAGE_SIZE,
> > +					(resource_size_t *)
> > +					&da8xx_fb_info->fix.smem_start,
> > +					GFP_KERNEL | GFP_DMA);
> > +
> > +	if (!da8xx_fb_info->screen_base) {
> > +		dev_err(&device->dev,
> > +			"GLCD: kmalloc for frame buffer failed\n");
> > +		ret = -EINVAL;
> > +		goto err_release_fb;
> > +	}
> > +
> > +	/* move palette base pointer by (PAGE_SIZE - palette_sz) bytes */
> > +	par->v_palette_base = da8xx_fb_info->screen_base +
> > +				(PAGE_SIZE - par->palette_sz);
> > +	par->p_palette_base = da8xx_fb_info->fix.smem_start +
> > +				(PAGE_SIZE - par->palette_sz);
> > +
> > +	/* the rest of the frame buffer is pixel data */
> > +	da8xx_fb_info->screen_base = par->v_palette_base + par->palette_sz;
> > +	da8xx_fb_info->fix.smem_start = par->p_palette_base +
par->palette_sz;
> > +	da8xx_fb_info->fix.smem_len = par->databuf_sz - par->palette_sz;
> > +
> > +	par->lcdc_clk = fb_clk;
> > +
> > +	da8xx_fb_fix.smem_start = (unsigned
long)da8xx_fb_info->fix.smem_start;
> > +	da8xx_fb_fix.smem_len = da8xx_fb_info->fix.smem_len;
> > +
> 
> Do fb_info->fix = da8xx_fb_fix earlier so these lines becomes redundant.

OK.

> 
> > +	init_waitqueue_head(&par->da8xx_wq);
> > +
> > +	par->irq = platform_get_irq(device, 0);
> > +	if (par->irq < 0) {
> > +		ret = -ENOENT;
> > +		goto err_release_fb_mem;
> > +	}
> > +
> > +	ret = request_irq(par->irq, lcdc_irq_handler, 0, DRIVER_NAME, par);
> > +	if (ret)
> > +		goto err_free_irq;
> 
> The irq handler has not been registered in case of error so the free_irq()
call
> is not required.

OK.

>  
> > +
> > +	/* Initialize par */
> > +	da8xx_fb_info->var.bits_per_pixel = lcd_cfg->bpp;
> > +
> > +	da8xx_fb_var.xres = lcdc_info->width;
> > +	da8xx_fb_var.xres_virtual = lcdc_info->width;
> > +
> > +	da8xx_fb_var.yres = lcdc_info->height;
> > +	da8xx_fb_var.yres_virtual = lcdc_info->height;
> > +
> > +	da8xx_fb_var.grayscale =
> > +	    lcd_cfg->p_disp_panel->panel_shade == MONOCHROME ? 1 : 0;
> > +	da8xx_fb_var.bits_per_pixel = lcd_cfg->bpp;
> > +
> > +	da8xx_fb_var.hsync_len = lcdc_info->hsw;
> > +	da8xx_fb_var.vsync_len = lcdc_info->vsw;
> > +
> > +	/* Initialize fbinfo */
> > +	da8xx_fb_info->flags = FBINFO_FLAG_DEFAULT;
> > +	da8xx_fb_info->fix = da8xx_fb_fix;
> > +	da8xx_fb_info->var = da8xx_fb_var;
> > +	da8xx_fb_info->fbops = &da8xx_fb_ops;
> > +	da8xx_fb_info->pseudo_palette = par->pseudo_palette;
> > +
> > +	ret = fb_alloc_cmap(&da8xx_fb_info->cmap, PALETTE_SIZE, 0);
> > +	if (ret)
> > +		goto err_free_irq;
> > +
> > +	/* First palette_sz byte of the frame buffer is the palette */
> > +	da8xx_fb_info->cmap.len = par->palette_sz;
> > +
> > +	/* Initialize the Palette */
> > +	ret = init_palette(da8xx_fb_info);
> > +	if (ret < 0)
> > +		goto err_free_irq;
> 
> One should free cmap memory here.

OK.

> 
> > +
> > +	/* Flush the buffer to the screen. */
> > +	lcd_blit(LOAD_DATA, par);
> > +
> > +	/* initialize var_screeninfo */
> > +	da8xx_fb_var.activate = FB_ACTIVATE_FORCE;
> > +	fb_set_var(da8xx_fb_info, &da8xx_fb_var);
> > +
> > +	dev_set_drvdata(&device->dev, da8xx_fb_info);
> > +	/* Register the Frame Buffer  */
> > +	if (register_framebuffer(da8xx_fb_info) < 0) {
> > +		dev_err(&device->dev,
> > +			"GLCD: Frame Buffer Registration Failed!\n");
> > +		ret = -EINVAL;
> > +		goto err_dealloc_cmap;
> > +	}
> > +
> > +	/* enable raster engine */
> > +	lcdc_write(lcdc_read(LCD_RASTER_CTRL_REG) |
> > +			LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> > +
> > +	return 0;
> > +
> > +err_dealloc_cmap:
> > +	fb_dealloc_cmap(&da8xx_fb_info->cmap);
> > +
> > +err_free_irq:
> > +	free_irq(par->irq, NULL);
> > +
> > +err_release_fb_mem:
> > +	dma_free_coherent(NULL, par->databuf_sz + PAGE_SIZE,
> > +				da8xx_fb_info->screen_base,
> > +				da8xx_fb_info->fix.smem_start);
> > +
> > +err_release_fb:
> > +	framebuffer_release(da8xx_fb_info);
> > +
> > +err_clk_disable:
> > +	clk_disable(fb_clk);
> > +
> > +err_clk_put:
> > +	clk_put(fb_clk);
> > +
> > +	return ret;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int fb_suspend(struct platform_device *dev, pm_message_t state)
> > +{
> > +	 return -EBUSY;
> > +}
> > +static int fb_resume(struct platform_device *dev)
> > +{
> > +	 return -EBUSY;
> > +}
> > +#else
> > +#define fb_suspend NULL
> > +#define fb_resume NULL
> > +#endif
> > +
> > +static struct platform_driver da8xx_fb_driver = {
> > +	.probe = fb_probe,
> > +	.remove = fb_remove,
> > +	.suspend = fb_suspend,
> > +	.resume = fb_resume,
> > +	.driver = {
> > +		   .name = DRIVER_NAME,
> > +		   .owner = THIS_MODULE,
> > +		   },
> > +};
> > +
> > +static int __init da8xx_fb_init(void)
> > +{
> > +	return platform_driver_register(&da8xx_fb_driver);
> > +}
> > +
> > +static void __exit da8xx_fb_cleanup(void)
> > +{
> > +	platform_driver_unregister(&da8xx_fb_driver);
> > +}
> > +
> > +module_init(da8xx_fb_init);
> > +module_exit(da8xx_fb_cleanup);
> > +
> > +MODULE_DESCRIPTION("Framebuffer driver for TI da8xx/omap-l1xx");
> > +MODULE_AUTHOR("Texas Instruments");
> > +MODULE_LICENSE("GPL");

I'll submit the updated version of this patch soon.

Thanks, Sudhakar
