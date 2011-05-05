From: Jack Stone <jwjstone@fastmail.fm>
Date: Thu, 05 May 2011 21:00:42 +0000
Subject: Re: [PATCH] fbcon -- fix race between open and removal of framebuffers
Message-Id: <4DC30FFA.9030708@fastmail.fm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304617307-7389-1-git-send-email-tim.gardner@canonical.com> <1304617307-7389-2-git-send-email-tim.gardner@canonical.com>
In-Reply-To: <1304617307-7389-2-git-send-email-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tim.gardner@canonical.com
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, Leann Ogasawara <leann.ogasawara@canonical.com>

On 05/05/2011 18:41, tim.gardner@canonical.com wrote:
> +static struct fb_info *get_framebuffer_info(int idx)
> +__acquires(&registered_lock)
> +__releases(&registered_lock)
> +{
> +	struct fb_info *fb_info;
> +
> +	spin_lock(&registered_lock);
> +	fb_info = registered_fb[idx];
> +	fb_info->ref_count++;
> +	spin_unlock(&registered_lock);
> +
> +	return fb_info;
> +}
> +
>  static int
>  fb_open(struct inode *inode, struct file *file)
>  __acquires(&info->lock)
> @@ -1363,13 +1421,17 @@ __releases(&info->lock)
>  
>  	if (fbidx >= FB_MAX)
>  		return -ENODEV;
> -	info = registered_fb[fbidx];
> +	info = get_framebuffer_info(fbidx);
>  	if (!info)
>  		request_module("fb%d", fbidx);
> -	info = registered_fb[fbidx];
> +	info = get_framebuffer_info(fbidx);
>  	if (!info)
>  		return -ENODEV;

If the first get_framebuffer_info succeeds don't you up the ref count
twice? Shouldn't this be:

info = get_framebuffer_info(fbidx);
if (!info) {
	request_module("fb%d", fbidx);
	info = get_framebuffer_info(fbidx);
}
if (!info)
	return -ENODEV;

Thanks,

Jack
