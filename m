From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fbdev: Wrong test on unsigned in fb_set_user_cmap()?
Date: Tue, 3 Nov 2009 14:59:14 -0800
Message-ID: <20091103145914.84094e8e.akpm@linux-foundation.org>
References: <4ADE0FDE.5070101@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751415AbZKCW70@vger.kernel.org>
In-Reply-To: <4ADE0FDE.5070101@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Tue, 20 Oct 2009 21:30:38 +0200
Roel Kluin <roel.kluin@gmail.com> wrote:

> struct fb_cmap_user member start is unsigned.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Is this required?
> 
> diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
> index f53b9f1..f46f05f 100644
> --- a/drivers/video/fbcmap.c
> +++ b/drivers/video/fbcmap.c
> @@ -266,7 +266,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
>  		rc = -ENODEV;
>  		goto out;
>  	}
> -	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
> +	if ((int)cmap->start < 0 || (!info->fbops->fb_setcolreg &&
>  				!info->fbops->fb_setcmap)) {
>  		rc = -EINVAL;
>  		goto out1;

I think the test _is_ needed, as `start' is passed in direct from
userspace, via do_fb_ioctl():FBIOPUTCMAP.

However fb_set_user_cmap() calls fb_set_cmap() which also checks
`start', only this time it does it correctly.

So overall the code is OK and the check which you've identified
is unneeded.

In fact, all of

	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
				!info->fbops->fb_setcmap)) {
		rc = -EINVAL;
		goto out1;
	}

can be removed.
