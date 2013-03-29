From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 29 Mar 2013 01:29:52 +0000
Subject: Re: [PATCH 1/1] video: fbomn: fix type VESA_DMT_VSYNC_HIGH
Message-Id: <002801ce2c1c$e93564a0$bba02de0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364504606-2087-1-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1364504606-2087-1-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday, March 29, 2013 6:03 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> it's VESA_DMT_VSYNC_HIGH not VESA_DMT_HSYNC_HIGH
> to check to enable the FB_SYNC_VERT_HIGH_ACT
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-fbdev@vger.kernel.org

CC'ed Steffen Trumtrar.

The same patch was already submitted as below:
(https://patchwork.kernel.org/patch/2183811/)

I will resend this patch, soon.

Best regards,
Jingoo Han

> ---
>  drivers/video/fbmon.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> index 94ad0f7..7f67099 100644
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -1400,7 +1400,7 @@ int fb_videomode_from_videomode(const struct videomode *vm,
>  	fbmode->vmode = 0;
>  	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
>  		fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
> -	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
> +	if (vm->dmt_flags & VESA_DMT_VSYNC_HIGH)
>  		fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
>  	if (vm->data_flags & DISPLAY_FLAGS_INTERLACED)
>  		fbmode->vmode |= FB_VMODE_INTERLACED;
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

