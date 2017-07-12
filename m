From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 12 Jul 2017 08:17:32 +0000
Subject: Re: [PATCH v2] fbdev: make get_fb_unmapped_area depends of !MMU
Message-Id: <20170712081732.v4gmp6omjo3pynep@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1499845387-10394-1-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1499845387-10394-1-git-send-email-benjamin.gaignard@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, emil.l.velikov@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, yannick.fertre@st.com

On Wed, Jul 12, 2017 at 09:43:07AM +0200, Benjamin Gaignard wrote:
> Even if CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA flag is selected
> do not compile and use get_fb_unmapped_area() if CONFIG_MMU is
> also set. This will avoid mmap errors when compiling multi
> architectures at same time.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Yeah we have the same CONFIG_MMU check on the gem side for
get_unmapped_area.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
> version 2:
> - remove duplicated "\"
> 
>  drivers/video/fbdev/core/fbmem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 069fe79..f20c5d2 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1492,7 +1492,7 @@ static long fb_compat_ioctl(struct file *file, unsigned int cmd,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA
> +#if defined(CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA) && !defined(CONFIG_MMU)
>  unsigned long get_fb_unmapped_area(struct file *filp,
>  				   unsigned long addr, unsigned long len,
>  				   unsigned long pgoff, unsigned long flags)
> @@ -1519,7 +1519,8 @@ unsigned long get_fb_unmapped_area(struct file *filp,
>  	.open =		fb_open,
>  	.release =	fb_release,
>  #if defined(HAVE_ARCH_FB_UNMAPPED_AREA) || \
> -    defined(CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA)
> +	(defined(CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA) && \
> +	 !defined(CONFIG_MMU))
>  	.get_unmapped_area = get_fb_unmapped_area,
>  #endif
>  #ifdef CONFIG_FB_DEFERRED_IO
> -- 
> 1.9.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
