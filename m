From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 04 Jul 2018 08:40:33 +0000
Subject: Re: [PATCH] fb: fix lost console when the user unplugs a USB adapter
Message-Id: <20180704084033.GO3891@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1806031143470.15248@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1806031143470.15248@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>

On Sun, Jun 03, 2018 at 11:46:29AM -0400, Mikulas Patocka wrote:
> I have a USB display adapter using the udlfb driver and I use it on an ARM
> board that doesn't have any graphics card. When I plug the adapter in, the
> console is properly displayed, however when I unplug and re-plug the
> adapter, the console is not displayed and I can't access it until I reboot
> the board.
> 
> The reason is this:
> When the adapter is unplugged, dlfb_usb_disconnect calls
> unlink_framebuffer, then it waits until the reference count drops to zero
> and then it deallocates the framebuffer. However, the console that is
> attached to the framebuffer device keeps the reference count non-zero, so
> the framebuffer device is never destroyed. When the USB adapter is plugged
> again, it creates a new device /dev/fb1 and the console is not attached to
> it.
> 
> This patch fixes the bug by unbinding the console from unlink_framebuffer.
> The code to unbind the console is moved from do_unregister_framebuffer to
> a function unbind_console. When the console is unbound, the reference
> count drops to zero and the udlfb driver frees the framebuffer. When the
> adapter is plugged back, a new framebuffer is created and the console is
> attached to it.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org

Does this work correctly with the udl drm driver and the drm fbdev
emulation? If yes I'm not sure what the value is in fixing up the uldfb
driver really ...

Same for all the uldfb fixes in your other series. If the 2 drivers are
on feature parity I'd just go ahead and remove the uldfb one.
-Daniel
> 
> ---
>  drivers/video/fbdev/core/fbmem.c |   21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> Index: linux-4.16.12/drivers/video/fbdev/core/fbmem.c
> =================================> --- linux-4.16.12.orig/drivers/video/fbdev/core/fbmem.c	2018-05-26 06:13:20.000000000 +0200
> +++ linux-4.16.12/drivers/video/fbdev/core/fbmem.c	2018-05-26 06:13:20.000000000 +0200
> @@ -1805,12 +1805,12 @@ static int do_register_framebuffer(struc
>  	return 0;
>  }
>  
> -static int do_unregister_framebuffer(struct fb_info *fb_info)
> +static int unbind_console(struct fb_info *fb_info)
>  {
>  	struct fb_event event;
> -	int i, ret = 0;
> +	int ret;
> +	int i = fb_info->node;
>  
> -	i = fb_info->node;
>  	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
>  		return -EINVAL;
>  
> @@ -1825,6 +1825,16 @@ static int do_unregister_framebuffer(str
>  	unlock_fb_info(fb_info);
>  	console_unlock();
>  
> +	return ret;
> +}
> +
> +static int do_unregister_framebuffer(struct fb_info *fb_info)
> +{
> +	struct fb_event event;
> +	int ret;
> +
> +	ret = unbind_console(fb_info);
> +
>  	if (ret)
>  		return -EINVAL;
>  
> @@ -1835,7 +1845,7 @@ static int do_unregister_framebuffer(str
>  	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
>  		kfree(fb_info->pixmap.addr);
>  	fb_destroy_modelist(&fb_info->modelist);
> -	registered_fb[i] = NULL;
> +	registered_fb[fb_info->node] = NULL;
>  	num_registered_fb--;
>  	fb_cleanup_device(fb_info);
>  	event.info = fb_info;
> @@ -1860,6 +1870,9 @@ int unlink_framebuffer(struct fb_info *f
>  		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
>  		fb_info->dev = NULL;
>  	}
> +
> +	unbind_console(fb_info);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(unlink_framebuffer);
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
