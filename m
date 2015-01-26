From: David Ung <davidu@nvidia.com>
Date: Mon, 26 Jan 2015 20:21:33 +0000
Subject: RE: [PATCH] fbdev: fix CVT vertical front and back porch values
Message-Id: <d60f2ef79b004c0b8b5d9cc8476062a0@HQMAIL102.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422277830-5163-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1422277830-5163-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@ti.com]
> Sent: Monday, January 26, 2015 5:11 AM
> To: linux-fbdev@vger.kernel.org
> Cc: Tomi Valkeinen; David Ung; Antonino A. Daplas
> Subject: [PATCH] fbdev: fix CVT vertical front and back porch values
> 
> CVT v1.1 spec says: "the vertical front porch shall in all cases be fixed to 3
> lines". The code in fbcvt.c instead sets the _back_ porch to
> 3 (plus margin).
> 
> After swapping cvt.v_front_porch and cvt.v_back_porch the resulting
> timings were in line with CVT timings in VESA DMT spec.
> 
> The bug seems to be more than 9 years old, but I presume it has not been
> noticed as usually the video timings come from the EDID or from the timing
> tables in fbdev, and probably swapped values for vfp and vbp work fine for
> most of the displays.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Ung <davidu@nvidia.com>
> Cc: Antonino A. Daplas <adaplas@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcvt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcvt.c
> b/drivers/video/fbdev/core/fbcvt.c
> index 7cb715dfc0e1..55d2bd0ce5c0 100644
> --- a/drivers/video/fbdev/core/fbcvt.c
> +++ b/drivers/video/fbdev/core/fbcvt.c
> @@ -369,9 +369,9 @@ int fb_find_mode_cvt(struct fb_videomode *mode,
> int margins, int rb)
>  	cvt.h_back_porch = cvt.hblank/2 + cvt.h_margin;
>  	cvt.h_front_porch = cvt.hblank - cvt.hsync - cvt.h_back_porch +
>  		2 * cvt.h_margin;
> -	cvt.v_back_porch = 3 + cvt.v_margin;
> -	cvt.v_front_porch = cvt.vtotal - cvt.yres/cvt.interlace -
> -	    cvt.v_back_porch - cvt.vsync;
> +	cvt.v_front_porch = 3 + cvt.v_margin;
> +	cvt.v_back_porch = cvt.vtotal - cvt.yres/cvt.interlace -
> +	    cvt.v_front_porch - cvt.vsync;
>  	fb_cvt_print_name(&cvt);
>  	fb_cvt_convert_to_mode(&cvt, mode);
> 
> --
> 2.2.2

lgtm
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
