From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 10 Jul 2018 02:29:40 +0000
Subject: Re: [PATCH] fb: fix lost console when the user unplugs a USB adapter
Message-Id: <alpine.LRH.2.02.1807092148080.30863@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180603154636epcas2p4812a1f19c6ae236336ae580658edb167@epcas2p4.samsung.com>
 <5091035.TYlAUG7jeO@amdc3058>
 <alpine.LRH.2.02.1807031301290.22443@file01.intranet.prod.int.rdu2.redhat.com>
 <6008699.T6Yd1fn3Dk@amdc3058>
In-Reply-To: <6008699.T6Yd1fn3Dk@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Dave Airlie <airlied@redhat.com>, linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org



On Wed, 4 Jul 2018, Bartlomiej Zolnierkiewicz wrote:

> On Tuesday, July 03, 2018 01:18:57 PM Mikulas Patocka wrote:
> > 
> > On Tue, 3 Jul 2018, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > Hi,
> > > 
> > > On Sunday, June 03, 2018 11:46:29 AM Mikulas Patocka wrote:
> > > > I have a USB display adapter using the udlfb driver and I use it on an ARM
> > > > board that doesn't have any graphics card. When I plug the adapter in, the
> > > > console is properly displayed, however when I unplug and re-plug the
> > > > adapter, the console is not displayed and I can't access it until I reboot
> > > > the board.
> > > > 
> > > > The reason is this:
> > > > When the adapter is unplugged, dlfb_usb_disconnect calls
> > > > unlink_framebuffer, then it waits until the reference count drops to zero
> > > > and then it deallocates the framebuffer. However, the console that is
> > > > attached to the framebuffer device keeps the reference count non-zero, so
> > > > the framebuffer device is never destroyed. When the USB adapter is plugged
> > > > again, it creates a new device /dev/fb1 and the console is not attached to
> > > > it.
> > > > 
> > > > This patch fixes the bug by unbinding the console from unlink_framebuffer.
> > > > The code to unbind the console is moved from do_unregister_framebuffer to
> > > > a function unbind_console. When the console is unbound, the reference
> > > > count drops to zero and the udlfb driver frees the framebuffer. When the
> > > > adapter is plugged back, a new framebuffer is created and the console is
> > > > attached to it.
> > > > 
> > > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > > Cc: stable@vger.kernel.org
> > > 
> > > After this change unbind_console() will be called twice in the standard
> > > framebuffer unregister path:
> > > 
> > > - first time, directly by do_unregister_framebuffer()
> > > 
> > > - second time, indirectly by do_unregister_framebuffer()->unlink_framebuffer()
> > > 
> > > This doesn't look correctly.
> > 
> > unbind_console calls the FB_EVENT_FB_UNBIND notifier, FB_EVENT_FB_UNBIND 
> > goes to the function fbcon_fb_unbind and fbcon_fb_unbind checks if the 
> > console is bound to the framebuffer for which unbind is requested. So a 
> > double call won't cause any trouble.
> 
> Even if it works okay currently it is not a best design to send duplicate
> events - especially since this can be easily avoided (for non-udlfb users)
> by:
> 
> - renaming "vanilla" unlink_framebuffer() to __unlink_framebuffer()
> 
> - converting do_unregister_framebuffer() to use __unlink_framebuffer()
> 
> - adding "new" unlink_framebuffer() that will also call unbind_console()
> 
> > > Also why can't udlfb just use unregister_framebuffer() like all other
> > > drivers (it uses unlink_framebuffer() and it is the only user of this
> > > helper)?
> > 
> > It uses unregister_framebuffer() - but - unregister_framebuffer() may only 
> > be called when the open count of the framebuffer is zero. So, the udlfb 
> > driver waits until the open count drops to zero and then calls 
> > unregister_framebuffer().
> > 
> > But the console subsystem keeps the framebuffer open - which means that if 
> > user use unplugs the USB adapter, the open count won't drop to zero 
> > (because the console is bound to it) - which means that 
> > unregister_framebuffer() will not be called.
> 
> Is it a really the console subsystem and not the user-space keeping
> /dev/fb0 (with console binded to fb0) opened after the USB device
> vanishes?

Yes - I unplugged the adapter without Xserver running and without any 
other framebuffer application running - the console keeps it open.

> After re-plugging the USB device /dev/fb0 stays and /dev/fb1
> appears, right?

The file /dev/fb0 is deleted (because dlfb_usb_disconnect calls 
unlink_framebuffer), but it is kept in the kernel. When I re-plug the 
adapter, /dev/fb1 is created but the console is still bound to /dev/fb0. 
When the adapter is re-plugged, it shows just a green screen.

