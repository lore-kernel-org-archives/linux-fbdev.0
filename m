From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 30 Jul 2018 10:30:00 +0000
Subject: Re: [PATCH] fb: fix lost console when the user unplugs a USB adapter
Message-Id: <alpine.LRH.2.02.1807300552140.2919@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180603154636epcas2p4812a1f19c6ae236336ae580658edb167@epcas2p4.samsung.com>
 <6008699.T6Yd1fn3Dk@amdc3058>
 <alpine.LRH.2.02.1807092148080.30863@file01.intranet.prod.int.rdu2.redhat.com>
 <1975707.vO8kdHz3oS@amdc3058>
In-Reply-To: <1975707.vO8kdHz3oS@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org



On Wed, 25 Jul 2018, Bartlomiej Zolnierkiewicz wrote:

> > Can unregister_framebuffer() be called when /dev/fb0 is open as a file 
> > handle and/or mapped to some process?
> 
> It should be OK.
> 
> > > Moreover the dlfb <-> fb_info locking scheme seems to be reversed
> > > (+racy) as it is dlfb that should control lifetime of fb_info, then
> > > in dlfb_free() we should just call framebuffer_release() etc.
> > 
> > How should in your opinion framebuffer destruction work?
> > 
> > Should the driver count the number of users and call 
> > unregister_framebuffer() when it drops to zero?
> > 
> > Or should the driver call unregister_framebuffer() unconditionally when 
> > the device is unplugged and destroy the device in the "fb_destroy" 
> > callback? (fb_destroy seems to be called by the framebuffer subsystem when 
> > the open count reaches zero)
> 
> The driver should call unregister_framebuffer() unconditionally in
> dlfb_usb_disconnect() (instead of calling unlink_framebuffer()).

I reworked the udlfb driver to call unregister_framebuffer unconditionally 
and destroy the device from the fb_destroy method and it works very well. 
I tried to unplug it at various times and it didn't result in any crashes 
or warnings.

I'll send the patch in next email.

> Anyway it seems that this would require major reworking of the driver and
> I think that it would be better to put efforts into fixing udl-kms driver
> instead. For now I have queued your patch (with __unregister_framebuffer()
> change to keep the old behavior for non-udlfb drivers) for v4.19 (patch
> attached at the end of this mail).

Could someone describe what is the architecturely proper way to unload a 
KMS driver?

udl_usb_disconnect calls these functions
        drm_kms_helper_poll_disable(dev);
        udl_fbdev_unplug(dev);
        udl_drop_usb(dev);
        drm_dev_unplug(dev);
- and if crashes if the device is unplugged while Xserver is running.

And it results in a warning "WARNING: CPU: 0 PID: 21685 at 
drivers/gpu/drm/drm_mode_config.c:473 drm_mode_config_cleanup+0x294/0x2b8 
[drm]" if the device is unplugged while only console is in use.

> > I tested matrox PCI framebuffer driver on an old computer - and it suffers 
> > from the same problem as udlfb. The matrox driver keeps the open count and 
> > destroys itself when the open count reaches zero - but the console that is 
> > bound to the driver prevents the open count from reaching zero - so if I 
> > unbind the PCI device in sysfs, it does nothing and the console is still 
> > active and works.
> 
> matroxfb is a not a good reference driver as it also defers the call to
> unregister_framebuffer() when the device is unplugged:
> 
> static void matroxfb_remove(struct matrox_fb_info *minfo, int dummy)
> {
> ...
> 	minfo->dead = 1;
> 	if (minfo->usecount) {
> 		/* destroy it later */
> -->		return;
> 	}
> 	matroxfb_unregister_device(minfo);
> 	unregister_framebuffer(&minfo->fbcon);
> ...
> }

I think that for PCI framebuffer drivers, there's no correct way how to 
unload them correctly - so the framebuffer subsystem should prevent PCI 
unbind.

If the user unbinds the device, then what?
- either you destroy the framebuffer immediatelly and you'll get crashes 
  if it is used by some programs
- or you delay destroying the framebuffer - but then, the unbound device 
  may be re-bound to a different instance of the driver (or a different 
  driver) and these two instances would clash accessing the videoram and 
  regsters simultaneously

BTW. only 5 framebuffer drivers currently use the fb_destroy - so most of 
them are destroyed improperly.

Mikulas
