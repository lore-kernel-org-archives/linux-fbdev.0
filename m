From: Peter Chen <peter.chen@freescale.com>
Date: Wed, 04 Mar 2015 06:36:07 +0000
Subject: Re: [PATCH] video: mxsfb: Make sure axi clock is enabled when accessing registers
Message-Id: <20150304063604.GA2689@shlinux2>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425448735-21490-1-git-send-email-Ying.Liu@freescale.com>
In-Reply-To: <1425448735-21490-1-git-send-email-Ying.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liu Ying <Ying.Liu@freescale.com>
Cc: linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Fabio Estevam <fabio.estevam@freescale.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Wed, Mar 04, 2015 at 01:58:55PM +0800, Liu Ying wrote:
> The LCDIF engines embedded in i.MX6sl and i.MX6sx SoCs need the axi clock
> as the engine's system clock.  The clock should be enabled when accessing
> LCDIF registers, otherwise the kernel would hang up.  We should also keep
> the clock being enabled when the engine is being active to scan out frames
> from memory.  This patch makes sure the axi clock is enabled when accessing
> registers so that the kernel hang up issue can be fixed.
> 
> Reported-by: Peter Chen <peter.chen@freescale.com>
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
>  drivers/video/fbdev/mxsfb.c | 70 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
> index f8ac4a4..a8cf3b2 100644
> --- a/drivers/video/fbdev/mxsfb.c
> +++ b/drivers/video/fbdev/mxsfb.c
> @@ -316,6 +316,18 @@ static int mxsfb_check_var(struct fb_var_screeninfo *var,
>  	return 0;
>  }
>  
> +static inline void mxsfb_enable_axi_clk(struct mxsfb_info *host)
> +{
> +	if (host->clk_axi)
> +		clk_prepare_enable(host->clk_axi);
> +}
> +
> +static inline void mxsfb_disable_axi_clk(struct mxsfb_info *host)
> +{
> +	if (host->clk_axi)
> +		clk_disable_unprepare(host->clk_axi);
> +}
> +
>  static void mxsfb_enable_controller(struct fb_info *fb_info)
>  {
>  	struct mxsfb_info *host = to_imxfb_host(fb_info);
> @@ -333,14 +345,13 @@ static void mxsfb_enable_controller(struct fb_info *fb_info)
>  		}
>  	}
>  
> -	if (host->clk_axi)
> -		clk_prepare_enable(host->clk_axi);
> -
>  	if (host->clk_disp_axi)
>  		clk_prepare_enable(host->clk_disp_axi);
>  	clk_prepare_enable(host->clk);
>  	clk_set_rate(host->clk, PICOS2KHZ(fb_info->var.pixclock) * 1000U);
>  
> +	mxsfb_enable_axi_clk(host);
> +
>  	/* if it was disabled, re-enable the mode again */
>  	writel(CTRL_DOTCLK_MODE, host->base + LCDC_CTRL + REG_SET);
>  
> @@ -380,11 +391,11 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
>  	reg = readl(host->base + LCDC_VDCTRL4);
>  	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
>  
> +	mxsfb_disable_axi_clk(host);
> +
>  	clk_disable_unprepare(host->clk);
>  	if (host->clk_disp_axi)
>  		clk_disable_unprepare(host->clk_disp_axi);
> -	if (host->clk_axi)
> -		clk_disable_unprepare(host->clk_axi);
>  
>  	host->enabled = 0;
>  
> @@ -421,6 +432,8 @@ static int mxsfb_set_par(struct fb_info *fb_info)
>  		mxsfb_disable_controller(fb_info);
>  	}
>  
> +	mxsfb_enable_axi_clk(host);
> +
>  	/* clear the FIFOs */
>  	writel(CTRL1_FIFO_CLEAR, host->base + LCDC_CTRL1 + REG_SET);
>  
> @@ -438,6 +451,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
>  		ctrl |= CTRL_SET_WORD_LENGTH(3);
>  		switch (host->ld_intf_width) {
>  		case STMLCDIF_8BIT:
> +			mxsfb_disable_axi_clk(host);
>  			dev_err(&host->pdev->dev,
>  					"Unsupported LCD bus width mapping\n");
>  			return -EINVAL;
> @@ -451,6 +465,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
>  		writel(CTRL1_SET_BYTE_PACKAGING(0x7), host->base + LCDC_CTRL1);
>  		break;
>  	default:
> +		mxsfb_disable_axi_clk(host);
>  		dev_err(&host->pdev->dev, "Unhandled color depth of %u\n",
>  				fb_info->var.bits_per_pixel);
>  		return -EINVAL;
> @@ -504,6 +519,8 @@ static int mxsfb_set_par(struct fb_info *fb_info)
>  			fb_info->fix.line_length * fb_info->var.yoffset,
>  			host->base + host->devdata->next_buf);
>  
> +	mxsfb_disable_axi_clk(host);
> +
>  	if (reenable)
>  		mxsfb_enable_controller(fb_info);
>  
> @@ -582,10 +599,16 @@ static int mxsfb_pan_display(struct fb_var_screeninfo *var,
>  
>  	offset = fb_info->fix.line_length * var->yoffset;
>  
> +	if (!host->enabled)
> +		mxsfb_enable_axi_clk(host);
> +
>  	/* update on next VSYNC */
>  	writel(fb_info->fix.smem_start + offset,
>  			host->base + host->devdata->next_buf);
>  
> +	if (!host->enabled)
> +		mxsfb_disable_axi_clk(host);
> +
>  	return 0;
>  }
>  
> @@ -608,13 +631,17 @@ static int mxsfb_restore_mode(struct mxsfb_info *host,
>  	unsigned line_count;
>  	unsigned period;
>  	unsigned long pa, fbsize;
> -	int bits_per_pixel, ofs;
> +	int bits_per_pixel, ofs, ret = 0;
>  	u32 transfer_count, vdctrl0, vdctrl2, vdctrl3, vdctrl4, ctrl;
>  
> +	mxsfb_enable_axi_clk(host);
> +
>  	/* Only restore the mode when the controller is running */
>  	ctrl = readl(host->base + LCDC_CTRL);
> -	if (!(ctrl & CTRL_RUN))
> -		return -EINVAL;
> +	if (!(ctrl & CTRL_RUN)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
>  
>  	vdctrl0 = readl(host->base + LCDC_VDCTRL0);
>  	vdctrl2 = readl(host->base + LCDC_VDCTRL2);
> @@ -635,7 +662,8 @@ static int mxsfb_restore_mode(struct mxsfb_info *host,
>  		break;
>  	case 1:
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err;
>  	}
>  
>  	fb_info->var.bits_per_pixel = bits_per_pixel;
> @@ -673,10 +701,14 @@ static int mxsfb_restore_mode(struct mxsfb_info *host,
>  
>  	pa = readl(host->base + host->devdata->cur_buf);
>  	fbsize = fb_info->fix.line_length * vmode->yres;
> -	if (pa < fb_info->fix.smem_start)
> -		return -EINVAL;
> -	if (pa + fbsize > fb_info->fix.smem_start + fb_info->fix.smem_len)
> -		return -EINVAL;
> +	if (pa < fb_info->fix.smem_start) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	if (pa + fbsize > fb_info->fix.smem_start + fb_info->fix.smem_len) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
>  	ofs = pa - fb_info->fix.smem_start;
>  	if (ofs) {
>  		memmove(fb_info->screen_base, fb_info->screen_base + ofs, fbsize);
> @@ -689,7 +721,11 @@ static int mxsfb_restore_mode(struct mxsfb_info *host,
>  	clk_prepare_enable(host->clk);
>  	host->enabled = 1;
>  
> -	return 0;
> +err:
> +	if (ret)
> +		mxsfb_disable_axi_clk(host);
> +
> +	return ret;
>  }
>  
>  static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host,
> @@ -915,7 +951,9 @@ static int mxsfb_probe(struct platform_device *pdev)
>  	}
>  
>  	if (!host->enabled) {
> +		mxsfb_enable_axi_clk(host);
>  		writel(0, host->base + LCDC_CTRL);
> +		mxsfb_disable_axi_clk(host);
>  		mxsfb_set_par(fb_info);
>  		mxsfb_enable_controller(fb_info);
>  	}
> @@ -954,11 +992,15 @@ static void mxsfb_shutdown(struct platform_device *pdev)
>  	struct fb_info *fb_info = platform_get_drvdata(pdev);
>  	struct mxsfb_info *host = to_imxfb_host(fb_info);
>  
> +	mxsfb_enable_axi_clk(host);
> +
>  	/*
>  	 * Force stop the LCD controller as keeping it running during reboot
>  	 * might interfere with the BootROM's boot mode pads sampling.
>  	 */
>  	writel(CTRL_RUN, host->base + LCDC_CTRL + REG_CLR);
> +
> +	mxsfb_disable_axi_clk(host);
>  }
>  
>  static struct platform_driver mxsfb_driver = {
> -- 
> 2.1.0
> 

It fixed the system hang issue at yocto rootfs at imx6sx sdb
and imx6sl sdb boards.

Tested-by: Peter Chen <peter.chen@freescale.com>

-- 

Best Regards,
Peter Chen
