From: Ben Dooks <ben@simtec.co.uk>
Date: Sun, 30 May 2010 06:07:09 +0000
Subject: Re: [PATCH 1/2] sm501: support booting with splash screen on embedded
Message-Id: <4C02008D.6040904@simtec.co.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274867863-4238-1-git-send-email-agust@denx.de>
In-Reply-To: <1274867863-4238-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 26/05/10 18:57, Anatolij Gustschin wrote:
> Change panel frame buffer to fb0 device and crt frame
> buffer to fb1 device. This is done to be able to use pre-
> initialized frame buffer on embedded devices. Firmware
> initializes the LCD panel controller and shows a splash
> image. We want to continue to display this image while
> booting and do not want to copy bitmap data to new frame
> buffer allocated by the driver for LCD panel. Therefore
> we make panel interface to be fb0, read out the programmed
> mode, setup fb info accordingly and do not clear the
> frame buffer content if the display controller has been
> previously enabled by the firmware.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Ben Dooks <ben@simtec.co.uk>
> Cc: Simtec Linux Team <linux@simtec.co.uk>
> ---
>  drivers/mfd/sm501.c     |   17 ++++
>  drivers/video/sm501fb.c |  188 +++++++++++++++++++++++++++++++++++++++++------
>  include/linux/sm501.h   |    3 +
>  3 files changed, 185 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> index bc9275c..a0f2feb 100644
> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -308,6 +308,23 @@ unsigned long sm501_modify_reg(struct device *dev,
>  
>  EXPORT_SYMBOL_GPL(sm501_modify_reg);
>  
> +unsigned long sm501_read_reg(struct device *dev,
> +			     unsigned long reg)
> +{
> +	struct sm501_devdata *sm = dev_get_drvdata(dev);
> +	unsigned long data;
> +	unsigned long save;
> +
> +	spin_lock_irqsave(&sm->reg_lock, save);
> +
> +	data = readl(sm->regs + reg);
> +
> +	spin_unlock_irqrestore(&sm->reg_lock, save);
> +
> +	return data;
> +}
> +EXPORT_SYMBOL_GPL(sm501_read_reg);

I'm not sure why you need locking around a read
call. I don't think you even need it, the only
place this is being called from is within this
driver.

>  /* sm501_unit_power
>   *
>   * alters the power active gate to set specific units on or off
> diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
> index b7dc180..0b59112 100644
> --- a/drivers/video/sm501fb.c
> +++ b/drivers/video/sm501fb.c
> @@ -92,6 +92,7 @@ struct sm501fb_par {
>  	void			*store_cursor;
>  	void __iomem		*cursor_regs;
>  	struct sm501fb_info	*info;
> +	bool			pre_init;	/* pre-initialized disp. cfg. */
>  };
>  
>  /* Helper functions */
> @@ -160,12 +161,12 @@ static int sm501_alloc_mem(struct sm501fb_info *inf, struct sm501_mem *mem,
>  		inf->fbmem_len = ptr;	/* adjust available memory. */
>  		break;
>  
> -	case SM501_MEMF_PANEL:
> +	case SM501_MEMF_CRT:
>  		if (size > inf->fbmem_len)
>  			return -ENOMEM;
>  
>  		ptr = inf->fbmem_len - size;
> -		fbi = inf->fb[HEAD_CRT];
> +		fbi = inf->fb[HEAD_PANEL];
>  
>  		/* round down, some programs such as directfb do not draw
>  		 * 0,0 correctly unless the start is aligned to a page start.
> @@ -179,13 +180,13 @@ static int sm501_alloc_mem(struct sm501fb_info *inf, struct sm501_mem *mem,
>  
>  		break;
>  
> -	case SM501_MEMF_CRT:
> +	case SM501_MEMF_PANEL:
>  		ptr = 0;
>  
>  		/* check to see if we have panel memory allocated
>  		 * which would put an limit on available memory. */
>  
> -		fbi = inf->fb[HEAD_PANEL];
> +		fbi = inf->fb[HEAD_CRT];
>  		if (fbi) {
>  			par = fbi->par;
>  			end = par->screen.k_addr ? par->screen.sm_addr : inf->fbmem_len;
> @@ -469,6 +470,8 @@ static int sm501fb_set_par_common(struct fb_info *info,
>  	mutex_lock(&info->mm_lock);
>  	info->fix.smem_start = fbi->fbmem_res->start + par->screen.sm_addr;
>  	info->fix.smem_len   = smem_len;
> +	info->fix.mmio_start = fbi->regs_res->start;
> +	info->fix.mmio_len   = resource_size(fbi->regs_res);
>  	mutex_unlock(&info->mm_lock);
>  
>  	info->screen_base = fbi->fbmem + par->screen.sm_addr;
> @@ -478,6 +481,14 @@ static int sm501fb_set_par_common(struct fb_info *info,
>  
>  	writel(par->screen.sm_addr | SM501_ADDR_FLIP, fbi->regs + head_addr);
>  
> +	/*
> +	 * To avoid flicker while booting we use pre-initialised
> +	 * configuration and do not reprogram the clock if the
> +	 * display controller has been initialized by the firmware.
> +	 */
> +	if (par->pre_init)
> +		return 0;
> +
>  	/* program CRT clock  */
>  
>  	pixclock = sm501fb_ps_to_hz(var->pixclock);
> @@ -1492,6 +1503,7 @@ static int sm501fb_start(struct sm501fb_info *info,
>  	struct device *dev = &pdev->dev;
>  	int k;
>  	int ret;
> +	u32 ctrl;
>  
>  	info->irq = ret = platform_get_irq(pdev, 0);
>  	if (ret < 0) {
> @@ -1576,8 +1588,20 @@ static int sm501fb_start(struct sm501fb_info *info,
>  
>  	info->fbmem_len = resource_size(res);
>  
> -	/* clear framebuffer memory - avoids garbage data on unused fb */
> -	memset(info->fbmem, 0, info->fbmem_len);
> +	/*
> +	 * Check if the display controller is enabled and
> +	 * do not clear the framebuffer content in this case
> +	 * as we want to display splash image as set by the
> +	 * firmware.
> +	 */
> +	ctrl = readl(info->regs + SM501_DC_CRT_CONTROL);
> +	ctrl &= SM501_DC_CRT_CONTROL_ENABLE;
> +	ctrl |= readl(info->regs + SM501_DC_PANEL_CONTROL) &
> +		SM501_DC_PANEL_CONTROL_EN;
> +	if (!ctrl) {
> +		/* clear fb memory - avoids garbage data on unused fb */
> +		memset(info->fbmem, 0, info->fbmem_len);
> +	}
>  
>  	/* clear palette ram - undefined at power on */
>  	for (k = 0; k < (256 * 3); k++)
> @@ -1635,6 +1659,123 @@ static void sm501fb_stop(struct sm501fb_info *info)
>  	kfree(info->regs_res);
>  }
>  
> +/*
> + * sm501fb_disp_to_mode
> + *
> + * read the mode from the current display controller configuration
> +*/
> +static void sm501fb_disp_to_mode(struct fb_info *fb,
> +				 enum sm501_controller head)
> +{
> +	struct sm501fb_par *par = fb->par;
> +	struct sm501fb_info *info = par->info;
> +	unsigned long clock;
> +	unsigned long clk_div;
> +	unsigned long freq;
> +	unsigned long div;
> +	unsigned long ctrl;
> +	unsigned long reg;
> +	unsigned int ht, hde, hsw, hs;
> +	unsigned int vt, vde, vsh, vs;
> +	int div_val[] = { 1, 2, 4, 8, 16, 32, 64, 128 };

looks like a simple 1 << x would have done instead of this
table.


> +	par->pre_init = true;
> +
> +	if (head = HEAD_PANEL)
> +		ctrl = readl(info->regs + SM501_DC_PANEL_CONTROL);
> +	else
> +		ctrl = readl(info->regs + SM501_DC_CRT_CONTROL);
> +
> +	switch (ctrl & 0x3) {
> +	case SM501_DC_PANEL_CONTROL_32BPP:
> +		fb->var.bits_per_pixel  = 32;
> +		break;
> +	case SM501_DC_PANEL_CONTROL_16BPP:
> +		fb->var.bits_per_pixel  = 16;
> +		break;
> +	default:
> +		fb->var.bits_per_pixel  = 8;
> +	}
> +
> +	if (!(ctrl & SM501_DC_PANEL_CONTROL_HSP))
> +		fb->var.sync |= FB_SYNC_HOR_HIGH_ACT;
> +	if (!(ctrl & SM501_DC_PANEL_CONTROL_VSP))
> +		fb->var.sync |= FB_SYNC_VERT_HIGH_ACT;
> +
> +	freq = 288000000;

Hmm, is this fixed for all SM501 devices?

> +	clock = sm501_read_reg(info->dev->parent, SM501_CURRENT_CLOCK);
> +	if (clock & (head = HEAD_PANEL ? 0x20000000 : 0x00100000))
> +		freq = 336000000;
> +
> +	if (head = HEAD_PANEL)
> +		clk_div = (clock >> 24) & 0x1f;
> +	else
> +		clk_div = (clock >> 16) & 0xf;
> +
> +	div = div_val[clk_div & 0x7];
> +	if (clk_div & 0x8)
> +		div *= 3;
> +	else if (clk_div & 0x10)
> +		div *= 5;
> +
> +	freq = freq / div / 2;
> +	fb->var.pixclock = sm501fb_hz_to_ps(freq);
> +	dev_dbg(info->dev, "freq %luHz, div %lu, pixclk(ps) %d\n",
> +		freq, div, fb->var.pixclock);
> +
> +	reg = readl(info->regs + ((head = HEAD_PANEL) ?
> +		    SM501_DC_PANEL_H_TOT : SM501_DC_CRT_H_TOT));
> +	ht = ((reg >> 16) & 0xfff) + 1;
> +	hde = (reg & 0xfff) + 1;
> +	reg = readl(info->regs + ((head = HEAD_PANEL) ?
> +		    SM501_DC_PANEL_H_SYNC : SM501_DC_CRT_H_SYNC));
> +	hsw = (reg >> 16) & 0xff;
> +	hs = (reg & 0xfff) + 1;
> +
> +	fb->var.right_margin = hs - hde;
> +	fb->var.left_margin = ht - hde - fb->var.right_margin - hsw;
> +	fb->var.hsync_len = hsw;
> +
> +	reg = readl(info->regs + ((head = HEAD_PANEL) ?
> +		    SM501_DC_PANEL_V_TOT : SM501_DC_CRT_V_TOT));
> +	vt = ((reg >> 16) & 0x7ff) + 1;
> +	vde = (reg & 0x7ff) + 1;
> +	reg = readl(info->regs + ((head = HEAD_PANEL) ?
> +		    SM501_DC_PANEL_V_SYNC : SM501_DC_CRT_V_SYNC));
> +	vsh = (reg >> 16) & 0x3f;
> +	vs = (reg & 0x7ff) + 1;
> +
> +	fb->var.lower_margin = vs - vde;
> +	fb->var.upper_margin = vt - vde - fb->var.lower_margin - vsh;
> +	fb->var.vsync_len = vsh;
> +
> +	if (head = HEAD_PANEL) {
> +		fb->var.xres > +			readl(info->regs + SM501_DC_PANEL_FB_WIDTH) >> 16;
> +		fb->var.yres > +			readl(info->regs + SM501_DC_PANEL_FB_HEIGHT) >> 16;
> +	} else {
> +		reg = readl(info->regs + SM501_DC_CRT_FB_OFFSET);
> +		fb->var.xres = (reg >> 16) / (fb->var.bits_per_pixel / 8);
> +		fb->var.yres = vde;
> +	}
> +	fb->var.xres_virtual = fb->var.xres;
> +	fb->var.yres_virtual = fb->var.yres;
> +
> +	dev_dbg(info->dev, "ctrl 0x%lx\n", ctrl);
> +	dev_dbg(info->dev, "pixclock %d\n", fb->var.pixclock);
> +	dev_dbg(info->dev, "bpp %d\n", fb->var.bits_per_pixel);
> +	dev_dbg(info->dev, "xres %d\n", fb->var.xres);
> +	dev_dbg(info->dev, "yres %d\n", fb->var.yres);
> +	dev_dbg(info->dev, "right_margin %d\n", fb->var.right_margin);
> +	dev_dbg(info->dev, "left_margin %d\n", fb->var.left_margin);
> +	dev_dbg(info->dev, "lower_margin %d\n", fb->var.lower_margin);
> +	dev_dbg(info->dev, "upper_margin %d\n", fb->var.upper_margin);
> +	dev_dbg(info->dev, "hsync_len %d\n", fb->var.hsync_len);
> +	dev_dbg(info->dev, "vsync_len %d\n", fb->var.vsync_len);
> +	dev_dbg(info->dev, "sync %d\n", fb->var.sync);
> +}
> +
>  static int sm501fb_init_fb(struct fb_info *fb,
>  			   enum sm501_controller head,
>  			   const char *fbname)
> @@ -1717,9 +1858,9 @@ static int sm501fb_init_fb(struct fb_info *fb,
>  	fb->var.vmode		= FB_VMODE_NONINTERLACED;
>  	fb->var.bits_per_pixel  = 16;
>  
> -	if (enable && (pd->flags & SM501FB_FLAG_USE_INIT_MODE) && 0) {
> -		/* TODO read the mode from the current display */
> -
> +	if (enable && (pd->flags & SM501FB_FLAG_USE_INIT_MODE)) {
> +		/* read the mode from the current display */
> +		sm501fb_disp_to_mode(fb, head);
>  	} else {
>  		if (pd->def_mode) {
>  			dev_info(info->dev, "using supplied mode\n");
> @@ -1730,7 +1871,7 @@ static int sm501fb_init_fb(struct fb_info *fb,
>  			fb->var.yres_virtual = fb->var.yres;
>  		} else {
>  			ret = fb_find_mode(&fb->var, fb,
> -					   NULL, NULL, 0, NULL, 8);
> +					"640x480@60", NULL, 0, NULL, 16);
>  
>  			if (ret = 0 || ret = 4) {
>  				dev_err(info->dev,
> @@ -1827,6 +1968,7 @@ static int __devinit sm501fb_start_one(struct sm501fb_info *info,
>  				       const char *drvname)
>  {
>  	struct fb_info *fbi = info->fb[head];
> +	struct sm501fb_par *par = fbi->par;
>  	int ret;
>  
>  	if (!fbi)
> @@ -1846,7 +1988,7 @@ static int __devinit sm501fb_start_one(struct sm501fb_info *info,
>  		sm501_free_init_fb(info, head);
>  		return ret;
>  	}
> -
> +	(par->ops.fb_set_par)(fbi);
>  	dev_info(info->dev, "fb%d: %s frame buffer\n", fbi->node, fbi->fix.id);
>  
>  	return 0;
> @@ -1881,18 +2023,18 @@ static int __devinit sm501fb_probe(struct platform_device *pdev)
>  
>  	/* probe for the presence of each panel */

I'd much rather see some form of swap panel/crt flag instead
of the changes being done.

> -	ret = sm501fb_probe_one(info, HEAD_CRT);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to probe CRT\n");
> -		goto err_alloc;
> -	}
> -
>  	ret = sm501fb_probe_one(info, HEAD_PANEL);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to probe PANEL\n");
>  		goto err_probed_crt;
>  	}
>  
> +	ret = sm501fb_probe_one(info, HEAD_CRT);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to probe CRT\n");
> +		goto err_alloc;
> +	}
> +
>  	if (info->fb[HEAD_PANEL] = NULL &&
>  	    info->fb[HEAD_CRT] = NULL) {
>  		dev_err(dev, "no framebuffers found\n");
> @@ -1907,18 +2049,18 @@ static int __devinit sm501fb_probe(struct platform_device *pdev)
>  		goto err_probed_panel;
>  	}
>  
> -	ret = sm501fb_start_one(info, HEAD_CRT, driver_name_crt);
> -	if (ret) {
> -		dev_err(dev, "failed to start CRT\n");
> -		goto err_started;
> -	}
> -
>  	ret = sm501fb_start_one(info, HEAD_PANEL, driver_name_pnl);
>  	if (ret) {
>  		dev_err(dev, "failed to start Panel\n");
>  		goto err_started_crt;
>  	}
>  
> +	ret = sm501fb_start_one(info, HEAD_CRT, driver_name_crt);
> +	if (ret) {
> +		dev_err(dev, "failed to start CRT\n");
> +		goto err_started;
> +	}
> +
>  	/* create device files */
>  
>  	ret = device_create_file(dev, &dev_attr_crt_src);
> diff --git a/include/linux/sm501.h b/include/linux/sm501.h
> index 214f932..e705ba6 100644
> --- a/include/linux/sm501.h
> +++ b/include/linux/sm501.h
> @@ -46,6 +46,9 @@ extern unsigned long sm501_modify_reg(struct device *dev,
>  				      unsigned long set,
>  				      unsigned long clear);
>  
> +extern unsigned long sm501_read_reg(struct device *dev,
> +				    unsigned long reg);
> +
>  
>  /* Platform data definitions */
>  

