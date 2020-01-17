From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 17 Jan 2020 18:59:33 +0000
Subject: Re: [PATCH 1/2] video: fbdev: wm8505fb: fix sparse warnings about using incorrect types
Message-Id: <20200117185933.GA24812@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116145444eucas1p1b62a023ad7ea3722193c932761eb8493@eucas1p1.samsung.com>
 <411db705-a098-27e6-8f52-acfea2735738@samsung.com>
In-Reply-To: <411db705-a098-27e6-8f52-acfea2735738@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, Jan 16, 2020 at 03:54:42PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Use ->screen_buffer instead of ->screen_base to fix sparse warnings.
> 
> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>   pointer") for details. ]
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/video/fbdev/wm8505fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/drivers/video/fbdev/wm8505fb.c
> =================================> --- a/drivers/video/fbdev/wm8505fb.c
> +++ b/drivers/video/fbdev/wm8505fb.c
> @@ -339,7 +339,7 @@ static int wm8505fb_probe(struct platfor
>  
>  	fbi->fb.fix.smem_start		= fb_mem_phys;
>  	fbi->fb.fix.smem_len		= fb_mem_len;
> -	fbi->fb.screen_base		= fb_mem_virt;
> +	fbi->fb.screen_buffer		= fb_mem_virt;
>  	fbi->fb.screen_size		= fb_mem_len;
>  
>  	fbi->contrast = 0x10;
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
