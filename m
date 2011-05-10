From: Jack Stone <jwjstone@fastmail.fm>
Date: Tue, 10 May 2011 21:08:03 +0000
Subject: Re: [PATCH V2] fbcon -- fix race between open and removal of framebuffers
Message-Id: <4DC9A933.5030706@fastmail.fm>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304617307-7389-1-git-send-email-tim.gardner@canonical.com> <1304617307-7389-2-git-send-email-tim.gardner@canonical.com> <4DC30FFA.9030708@fastmail.fm> <4DC933EE.70409@canonical.com> <4DC9A8C0.9070502@fastmail.fm>
In-Reply-To: <4DC9A8C0.9070502@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tim Gardner <tim.gardner@canonical.com>
Cc: linux-fbdev@vger.kernel.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, Leann Ogasawara <leann.ogasawara@canonical.com>

On 10/05/2011 22:06, Jack Stone wrote:
> Hi Tim,
> 
> One more quick question:
> 
> On 10/05/2011 13:47, Tim Gardner wrote:
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
> 
> [snip]
> 
>  static int
>  fb_open(struct inode *inode, struct file *file)
>  __acquires(&info->lock)
> @@ -1363,13 +1421,18 @@ __releases(&info->lock)
> 
>  	if (fbidx >= FB_MAX)
>  		return -ENODEV;
> -	info = registered_fb[fbidx];
> -	if (!info)
> +	info = get_framebuffer_info(fbidx);
> +	if (!info) {
>  		request_module("fb%d", fbidx);
> -	info = registered_fb[fbidx];
> +		info = get_framebuffer_info(fbidx);
> +	}
>  	if (!info)
>  		return -ENODEV;
> 
> This section of code implies that get_framebuffer_info can return NULL
> but in that case wouldn't the fb_info->ref_count++ have oopsed?
> 
> You could add the simple case of
> 
> if(fb_info)
> 	fb_info->ref_count++
> 
> to get_framebuffer_info. That should cover it.
> 

Just read your later patch. Sorry for the extra email.

Thanks,

Jack
