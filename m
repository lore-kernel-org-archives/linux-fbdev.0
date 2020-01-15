From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 14:31:29 +0000
Subject: Re: [PATCH v2] fbdev: potential information leak in do_fb_ioctl()
Message-Id: <ac5585a5-1670-92d2-c019-f349df123f47@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200113111044eucas1p2037e64332e79316dc0114d67a38400ab@eucas1p2.samsung.com>
 <20200113100132.ixpaymordi24n3av@kili.mountain>
In-Reply-To: <20200113100132.ixpaymordi24n3av@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>, Andrea Righi <righi.andrea@gmail.com>


On 1/13/20 12:08 PM, Dan Carpenter wrote:
> The "fix" struct has a 2 byte hole after ->ywrapstep and the
> "fix = info->fix;" assignment doesn't necessarily clear it.  It depends
> on the compiler.  The solution is just to replace the assignment with an
> memcpy().
> 
> Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch queued for v5.6, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> v2:  Use memcpy()
> 
>  drivers/video/fbdev/core/fbmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index d04554959ea7..bb8d8dbc0461 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1115,7 +1115,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  		break;
>  	case FBIOGET_FSCREENINFO:
>  		lock_fb_info(info);
> -		fix = info->fix;
> +		memcpy(&fix, &info->fix, sizeof(fix));
>  		if (info->flags & FBINFO_HIDE_SMEM_START)
>  			fix.smem_start = 0;
>  		unlock_fb_info(info);
> 
