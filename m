From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 20 Dec 2018 16:21:45 +0000
Subject: Re: [PATCH] fbcon: use kvmalloc() for scrollback buffer
Message-Id: <a7f6bf30-5094-b669-126d-e4751c17dcbb@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181126100342epcas3p12a1e6505ff4b73375ac3fcf5d0355d3f@epcas3p1.samsung.com>
        <20181126100253.3299-1-khorenko@virtuozzo.com>
In-Reply-To: <20181126100253.3299-1-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi,

On 11/26/2018 11:02 AM, Konstantin Khorenko wrote:
> Scrollback frame buffer is rather big - 32K,
> so it requires 3rd order page, so let's use kvmalloc() instead of
> ordinary kmalloc() for it.

Is it actually safe to use non-contiguous memory for softback_buf?

> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 8958ccc8b1ac..2b1a34d3f5e2 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -992,7 +992,7 @@ static const char *fbcon_startup(void)
>  			if (!softback_buf) {
>  				softback_buf >  				    (unsigned long)
> -				    kmalloc(fbcon_softback_size,
> +				    kvmalloc(fbcon_softback_size,
>  					    GFP_KERNEL);
>  				if (!softback_buf) {
>  					fbcon_softback_size = 0;
> @@ -1001,7 +1001,7 @@ static const char *fbcon_startup(void)
>  			}
>  		} else {
>  			if (softback_buf) {
> -				kfree((void *) softback_buf);
> +				kvfree((void *) softback_buf);
>  				softback_buf = 0;
>  				softback_top = 0;
>  			}
> @@ -3665,7 +3665,7 @@ static void fbcon_exit(void)
>  	}
>  #endif
>  
> -	kfree((void *)softback_buf);
> +	kvfree((void *)softback_buf);
>  	softback_buf = 0UL;
>  
>  	for_each_registered_fb(i) {

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
