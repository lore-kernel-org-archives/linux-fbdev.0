From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 14 Dec 2011 03:04:52 +0000
Subject: Re: [PATCH 33/57] fbdev: sh_mobile_lcdc: Add sh_mobile_format_info()
Message-Id: <4EE81254.7090805@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-34-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-34-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent,


On 2011/12/13 23:02, Laurent Pinchart wrote:
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c
> @@ -447,6 +447,75 @@ static int sh_mobile_lcdc_display_notify(struct sh_mobile_lcdc_chan *ch,
>   * Format helpers
>   */
>  
> +struct sh_mobile_lcdc_format_info {
> +	u32 fourcc;
> +	unsigned int bpp;
> +	bool yuv;
> +	u32 lddfr;
> +};
> +
> +static const struct sh_mobile_lcdc_format_info sh_mobile_format_infos[] = {
> +	{
> +		.fourcc = V4L2_PIX_FMT_RGB565,
> +		.bpp = 12,
I think that this should be 16 instead of 12.


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
Do you need to check if format is NULL here?


Damian
