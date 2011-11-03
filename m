From: Huang Changming-R66093 <r66093@freescale.com>
Date: Thu, 03 Nov 2011 02:32:06 +0000
Subject: RE: [PATCH] FSL/DIU: add 1080P, 720P and 800x600 video modes
Message-Id: <8A2FC72B45BB5A4C9F801431E06AE48F1160B8C5@039-SN1MPN1-006.039d.mgd.msft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1320215710-9128-1-git-send-email-r66093@freescale.com>
In-Reply-To: <1320215710-9128-1-git-send-email-r66093@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Please ignore this patch.

Thanks and Best Regards
Jerry Huang


> -----Original Message-----
> From: Huang Changming-R66093
> Sent: Wednesday, November 02, 2011 2:35 PM
> To: linux-fbdev@vger.kernel.org
> Cc: Huang Changming-R66093; Paul Mundt
> Subject: [PATCH] FSL/DIU: add 1080P, 720P and 800x600 video modes
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> Add 1920x1080, 1280x720 and 800x600 resolution support.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Paul Mundt <lethal@linux-sh.org>
> ---
>  drivers/video/fsl-diu-fb.c |   47
> +++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 46 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 0acc7d6..756975f 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 2008 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2008,2011 Freescale Semiconductor, Inc. All Rights
> Reserved.
>   *
>   *  Freescale DIU Frame Buffer device driver
>   *
> @@ -60,6 +60,21 @@ static struct fb_videomode __devinitdata
> fsl_diu_default_mode = {
> 
>  static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
>  	{
> +		.name		= "800x600-60",
> +		.refresh	= 60,
> +		.xres		= 800,
> +		.yres		= 600,
> +		.pixclock	= 25000,
> +		.left_margin	= 88,
> +		.right_margin	= 40,
> +		.upper_margin	= 23,
> +		.lower_margin	= 1,
> +		.hsync_len	= 128,
> +		.vsync_len	= 4,
> +		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +		.vmode		= FB_VMODE_NONINTERLACED
> +	},
> +	{
>  		.name		= "1024x768-60",
>  		.refresh	= 60,
>  		.xres		= 1024,
> @@ -105,6 +120,21 @@ static struct fb_videomode __devinitdata
> fsl_diu_mode_db[] = {
>  		.vmode		= FB_VMODE_NONINTERLACED
>  	},
>  	{
> +		.name		= "1280x720-60",
> +		.refresh	= 60,
> +		.xres		= 1280,
> +		.yres		= 720,
> +		.pixclock	= 13426,
> +		.left_margin	= 192,
> +		.right_margin	= 64,
> +		.upper_margin	= 22,
> +		.lower_margin	= 1,
> +		.hsync_len	= 136,
> +		.vsync_len	= 3,
> +		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +		.vmode		= FB_VMODE_NONINTERLACED
> +	},
> +	{
>  		.name		= "1280x1024-60",
>  		.refresh	= 60,
>  		.xres		= 1280,
> @@ -150,6 +180,21 @@ static struct fb_videomode __devinitdata
> fsl_diu_mode_db[] = {
>  		.vmode		= FB_VMODE_NONINTERLACED
>  	},
>  	{
> +		.name		= "1920x1080-60",
> +		.refresh	= 60,
> +		.xres		= 1920,
> +		.yres		= 1080,
> +		.pixclock	= 5787,
> +		.left_margin	= 328,
> +		.right_margin	= 120,
> +		.upper_margin	= 34,
> +		.lower_margin	= 1,
> +		.hsync_len	= 208,
> +		.vsync_len	= 3,
> +		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +		.vmode		= FB_VMODE_NONINTERLACED
> +	},
> +	{
>  		.name		= "320x240",		/* for AOI only */
>  		.refresh	= 60,
>  		.xres		= 320,
> --
> 1.7.4.1


