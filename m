From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 04 Jul 2018 14:52:22 +0000
Subject: Re: [PATCH] fb: fix lost console when the user unplugs a USB adapter
Message-Id: <alpine.LRH.2.02.1807041047420.21813@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1806031143470.15248@file01.intranet.prod.int.rdu2.redhat.com>
 <20180704084033.GO3891@phenom.ffwll.local>
In-Reply-To: <20180704084033.GO3891@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>



On Wed, 4 Jul 2018, Daniel Vetter wrote:

> On Sun, Jun 03, 2018 at 11:46:29AM -0400, Mikulas Patocka wrote:
> > I have a USB display adapter using the udlfb driver and I use it on an ARM
> > board that doesn't have any graphics card. When I plug the adapter in, the
> > console is properly displayed, however when I unplug and re-plug the
> > adapter, the console is not displayed and I can't access it until I reboot
> > the board.
> > 
> > The reason is this:
> > When the adapter is unplugged, dlfb_usb_disconnect calls
> > unlink_framebuffer, then it waits until the reference count drops to zero
> > and then it deallocates the framebuffer. However, the console that is
> > attached to the framebuffer device keeps the reference count non-zero, so
> > the framebuffer device is never destroyed. When the USB adapter is plugged
> > again, it creates a new device /dev/fb1 and the console is not attached to
> > it.
> > 
> > This patch fixes the bug by unbinding the console from unlink_framebuffer.
> > The code to unbind the console is moved from do_unregister_framebuffer to
> > a function unbind_console. When the console is unbound, the reference
> > count drops to zero and the udlfb driver frees the framebuffer. When the
> > adapter is plugged back, a new framebuffer is created and the console is
> > attached to it.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Cc: stable@vger.kernel.org
> 
> Does this work correctly with the udl drm driver and the drm fbdev
> emulation? If yes I'm not sure what the value is in fixing up the uldfb
> driver really ...
> 
> Same for all the uldfb fixes in your other series. If the 2 drivers are
> on feature parity I'd just go ahead and remove the uldfb one.
> -Daniel

The udl drm driver is worse than udlfb with regard to unplug.

The udl drm driver destroys the device on USB unplug no matter if someone 
is using it or not. If you unplug the device while Xserver is running or 
while some console framebuffer application is running, you get a crash.

The udl fb driver correctly waits until all users close the device before 
destroying it.

Mikulas
