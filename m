From: Lucas Stach <l.stach@pengutronix.de>
Date: Tue, 06 Aug 2013 08:47:39 +0000
Subject: Re: [PATCH 4/5] fb: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <1375778859.4276.25.camel@weser.hi.pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
 <1373609276-14566-5-git-send-email-b18965@freescale.com>
In-Reply-To: <1373609276-14566-5-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Am Freitag, den 12.07.2013, 14:07 +0800 schrieb Alison Wang:
> The Display Controller Unit (DCU) module is a system master that
> fetches graphics stored in internal or external memory and displays
> them on a TFT LCD panel. A wide range of panel sizes is supported
> and the timing of the interface signals is highly configurable.
> Graphics are read directly from memory and then blended in real-time,
> which allows for dynamic content creation with minimal CPU intervention.
> 
> The features:
> 
> (1) Full RGB888 output to TFT LCD panel.
> (2) For the current LCD panel, WQVGA "480x272" is tested.
> (3) Blending of each pixel using up to 4 source layers dependent on size of panel.
> (4) Each graphic layer can be placed with one pixel resolution in either axis.
> (5) Each graphic layer support RGB565 and RGB888 direct colors without alpha channel
> and BGRA8888 direct colors with an alpha channel.
> (6) Each graphic layer support alpha blending with 8-bit resolution.
> 
> This driver has been tested on Vybrid VF610 TOWER board.
> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> ---
> Changes in v2: None
> 
>  drivers/video/Kconfig      |    9 +
>  drivers/video/Makefile     |    1 +
>  drivers/video/fsl-dcu-fb.c | 1091 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1101 insertions(+)
>  create mode 100644 drivers/video/fsl-dcu-fb.c
> 
[...]
> +
> +static struct fb_videomode dcu_mode_db[] = {
> +	{
> +		.name		= "480x272",
> +		.refresh	= 75,
> +		.xres		= 480,
> +		.yres		= 272,
> +		.pixclock	= 91996,
> +		.left_margin	= 2,
> +		.right_margin	= 2,
> +		.upper_margin	= 1,
> +		.lower_margin	= 1,
> +		.hsync_len	= 41,
> +		.vsync_len	= 2,
> +		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +		.vmode		= FB_VMODE_NONINTERLACED,
> +	},
> +};
Don't hardcode panel data in the driver. Use the videomode helpers to
get the relevant data from devicetree.

> +
> +/* DCU framebuffer data structure */
> +struct dcu_fb_data {
> +	struct fb_info *fsl_dcu_info[DCU_LAYER_NUM];
> +	void __iomem *reg_base;
> +	unsigned int irq;
> +	struct clk *clk;
> +};
> +
> +struct layer_display_offset {
> +	int x_layer_d;
> +	int y_layer_d;
> +};
> +
> +struct mfb_info {
> +	int index;
> +	char *id;
> +	unsigned long pseudo_palette[16];
> +	unsigned char alpha;
> +	unsigned char blend;
> +	unsigned int count;
> +	int x_layer_d;	/* layer display x offset to physical screen */
> +	int y_layer_d;	/* layer display y offset to physical screen */
> +	struct dcu_fb_data *parent;
> +};
> +
> +enum mfb_index {
> +	LAYER0 = 0,
> +	LAYER1,
> +	LAYER2,
> +	LAYER3,
> +};
Why are there only 4 layers here? I thought the controller supports at
least 6 simultaneous layers?

