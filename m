From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 29 Jul 2013 11:14:57 +0000
Subject: Re: [PATCH 4/5] fb: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <20130729111457.GB3029@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
 <1373609276-14566-5-git-send-email-b18965@freescale.com>
In-Reply-To: <1373609276-14566-5-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jul 12, 2013 at 02:07:55PM +0800, Alison Wang wrote:
> The Display Controller Unit (DCU) module is a system master that
> fetches graphics stored in internal or external memory and displays
> them on a TFT LCD panel. A wide range of panel sizes is supported
> and the timing of the interface signals is highly configurable.
> Graphics are read directly from memory and then blended in real-time,
> which allows for dynamic content creation with minimal CPU intervention.

Only a review of the code inline.

Maybe the real question is whether we want to introduce another
framebuffer driver at all instead of making it a DRM driver.

> +
> +#define DRIVER_NAME			"fsl-dcu-fb"
> +
> +#define DCU_DCU_MODE			0x0010
> +#define DCU_MODE_BLEND_ITER(x)		(x << 20)

What's the result of DCU_MODE_BLEND_ITER(1 + 1)?

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

We have ways to describe a panel in dt. Use them.

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

Wrong indentation.

> +	default:
> +		printk(KERN_ERR "unsupported color depth: %u\n",
> +			var->bits_per_pixel);

Use dev_* for printing messages in drivers.

> +static int fsl_dcu_check_var(struct fb_var_screeninfo *var,
> +		struct fb_info *info)
> +{
> +	if (var->xres_virtual < var->xres)
> +		var->xres_virtual = var->xres;
> +	if (var->yres_virtual < var->yres)
> +		var->yres_virtual = var->yres;
> +
> +	if (var->xoffset < 0)
> +		var->xoffset = 0;
> +
> +	if (var->yoffset < 0)
> +		var->yoffset = 0;

Ever seen an unsigned value going below zero?

> +	default:
> +		printk(KERN_ERR "unsupported color depth: %u\n",
> +			var->bits_per_pixel);

BUG(). This can't happen since you make that sure above.

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int calc_div_ratio(struct fb_info *info)
> +{

Use a consistent namespace for function names (fsl_dcu_)

> +	writel(DCU_THRESHOLD_LS_BF_VS(0x3) | DCU_THRESHOLD_OUT_BUF_HIGH(0x78) |
> +		DCU_THRESHOLD_OUT_BUF_LOW(0), dcufb->reg_base + DCU_THRESHOLD);
> +
> +	enable_controller(info);
> +}

Make your functions symmetric. If there's update_controller(), the
function should do exactly that, it should *not* enable the controller.
Call this from the users of this function if necessary.

> +		if (copy_to_user(buf, &alpha, sizeof(alpha)))
> +			return -EFAULT;
> +		break;
> +	case MFB_SET_ALPHA:
> +		if (copy_from_user(&alpha, buf, sizeof(alpha)))
> +			return -EFAULT;
> +		mfbi->blend = 1;
> +		mfbi->alpha = alpha;
> +		fsl_dcu_set_par(info);
> +		break;

Is it still state of the art to introduce ioctls in the fb framework
without any kind of documentation?

> +	default:
> +		printk(KERN_ERR "unknown ioctl command (0x%08X)\n", cmd);

What shall a reader of the kernel log do with a message like this? It's
utterly useless when he doesn't even now which device failed here. Just
drop this.

> +static void enable_interrupts(struct dcu_fb_data *dcufb)
> +{
> +	u32 int_mask = readl(dcufb->reg_base + DCU_INT_MASK);
> +
> +	writel(int_mask & ~DCU_INT_MASK_UNDRUN, dcufb->reg_base + DCU_INT_MASK);
> +}

Inline this code where you need it. Introducing a function for a single
register write seems quite useless.

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

Propagate the error.

> +		goto failed_checkvar;
> +	}
> +
> +	if (register_framebuffer(info) < 0) {
> +		ret = -EINVAL;

ditto

> +static irqreturn_t fsl_dcu_irq(int irq, void *dev_id)
> +{
> +	struct dcu_fb_data *dcufb = dev_id;
> +	unsigned int status = readl(dcufb->reg_base + DCU_INT_STATUS);
> +	u32 dcu_mode;
> +
> +	if (status) {

Save indendation level by bailing out early.

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
> +	if (IS_ERR(tcon_clk)) {
> +		ret = PTR_ERR(tcon_clk);
> +		goto failed_getclock;
> +	}
> +	clk_prepare_enable(tcon_clk);
> +
> +	tcon_reg = of_iomap(tcon_np, 0);

Use devm_*

> +	dcufb->irq = platform_get_irq(pdev, 0);
> +	if (!dcufb->irq) {
> +		ret = -EINVAL;
> +		goto failed_getirq;
> +	}
> +
> +	ret = request_irq(dcufb->irq, fsl_dcu_irq, 0, DRIVER_NAME, dcufb);

Use devm_request_irq

> +	if (ret) {
> +		dev_err(&pdev->dev, "could not request irq\n");
> +		goto failed_requestirq;
> +	}
> +
> +	/* Put TCON in bypass mode, so the input signals from DCU are passed
> +	 * through TCON unchanged */
> +	ret = bypass_tcon(pdev->dev.of_node);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not bypass TCON\n");
> +		goto failed_bypasstcon;
> +	}
> +
> +	dcufb->clk = devm_clk_get(&pdev->dev, "dcu");
> +	if (IS_ERR(dcufb->clk)) {
> +		dev_err(&pdev->dev, "could not get clock\n");
> +		goto failed_getclock;

You will return 0 here.

> +	}
> +	clk_prepare_enable(dcufb->clk);
> +
> +	for (i = 0; i < ARRAY_SIZE(dcufb->fsl_dcu_info); i++) {
> +		dcufb->fsl_dcu_info[i] > +			framebuffer_alloc(sizeof(struct mfb_info), &pdev->dev);
> +		if (!dcufb->fsl_dcu_info[i]) {
> +			ret = ENOMEM;

-ENOMEM

> +failed_alloc_framebuffer:
> +failed_getclock:
> +failed_bypasstcon:
> +	free_irq(dcufb->irq, dcufb);
> +failed_requestirq:
> +failed_getirq:
> +	iounmap(dcufb->reg_base);

You used devm_ioremap, so drop this.

> +failed_ioremap:
> +	kfree(dcufb);

This is allocated with devm_*. Drop this.


Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
