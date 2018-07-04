From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Wed, 04 Jul 2018 15:31:19 +0000
Subject: Re: [PATCH] fb: fix lost console when the user unplugs a USB adapter
Message-Id: <7861c063-6494-7cd8-683d-02c61f9faa1f@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180603154636epcas2p4812a1f19c6ae236336ae580658edb167@epcas2p4.samsung.com>
 <alpine.LRH.2.02.1806031143470.15248@file01.intranet.prod.int.rdu2.redhat.com>
 <5091035.TYlAUG7jeO@amdc3058>
 <alpine.LRH.2.02.1807031301290.22443@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1807031301290.22443@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org


Den 03.07.2018 19.18, skrev Mikulas Patocka:
>
> On Tue, 3 Jul 2018, Bartlomiej Zolnierkiewicz wrote:
>
>> Hi,
>>
>> On Sunday, June 03, 2018 11:46:29 AM Mikulas Patocka wrote:
>>> I have a USB display adapter using the udlfb driver and I use it on an ARM
>>> board that doesn't have any graphics card. When I plug the adapter in, the
>>> console is properly displayed, however when I unplug and re-plug the
>>> adapter, the console is not displayed and I can't access it until I reboot
>>> the board.
>>>
>>> The reason is this:
>>> When the adapter is unplugged, dlfb_usb_disconnect calls
>>> unlink_framebuffer, then it waits until the reference count drops to zero
>>> and then it deallocates the framebuffer. However, the console that is
>>> attached to the framebuffer device keeps the reference count non-zero, so
>>> the framebuffer device is never destroyed. When the USB adapter is plugged
>>> again, it creates a new device /dev/fb1 and the console is not attached to
>>> it.
>>>
>>> This patch fixes the bug by unbinding the console from unlink_framebuffer.
>>> The code to unbind the console is moved from do_unregister_framebuffer to
>>> a function unbind_console. When the console is unbound, the reference
>>> count drops to zero and the udlfb driver frees the framebuffer. When the
>>> adapter is plugged back, a new framebuffer is created and the console is
>>> attached to it.
>>>
>>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>>> Cc: stable@vger.kernel.org
>> After this change unbind_console() will be called twice in the standard
>> framebuffer unregister path:
>>
>> - first time, directly by do_unregister_framebuffer()
>>
>> - second time, indirectly by do_unregister_framebuffer()->unlink_framebuffer()
>>
>> This doesn't look correctly.
> unbind_console calls the FB_EVENT_FB_UNBIND notifier, FB_EVENT_FB_UNBIND
> goes to the function fbcon_fb_unbind and fbcon_fb_unbind checks if the
> console is bound to the framebuffer for which unbind is requested. So a
> double call won't cause any trouble.
>
>> Also why can't udlfb just use unregister_framebuffer() like all other
>> drivers (it uses unlink_framebuffer() and it is the only user of this
>> helper)?
> It uses unregister_framebuffer() - but - unregister_framebuffer() may only
> be called when the open count of the framebuffer is zero.

AFAIU calling unregister_framebuffer() with open fd's is just fine as
long as fb_info with buffers stay intact. All it does is to remove the
fbX from userspace. Cleanup can be done in fb_ops->fb_destroy.

I have been working on generic fbdev emulation for DRM [1] and I did a
test now to see what would happen if I did unbind the driver from the
device. It worked as expected if I didn't have another fbdev present,
but if there is an fb0 and I remove fb1 with a console on it, I would
sometimes get crashes, often with a call to cursor_timer_handler() in
the traceback.

I think there's index mixup in fbcon_fb_unbind(), at least this change
seems to solve the immediate problem:

diff --git a/drivers/video/fbdev/core/fbcon.c 
b/drivers/video/fbdev/core/fbcon.c
index 5fb156bdcf4e..271b9b988b73 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3066,7 +3072,7 @@ static int fbcon_fb_unbind(int idx)
         for (i = first_fb_vc; i <= last_fb_vc; i++) {
                 if (con2fb_map[i] != idx &&
                     con2fb_map[i] != -1) {
-                       new_idx = i;
+                       new_idx = con2fb_map[i];
                         break;
                 }
         }

I haven't got time to follow up on this now, but making sure DRM generic
fbdev emulation device unplug works is on my TODO.

BTW, I believe the udl drm driver should be able to use the generic fbdev
emulation if it had a drm_driver->gem_prime_vmap hook. It uses a shadow
buffer which would also make fbdev mmap work for udl. (shmem buffers and
fbdev deferred I/O doesn't work together since they both use
page->lru/mapping)

Noralf.

[1] https://patchwork.freedesktop.org/series/45847/


> So, the udlfb
> driver waits until the open count drops to zero and then calls
> unregister_framebuffer().
>
> But the console subsystem keeps the framebuffer open - which means that if
> user use unplugs the USB adapter, the open count won't drop to zero
> (because the console is bound to it) - which means that
> unregister_framebuffer() will not be called.
>
> You must unbind the console before calling unregister_framebuffer(). The
> PCI framebuffer drivers don't have this problem because the user is not
> expected to just unplug the PCI card while it is being used by the
> console.
>
> Mikulas
>
>>> ---
>>>   drivers/video/fbdev/core/fbmem.c |   21 +++++++++++++++++----
>>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>>
>>> Index: linux-4.16.12/drivers/video/fbdev/core/fbmem.c
>>> =================================>>> --- linux-4.16.12.orig/drivers/video/fbdev/core/fbmem.c	2018-05-26 06:13:20.000000000 +0200
>>> +++ linux-4.16.12/drivers/video/fbdev/core/fbmem.c	2018-05-26 06:13:20.000000000 +0200
>>> @@ -1805,12 +1805,12 @@ static int do_register_framebuffer(struc
>>>   	return 0;
>>>   }
>>>   
>>> -static int do_unregister_framebuffer(struct fb_info *fb_info)
>>> +static int unbind_console(struct fb_info *fb_info)
>>>   {
>>>   	struct fb_event event;
>>> -	int i, ret = 0;
>>> +	int ret;
>>> +	int i = fb_info->node;
>>>   
>>> -	i = fb_info->node;
>>>   	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
>>>   		return -EINVAL;
>>>   
>>> @@ -1825,6 +1825,16 @@ static int do_unregister_framebuffer(str
>>>   	unlock_fb_info(fb_info);
>>>   	console_unlock();
>>>   
>>> +	return ret;
>>> +}
>>> +
>>> +static int do_unregister_framebuffer(struct fb_info *fb_info)
>>> +{
>>> +	struct fb_event event;
>>> +	int ret;
>>> +
>>> +	ret = unbind_console(fb_info);
>>> +
>>>   	if (ret)
>>>   		return -EINVAL;
>>>   
>>> @@ -1835,7 +1845,7 @@ static int do_unregister_framebuffer(str
>>>   	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
>>>   		kfree(fb_info->pixmap.addr);
>>>   	fb_destroy_modelist(&fb_info->modelist);
>>> -	registered_fb[i] = NULL;
>>> +	registered_fb[fb_info->node] = NULL;
>>>   	num_registered_fb--;
>>>   	fb_cleanup_device(fb_info);
>>>   	event.info = fb_info;
>>> @@ -1860,6 +1870,9 @@ int unlink_framebuffer(struct fb_info *f
>>>   		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
>>>   		fb_info->dev = NULL;
>>>   	}
>>> +
>>> +	unbind_console(fb_info);
>>> +
>>>   	return 0;
>>>   }
>>>   EXPORT_SYMBOL(unlink_framebuffer);
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

