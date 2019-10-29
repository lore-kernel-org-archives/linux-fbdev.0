From: Joe Perches <joe@perches.com>
Date: Tue, 29 Oct 2019 18:35:55 +0000
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
Message-Id: <5a6f05cef45dbb4f77008b36d7a63b429f1519ec.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191029182320.GA17569@mwanda>
In-Reply-To: <20191029182320.GA17569@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrea Righi <righi.andrea@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Peter Rosin <peda@axentia.se>, Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, security@kernel.org, Kees Cook <keescook@chromium.org>, Julia Lawall <Julia.Lawall@lip6.fr>

On Tue, 2019-10-29 at 21:23 +0300, Dan Carpenter wrote:
> The "fix" struct has a 2 byte hole after ->ywrapstep and the
> "fix = info->fix;" assignment doesn't necessarily clear it.  It depends
> on the compiler.
[]
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
[]
> @@ -1109,6 +1109,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  			ret = -EFAULT;
>  		break;
>  	case FBIOGET_FSCREENINFO:
> +		memset(&fix, 0, sizeof(fix));
>  		lock_fb_info(info);
>  		fix = info->fix;
>  		if (info->flags & FBINFO_HIDE_SMEM_START)

Perhaps better to change the struct copy to a memcpy
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index e6a1c80..364699 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1110,7 +1110,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		break;
 	case FBIOGET_FSCREENINFO:
 		lock_fb_info(info);
-		fix = info->fix;
+		memcpy(&fix, &info->fix, sizeof(fix));
 		if (info->flags & FBINFO_HIDE_SMEM_START)
 			fix.smem_start = 0;
 		unlock_fb_info(info);
