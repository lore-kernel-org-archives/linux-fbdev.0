From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 03 Jul 2018 14:52:19 +0000
Subject: Re: [PATCH] fb: fix lost console when the user unplugs a USB adapter
Message-Id: <5091035.TYlAUG7jeO@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180603154636epcas2p4812a1f19c6ae236336ae580658edb167@epcas2p4.samsung.com>
 <alpine.LRH.2.02.1806031143470.15248@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1806031143470.15248@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org


Hi,

On Sunday, June 03, 2018 11:46:29 AM Mikulas Patocka wrote:
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

After this change unbind_console() will be called twice in the standard
framebuffer unregister path:

- first time, directly by do_unregister_framebuffer()

- second time, indirectly by do_unregister_framebuffer()->unlink_framebuffer()

This doesn't look correctly.

Also why can't udlfb just use unregister_framebuffer() like all other
drivers (it uses unlink_framebuffer() and it is the only user of this
helper)?

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

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

