From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sun, 13 Feb 2011 13:31:16 +0000
Subject: Re: [PATCH] ARM: PXA: Make PXA27x/PXA3xx overlay actually work
Message-Id: <20110213133116.GD4799@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Eric - ping?

On Wed, Feb 02, 2011 at 10:46:59PM +0200, Vasily Khoruzhick wrote:
> From: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
> 
> Release callback tries to free memory even if it was not allocated in
> map_video_memory. Fix PXA27x/3xx overlay memory management and make overlay
> actually work.
> 
> Added by Vasily Khoruzhick:
> 
> - Move overlay Z-ordering selection into main fb initialization,
> otherwise plane ordering is wrong.
> - Clear x_res/y_res fields of fb.var on release, to make sure
> our callback will be called on next FBIOPUT_VSCREENINFO ioctl.
> - Disable overlay only if it was enabled.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/video/pxafb.c |   86 ++++++++++++++++++++++++++++++------------------
>  drivers/video/pxafb.h |    2 +-
>  2 files changed, 55 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index 825b665..33f607a 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -629,16 +629,19 @@ static void overlay1fb_disable(struct pxafb_layer *ofb)
>  {
>  	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
>  
> -	lcd_writel(ofb->fbi, OVL1C1, ofb->control[0] & ~OVLxC1_OEN);
> +	if (lcd_readl(ofb->fbi, OVL1C1) & OVLxC1_OEN) {
> +		lcd_writel(ofb->fbi, OVL1C1, ofb->control[0] & ~OVLxC1_OEN);
>  
> -	lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(1));
> -	lcd_writel(ofb->fbi, LCCR5, lccr5 & ~LCSR1_BS(1));
> -	lcd_writel(ofb->fbi, FBR1, ofb->fbi->fdadr[DMA_OV1] | 0x3);
> +		lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(1));
> +		lcd_writel(ofb->fbi, LCCR5, lccr5 & ~LCSR1_BS(1));
> +		lcd_writel(ofb->fbi, FBR1, ofb->fbi->fdadr[DMA_OV1] | 0x3);
>  
> -	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) = 0)
> -		pr_warning("%s: timeout disabling overlay1\n", __func__);
> +		if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) = 0)
> +			pr_warning("%s: timeout disabling overlay1\n",
> +				__func__);
>  
> -	lcd_writel(ofb->fbi, LCCR5, lccr5);
> +		lcd_writel(ofb->fbi, LCCR5, lccr5);
> +	}
>  }
>  
>  static void overlay2fb_setup(struct pxafb_layer *ofb)
> @@ -687,16 +690,19 @@ static void overlay2fb_disable(struct pxafb_layer *ofb)
>  {
>  	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
>  
> -	lcd_writel(ofb->fbi, OVL2C1, ofb->control[0] & ~OVLxC1_OEN);
> +	if (lcd_readl(ofb->fbi, OVL2C1) & OVLxC1_OEN) {
> +		lcd_writel(ofb->fbi, OVL2C1, ofb->control[0] & ~OVLxC1_OEN);
>  
> -	lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(2));
> -	lcd_writel(ofb->fbi, LCCR5, lccr5 & ~LCSR1_BS(2));
> -	lcd_writel(ofb->fbi, FBR2, ofb->fbi->fdadr[DMA_OV2_Y]  | 0x3);
> -	lcd_writel(ofb->fbi, FBR3, ofb->fbi->fdadr[DMA_OV2_Cb] | 0x3);
> -	lcd_writel(ofb->fbi, FBR4, ofb->fbi->fdadr[DMA_OV2_Cr] | 0x3);
> +		lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(2));
> +		lcd_writel(ofb->fbi, LCCR5, lccr5 & ~LCSR1_BS(2));
> +		lcd_writel(ofb->fbi, FBR2, ofb->fbi->fdadr[DMA_OV2_Y]  | 0x3);
> +		lcd_writel(ofb->fbi, FBR3, ofb->fbi->fdadr[DMA_OV2_Cb] | 0x3);
> +		lcd_writel(ofb->fbi, FBR4, ofb->fbi->fdadr[DMA_OV2_Cr] | 0x3);
>  
> -	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) = 0)
> -		pr_warning("%s: timeout disabling overlay2\n", __func__);
> +		if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) = 0)
> +			pr_warning("%s: timeout disabling overlay2\n",
> +				__func__);
> +	}
>  }
>  
>  static struct pxafb_layer_ops ofb_ops[] = {
> @@ -720,12 +726,10 @@ static int overlayfb_open(struct fb_info *info, int user)
>  	if (user = 0)
>  		return -ENODEV;
>  
> -	/* allow only one user at a time */
> -	if (atomic_inc_and_test(&ofb->usage))
> -		return -EBUSY;
> +	if (ofb->usage++ = 0)
> +		/* unblank the base framebuffer */
> +		fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
>  
> -	/* unblank the base framebuffer */
> -	fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
>  	return 0;
>  }
>  
> @@ -733,12 +737,24 @@ static int overlayfb_release(struct fb_info *info, int user)
>  {
>  	struct pxafb_layer *ofb = (struct pxafb_layer*) info;
>  
> -	atomic_dec(&ofb->usage);
> -	ofb->ops->disable(ofb);
> -
> -	free_pages_exact(ofb->video_mem, ofb->video_mem_size);
> -	ofb->video_mem = NULL;
> -	ofb->video_mem_size = 0;
> +	if (--ofb->usage = 0) {
> +		ofb->ops->disable(ofb);
> +		ofb->fb.var.height	= -1;
> +		ofb->fb.var.width	= -1;
> +		ofb->fb.var.xres = ofb->fb.var.xres_virtual = 0;
> +		ofb->fb.var.yres = ofb->fb.var.yres_virtual = 0;
> +
> +		mutex_lock(&ofb->fb.mm_lock);
> +		ofb->fb.fix.smem_start	= 0;
> +		ofb->fb.fix.smem_len	= 0;
> +		mutex_unlock(&ofb->fb.mm_lock);
> +
> +		if (ofb->video_mem) {
> +			free_pages_exact(ofb->video_mem, ofb->video_mem_size);
> +			ofb->video_mem = NULL;
> +			ofb->video_mem_size = 0;
> +		}
> +	}
>  	return 0;
>  }
>  
> @@ -817,7 +833,8 @@ static int overlayfb_map_video_memory(struct pxafb_layer *ofb)
>  		if (ofb->video_mem_size >= size)
>  			return 0;
>  
> -		free_pages_exact(ofb->video_mem, ofb->video_mem_size);
> +		/* don't re-allocate: userspace may have the buffer mapped */
> +		return -EINVAL;
>  	}
>  
>  	ofb->video_mem = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
> @@ -891,7 +908,7 @@ static void __devinit init_pxafb_overlay(struct pxafb_info *fbi,
>  
>  	ofb->id = id;
>  	ofb->ops = &ofb_ops[id];
> -	atomic_set(&ofb->usage, 0);
> +	ofb->usage = 0;
>  	ofb->fbi = fbi;
>  	init_completion(&ofb->branch_done);
>  }
> @@ -923,8 +940,6 @@ static int __devinit pxafb_overlay_init(struct pxafb_info *fbi)
>  	/* mask all IU/BS/EOF/SOF interrupts */
>  	lcd_writel(fbi, LCCR5, ~0);
>  
> -	/* place overlay(s) on top of base */
> -	fbi->lccr0 |= LCCR0_OUC;
>  	pr_info("PXA Overlay driver loaded successfully!\n");
>  	return 0;
>  }
> @@ -1368,7 +1383,8 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
>  	    (lcd_readl(fbi, LCCR3) != fbi->reg_lccr3) ||
>  	    (lcd_readl(fbi, LCCR4) != fbi->reg_lccr4) ||
>  	    (lcd_readl(fbi, FDADR0) != fbi->fdadr[0]) ||
> -	    (lcd_readl(fbi, FDADR1) != fbi->fdadr[1]))
> +	    ((fbi->lccr0 & LCCR0_SDS) &&
> +	    (lcd_readl(fbi, FDADR1) != fbi->fdadr[1])))
>  		pxafb_schedule_work(fbi, C_REENABLE);
>  
>  	return 0;
> @@ -1420,7 +1436,8 @@ static void pxafb_enable_controller(struct pxafb_info *fbi)
>  	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 & ~LCCR0_ENB);
>  
>  	lcd_writel(fbi, FDADR0, fbi->fdadr[0]);
> -	lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
> +	if (fbi->lccr0 & LCCR0_SDS)
> +		lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
>  	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 | LCCR0_ENB);
>  }
>  
> @@ -1806,6 +1823,11 @@ static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
>  
>  	pxafb_decode_mach_info(fbi, inf);
>  
> +#ifdef CONFIG_FB_PXA_OVERLAY
> +	if (cpu_is_pxa27x())
> +		fbi->lccr0 |= LCCR0_OUC;
> +#endif
> +
>  	init_waitqueue_head(&fbi->ctrlr_wait);
>  	INIT_WORK(&fbi->task, pxafb_task);
>  	mutex_init(&fbi->ctrlr_lock);
> diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
> index 2353521..84e3ae1 100644
> --- a/drivers/video/pxafb.h
> +++ b/drivers/video/pxafb.h
> @@ -92,7 +92,7 @@ struct pxafb_layer_ops {
>  struct pxafb_layer {
>  	struct fb_info		fb;
>  	int			id;
> -	atomic_t		usage;
> +	uint32_t		usage;
>  	uint32_t		control[2];
>  
>  	struct pxafb_layer_ops	*ops;
> -- 
> 1.7.4.rc1
> 
