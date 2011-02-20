From: Marek Vasut <marek.vasut@gmail.com>
Date: Sun, 20 Feb 2011 18:46:20 +0000
Subject: Re: [PATCH v2 1/3] ARM: PXA: PXAFB: Fix double-free issue
Message-Id: <201102201946.20681.marek.vasut@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110217110321.GF24627@n2100.arm.linux.org.uk>
	<1298214147-11578-1-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1298214147-11578-1-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sunday 20 February 2011 16:02:25 Vasily Khoruzhick wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> 
> Release callback tries to free memory even if it was not allocated in
> map_video_memory, fix it.
> 
> Added by Vasily Khoruzhick:
> 
> - Clear x_res/y_res fields of fb.var on release, to make sure
> our callback will be called on next FBIOPUT_VSCREENINFO ioctl.
> - Disable overlay only if it was enabled.
> - Don't touch FDADR1 if it's not necessary
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> v2: remove unnecessary newlines, add comment about FDADR1
> 
>  drivers/video/pxafb.c |   49
> ++++++++++++++++++++++++++++++++++--------------- drivers/video/pxafb.h | 
>   2 +-
>  2 files changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index 825b665..41a499f 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -629,6 +629,9 @@ static void overlay1fb_disable(struct pxafb_layer *ofb)
>  {
>  	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
> 
> +	if (!(lcd_readl(ofb->fbi, OVL1C1) & OVLxC1_OEN))
> +		return;
> +

Maybe you can even avoid reading LCCR5 above ;-)

>  	lcd_writel(ofb->fbi, OVL1C1, ofb->control[0] & ~OVLxC1_OEN);
> 
>  	lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(1));
> @@ -687,6 +690,9 @@ static void overlay2fb_disable(struct pxafb_layer *ofb)
>  {
>  	uint32_t lccr5 = lcd_readl(ofb->fbi, LCCR5);
> 
> +	if (!(lcd_readl(ofb->fbi, OVL2C1) & OVLxC1_OEN))
> +		return;
> +

Hm?

>  	lcd_writel(ofb->fbi, OVL2C1, ofb->control[0] & ~OVLxC1_OEN);
> 
>  	lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(2));
> @@ -720,12 +726,10 @@ static int overlayfb_open(struct fb_info *info, int
> user) if (user = 0)
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
> @@ -733,12 +737,24 @@ static int overlayfb_release(struct fb_info *info,
> int user) {
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
> @@ -817,7 +833,8 @@ static int overlayfb_map_video_memory(struct
> pxafb_layer *ofb) if (ofb->video_mem_size >= size)
>  			return 0;
> 
> -		free_pages_exact(ofb->video_mem, ofb->video_mem_size);
> +		/* don't re-allocate: userspace may have the buffer mapped */
> +		return -EINVAL;
>  	}
> 
>  	ofb->video_mem = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
> @@ -891,7 +908,7 @@ static void __devinit init_pxafb_overlay(struct
> pxafb_info *fbi,
> 
>  	ofb->id = id;
>  	ofb->ops = &ofb_ops[id];
> -	atomic_set(&ofb->usage, 0);
> +	ofb->usage = 0;
>  	ofb->fbi = fbi;
>  	init_completion(&ofb->branch_done);
>  }
> @@ -1368,7 +1385,8 @@ static int pxafb_activate_var(struct
> fb_var_screeninfo *var, (lcd_readl(fbi, LCCR3) != fbi->reg_lccr3) ||
>  	    (lcd_readl(fbi, LCCR4) != fbi->reg_lccr4) ||
>  	    (lcd_readl(fbi, FDADR0) != fbi->fdadr[0]) ||
> -	    (lcd_readl(fbi, FDADR1) != fbi->fdadr[1]))
> +	    ((fbi->lccr0 & LCCR0_SDS) &&
> +	    (lcd_readl(fbi, FDADR1) != fbi->fdadr[1])))
>  		pxafb_schedule_work(fbi, C_REENABLE);
> 
>  	return 0;
> @@ -1420,7 +1438,8 @@ static void pxafb_enable_controller(struct pxafb_info
> *fbi) lcd_writel(fbi, LCCR0, fbi->reg_lccr0 & ~LCCR0_ENB);
> 
>  	lcd_writel(fbi, FDADR0, fbi->fdadr[0]);
> -	lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
> +	if (fbi->lccr0 & LCCR0_SDS)
> +		lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
>  	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 | LCCR0_ENB);
>  }
> 
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
