From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Multiple drivers for same hardware:, was: DRM and pci_driver
 conversion
Date: Thu, 23 Oct 2003 21:40:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0310232132410.4894-100000@home.osdl.org>
References: <20031024034701.16514.qmail@web14915.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20031024034701.16514.qmail@web14915.mail.yahoo.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>


On Thu, 23 Oct 2003, Jon Smirl wrote:
>
> What about the fundamental question? We have several pairs of device drivers
> that want to control the same hardware. One example would be radeon DRM and
> radeon Framebuffer. How should these drivers coordinate probing and claiming
> resources?

Since they have to co-operate some way on the resources _anyway_, they'll 
just need to work it out amongst themselves.

One common case is to have a "arbitration driver" that tends to do the
actual low-level accesses and is one level of abstraction over the
hardware (papers over trivial differences in hardware). An example of this
would be the old-style ISA DMA infrastructure (now happily pretty much
dead), where the "DMA driver" was just a trivial layer that had some basic
allocation/deallocation and had somewhat nicer access routines than the
raw IO accesses, but didn't do much more.

Another case is the PS/2 keyboard driver, where the mouse and the keyboard
actually share the controller, and they shared a spinlock and some helper
routines to guarantee some basic serialization (that eventually got 
replaced with the current i8042 driver, but the old setup was trivial).

> 1) try new probe first and fall back to old scheme. First driver that loads
> gets the new probe, second gets the old. First driver reserves resources.
> 2) Require a mini driver that handles probing. Then both drivers attach to the
> mini driver.
> 3) Declare it illegal and make the drivers merge.
> 4) Declare it illegal and only allow first one loaded to run.

I'd suggest the minidriver case. You _will_ find common issues anyway
(locking and certain access patterns etc), and the minidriver ends up
being a place to put the trivial shared code too.

			Linus
