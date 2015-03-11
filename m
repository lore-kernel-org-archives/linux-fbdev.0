From: Liu Ying <Ying.Liu@freescale.com>
Date: Wed, 11 Mar 2015 02:58:22 +0000
Subject: Re: [PATCH v2] video: mxsfb: Make sure axi clock is enabled when accessing registers
Message-Id: <20150311030327.GA3724@victor>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425452771-19313-1-git-send-email-Ying.Liu@freescale.com>
 <54FEDD5D.4000104@ti.com>
In-Reply-To: <54FEDD5D.4000104@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, Peter Chen <peter.chen@freescale.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Fabio Estevam <fabio.estevam@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Tue, Mar 10, 2015 at 02:02:37PM +0200, Tomi Valkeinen wrote:
> On 04/03/15 09:06, Liu Ying wrote:
> > The LCDIF engines embedded in i.MX6sl and i.MX6sx SoCs need the axi clock
> > as the engine's system clock.  The clock should be enabled when accessing
> > LCDIF registers, otherwise the kernel would hang up.  We should also keep
> > the clock being enabled when the engine is being active to scan out frames
> 
> The text above is a bit confusing. Maybe just "... also keep the clock
> enabled when..."

Okay.

> 
> > from memory.  This patch makes sure the axi clock is enabled when accessing
> > registers so that the kernel hang up issue can be fixed.
> > 
> > Reported-by: Peter Chen <peter.chen@freescale.com>
> > Tested-by: Peter Chen <peter.chen@freescale.com>
> > Cc: <stable@vger.kernel.org> # 3.19+
> > Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> > ---
> > v1->v2:
> > * Add 'Tested-by: Peter Chen <peter.chen@freescale.com>' tag.
> > * Add 'Cc: <stable@vger.kernel.org> # 3.19+' tag.
> > 
> >  drivers/video/fbdev/mxsfb.c | 70 ++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 56 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
> > index f8ac4a4..a8cf3b2 100644
> > --- a/drivers/video/fbdev/mxsfb.c
> > +++ b/drivers/video/fbdev/mxsfb.c
> > @@ -316,6 +316,18 @@ static int mxsfb_check_var(struct fb_var_screeninfo *var,
> >  	return 0;
> >  }
> >  
> > +static inline void mxsfb_enable_axi_clk(struct mxsfb_info *host)
> > +{
> > +	if (host->clk_axi)
> > +		clk_prepare_enable(host->clk_axi);
> > +}
> > +
> > +static inline void mxsfb_disable_axi_clk(struct mxsfb_info *host)
> > +{
> > +	if (host->clk_axi)
> > +		clk_disable_unprepare(host->clk_axi);
> > +}
> > +
> >  static void mxsfb_enable_controller(struct fb_info *fb_info)
> >  {
> >  	struct mxsfb_info *host = to_imxfb_host(fb_info);
> > @@ -333,14 +345,13 @@ static void mxsfb_enable_controller(struct fb_info *fb_info)
> >  		}
> >  	}
> >  
> > -	if (host->clk_axi)
> > -		clk_prepare_enable(host->clk_axi);
> > -
> >  	if (host->clk_disp_axi)
> >  		clk_prepare_enable(host->clk_disp_axi);
> >  	clk_prepare_enable(host->clk);
> >  	clk_set_rate(host->clk, PICOS2KHZ(fb_info->var.pixclock) * 1000U);
> >  
> > +	mxsfb_enable_axi_clk(host);
> > +
> 
> Is there some reason to move the clk enable to a different place here?

Moving it to here reflects better that we need to enable it when accessing the
registers.

Another reason is weak, perhaps.  We've got an unannounced new SoC(not yet get
upstreamed).  It has a LCDIF embedded.  The pixel clock(host->clk) and the axi
clock are derived from a same clock gate.  And, the clock gate is defined with
the flag CLK_SET_RATE_GATE, which means it must be gated across rate change.
So, we need to move it beneath clk_set_rate() for the pixel clock sooner or
later.

> 
> >  	/* if it was disabled, re-enable the mode again */
> >  	writel(CTRL_DOTCLK_MODE, host->base + LCDC_CTRL + REG_SET);
> >  
> > @@ -380,11 +391,11 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
> >  	reg = readl(host->base + LCDC_VDCTRL4);
> >  	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
> >  
> > +	mxsfb_disable_axi_clk(host);
> > +
> >  	clk_disable_unprepare(host->clk);
> >  	if (host->clk_disp_axi)
> >  		clk_disable_unprepare(host->clk_disp_axi);
> > -	if (host->clk_axi)
> > -		clk_disable_unprepare(host->clk_axi);
> 
> And same here for disable.

This is to make sure the clock disable order is exactly reversed, comparing to
the clock enable order.

> 
> >  	host->enabled = 0;
> >  
> > @@ -421,6 +432,8 @@ static int mxsfb_set_par(struct fb_info *fb_info)
> >  		mxsfb_disable_controller(fb_info);
> >  	}
> >  
> > +	mxsfb_enable_axi_clk(host);
> > +
> >  	/* clear the FIFOs */
> >  	writel(CTRL1_FIFO_CLEAR, host->base + LCDC_CTRL1 + REG_SET);
> >  
> > @@ -438,6 +451,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
> >  		ctrl |= CTRL_SET_WORD_LENGTH(3);
> >  		switch (host->ld_intf_width) {
> >  		case STMLCDIF_8BIT:
> > +			mxsfb_disable_axi_clk(host);
> >  			dev_err(&host->pdev->dev,
> >  					"Unsupported LCD bus width mapping\n");
> >  			return -EINVAL;
> > @@ -451,6 +465,7 @@ static int mxsfb_set_par(struct fb_info *fb_info)
> >  		writel(CTRL1_SET_BYTE_PACKAGING(0x7), host->base + LCDC_CTRL1);
> >  		break;
> >  	default:
> > +		mxsfb_disable_axi_clk(host);
> >  		dev_err(&host->pdev->dev, "Unhandled color depth of %u\n",
> >  				fb_info->var.bits_per_pixel);
> >  		return -EINVAL;
> > @@ -504,6 +519,8 @@ static int mxsfb_set_par(struct fb_info *fb_info)
> >  			fb_info->fix.line_length * fb_info->var.yoffset,
> >  			host->base + host->devdata->next_buf);
> >  
> > +	mxsfb_disable_axi_clk(host);
> > +
> >  	if (reenable)
> >  		mxsfb_enable_controller(fb_info);
> >  
> > @@ -582,10 +599,16 @@ static int mxsfb_pan_display(struct fb_var_screeninfo *var,
> >  
> >  	offset = fb_info->fix.line_length * var->yoffset;
> >  
> > +	if (!host->enabled)
> > +		mxsfb_enable_axi_clk(host);
> > +
> >  	/* update on next VSYNC */
> >  	writel(fb_info->fix.smem_start + offset,
> >  			host->base + host->devdata->next_buf);
> >  
> > +	if (!host->enabled)
> > +		mxsfb_disable_axi_clk(host);
> > +
> 
> Why do you check for host->enabled here, but not elsewhere?

We need this check here to make sure the axi clock reference count is no greater
than 1.  Looking at the context of mxsfb_set_par(), mxsfb_restore_mode() and
mxsfb_probe() closely, the check is not necessary.  Regarding mxsfb_shutdown(),
since the system is shutting down, I assume the reference count is not that
important.

Regards,
Liu Ying

> 
>  Tomi
> 
> 


