From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 15 Dec 2011 22:17:28 +0000
Subject: Re: [PATCH 33/57] fbdev: sh_mobile_lcdc: Add sh_mobile_format_info()
Message-Id: <Pine.LNX.4.64.1112152246040.32653@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-34-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-34-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, 13 Dec 2011, Laurent Pinchart wrote:

> The function returns a pointer to a structure describing a format based
> on its fourcc. Use the function where applicable instead of hardcoded
> switch-case statements.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/video/sh_mobile_lcdcfb.c |  174 ++++++++++++++++++++++----------------
>  1 files changed, 102 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
> index 3bc82ae..c6b6b9d 100644
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c

[snip]

> @@ -665,37 +726,20 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
>  
>  	/* Setup geometry, format, frame buffer memory and operation mode. */
>  	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
> +		const struct sh_mobile_lcdc_format_info *format;
> +		u32 fourcc;
> +
>  		ch = &priv->ch[k];
>  		if (!ch->enabled)
>  			continue;
>  
>  		sh_mobile_lcdc_geometry(ch);
>  
> -		switch (sh_mobile_format_fourcc(&ch->info->var)) {
> -		case V4L2_PIX_FMT_RGB565:
> -			tmp = LDDFR_PKF_RGB16;
> -			break;
> -		case V4L2_PIX_FMT_BGR24:
> -			tmp = LDDFR_PKF_RGB24;
> -			break;
> -		case V4L2_PIX_FMT_BGR32:
> -			tmp = LDDFR_PKF_ARGB32;
> -			break;
> -		case V4L2_PIX_FMT_NV12:
> -		case V4L2_PIX_FMT_NV21:
> -			tmp = LDDFR_CC | LDDFR_YF_420;
> -			break;
> -		case V4L2_PIX_FMT_NV16:
> -		case V4L2_PIX_FMT_NV61:
> -			tmp = LDDFR_CC | LDDFR_YF_422;
> -			break;
> -		case V4L2_PIX_FMT_NV24:
> -		case V4L2_PIX_FMT_NV42:
> -			tmp = LDDFR_CC | LDDFR_YF_444;
> -			break;
> -		}
> +		fourcc = sh_mobile_format_fourcc(&ch->info->var);
> +		format = sh_mobile_format_info(fourcc);
> +		tmp = format->lddfr;

Why don't you just store a pointer to the selected format struct per 
channel in sh_mobile_lcdc_channel_init() to avoid recalculation here? If 
OTOH this can be a new info here from a hotplug event, the above risks an 
Oops?

>  
> -		if (sh_mobile_format_is_yuv(&ch->info->var)) {
> +		if (format->yuv) {
>  			switch (ch->info->var.colorspace) {
>  			case V4L2_COLORSPACE_REC709:
>  				tmp |= LDDFR_CF1;

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
