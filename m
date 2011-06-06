From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 06 Jun 2011 03:07:04 +0000
Subject: Re: [Patch 2/2 resend] Prevent vga16fb from accessing hw after it was unregistered
Message-Id: <20110606030704.GD26101@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110524223221.741ffbc0@neptune.home>
In-Reply-To: <20110524223221.741ffbc0@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, May 24, 2011 at 10:32:21PM +0200, Bruno Pr??mont wrote:
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 5aac00e..bd9f93b 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1661,6 +1661,11 @@ static int do_unregister_framebuffer(struct fb_info *fb_info)
>  	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
>  	event.info = fb_info;
>  	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
> +	if (fb_info->fbops->fb_unregistered) {
> +		mutex_lock(&fb_info->lock);
> +		fb_info->fbops->fb_unregistered(fb_info);
> +		mutex_unlock(&fb_info->lock);
> +	}
>  
>  	/* this may free fb info */
>  	put_fb_info(fb_info);

I'm not sure I really see the point, given that you can already do all of
the same work by tying in to the notifier chain. See for example the
sh_mobile_hdmi driver and its unreg notifier.
