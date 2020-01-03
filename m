From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 12:02:41 +0000
Subject: Re: [PATCH] video/fbdev/68328fb: Remove dead code
Message-Id: <dc887c33-0374-34e7-8d0d-329b87a5a7c3@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190902124317epcas1p3933aec8ee7e526f3f42dd9f08ce6bdb0@epcas1p3.samsung.com>
 <1567428544-8620-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1567428544-8620-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, sabyasachi.linux@gmail.com


On 9/2/19 2:49 PM, Souptick Joarder wrote:
> This is dead code since 3.15. If their is no plan to
> use it further, these can be removed forever.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/68328fb.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/video/fbdev/68328fb.c b/drivers/video/fbdev/68328fb.c
> index d48e960..02d22b7 100644
> --- a/drivers/video/fbdev/68328fb.c
> +++ b/drivers/video/fbdev/68328fb.c
> @@ -405,20 +405,8 @@ static int mc68x328fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
>  
>  int __init mc68x328fb_setup(char *options)
>  {
> -#if 0
> -	char *this_opt;
> -#endif
> -
>  	if (!options || !*options)
>  		return 1;
> -#if 0
> -	while ((this_opt = strsep(&options, ",")) != NULL) {
> -		if (!*this_opt)
> -			continue;
> -		if (!strncmp(this_opt, "disable", 7))
> -			mc68x328fb_enable = 0;
> -	}
> -#endif
>  	return 1;
>  }
>  
