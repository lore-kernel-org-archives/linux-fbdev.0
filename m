From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 28 Jun 2011 09:09:36 +0000
Subject: Re: [PATCH v2 05/29] atmel_lcdfb: use display information in info not in var for panning
Message-Id: <201106281109.36489.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308043507-11083-6-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1308043507-11083-6-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Nicolas,

On Tuesday 28 June 2011 10:10:13 Nicolas Ferre wrote:
> Le 14/06/2011 11:24, Laurent Pinchart :
> > We must not use any information in the passed var besides xoffset,
> > yoffset and vmode as otherwise applications might abuse it.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> > 
> >  drivers/video/atmel_lcdfb.c |   15 +++++++++------
> >  1 files changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> > index 4484c72..8b5d755 100644
> > --- a/drivers/video/atmel_lcdfb.c
> > +++ b/drivers/video/atmel_lcdfb.c
> > @@ -39,7 +39,8 @@
> > 
> >  					 | FBINFO_HWACCEL_YPAN)
> >  
> >  static inline void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info
> >  *sinfo,
> > 
> > -					struct fb_var_screeninfo *var)
> > +					struct fb_var_screeninfo *var,
> > +					struct fb_info *info)
> > 
> >  {
> >  
> >  }
> > 
> > @@ -50,14 +51,16 @@ static inline void atmel_lcdfb_update_dma2d(struct
> > atmel_lcdfb_info *sinfo,
> > 
> >  					| FBINFO_HWACCEL_YPAN)
> >  
> >  static void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
> > 
> > -				     struct fb_var_screeninfo *var)
> > +				     struct fb_var_screeninfo *var,
> > +				     struct fb_info *info)
> > 
> >  {
> >  
> >  	u32 dma2dcfg;
> >  	u32 pixeloff;
> > 
> > -	pixeloff = (var->xoffset * var->bits_per_pixel) & 0x1f;
> > +	pixeloff = (var->xoffset * info->var.bits_per_pixel) & 0x1f;
> > 
> > -	dma2dcfg = ((var->xres_virtual - var->xres) * var->bits_per_pixel) / 8;
> > +	dma2dcfg = (info-var.xres_virtual - info->var.xres)
> 
> ------------------------^^^
> Wolfram Sang identified this error: it cannot compile!
> Thank you Wolfram.

Oops, sorry for that.

> > +		 * info->var.bits_per_pixel / 8;
> > 
> >  	dma2dcfg |= pixeloff << ATMEL_LCDC_PIXELOFF_OFFSET;
> >  	lcdc_writel(sinfo, ATMEL_LCDC_DMA2DCFG, dma2dcfg);
> > 
> > @@ -249,14 +252,14 @@ static void atmel_lcdfb_update_dma(struct fb_info
> > *info,
> > 
> >  	unsigned long dma_addr;
> >  	
> >  	dma_addr = (fix->smem_start + var->yoffset * fix->line_length
> > 
> > -		    + var->xoffset * var->bits_per_pixel / 8);
> > +		    + var->xoffset * info->var.bits_per_pixel / 8);
> > 
> >  	dma_addr &= ~3UL;
> >  	
> >  	/* Set framebuffer DMA base address and pixel offset */
> >  	lcdc_writel(sinfo, ATMEL_LCDC_DMABADDR1, dma_addr);
> > 
> > -	atmel_lcdfb_update_dma2d(sinfo, var);
> > +	atmel_lcdfb_update_dma2d(sinfo, var, info);
> > 
> >  }
> >  
> >  static inline void atmel_lcdfb_free_video_memory(struct atmel_lcdfb_info
> >  *sinfo)
> 
> *When* the error will be corrected, you can submit it to linux-fbdev
> with my:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thank you. I will resubmit fixed patches with your ack.

-- 
Regards,

Laurent Pinchart
