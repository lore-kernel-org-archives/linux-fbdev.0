From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 Jan 2014 15:17:47 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdcfb: Don't use plain 0 as NULL pointer
Message-Id: <4478344.Lf8VtL9Dnd@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385512723-11722-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385512723-11722-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Jean-Christophe and Tomi,

Could you please pick this patch up for v3.14 ?

On Wednesday 27 November 2013 01:38:43 Laurent Pinchart wrote:
> This fixes a sparse warning.
> 
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/video/sh_mobile_lcdcfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/sh_mobile_lcdcfb.c
> b/drivers/video/sh_mobile_lcdcfb.c index ab85ad6..2bcc84a 100644
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c
> @@ -1227,7 +1227,7 @@ static void sh_mobile_lcdc_stop(struct
> sh_mobile_lcdc_priv *priv) /* Free the MERAM cache. */
>  		if (ch->cache) {
>  			sh_mobile_meram_cache_free(priv->meram_dev, ch->cache);
> -			ch->cache = 0;
> +			ch->cache = NULL;
>  		}
> 
>  	}
-- 
Regards,

Laurent Pinchart

