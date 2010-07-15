From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 15 Jul 2010 11:18:28 +0000
Subject: RE: [PATCH 05/10 v2] s3c-fb: Add v4l2 subdevice to support framebuffer
Message-Id: <000601cb240f$730f19f0$592d4dd0$%nawrocki@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
	<1279185041-6004-6-git-send-email-s.nawrocki@samsung.com>
	<4C3EE3BA.9020307@gmail.com>
In-Reply-To: <4C3EE3BA.9020307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

> -----Original Message-----
> From: linux-samsung-soc-owner@vger.kernel.org [mailto:linux-samsung-
> soc-owner@vger.kernel.org] On Behalf Of Maurus Cuelenaere
> Sent: Thursday, July 15, 2010 12:32 PM
> To: Sylwester Nawrocki
> Cc: linux-samsung-soc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; p.osciak@samsung.com;
> m.szyprowski@samsung.com; kyungmin.park@samsung.com;
> kgene.kim@samsung.com; ben-linux@fluff.org; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH 05/10 v2] s3c-fb: Add v4l2 subdevice to support
> framebuffer local fifo input path
> 
>  Op 15-07-10 11:10, Sylwester Nawrocki schreef:
> > Selected multimedia devices in Samsung S3C/S5P SoC series are capable
> of
> > transferring data directly between each other, bypassing the main
> system
> > bus. Such a datapath exists between the camera interface/video
> > postprocessor and the lcd controller. To control the data flow from
> the
> > fimc driver level v4l2-subdevice driver is added to the framebuffer.
> > It enables to configure the lcd controller into FIFO or DMA input
> mode.
> >
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  arch/arm/plat-samsung/include/plat/fb.h |    6 +
> >  drivers/video/s3c-fb.c                  |  487
> +++++++++++++++++++++++++++++--
> >  2 files changed, 472 insertions(+), 21 deletions(-)
> 
> <snip>
> 
> >  /**
> > + * s3c_fb_enable_local() - switch window between input DMA and fifo
> modes
> > + *
> > + * @fb_sd: window subdevice for fifo input
> > + * @en:    1 - switch from input DMA to fifo mode and apply
> > + *	       window size and position set by the window's subdevice
> > + *         0 - restore from fifo to DMA mode
> > + */
> > +static int s3c_fb_enable_local_in(struct s3c_fb_win_sd *fb_sd, int
> en)
> > +{
> > +	struct s3c_fb_win *win = fb_sd->win;
> > +	struct s3c_fb *sfb = win->parent;
> > +	static u32 wincon;
> > +	u32 reg, data;
> > +	int ret = 0, bpp = 32;
> > +
> > +	/* disable video output and the window logic */
> > +	reg = readl(sfb->regs + WINCON(win->index));
> > +	writel(reg & ~WINCONx_ENWIN, sfb->regs + WINCON(win->index));
> > +
> > +	shadow_protect_win(win, 1);
> > +
> > +	if (en = 1) {
> > +		if (fb_sd->streaming)
> > +			return 0;
> 
> Shouldn't you do shadow_protect_win(win, 0) before returning here?

Yes, indeed the error path is wrong and also WINCONx_ENWIN
needs to be restored.
Thank you for pointing this out. 

> 
> > +
> > +		wincon = reg;
> > +
> > +		switch (fb_sd->fmt.fmt.pix.pixelformat) {
> > +		case V4L2_PIX_FMT_YUYV: /* YCbCr 4:4:4 */
> > +			reg |= WINCONx_YCbCr | WINCONx_ENLOCAL;
> > +			bpp = 16;
> > +			break;
> > +
> > +		case V4L2_PIX_FMT_RGB24:
> > +		default:
> > +			reg &= ~(WINCONx_YCbCr | WINCONx_WSWP |
> WINCONx_HAWSWP |
> > +				 WINCONx_BYTSWP | WINCONx_BITSWP |
> > +				 WINCON0_BPPMODE_MASK | WINCONx_BURSTLEN_MASK);
> > +
> > +			reg |=	WINCON0_BPPMODE_24BPP_888 |
> > +				WINCONx_BURSTLEN_4WORD;
> > +			bpp = 24;
> > +			break;
> > +		}
> > +
> > +		fb_sd->streaming = 1;
> > +		writel(reg, sfb->regs + WINCON(win->index));
> > +
> > +		s3c_fb_set_osd(fb_sd->win, &fb_sd->curr_osd_win, bpp);
> > +
> > +		writel(reg | WINCONx_ENLOCAL, sfb->regs + WINCON(win-
> >index));
> > +
> > +		shadow_protect_win(win, 0);
> > +
> > +		reg = readl(sfb->regs + WINCON(win->index));
> > +		writel(reg | WINCONx_ENWIN, sfb->regs + WINCON(win-
> >index));
> > +
> > +		if (sfb->variant.has_shadowcon)	{
> > +			data = readl(sfb->regs + SHADOWCON);
> > +			data |=	SHADOWCON_CHx_LOCAL_ENABLE(win->index);
> > +			writel(data, sfb->regs + SHADOWCON);
> > +		}
> > +
> > +	} else if (en = 0) {
> > +		if (!fb_sd->streaming)
> > +			return 0;
> 
> Same comment
> 
> > +
> > +		fb_sd->streaming = 0;
> > +
> > +		/* need to be aligned with VSYNC interrupt */
> > +		writel(wincon & ~WINCONx_ENLOCAL,
> > +		       sfb->regs + WINCON(win->index));
> > +
> > +		/* restore OSD values from before we enabled local mode */
> > +		bpp = win->fbinfo->var.bits_per_pixel;
> > +		s3c_fb_set_osd(fb_sd->win, &fb_sd->default_osd_win, bpp);
> > +
> > +		shadow_protect_win(win, 0);
> > +
> > +		if (sfb->variant.has_shadowcon)	{
> > +			data = readl(sfb->regs + SHADOWCON);
> > +			data &=	~SHADOWCON_CHx_LOCAL_ENABLE(win->index);
> > +			writel(data, sfb->regs + SHADOWCON);
> > +		}
> > +
> > +		reg = readl(sfb->regs + WINCON(win->index));
> > +		writel(reg | WINCONx_ENWIN, sfb->regs + WINCON(win-
> >index));
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> 
> --
> Maurus Cuelenaere

Regards,
--
Sylwester Nawrocki

> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


