From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 04 Jul 2018 15:07:27 +0000
Subject: Re: [PATCH] fb: fix lost console when the user unplugs a USB adapter
Message-Id: <6008699.T6Yd1fn3Dk@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180603154636epcas2p4812a1f19c6ae236336ae580658edb167@epcas2p4.samsung.com>
 <5091035.TYlAUG7jeO@amdc3058>
 <alpine.LRH.2.02.1807031301290.22443@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1807031301290.22443@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org

On Tuesday, July 03, 2018 01:18:57 PM Mikulas Patocka wrote:
> 
> On Tue, 3 Jul 2018, Bartlomiej Zolnierkiewicz wrote:
> 
> > 
> > Hi,
> > 
> > On Sunday, June 03, 2018 11:46:29 AM Mikulas Patocka wrote:
> > > I have a USB display adapter using the udlfb driver and I use it on an ARM
> > > board that doesn't have any graphics card. When I plug the adapter in, the
> > > console is properly displayed, however when I unplug and re-plug the
> > > adapter, the console is not displayed and I can't access it until I reboot
> > > the board.
> > > 
> > > The reason is this:
> > > When the adapter is unplugged, dlfb_usb_disconnect calls
> > > unlink_framebuffer, then it waits until the reference count drops to zero
> > > and then it deallocates the framebuffer. However, the console that is
> > > attached to the framebuffer device keeps the reference count non-zero, so
> > > the framebuffer device is never destroyed. When the USB adapter is plugged
> > > again, it creates a new device /dev/fb1 and the console is not attached to
> > > it.
> > > 
> > > This patch fixes the bug by unbinding the console from unlink_framebuffer.
> > > The code to unbind the console is moved from do_unregister_framebuffer to
> > > a function unbind_console. When the console is unbound, the reference
> > > count drops to zero and the udlfb driver frees the framebuffer. When the
> > > adapter is plugged back, a new framebuffer is created and the console is
> > > attached to it.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > Cc: stable@vger.kernel.org
> > 
> > After this change unbind_console() will be called twice in the standard
> > framebuffer unregister path:
> > 
> > - first time, directly by do_unregister_framebuffer()
> > 
> > - second time, indirectly by do_unregister_framebuffer()->unlink_framebuffer()
> > 
> > This doesn't look correctly.
> 
> unbind_console calls the FB_EVENT_FB_UNBIND notifier, FB_EVENT_FB_UNBIND 
> goes to the function fbcon_fb_unbind and fbcon_fb_unbind checks if the 
> console is bound to the framebuffer for which unbind is requested. So a 
> double call won't cause any trouble.

Even if it works okay currently it is not a best design to send duplicate
events - especially since this can be easily avoided (for non-udlfb users)
by:

- renaming "vanilla" unlink_framebuffer() to __unlink_framebuffer()

- converting do_unregister_framebuffer() to use __unlink_framebuffer()

- adding "new" unlink_framebuffer() that will also call unbind_console()

> > Also why can't udlfb just use unregister_framebuffer() like all other
> > drivers (it uses unlink_framebuffer() and it is the only user of this
> > helper)?
> 
> It uses unregister_framebuffer() - but - unregister_framebuffer() may only 
> be called when the open count of the framebuffer is zero. So, the udlfb 
> driver waits until the open count drops to zero and then calls 
> unregister_framebuffer().
> 
> But the console subsystem keeps the framebuffer open - which means that if 
> user use unplugs the USB adapter, the open count won't drop to zero 
> (because the console is bound to it) - which means that 
> unregister_framebuffer() will not be called.

Is it a really the console subsystem and not the user-space keeping
/dev/fb0 (with console binded to fb0) opened after the USB device
vanishes? After re-plugging the USB device /dev/fb0 stays and /dev/fb1
appears, right?

I also mean that unregister_framebuffer() should be called instead
unlink_framebuffer(), not additionally some time later as it is done
currently.

Moreover the dlfb <-> fb_info locking scheme seems to be reversed
(+racy) as it is dlfb that should control lifetime of fb_info, then
in dlfb_free() we should just call framebuffer_release() etc.

BTW comment in dlfb_ops_release():

/* We can't free fb_info here - fbmem will touch it when we return */

seems to be wrong as fbmem keeps an extra reference on fb_info
during ->fb_release().

> You must unbind the console before calling unregister_framebuffer(). The 

Hmm? The first thing that [do_]unregister_framebuffer) does seems to be
unbinding the console.

> PCI framebuffer drivers don't have this problem because the user is not 
> expected to just unplug the PCI card while it is being used by the 
> console.

PCI framebuffer drivers currently don't use .suppress_bind_attrs driver
flag so the PCI devices can be unbinded at any time by using sysfs "unbind"
functionality (I guess we should be using .suppress_bind_attrs flag if it
doesn't work currently).

> Mikulas
> 
> > > ---
> > >  drivers/video/fbdev/core/fbmem.c |   21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > Index: linux-4.16.12/drivers/video/fbdev/core/fbmem.c
> > > =================================> > > --- linux-4.16.12.orig/drivers/video/fbdev/core/fbmem.c	2018-05-26 06:13:20.000000000 +0200
> > > +++ linux-4.16.12/drivers/video/fbdev/core/fbmem.c	2018-05-26 06:13:20.000000000 +0200
> > > @@ -1805,12 +1805,12 @@ static int do_register_framebuffer(struc
> > >  	return 0;
> > >  }
> > >  
> > > -static int do_unregister_framebuffer(struct fb_info *fb_info)
> > > +static int unbind_console(struct fb_info *fb_info)
> > >  {
> > >  	struct fb_event event;
> > > -	int i, ret = 0;
> > > +	int ret;
> > > +	int i = fb_info->node;
> > >  
> > > -	i = fb_info->node;
> > >  	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
> > >  		return -EINVAL;
> > >  
> > > @@ -1825,6 +1825,16 @@ static int do_unregister_framebuffer(str
> > >  	unlock_fb_info(fb_info);
> > >  	console_unlock();
> > >  
> > > +	return ret;
> > > +}
> > > +
> > > +static int do_unregister_framebuffer(struct fb_info *fb_info)
> > > +{
> > > +	struct fb_event event;
> > > +	int ret;
> > > +
> > > +	ret = unbind_console(fb_info);
> > > +
> > >  	if (ret)
> > >  		return -EINVAL;
> > >  
> > > @@ -1835,7 +1845,7 @@ static int do_unregister_framebuffer(str
> > >  	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
> > >  		kfree(fb_info->pixmap.addr);
> > >  	fb_destroy_modelist(&fb_info->modelist);
> > > -	registered_fb[i] = NULL;
> > > +	registered_fb[fb_info->node] = NULL;
> > >  	num_registered_fb--;
> > >  	fb_cleanup_device(fb_info);
> > >  	event.info = fb_info;
> > > @@ -1860,6 +1870,9 @@ int unlink_framebuffer(struct fb_info *f
> > >  		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
> > >  		fb_info->dev = NULL;
> > >  	}
> > > +
> > > +	unbind_console(fb_info);
> > > +
> > >  	return 0;
> > >  }
> > >  EXPORT_SYMBOL(unlink_framebuffer);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