> I also mean that unregister_framebuffer() should be called instead
> unlink_framebuffer(), not additionally some time later as it is done
> currently.

Can unregister_framebuffer() be called when /dev/fb0 is open as a file 
handle and/or mapped to some process?

> Moreover the dlfb <-> fb_info locking scheme seems to be reversed
> (+racy) as it is dlfb that should control lifetime of fb_info, then
> in dlfb_free() we should just call framebuffer_release() etc.

How should in your opinion framebuffer destruction work?

Should the driver count the number of users and call 
unregister_framebuffer() when it drops to zero?

Or should the driver call unregister_framebuffer() unconditionally when 
the device is unplugged and destroy the device in the "fb_destroy" 
callback? (fb_destroy seems to be called by the framebuffer subsystem when 
the open count reaches zero)

If I grep the kernel for fb_destroy, very few framebuffer drivers use it.

> BTW comment in dlfb_ops_release():
> 
> /* We can't free fb_info here - fbmem will touch it when we return */
> 
> seems to be wrong as fbmem keeps an extra reference on fb_info
> during ->fb_release().
> 
> > You must unbind the console before calling unregister_framebuffer(). The 
> 
> Hmm? The first thing that [do_]unregister_framebuffer) does seems to be
> unbinding the console.
> 
> > PCI framebuffer drivers don't have this problem because the user is not 
> > expected to just unplug the PCI card while it is being used by the 
> > console.
> 
> PCI framebuffer drivers currently don't use .suppress_bind_attrs driver
> flag so the PCI devices can be unbinded at any time by using sysfs "unbind"
> functionality (I guess we should be using .suppress_bind_attrs flag if it
> doesn't work currently).

I tested matrox PCI framebuffer driver on an old computer - and it suffers 
from the same problem as udlfb. The matrox driver keeps the open count and 
destroys itself when the open count reaches zero - but the console that is 
bound to the driver prevents the open count from reaching zero - so if I 
unbind the PCI device in sysfs, it does nothing and the console is still 
active and works.

When I unbind the console with 'echo 0 >/sys/class/vtconsole/vtcon1/bind' 
(after unbinding the PCI device), I get this deadlock:
[  832.111652] sysrq: SysRq : Show Blocked State
[  832.111674]   task                PC stack   pid father
[  832.111753] bash            D    0  2254   2249 0x00000000
[  832.111777] Call Trace:
[  832.111816]  ? __schedule+0x11e/0x3a0
[  832.111834]  ? schedule+0x26/0x80
[  832.111855]  ? schedule_timeout+0xed/0x140
[  832.111879]  ? __down+0x43/0x80
[  832.111902]  ? down+0x2d/0x40
[  832.111917]  ? console_lock+0xa/0x20
[  832.111943]  ? do_unregister_framebuffer+0x2a/0x100
[  832.111963]  ? unregister_framebuffer+0x14/0x40
[  832.111989]  ? matroxfb_remove.isra.10.part.11+0x65/0xe0 [matroxfb_base]
[  832.112009]  ? matroxfb_release+0x39/0xc0 [matroxfb_base]
[  832.112025]  ? fbcon_deinit+0x22e/0x300
[  832.112049]  ? do_bind_con_driver+0x176/0x360
[  832.112071]  ? do_unbind_con_driver+0x1ac/0x220
[  832.112092]  ? store_bind+0xe0/0x1e0
[  832.112111]  ? do_take_over_console+0x180/0x180
[  832.112136]  ? sysfs_kf_bin_read+0xc0/0xc0
[  832.112154]  ? dev_attr_store+0x11/0x20
[  832.112172]  ? sysfs_kf_write+0x24/0x60
[  832.112191]  ? kernfs_fop_write+0xc7/0x160
[  832.112210]  ? kernfs_fop_open+0x3a0/0x3a0
[  832.112232]  ? __vfs_write+0x1c/0x120
[  832.112249]  ? __alloc_fd+0x27/0x140
[  832.112266]  ? f_dupfd+0x4b/0x60
[  832.112281]  ? get_close_on_exec+0x25/0x40
[  832.112297]  ? do_fcntl+0x417/0x580
[  832.112315]  ? vfs_write+0x9e/0x1c0
[  832.112334]  ? ksys_write+0x32/0x80
[  832.112352]  ? do_int80_syscall_32+0x3e/0xe0
[  832.112373]  ? entry_INT80_32+0x27/0x27

Mikulas
