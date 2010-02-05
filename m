From: James Simmons <jsimmons@infradead.org>
Date: Fri, 05 Feb 2010 15:14:51 +0000
Subject: Re: [fwd: [PATCH] obsolete config in kernel source
Message-Id: <alpine.LFD.2.00.1002051513060.23086@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100120111628.GA2040@stud.informatik.uni-erlangen.de>
In-Reply-To: <20100120111628.GA2040@stud.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> ----- Forwarded message from Christoph Egger <siccegge@stud.informatik.uni-erlangen.de> -----
> 
> Date: Fri, 15 Jan 2010 13:27:56 +0100
> 
> Hi all!
> 
> 	As part of the VAMOS[0] research project at the University of
> Erlangen we're checking referential integrity between kernel KConfig
> options and in-code Conditional blocks.
> 
> 	While probably not strictly a integrity violation (as
> FB_SOFT_CURSOR can still be set as it is once mentioned in a KConfig
> select statement this looks like a left-over of
> c465e05a03209651078b95686158648fd7ed84c5
> 
> 	Please keep me informed of this patch getting confirmed /
> merged so we can keep track of it.
> 
> Regards
> 
> 	Christoph Egger
> 
> [0] http://vamos1.informatik.uni-erlangen.de/
> 
> >From 5461c8d1ebc54e9f5c86233aa831cefc7c06a140 Mon Sep 17 00:00:00 2001
> From: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>
> Date: Fri, 15 Jan 2010 11:03:50 +0100
> Subject: [PATCH] Clean missed bit of FB_SOFT_CURSOR
> 
> While the config Option FB_SOFT_BUFFER was removed in
> c465e05a03209651078b95686158648fd7ed84c5 while moving to fbcon this
> single driver has it left as a select in KConfig / #ifdef in
> source. This last occurence is removed here so the option is really
> gone
> 
> Signed-off-by: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>

Acked-by: James Simmons <jsimmons@infradead.org>

Patches is fine.

>  drivers/video/Kconfig        |    1 -
>  drivers/video/sis/sis_main.c |    3 ---
>  2 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 5a5c303..7fe1839 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1494,7 +1494,6 @@ config FB_VIA
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT
> -       select FB_SOFT_CURSOR
>         select I2C_ALGOBIT
>         select I2C
>         help
> diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
> index 9d2b6bc..a531a0f 100644
> --- a/drivers/video/sis/sis_main.c
> +++ b/drivers/video/sis/sis_main.c
> @@ -1891,9 +1891,6 @@ static struct fb_ops sisfb_ops = {
>  	.fb_fillrect	= fbcon_sis_fillrect,
>  	.fb_copyarea	= fbcon_sis_copyarea,
>  	.fb_imageblit	= cfb_imageblit,
> -#ifdef CONFIG_FB_SOFT_CURSOR
> -	.fb_cursor	= soft_cursor,
> -#endif
>  	.fb_sync	= fbcon_sis_sync,
>  #ifdef SIS_NEW_CONFIG_COMPAT
>  	.fb_compat_ioctl= sisfb_ioctl,
> -- 
> 1.6.3.3
> 
> 
> 
> ----- End forwarded message -----
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
