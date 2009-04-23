From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: fbcmap: non working tests on unsigned cmap->start
Date: Thu, 23 Apr 2009 13:41:10 -0700
Message-ID: <20090423134110.51ea8df2.akpm@linux-foundation.org>
References: <49EDD799.8060607@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757953AbZDWUpl@vger.kernel.org>
In-Reply-To: <49EDD799.8060607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Roel Kluin <roel.kluin@gmail.com>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, 21 Apr 2009 16:26:33 +0200
Roel Kluin <roel.kluin@gmail.com> wrote:

> vi include/linux/fb.h +478
> 
> Note that struct fb_cmap_user cmap->start in fb_set_user_cmap() is unsigned.
> Should there maybe be a test:
> 
> if (cmap->start > MAX || ...)
> 
> (and what should MAX be then?)
> 
> Otherwise you may want to apply the cleanup patch below
> 
> Roel
> ------------------------------>8-------------8<---------------------------------
> Remove redundant tests on unsigned
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com> 
> ---
> diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
> index f53b9f1..958bf4e 100644
> --- a/drivers/video/fbcmap.c
> +++ b/drivers/video/fbcmap.c
> @@ -266,8 +266,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
>  		rc = -ENODEV;
>  		goto out;
>  	}
> -	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
> -				!info->fbops->fb_setcmap)) {
> +	if (!info->fbops->fb_setcolreg && !info->fbops->fb_setcmap) {
>  		rc = -EINVAL;
>  		goto out1;
>  	}

argh.

- Perhaps userspace can kill the kernel by sending a "negative"
  `start'.  Removing the test will make it even less likely that we'll
  fix this bug.

- If this bug doesn't exist, and there _is_ userspace which is
  legitimately sending in "negative" values of `start' (unlikely?) then
  we will break userspace if we fix this comparison.

IOW, I don't have enough knowledge about this code to be able to know
what to do.
