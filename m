From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 26 Sep 2018 15:45:52 +0000
Subject: Re: [PATCH] fbdev/omapfb: fix omapfb_memory_read infoleak
Message-Id: <20180926154553eucas1p11b97be93a7e9218945a45e2a23dfb099~X-bV9uhhW2059120591eucas1p1F@eucas1p1.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180912073137epcas5p36de373cd9715ad2a2b60c5206c08e5cf@epcas5p3.samsung.com>
        <20180912073046.26475-1-tomi.valkeinen@ti.com>
In-Reply-To: <20180912073046.26475-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, stable@vger.kernel.org, security@kernel.org, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>, Tony Lindgren <tony@atomide.com>


[ added dri-devel@lists.freedesktop.org to Cc: ]

On 09/12/2018 09:30 AM, Tomi Valkeinen wrote:
> OMAPFB_MEMORY_READ ioctl reads pixels from the LCD's memory and copies
> them to a userspace buffer. The code has two issues:
> 
> - The user provided width and height could be large enough to overflow
>   the calculations
> - The copy_to_user() can copy uninitialized memory to the userspace,
>   which might contain sensitive kernel information.
> 
> Fix these by limiting the width & height parameters, and only copying
> the amount of data that we actually received from the LCD.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reported-by: Jann Horn <jannh@google.com>
> Cc: stable@vger.kernel.org
> Cc: security@kernel.org
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Tony Lindgren <tony@atomide.com>

Patch queued for 4.19, thanks.

> ---
>  drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> index ef69273074ba..a3edb20ea4c3 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> @@ -496,6 +496,9 @@ static int omapfb_memory_read(struct fb_info *fbi,
>  	if (!access_ok(VERIFY_WRITE, mr->buffer, mr->buffer_size))
>  		return -EFAULT;
>  
> +	if (mr->w > 4096 || mr->h > 4096)
> +		return -EINVAL;
> +
>  	if (mr->w * mr->h * 3 > mr->buffer_size)
>  		return -EINVAL;
>  
> @@ -509,7 +512,7 @@ static int omapfb_memory_read(struct fb_info *fbi,
>  			mr->x, mr->y, mr->w, mr->h);
>  
>  	if (r > 0) {
> -		if (copy_to_user(mr->buffer, buf, mr->buffer_size))
> +		if (copy_to_user(mr->buffer, buf, r))
>  			r = -EFAULT;
>  	}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
