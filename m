From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 15 Dec 2011 16:16:16 +0000
Subject: Re: [PATCH 21/57] sh_mobile_lcdc: Add an lcdc channel pointer to
Message-Id: <Pine.LNX.4.64.1112151714530.32653@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323784972-24205-22-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1323784972-24205-22-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Laurent

On Tue, 13 Dec 2011, Laurent Pinchart wrote:

> The field will be used by the transmitter drivers to access
> sh_mobile_lcdc_chan fields such as fb_info.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/video/sh_mobile_lcdcfb.c |    5 ++++-
>  drivers/video/sh_mobile_lcdcfb.h |    2 ++
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
> index cb5ea3c..2dccfde 100644
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c
> @@ -1497,8 +1497,10 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
>  		if (!info || !info->device)
>  			continue;
>  
> -		if (ch->tx_dev)
> +		if (ch->tx_dev) {
> +			ch->tx_dev->lcdc = NULL;
>  			module_put(ch->cfg.tx_dev->dev.driver->owner);
> +		}
>  
>  		if (ch->sglist)
>  			vfree(ch->sglist);
> @@ -1608,6 +1610,7 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
>  			return -EINVAL;
>  		}
>  		ch->tx_dev = platform_get_drvdata(cfg->tx_dev);
> +		ch->tx_dev->lcdc = ch;

I do not have a kernel, patched with your patches up to 20/57;-) so, I 
cannot verify - can ch->tx_dev at this point not be NULL?

>  	}
>  
>  	/* Iterate through the modes to validate them and find the highest
> diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
> index 9601b92..36cd564 100644
> --- a/drivers/video/sh_mobile_lcdcfb.h
> +++ b/drivers/video/sh_mobile_lcdcfb.h
> @@ -19,6 +19,7 @@ struct fb_info;
>  struct module;
>  struct sh_mobile_lcdc_entity;
>  struct sh_mobile_lcdc_priv;
> +struct sh_mobile_lcdc_chan;
>  
>  struct sh_mobile_lcdc_entity_ops {
>  	/* Display */
> @@ -30,6 +31,7 @@ struct sh_mobile_lcdc_entity_ops {
>  struct sh_mobile_lcdc_entity {
>  	struct module *owner;
>  	const struct sh_mobile_lcdc_entity_ops *ops;
> +	struct sh_mobile_lcdc_chan *lcdc;
>  };
>  
>  /*
> -- 
> 1.7.3.4
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
