From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 16 Dec 2011 10:22:36 +0000
Subject: Re: [PATCH 25/57] sh_mobile_lcdc: Add display notify callback to sh_mobile_lcdc_chan
Message-Id: <201112161122.37825.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-26-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-26-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Guennadi,

On Friday 16 December 2011 10:40:48 Guennadi Liakhovetski wrote:
> On Tue, 13 Dec 2011, Laurent Pinchart wrote:
> > The callback implements 3 notification events:
> > 
> > - SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT notifies the LCDC that the
> >   display has been connected
> > 
> > - SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT notifies the LCDC that the
> >   display has been disconnected
> > 
> > - SH_MOBILE_LCDC_EVENT_DISPLAY_MODE notifies that LCDC that a display
> >   mode has been detected
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > diff --git a/drivers/video/sh_mobile_lcdcfb.c
> > b/drivers/video/sh_mobile_lcdcfb.c index 4b03aa5..21e5f10 100644
> > --- a/drivers/video/sh_mobile_lcdcfb.c
> > +++ b/drivers/video/sh_mobile_lcdcfb.c
> > @@ -363,6 +363,86 @@ static void sh_mobile_lcdc_display_off(struct

[snip]

> > +static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
> > +					 enum sh_mobile_lcdc_entity_event event,
> > +					 struct fb_var_screeninfo *var)
> > +{
> > +	struct fb_info *info = ch->info;
> > +	int ret = 0;
> > +
> > +	switch (event) {
> > +	case SH_MOBILE_LCDC_EVENT_DISPLAY_CONNECT:
> > +		/* HDMI plug in */
> > +		if (lock_fb_info(info)) {
> > +			console_lock();
> > +
> > +			if (!sh_mobile_lcdc_must_reconfigure(ch, var) &&
> > +			    info->state = FBINFO_STATE_RUNNING) {
> > +				/* First activation with the default monitor.
> > +				 * Just turn on, if we run a resume here, the
> > +				 * logo disappears.
> > +				 */
> > +				info->var.width = var->width;
> > +				info->var.height = var->height;
> > +				sh_mobile_lcdc_display_on(ch);
> > +			} else {
> > +				/* New monitor or have to wake up */
> > +				fb_set_suspend(info, 0);
> > +			}
> > +
> > +			console_unlock();
> > +			unlock_fb_info(info);
> > +		}
> > +		break;
> > +
> > +	case SH_MOBILE_LCDC_EVENT_DISPLAY_DISCONNECT:
> > +		/* HDMI disconnect */
> > +		if (lock_fb_info(info)) {
> > +			console_lock();
> > +			fb_set_suspend(info, 1);
> > +			console_unlock();
> > +			unlock_fb_info(info);
> > +		}
> > +		break;
> > +
> > +	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE:
> > +		/* Validate a proposed new mode */
> > +		var->bits_per_pixel = info->var.bits_per_pixel;
> > +		ret = info->fbops->fb_check_var(var, info);
> 
> You can call sh_mobile_lcdc_check_var() directly here too, right?

This was a way to avoid a forward declaration. You would prefer a forward 
declaration, right ? :-) I think you would be right.

> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +

-- 
Regards,

Laurent Pinchart
