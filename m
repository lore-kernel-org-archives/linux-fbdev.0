From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Thu, 09 Jun 2011 06:10:19 +0000
Subject: Re: [RFC] fbmem: reset file->private_data on failed fb_open()
Message-Id: <20110609081019.145ed6d5@pluto.restena.lu>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110609030628.GA10233@localhost>
In-Reply-To: <20110609030628.GA10233@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, 9 Jun 2011 11:06:28 Wu Fengguang <fengguang.wu@intel.com> wrote:
> I wrote this when looking at NULL dereference bug
> https://bugzilla.kernel.org/show_bug.cgi?id912

The trace over there rather looks like closing of a framebuffer that
has been replaced (and destroyed) during boot sequence.
This action happens when switching from VESA to KMS from initrd
or early userspace boot sequence where plymouthd had already opened
vesafb.

That should hopefully be fixed by refcounting FBs as done during
2.6.39-rc7.

> Will it help by clearing private_data? I have no idea at all, because
> for regular files, ->release won't be called on failed ->open. Just in
> case there are some exceptions in fbmem...

fb devices files should be just as regular as any other device files...

> ---
>  drivers/video/fbmem.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-next.orig/drivers/video/fbmem.c	2011-06-09 10:36:06.000000000 +0800
> +++ linux-next/drivers/video/fbmem.c	2011-06-09 10:39:30.000000000 +0800
> @@ -1424,26 +1424,28 @@ __releases(&info->lock)
>  	file->private_data = info;
>  	if (info->fbops->fb_open) {
>  		res = info->fbops->fb_open(info,1);
>  		if (res)
>  			module_put(info->fbops->owner);
>  	}
>  #ifdef CONFIG_FB_DEFERRED_IO
>  	if (info->fbdefio)
>  		fb_deferred_io_open(info, inode, file);
>  #endif
>  out:
>  	mutex_unlock(&info->lock);
> -	if (res)
> +	if (res) {
> +		file->private_data = NULL;
>  		put_fb_info(info);
> +	}
>  	return res;
>  }
>  
>  static int 
>  fb_release(struct inode *inode, struct file *file)
>  __acquires(&info->lock)
>  __releases(&info->lock)
>  {
>  	struct fb_info * const info = file->private_data;
>  
>  	mutex_lock(&info->lock);
>  	if (info->fbops->fb_release)
