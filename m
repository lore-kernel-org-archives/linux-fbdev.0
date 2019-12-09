From: Jani Nikula <jani.nikula@intel.com>
Date: Mon, 09 Dec 2019 14:03:52 +0000
Subject: Re: [PATCH v3 12/12] auxdisplay: constify fb ops
Message-Id: <87pngx4muv.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
 <31c18e3ce9d6962aabda4799b3051039ff591c92.1575390741.git.jani.nikula@intel.com>
In-Reply-To: <31c18e3ce9d6962aabda4799b3051039ff591c92.1575390741.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, intel-gfx@lists.freedesktop.org, Robin van der Gracht <robin@protonic.nl>, Daniel Vetter <daniel.vetter@ffwll.ch>

On Tue, 03 Dec 2019, Jani Nikula <jani.nikula@intel.com> wrote:
> Now that the fbops member of struct fb_info is const, we can start
> making the ops const as well.
>
> Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> Cc: Robin van der Gracht <robin@protonic.nl>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Acked-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Miguel, Robin, just to err on the safe side, were you both okay with me
merging this through drm-misc? Not very likely to conflict badly.

BR,
Jani.

> ---
>  drivers/auxdisplay/cfag12864bfb.c | 2 +-
>  drivers/auxdisplay/ht16k33.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
> index 4074886b7bc8..2002291ab338 100644
> --- a/drivers/auxdisplay/cfag12864bfb.c
> +++ b/drivers/auxdisplay/cfag12864bfb.c
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

-- 
Jani Nikula, Intel Open Source Graphics Center
