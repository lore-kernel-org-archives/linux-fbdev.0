From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Nov 2019 18:29:40 +0000
Subject: Re: [PATCH 13/13] samples: vfio-mdev: constify fb ops
Message-Id: <20191127182940.GM406127@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
 <fc8342eef9fcd2f55c86fcd78f7df52f7c76fa87.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <fc8342eef9fcd2f55c86fcd78f7df52f7c76fa87.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

On Wed, Nov 27, 2019 at 06:32:09PM +0200, Jani Nikula wrote:
> Now that the fbops member of struct fb_info is const, we can star making
> the ops const as well.
> 
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

You've missed at least drivers/staging/fbtft in your search. I guess you
need to do a full make allyesconfig on x86/arm and arm64 (the latter
because some stupid drivers only compile there, not on arm, don't ask).
Still misses a pile of mips/ppc only stuff and maybe the sparcs and
alphas, but should be good enough.

With that done, on the remaining patches:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  samples/vfio-mdev/mdpy-fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/vfio-mdev/mdpy-fb.c b/samples/vfio-mdev/mdpy-fb.c
> index 2719bb259653..21dbf63d6e41 100644
> --- a/samples/vfio-mdev/mdpy-fb.c
> +++ b/samples/vfio-mdev/mdpy-fb.c
> @@ -86,7 +86,7 @@ static void mdpy_fb_destroy(struct fb_info *info)
>  		iounmap(info->screen_base);
>  }
>  
> -static struct fb_ops mdpy_fb_ops = {
> +static const struct fb_ops mdpy_fb_ops = {
>  	.owner		= THIS_MODULE,
>  	.fb_destroy	= mdpy_fb_destroy,
>  	.fb_setcolreg	= mdpy_fb_setcolreg,
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
