From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 11 Jan 2010 21:46:44 +0000
Subject: Re: [PATCH 3/4] viafb: do modesetting after updating variables
Message-Id: <20100111134644.bf26dd07.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1262732399-3416-1-git-send-email-FlorianSchandinat@gmx.de>
	<1262732399-3416-2-git-send-email-FlorianSchandinat@gmx.de>
	<1262732399-3416-3-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1262732399-3416-3-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Erik-Jan Post <ej.lfs@xs4all.nl>

On Tue,  5 Jan 2010 22:59:58 +0000
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> viafb: do modesetting after updating variables
> 
> Reorder viafb_set_par to allow using the updated variables in
> viafb_setmode. This fixes a regression that prevented proper
> runtime mode changes.
> 
> Signed-off-by: Erik-Jan Post <ej.lfs@xs4all.nl>
> Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> ---
>  drivers/video/via/viafbdev.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index e16df84..f7ff4ea 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -174,15 +174,15 @@ static int viafb_set_par(struct fb_info *info)
>  	}
>  
>  	if (vmode_entry) {
> -		viafb_setmode(vmode_entry, info->var.bits_per_pixel,
> -			vmode_entry1, viafb_bpp1);
> -
>  		viafb_update_fix(info);
>  		viafb_bpp = info->var.bits_per_pixel;
>  		if (info->var.accel_flags & FB_ACCELF_TEXT)
>  			info->flags &= ~FBINFO_HWACCEL_DISABLED;
>  		else
>  			info->flags |= FBINFO_HWACCEL_DISABLED;
> +
> +		viafb_setmode(vmode_entry, info->var.bits_per_pixel,
> +			vmode_entry1, viafb_bpp1);
>  	}
>  
>  	return 0;

Problem.

Patches 2, 3 and 4 are appropriate to 2.6.33 - they fix regressions. 
But all four patches are dependent upon patches which we already have
queued for 2.6.34!

I redid patches 2, 3 and 4 so they apply to current mainline.  This
particular patch (3/4) needed fixing - please check the result.  

--- a/drivers/video/via/viafbdev.c~viafb-do-modesetting-after-updating-variables
+++ a/drivers/video/via/viafbdev.c
@@ -177,16 +177,15 @@ static int viafb_set_par(struct fb_info 
 	}
 
 	if (vmode_index != VIA_RES_INVALID) {
-		viafb_setmode(vmode_index, info->var.xres, info->var.yres,
-			info->var.bits_per_pixel, vmode_index1,
-			viafb_second_xres, viafb_second_yres, viafb_bpp1);
-
 		viafb_update_fix(info);
 		viafb_bpp = info->var.bits_per_pixel;
 		if (info->var.accel_flags & FB_ACCELF_TEXT)
 			info->flags &= ~FBINFO_HWACCEL_DISABLED;
 		else
 			info->flags |= FBINFO_HWACCEL_DISABLED;
+		viafb_setmode(vmode_index, info->var.xres, info->var.yres,
+			info->var.bits_per_pixel, vmode_index1,
+			viafb_second_xres, viafb_second_yres, viafb_bpp1);
 	}
 
 	return 0;
_


This reordering broke viafb-split-global-index-up.patch, which I fixed up.
