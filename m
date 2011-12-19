From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Dec 2011 01:29:55 +0000
Subject: Re: [PATCH 27/57] fbdev: sh_mobile_lcdc: Pass a video mode to the notify callback
Message-Id: <201112190229.57229.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-28-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-28-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Guennadi,

On Friday 16 December 2011 11:33:55 Guennadi Liakhovetski wrote:
> On Fri, 16 Dec 2011, Laurent Pinchart wrote:
> > On Thursday 15 December 2011 20:01:54 Guennadi Liakhovetski wrote:
> > > On Tue, 13 Dec 2011, Laurent Pinchart wrote:
> > > > Pass pointers to struct fb_videomode and struct fb_monspecs instead
> > > > of struct fb_var_screeninfo to the notify callback.
> > > > 
> > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > ---
> > > > 
> > > >  drivers/video/sh_mobile_hdmi.c   |   59
> > > >  +++++++++++++++++--------------------
> > > >  drivers/video/sh_mobile_lcdcfb.c
> > > >  
> > > >  |   40 ++++++++++++++----------- drivers/video/sh_mobile_lcdcfb.h |
> > > >  
> > > >  3 +-
> > > >  3 files changed, 51 insertions(+), 51 deletions(-)
> > > 
> > > [snip]
> > > 
> > > > diff --git a/drivers/video/sh_mobile_lcdcfb.c
> > > > b/drivers/video/sh_mobile_lcdcfb.c index 21e5f10..4ec216e 100644
> > > > --- a/drivers/video/sh_mobile_lcdcfb.c
> > > > +++ b/drivers/video/sh_mobile_lcdcfb.c
> > > 
> > > [ditto]
> > > 
> > > > @@ -433,12 +432,17 @@ static int sh_mobile_lcdc_display_notify(struct
> > > > sh_mobile_lcdc_chan *ch,
> > > > 
> > > >  		}
> > > >  		break;
> > > > 
> > > > -	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE:
> > > > +	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE: {
> > > > +		struct fb_var_screeninfo var;
> > > > +
> > > > 
> > > >  		/* Validate a proposed new mode */
> > > > 
> > > > -		var->bits_per_pixel = info->var.bits_per_pixel;
> > > > -		ret = info->fbops->fb_check_var(var, info);
> > > > +		fb_videomode_to_var(&var, mode);
> > > > +		var.bits_per_pixel = info->var.bits_per_pixel;
> > > > +		var.grayscale = info->var.grayscale;
> > > > +		ret = info->fbops->fb_check_var(&var, info);
> > > > 
> > > >  		break;
> > > >  	
> > > >  	}
> > > > 
> > > > +	}
> > > 
> > > nitpick - please, realign:-)
> > 
> > It's common in driver code not to increase the identation level twice in
> > a case statement if braces are needed. However, those "braced"
> > statements are usually not the last ones in the switch. In this
> > particular case this creates an alignment issue at the end, as your
> > correctly pointed out. However, I'd like to avoid increasing the
> > indentation of the whole block. Increasing the indentation of the
> > closing brace only also causes an alignment issue. I can add a default
> > case that returns an error to fix this, but that's adding code to fix a
> > cosmetic problem :-) What's your preference.
> 
> Personally, I don't like just using braces without a related statement
> like "if," "do," etc. In such "case" cases I usually avoid adding own
> braces and just put any declarations, that are needed there in the
> enclosing block, e.g., the function.

Using braces with case statements is a common practice in the kernel, without 
adding an extra indentation level.

In this particular case I can move the variable declaration at the top of the 
function, as the generated code on ARM (at least with gcc ('cs2009q3-67-hard-
sb4') 4.4.1) doesn't differ.

> If you really don't want either, I would probably prefer a style like
> 
> 	switch (x) {
> 	case X:
> 		{
> 			int y;
> 			my_statement(y);
> 			break;
> 		}
> 	}
> 
> You could also do
> 
> 	switch (x) {
> 	case X:
> 		do {
> 			int y;
> 			my_statement(y);
> 			break;
> 		} while (0);
> 	}
> 
> So, choose your poison:-)


-- 
Regards,

Laurent Pinchart
