From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Dri-devel] Re: DRM and pci_driver
	conversion
Date: Wed, 29 Oct 2003 09:26:18 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1067379978.3333.44.camel@gaston>
References: <20031028220940.65607.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031028220940.65607.qmail@web14913.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: James Simmons <jsimmons@infradead.org>, Linus Torvalds <torvalds@osdl.org>, Ian Romanick <idr@us.ibm.com>, David Dawes <dawes@XFree86.Org>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-10-29 at 09:09, Jon Smirl wrote:

> Do we really want arbitration between multiple things (FB, X, DRI, etc) all
> trying to control the video hardware at a register level? This is like writing
> a multitaking system for device drivers.
> 
> Or do we want a single device driver with multiple clients?

Here, you are going away from Linus suggestion. While it makes sense
too, it would be a real pain to keep that single driver in sync between
the different parties, to keep backward compatibility, etc... re-read
Linus emails on this topic. I tend to agree with him here, what we want
is a small low level layer that does the strict minimum to provide
DMA/irq and arbitration.

> A major complaint from the framebuffer console people is that we have to do
> mode setting/EDID in the device driver so that there is a console to look at
> from the first second the kernel boots. This also means we have to map the
> framebuffer into kernel space (sucking up to 256MB of kernel address space).

That mode setting / EDID is done in drivers on other platforms as well,
I don't see the problem here. It's the basic "feature" provided by the
framebuffer driver, it doesn't only make sense for fbcon but also for
other framebuffer apps.

Mapping the framebuffer into kernel space isn't necessary. It's how
today's fbcon works, but it's not mandatory. In fact, if fbcon was
fully accelerated, mapping the fb would be useless.

> In the 2.7 time frame is it possible to write a low level driver like Linus
> proposed plus a small DSO for mode setting/EDID. 

DSO ? Can you translate ?

> Then write fbconsole as a user
> space app that is loaded much eariler in the boot process than user-mode
> currently starts? In other words is there a solution to having a boot time
> console that doesn't involve running it in a device driver?

So we lose the ability to get early boot messages and printk at
interrupt time ? no thanks ! Looks you aren't regulary faced with the
need to debug kernel code ;)

> Another possible solution to the boot time problem would be to write a
> disposable device driver. The disposable driver would set the mode/EDID and run
> the console until user mode started; then self destruct. 

fbcon can still be in the kernel. I see no point in your push to move it
down to userland, provided that it stays a clearly separate entity from the
fbdev itself, just another client.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
