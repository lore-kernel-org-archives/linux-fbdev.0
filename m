From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 15 Dec 2011 19:01:54 +0000
Subject: Re: [PATCH 27/57] fbdev: sh_mobile_lcdc: Pass a video mode to the
Message-Id: <Pine.LNX.4.64.1112151956220.32653@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-28-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-28-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 13 Dec 2011, Laurent Pinchart wrote:

> Pass pointers to struct fb_videomode and struct fb_monspecs instead of
> struct fb_var_screeninfo to the notify callback.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/video/sh_mobile_hdmi.c   |   59 +++++++++++++++++--------------------
>  drivers/video/sh_mobile_lcdcfb.c |   40 ++++++++++++++-----------
>  drivers/video/sh_mobile_lcdcfb.h |    3 +-
>  3 files changed, 51 insertions(+), 51 deletions(-)

[snip]

> diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
> index 21e5f10..4ec216e 100644
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c

[ditto]

> @@ -433,12 +432,17 @@ static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
>  		}
>  		break;
>  
> -	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE:
> +	case SH_MOBILE_LCDC_EVENT_DISPLAY_MODE: {
> +		struct fb_var_screeninfo var;
> +
>  		/* Validate a proposed new mode */
> -		var->bits_per_pixel = info->var.bits_per_pixel;
> -		ret = info->fbops->fb_check_var(var, info);
> +		fb_videomode_to_var(&var, mode);
> +		var.bits_per_pixel = info->var.bits_per_pixel;
> +		var.grayscale = info->var.grayscale;
> +		ret = info->fbops->fb_check_var(&var, info);
>  		break;
>  	}
> +	}

nitpick - please, realign:-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
