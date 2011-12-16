From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 16 Dec 2011 09:40:48 +0000
Subject: Re: [PATCH 25/57] sh_mobile_lcdc: Add display notify callback to
Message-Id: <Pine.LNX.4.64.1112161040110.6572@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-26-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-26-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 13 Dec 2011, Laurent Pinchart wrote:

> The callback implements 3 notification events:
> 
> - SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT notifies the LCDC that the
>   display has been connected
> - SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT notifies the LCDC that the
>   display has been disconnected
> - SH_MOBILE_LCDC_EVENT_DISPLAY_MODE notifies that LCDC that a display
>   mode has been detected
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/video/sh_mobile_lcdcfb.c |   81 ++++++++++++++++++++++++++++++++++++++
>  drivers/video/sh_mobile_lcdcfb.h |   10 +++++
>  2 files changed, 91 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
> index 4b03aa5..21e5f10 100644
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c
> @@ -363,6 +363,86 @@ static void sh_mobile_lcdc_display_off(struct sh_mobile_lcdc_chan *ch)
>  		ch->tx_dev->ops->display_off(ch->tx_dev);
>  }
>  
> +static bool
> +sh_mobile_lcdc_must_reconfigure(struct sh_mobile_lcdc_chan *ch,
> +				const struct fb_var_screeninfo *new_var)
> +{
> +	struct fb_var_screeninfo *old_var = &ch->display_var;
> +	struct fb_videomode old_mode;
> +	struct fb_videomode new_mode;
> +
> +	fb_var_to_videomode(&old_mode, old_var);
> +	fb_var_to_videomode(&new_mode, new_var);
> +
> +	dev_dbg(ch->info->dev, "Old %ux%u, new %ux%u\n",
> +		old_mode.xres, old_mode.yres, new_mode.xres, new_mode.yres);
> +
> +	if (fb_mode_is_equal(&old_mode, &new_mode)) {
> +		/* It can be a different monitor with an equal video-mode */
> +		old_var->width = new_var->width;
> +		old_var->height = new_var->height;
> +		return false;
> +	}
> +
> +	dev_dbg(ch->info->dev, "Switching %u -> %u lines\n",
> +		old_mode.yres, new_mode.yres);
> +	*old_var = *new_var;
> +
> +	return true;
> +}
> +
> +static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
> +					 enum sh_mobile_lcdc_entity_event event,
> +					 struct fb_var_screeninfo *var)
> +{
> +	struct fb_info *info = ch->info;
> +	int ret = 0;
> +
> +	switch (event) {
> +	case SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT:
> +		/* HDMI plug in */
> +		if (lock_fb_info(info)) {
> +			console_lock();
> +
> +			if (!sh_mobile_lcdc_must_reconfigure(ch, var) &&
> +			    info->state = FBINFO_STATE_RUNNING) {
> +				/* First activation with the default monitor.
> +				 * Just turn on, if we run a resume here, the
> +				 * logo disappears.
> +				 */
> +				info->var.width = var->width;
> +				info->var.height = var->height;
> +				sh_mobile_lcdc_display_on(ch);
> +			} else {
> +				/* New monitor or have to wake up */
> +				fb_set_suspend(info, 0);
> +			}
> +
> +			console_unlock();
> +			unlock_fb_info(info);
> +		}
> +		break;
> +
> +	case SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT:
> +		/* HDMI disconnect */
> +		if (lock_fb_info(info)) {
> +			console_lock();
> +			fb_set_suspend(info, 1);
> +			console_unlock();
> +			unlock_fb_info(info);
> +		}
> +		break;
> +
> +	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE:
> +		/* Validate a proposed new mode */
> +		var->bits_per_pixel = info->var.bits_per_pixel;
> +		ret = info->fbops->fb_check_var(var, info);

You can call sh_mobile_lcdc_check_var() directly here too, right?

Thanks
Guennadi

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  /* -----------------------------------------------------------------------------
>   * Format helpers
>   */
> @@ -1591,6 +1671,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
>  	int i;
>  
>  	mutex_init(&ch->open_lock);
> +	ch->notify = sh_mobile_lcdc_display_notify;
>  
>  	/* Allocate the frame buffer device. */
>  	ch->info = framebuffer_alloc(0, priv->dev);
> diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
> index 6fb956c..e2eb7af 100644
> --- a/drivers/video/sh_mobile_lcdcfb.h
> +++ b/drivers/video/sh_mobile_lcdcfb.h
> @@ -30,6 +30,12 @@ struct sh_mobile_lcdc_entity_ops {
>  	void (*display_off)(struct sh_mobile_lcdc_entity *entity);
>  };
>  
> +enum sh_mobile_lcdc_entity_event {
> +	SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT,
> +	SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT,
> +	SH_MOBILE_LCDC_EVENT_DISPLAY_MODE,
> +};
> +
>  struct sh_mobile_lcdc_entity {
>  	struct module *owner;
>  	const struct sh_mobile_lcdc_entity_ops *ops;
> @@ -70,6 +76,10 @@ struct sh_mobile_lcdc_chan {
>  	unsigned long base_addr_y;
>  	unsigned long base_addr_c;
>  	unsigned int pitch;
> +
> +	int (*notify)(struct sh_mobile_lcdc_chan *ch,
> +		      enum sh_mobile_lcdc_entity_event event,
> +		      struct fb_var_screeninfo *var);
>  };
>  
>  #endif
> -- 
> 1.7.3.4
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