> +
> +static struct mfb_info mfb_template[] = {
> +	{
> +	.index = LAYER0,
> +	.id = "Layer0",
> +	.alpha = 0xff,
> +	.blend = 0,
> +	.count = 0,
> +	.x_layer_d = 0,
> +	.y_layer_d = 0,
> +	},
> +	{
> +	.index = LAYER1,
> +	.id = "Layer1",
> +	.alpha = 0xff,
> +	.blend = 0,
> +	.count = 0,
> +	.x_layer_d = 50,
> +	.y_layer_d = 50,
> +	},
> +	{
> +	.index = LAYER2,
> +	.id = "Layer2",
> +	.alpha = 0xff,
> +	.blend = 0,
> +	.count = 0,
> +	.x_layer_d = 100,
> +	.y_layer_d = 100,
> +	},
> +	{
> +	.index = LAYER3,
> +	.id = "Layer3",
> +	.alpha = 0xff,
> +	.blend = 0,
> +	.count = 0,
> +	.x_layer_d = 150,
> +	.y_layer_d = 150,
> +	},
> +};
[...]

> +
> +static int calc_div_ratio(struct fb_info *info)
> +{
> +	struct mfb_info *mfbi = info->par;
> +	struct dcu_fb_data *dcufb = mfbi->parent;
> +	unsigned long dcu_clk;
> +	unsigned long long tmp;
> +
> +	dcu_clk = clk_get_rate(dcufb->clk);
> +	tmp = info->var.pixclock * (unsigned long long)dcu_clk;
> +
> +	do_div(tmp, 1000000);
> +
> +	if (do_div(tmp, 1000000) > 500000)
> +		tmp++;
Urgh, you are changing the value of tmp inside the if clause. This isn't
nice. This function as a a whole looks really odd.

> +
> +	tmp = tmp - 1;
> +	return tmp;
> +}
> +
> +static void update_controller(struct fb_info *info)
> +{
> +	struct fb_var_screeninfo *var = &info->var;
> +	struct mfb_info *mfbi = info->par;
> +	struct dcu_fb_data *dcufb = mfbi->parent;
> +	unsigned int ratio;
> +
> +	ratio = calc_div_ratio(info);
> +	writel(ratio, dcufb->reg_base + DCU_DIV_RATIO);
> +
> +	writel(DCU_DISP_SIZE_DELTA_Y(var->yres) |
> +		DCU_DISP_SIZE_DELTA_X(var->xres / 16),
> +		dcufb->reg_base + DCU_DISP_SIZE);
> +
> +	/* Horizontal and vertical sync parameter */
> +	writel(DCU_HSYN_PARA_BP(var->left_margin) |
> +		DCU_HSYN_PARA_PW(var->hsync_len) |
> +		DCU_HSYN_PARA_FP(var->right_margin),
> +		dcufb->reg_base + DCU_HSYN_PARA);
> +
> +	writel(DCU_VSYN_PARA_BP(var->upper_margin) |
> +		DCU_VSYN_PARA_PW(var->vsync_len) |
> +		DCU_VSYN_PARA_FP(var->lower_margin),
> +		dcufb->reg_base + DCU_VSYN_PARA);
> +
> +	writel(DCU_SYN_POL_INV_PXCK_FALL | DCU_SYN_POL_NEG_REMAIN |
> +		DCU_SYN_POL_INV_VS_LOW | DCU_SYN_POL_INV_HS_LOW,
> +		dcufb->reg_base + DCU_SYN_POL);
> +
> +	writel(DCU_BGND_R(0) | DCU_BGND_G(0) | DCU_BGND_B(0),
> +		dcufb->reg_base + DCU_BGND);
> +
> +	writel(DCU_MODE_BLEND_ITER(DCU_LAYER_NUM_MAX) | DCU_MODE_RASTER_EN,
> +			dcufb->reg_base + DCU_DCU_MODE);
> +
> +	writel(DCU_THRESHOLD_LS_BF_VS(0x3) | DCU_THRESHOLD_OUT_BUF_HIGH(0x78) |
> +		DCU_THRESHOLD_OUT_BUF_LOW(0), dcufb->reg_base + DCU_THRESHOLD);
> +
> +	enable_controller(info);
> +}
> +
> +static int map_video_memory(struct fb_info *info)
> +{
> +	u32 smem_len = info->fix.line_length * info->var.yres_virtual;
> +
> +	info->fix.smem_len = smem_len;
> +
> +	info->screen_base = dma_alloc_coherent(info->device, info->fix.smem_len,
You are setting up an uncached mapping here. Use a writecombined mapping
to help performance. It's still coherent, but allows at least write to
be fast.

> +		(dma_addr_t *)&info->fix.smem_start, GFP_KERNEL);
> +	if (!info->screen_base) {
> +		printk(KERN_ERR "unable to allocate fb memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	memset(info->screen_base, 0, info->fix.smem_len);
> +
> +	return 0;
> +}
> +
> +static void unmap_video_memory(struct fb_info *info)
> +{
> +	if (!info->screen_base)
> +		return;
> +
> +	dma_free_coherent(info->device, info->fix.smem_len,
> +		info->screen_base, info->fix.smem_start);
> +
> +	info->screen_base = NULL;
> +	info->fix.smem_start = 0;
> +	info->fix.smem_len = 0;
> +}
[...]

> +
> +static int fsl_dcu_open(struct fb_info *info, int user)
> +{
> +	struct mfb_info *mfbi = info->par;
> +	int ret = 0;
> +
> +	mfbi->index = info->node;
> +
> +	mfbi->count++;
> +	if (mfbi->count = 1) {
> +		fsl_dcu_check_var(&info->var, info);
> +		ret = fsl_dcu_set_par(info);
> +		if (ret < 0)
> +			mfbi->count--;
> +		else
> +			enable_interrupts(mfbi->parent);
> +	}
> +
> +	return ret;
> +}
> +
> +static int fsl_dcu_release(struct fb_info *info, int user)
> +{
> +	struct mfb_info *mfbi = info->par;
> +	int ret = 0;
> +
> +	mfbi->count--;
> +	if (mfbi->count = 0) {
> +		ret = disable_panel(info);
> +		if (ret < 0)
> +			mfbi->count++;
> +	}
> +
> +	return ret;
> +}
Could this be replaced by runtime pm?

> +
> +static struct fb_ops fsl_dcu_ops = {
> +	.owner = THIS_MODULE,
> +	.fb_check_var = fsl_dcu_check_var,
> +	.fb_set_par = fsl_dcu_set_par,
> +	.fb_setcolreg = fsl_dcu_setcolreg,
> +	.fb_blank = fsl_dcu_blank,
> +	.fb_pan_display = fsl_dcu_pan_display,
> +	.fb_fillrect = cfb_fillrect,
> +	.fb_copyarea = cfb_copyarea,
> +	.fb_imageblit = cfb_imageblit,
> +	.fb_ioctl = fsl_dcu_ioctl,
> +	.fb_open = fsl_dcu_open,
> +	.fb_release = fsl_dcu_release,
> +};
> +
> +static int install_framebuffer(struct fb_info *info)
> +{
> +	struct mfb_info *mfbi = info->par;
> +	struct fb_videomode *db = dcu_mode_db;
> +	unsigned int dbsize = ARRAY_SIZE(dcu_mode_db);
> +	int ret;
> +
> +	info->var.activate = FB_ACTIVATE_NOW;
> +	info->fbops = &fsl_dcu_ops;
> +	info->flags = FBINFO_FLAG_DEFAULT;
> +	info->pseudo_palette = &mfbi->pseudo_palette;
> +
> +	fb_alloc_cmap(&info->cmap, 16, 0);
> +
> +	ret = fb_find_mode(&info->var, info, fb_mode, db, dbsize,
> +			NULL, default_bpp);
> +
> +	if (fsl_dcu_check_var(&info->var, info)) {
> +		ret = -EINVAL;
> +		goto failed_checkvar;
> +	}
> +
> +	if (register_framebuffer(info) < 0) {
> +		ret = -EINVAL;
> +		goto failed_register_framebuffer;
> +	}
> +
> +	printk(KERN_INFO "fb%d: %s fb device registered successfully.\n",
> +		info->node, info->fix.id);
> +	return 0;
> +
> +failed_checkvar:
> +	fb_dealloc_cmap(&info->cmap);
> +failed_register_framebuffer:
> +	unmap_video_memory(info);
> +	fb_dealloc_cmap(&info->cmap);
> +	return ret;
> +}
> +
> +static void uninstall_framebuffer(struct fb_info *info)
> +{
> +	unregister_framebuffer(info);
> +	unmap_video_memory(info);
> +
> +	if (&info->cmap)
> +		fb_dealloc_cmap(&info->cmap);
> +}
> +
> +static irqreturn_t fsl_dcu_irq(int irq, void *dev_id)
> +{
> +	struct dcu_fb_data *dcufb = dev_id;
> +	unsigned int status = readl(dcufb->reg_base + DCU_INT_STATUS);
> +	u32 dcu_mode;
> +
> +	if (status) {
> +		if (status & DCU_INT_STATUS_UNDRUN) {
> +			dcu_mode = readl(dcufb->reg_base + DCU_DCU_MODE);
> +			dcu_mode &= ~DCU_MODE_DCU_MODE_MASK;
> +			writel(dcu_mode | DCU_MODE_DCU_MODE(DCU_MODE_OFF),
> +				dcufb->reg_base + DCU_DCU_MODE);
> +			udelay(1);
> +			writel(dcu_mode | DCU_MODE_DCU_MODE(DCU_MODE_NORMAL),
> +				dcufb->reg_base + DCU_DCU_MODE);
> +		}
> +		writel(status, dcufb->reg_base + DCU_INT_STATUS);
> +		return IRQ_HANDLED;
> +	}
> +	return IRQ_NONE;
> +}
> +
> +#ifdef CONFIG_PM
> +static int fsl_dcu_suspend(struct platform_device *pdev,
> +		pm_message_t state)
> +{
> +	struct dcu_fb_data *dcufb = dev_get_drvdata(&pdev->dev);
> +
> +	clk_disable_unprepare(dcufb->clk);
> +	return 0;
> +}
> +
> +static int fsl_dcu_resume(struct platform_device *pdev)
> +{
> +	struct dcu_fb_data *dcufb = dev_get_drvdata(&pdev->dev);
> +
> +	clk_prepare_enable(dcufb->clk);
> +	return 0;
> +}
> +#else
> +#define fsl_dcu_suspend	NULL
> +#define fsl_dcu_resume	NULL
> +#endif
> +
Could this be replaced by runtime pm?

> +static int bypass_tcon(struct device_node *np)
> +{
> +	struct device_node *tcon_np;
> +	struct platform_device *tcon_pdev;
> +	struct clk *tcon_clk;
> +	void __iomem *tcon_reg;
> +	int ret = 0;
> +
> +	tcon_np = of_parse_phandle(np, "tcon-controller", 0);
> +	if (!tcon_np)
> +		return -EINVAL;
> +
> +	tcon_pdev = of_find_device_by_node(tcon_np);
> +	if (!tcon_pdev)
> +		return -EINVAL;
> +
> +	tcon_clk = devm_clk_get(&tcon_pdev->dev, "tcon");
> +	if (IS_ERR(tcon_clk)) {
> +		ret = PTR_ERR(tcon_clk);
> +		goto failed_getclock;
> +	}
> +	clk_prepare_enable(tcon_clk);
> +
> +	tcon_reg = of_iomap(tcon_np, 0);
> +	if (!tcon_reg) {
> +		ret = -ENOMEM;
> +		goto failed_ioremap;
> +	}
> +	writel(TCON_BYPASS_ENABLE, tcon_reg + TCON_CTRL1);
> +
> +	return 0;
> +
> +failed_ioremap:
> +	clk_disable_unprepare(tcon_clk);
> +failed_getclock:
> +	of_node_put(tcon_np);
> +	return ret;
> +}
> +
Is the framebuffer driver the only user of tcon? If not you should not
map the memory here, but rather use something like regmap syscon.

[...]

Regards,
Lucas

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

