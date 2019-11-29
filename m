From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 29 Nov 2019 15:24:24 +0000
Subject: Re: [PATCH v2 14/14] auxdisplay: constify fb ops
Message-Id: <20191129152424.GG624164@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <94a33cf0a587e803bcadcf80e8152eac9b196f34.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <94a33cf0a587e803bcadcf80e8152eac9b196f34.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Robin van der Gracht <robin@protonic.nl>

On Fri, Nov 29, 2019 at 12:29:44PM +0200, Jani Nikula wrote:
> Now that the fbops member of struct fb_info is const, we can start
> making the ops const as well.
> 
> Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> Cc: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/auxdisplay/cfag12864bfb.c | 2 +-
>  drivers/auxdisplay/ht16k33.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
> index 4074886b7bc8..2002291ab338 100644
> --- a/drivers/auxdisplay/cfag12864bfb.c
> +++ b/drivers/auxdisplay/cfag12864bfb.c

Oh, another display subsystem? Intriguing ...

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> @@ -57,7 +57,7 @@ static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
>  	return vm_map_pages_zero(vma, &pages, 1);
>  }
>  
> -static struct fb_ops cfag12864bfb_ops = {
> +static const struct fb_ops cfag12864bfb_ops = {
>  	.owner = THIS_MODULE,
>  	.fb_read = fb_sys_read,
>  	.fb_write = fb_sys_write,
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index a2fcde582e2a..d951d54b26f5 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -228,7 +228,7 @@ static int ht16k33_mmap(struct fb_info *info, struct vm_area_struct *vma)
>  	return vm_map_pages_zero(vma, &pages, 1);
>  }
>  
> -static struct fb_ops ht16k33_fb_ops = {
> +static const struct fb_ops ht16k33_fb_ops = {
>  	.owner = THIS_MODULE,
>  	.fb_read = fb_sys_read,
>  	.fb_write = fb_sys_write,
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
