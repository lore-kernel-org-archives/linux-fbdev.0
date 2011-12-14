From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 14 Dec 2011 11:10:18 +0000
Subject: Re: [PATCH 11/57] fbdev: sh_mobile_lcdc: Handle HDMI/MIPI transmitter device directly
Message-Id: <201112141210.20579.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-12-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-12-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Guennadi,

On Wednesday 14 December 2011 01:03:06 Guennadi Liakhovetski wrote:
> On Tue, 13 Dec 2011, Laurent Pinchart wrote:
> > Pass a pointer to the transmitter device through platform data, retrieve
> > the corresponding sh_mobile_lcdc_entity structure in the probe method
> > and call the transmitter display_on/off methods directly.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >  drivers/video/sh_mobile_lcdcfb.c |   33
> >  ++++++++++++++++++++++++++++----- drivers/video/sh_mobile_lcdcfb.h |   
> >  2 ++
> >  include/video/sh_mobile_lcdc.h   |    2 ++
> >  3 files changed, 32 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/video/sh_mobile_lcdcfb.c
> > b/drivers/video/sh_mobile_lcdcfb.c index afa1fac..f1bbae6 100644
> > --- a/drivers/video/sh_mobile_lcdcfb.c
> > +++ b/drivers/video/sh_mobile_lcdcfb.c
> > @@ -338,6 +338,13 @@ static void sh_mobile_lcdc_deferred_io_touch(struct
> > fb_info *info)
> > 
> >  static void sh_mobile_lcdc_display_on(struct sh_mobile_lcdc_chan *ch)
> >  {
> >  
> >  	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
> > 
> > +	int ret;
> > +
> > +	if (ch->tx_dev) {
> > +		ret = ch->tx_dev->ops->display_on(ch->tx_dev, ch->info);
> 
> ->ops or ->display_o{n,ff}() cannot be NULL?

They must be provided, at least with the transmitters we currently have. This 
code will likely get reworked to support things like HDMI-on-DSI, so I don't 
think adding a pre

> also
> 
> +		int ret = ch->tx_dev->ops->display_on(ch->tx_dev, ch->info);
> 
> would suffice;-)

Or even if (ch->tx_dev->ops->display_on(ch->tx_dev, ch->info) < 0)

I'll fix that.

> > +		if (ret < 0)
> > +			return;
> > +	}
> > 
> >  	/* HDMI must be enabled before LCDC configuration */
> >  	if (board_cfg->display_on && try_module_get(board_cfg->owner)) {
> > 
> > @@ -354,6 +361,9 @@ static void sh_mobile_lcdc_display_off(struct
> > sh_mobile_lcdc_chan *ch)
> > 
> >  		board_cfg->display_off(board_cfg->board_data);
> >  		module_put(board_cfg->owner);
> >  	
> >  	}
> > 
> > +
> > +	if (ch->tx_dev)
> > +		ch->tx_dev->ops->display_off(ch->tx_dev);
> > 
> >  }
> >  
> >  /*
> >  -----------------------------------------------------------------------
> >  ------
> > 
> > @@ -1490,18 +1500,21 @@ static int sh_mobile_lcdc_remove(struct
> > platform_device *pdev)
> > 
> >  	sh_mobile_lcdc_stop(priv);
> >  	
> >  	for (i = 0; i < ARRAY_SIZE(priv->ch); i++) {
> > 
> > -		info = priv->ch[i].info;
> > +		struct sh_mobile_lcdc_chan *ch = &priv->ch[i];
> > 
> > +		info = ch->info;
> > 
> >  		if (!info || !info->device)
> >  		
> >  			continue;
> > 
> > -		if (priv->ch[i].sglist)
> > -			vfree(priv->ch[i].sglist);
> > +		if (ch->tx_dev)
> > +			module_put(ch->cfg.tx_dev->dev.driver->owner);
> 
> This is now the same ->owner, as the one taken in your
> sh_mobile_lcdc_display_o{n,ff}() functions? IIUC, you're now adding this
> new ->owner field to later (17/57) remove the original one?

It's the same owner, yes. The idea is to get a reference to the transmitter 
device module at probe() time and release it at remove() time instead of doing 
so in display_on() and display_off(), and to remove the owner field hack from 
platform data.

> > +
> > +		if (ch->sglist)
> > +			vfree(ch->sglist);
> > 
> >  		if (info->screen_base)
> >  		
> >  			dma_free_coherent(&pdev->dev, info->fix.smem_len,
> > 
> > -					  info->screen_base,
> > -					  priv->ch[i].dma_handle);
> > +					  info->screen_base, ch->dma_handle);
> > 
> >  		fb_dealloc_cmap(&info->cmap);
> >  		framebuffer_release(info);
> >  	
> >  	}
> > 
> > @@ -1596,6 +1609,16 @@ sh_mobile_lcdc_channel_init(struct
> > sh_mobile_lcdc_priv *priv,
> > 
> >  	info->pseudo_palette = &ch->pseudo_palette;
> >  	info->flags = FBINFO_FLAG_DEFAULT;
> > 
> > +	if (cfg->tx_dev) {
> > +		if (!cfg->tx_dev->dev.driver ||
> > +		    !try_module_get(cfg->tx_dev->dev.driver->owner)) {
> > +			dev_warn(priv->dev, "unable to get transmitter "
> > +				 "device\n");
> 
> Grrr... Pleeeease, don't split strings. If you really have to program on
> vt220;-) at least do
> 
> +			dev_warn(priv->dev,
> +				 "unable to get transmitter device\n");

Sorry about that. Will fix.

> > +			return -EINVAL;
> > +		}
> > +		ch->tx_dev = platform_get_drvdata(cfg->tx_dev);
> > +	}
> > +
> > 
> >  	/* Iterate through the modes to validate them and find the highest
> >  	
> >  	 * resolution.
> >  	 */
> > 
> > diff --git a/drivers/video/sh_mobile_lcdcfb.h
> > b/drivers/video/sh_mobile_lcdcfb.h index d79e5aa..9601b92 100644
> > --- a/drivers/video/sh_mobile_lcdcfb.h
> > +++ b/drivers/video/sh_mobile_lcdcfb.h
> > @@ -41,6 +41,8 @@ struct sh_mobile_lcdc_entity {
> > 
> >   */
> >  
> >  struct sh_mobile_lcdc_chan {
> >  
> >  	struct sh_mobile_lcdc_priv *lcdc;
> > 
> > +	struct sh_mobile_lcdc_entity *tx_dev;
> > +
> > 
> >  	unsigned long *reg_offs;
> >  	unsigned long ldmt1r_value;
> >  	unsigned long enabled; /* ME and SE in LDCNT2R */
> > 
> > diff --git a/include/video/sh_mobile_lcdc.h
> > b/include/video/sh_mobile_lcdc.h index fe30b75..0ec59e1 100644
> > --- a/include/video/sh_mobile_lcdc.h
> > +++ b/include/video/sh_mobile_lcdc.h
> > @@ -186,6 +186,8 @@ struct sh_mobile_lcdc_chan_cfg {
> > 
> >  	struct sh_mobile_lcdc_bl_info bl_info;
> >  	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
> >  	struct sh_mobile_meram_cfg *meram_cfg;
> > 
> > +
> > +	struct platform_device *tx_dev;	/* HDMI/MIPI transmitter device */
> 
> "MIPI" is too generic, IMHO

Will HDMI/DSI do ?

> Hm, could we, maybe, have different names for sh_mobile_lcdc_chan::tx_dev
> and sh_mobile_lcdc_chan_cfg::tx_dev?;-)

Sure. Do you have any suggestion ? :-)

> >  };
> >  
> >  struct sh_mobile_lcdc_info {

-- 
Regards,

Laurent Pinchart
