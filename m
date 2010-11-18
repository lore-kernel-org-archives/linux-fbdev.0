From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 18 Nov 2010 14:14:44 +0000
Subject: Re: [PATCH v2] fbdev: modedb: fix CEA modes
Message-Id: <Pine.LNX.4.64.1011181513370.3551@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290073542-943-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1290073542-943-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 18 Nov 2010, Arnd Hannemann wrote:

> Some of the modes were missing the correct sync polarities.
> This was causing a corrupt or left shifted picture on my TV.
> Additionally format #35 had a wrong refresh rate and pixel clock.
> 
> This patch fixes those issues.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> 
> ---
> v2: Format #5 had also wrong sync settings, so include the fix in this patch
> ---
>  drivers/video/modedb.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
> index 9a0ae6c..c3a1825 100644
> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> @@ -289,7 +289,8 @@ const struct fb_videomode cea_modes[64] = {
>  	},
>  	/* #5: 1920x1080i@59.94/60Hz */
>  	[5] = {
> -		NULL, 60, 1920, 1080, 13763, 148, 88, 15, 2, 44, 5, 0, FB_VMODE_INTERLACED, 0,
> +		NULL, 60, 1920, 1080, 13763, 148, 88, 15, 2, 44, 5,
> +		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_INTERLACED, 0,
>  	},
>  	/* #7: 720(1440)x480iH@59.94/60Hz */
>  	[7] = {
> @@ -305,19 +306,22 @@ const struct fb_videomode cea_modes[64] = {
>  	},
>  	/* #19: 1280x720p@50Hz */
>  	[19] = {
> -		NULL, 50, 1280, 720, 13468, 220, 440, 20, 5, 40, 5, 0, FB_VMODE_NONINTERLACED, 0,
> +		NULL, 50, 1280, 720, 13468, 220, 440, 20, 5, 40, 5,
> +		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, 0,
>  	},
>  	/* #20: 1920x1080i@50Hz */
>  	[20] = {
> -		NULL, 50, 1920, 1080, 13480, 148, 528, 15, 5, 528, 5, 0, FB_VMODE_INTERLACED, 0,
> +		NULL, 50, 1920, 1080, 13480, 148, 528, 15, 5, 528, 5,
> +		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_INTERLACED, 0,
>  	},
>  	/* #32: 1920x1080p@23.98/24Hz */
>  	[32] = {
> -		NULL, 24, 1920, 1080, 13468, 148, 638, 36, 4, 44, 5, 0, FB_VMODE_NONINTERLACED, 0,
> +		NULL, 24, 1920, 1080, 13468, 148, 638, 36, 4, 44, 5,
> +		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, 0,
>  	},
>  	/* #35: (2880)x480p4x@59.94/60Hz */
>  	[35] = {
> -		NULL, 50, 2880, 480, 11100, 240, 64, 30, 9, 248, 6, 0, FB_VMODE_NONINTERLACED, 0,
> +		NULL, 60, 2880, 480, 9250, 240, 64, 30, 9, 248, 6, 0, FB_VMODE_NONINTERLACED, 0,
>  	},
>  };
>  
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
