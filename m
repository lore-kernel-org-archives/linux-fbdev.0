From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:36:43 +0000
Subject: Re: [PATCH] video: fbdev: fix setting of pixclock because a pass-by-value error
Message-Id: <ed082436-9ce3-23fd-679c-9cdf7b1da0cd@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200723170235eucas1p21b1e0f5ff092d550d65057ae2a31a897@eucas1p2.samsung.com>
 <20200723170227.996229-1-colin.king@canonical.com>
In-Reply-To: <20200723170227.996229-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 7/23/20 7:02 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pixclock is being set locally because it is being passed as a
> pass-by-value argument rather than pass-by-reference, so the computed
> pixclock is never being set in var->pixclock. Fix this by passing
> by reference.
> 
> [This dates back to 2002, I found the offending commit from the git
> history git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git ]
> 
> Addresses-Coverity: ("Unused value")
> Fixes: 115f4504a64a ("Removed currcon and other console related code. Very little is now left.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to drm-misc-next tree, thanks and sorry for the delay.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/vga16fb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
> index a20eeb8308ff..52f273af6cae 100644
> --- a/drivers/video/fbdev/vga16fb.c
> +++ b/drivers/video/fbdev/vga16fb.c
> @@ -243,7 +243,7 @@ static void vga16fb_update_fix(struct fb_info *info)
>  }
>  
>  static void vga16fb_clock_chip(struct vga16fb_par *par,
> -			       unsigned int pixclock,
> +			       unsigned int *pixclock,
>  			       const struct fb_info *info,
>  			       int mul, int div)
>  {
> @@ -259,14 +259,14 @@ static void vga16fb_clock_chip(struct vga16fb_par *par,
>  		{     0 /* bad */,    0x00, 0x00}};
>  	int err;
>  
> -	pixclock = (pixclock * mul) / div;
> +	*pixclock = (*pixclock * mul) / div;
>  	best = vgaclocks;
> -	err = pixclock - best->pixclock;
> +	err = *pixclock - best->pixclock;
>  	if (err < 0) err = -err;
>  	for (ptr = vgaclocks + 1; ptr->pixclock; ptr++) {
>  		int tmp;
>  
> -		tmp = pixclock - ptr->pixclock;
> +		tmp = *pixclock - ptr->pixclock;
>  		if (tmp < 0) tmp = -tmp;
>  		if (tmp < err) {
>  			err = tmp;
> @@ -275,7 +275,7 @@ static void vga16fb_clock_chip(struct vga16fb_par *par,
>  	}
>  	par->misc |= best->misc;
>  	par->clkdiv = best->seq_clock_mode;
> -	pixclock = (best->pixclock * div) / mul;		
> +	*pixclock = (best->pixclock * div) / mul;
>  }
>  			       
>  #define FAIL(X) return -EINVAL
> @@ -497,10 +497,10 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
>  
>  	if (mode & MODE_8BPP)
>  		/* pixel clock = vga clock / 2 */
> -		vga16fb_clock_chip(par, var->pixclock, info, 1, 2);
> +		vga16fb_clock_chip(par, &var->pixclock, info, 1, 2);
>  	else
>  		/* pixel clock = vga clock */
> -		vga16fb_clock_chip(par, var->pixclock, info, 1, 1);
> +		vga16fb_clock_chip(par, &var->pixclock, info, 1, 1);
>  	
>  	var->red.offset = var->green.offset = var->blue.offset = 
>  	var->transp.offset = 0;
> 
