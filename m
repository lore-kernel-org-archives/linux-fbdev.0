From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Date: Sat, 25 Oct 2003 11:37:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
References: <16282.45806.428547.279213@zeus.local>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <16282.45806.428547.279213@zeus.local>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Egbert Eich <eich@xfree86.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>, Jeff Garzik <jgarzik@pobox.com>


On Sat, 25 Oct 2003, Egbert Eich wrote:
> 
> Speaking of XFree86: when I developed the PCI resource stuff in 
> XFree86 I was trying to get support from kernel folks to get the 
> appropriate user space interfaces into the kernel. When I got 
> nowhere I decided to do everything myself. 

There won't be any "user space interfaces". There are perfectly good 
in-kernel interfaces, and anybody who needs them needs to be in kernel 
space. Ie the kernel interfaces are for kernel modules, not for user space 
accesses.

The kernel module can be a simple interface layer like DRI, but the thing 
is, it needs to be specific to some kind of hardware. I refuse to have 
some kind of crap "user space driver" interface - drivers in user space 
are a mistake. 

> Is there any API that allows one to do this from user space?

No. And I don't really see any huge reason for it.

> There are plenty of XFree86 drivers around that don't have a
> DRM kernel module and it should  be possible to run those which
> do without DRI support, therefore it would be a good if the
> XFree86 driver could do this registration itself.

If you do this, do it _right_. Look at what X really needs, and make a
driver for it. A _real_ driver. Not just a half-hearted "we want to do
things in user space, but we can't".

Face it, a good graphics driver needs more than just "set up the ROM". It
needs DMA access, and the ability to use interrupts. It needs a real 
driver.

It basically needs something like what the DRI modules tend to do.

I'd be really happy to have real graphics drivers in the kernel, but quite
frankly, so far the abstractions I've seen have sucked dead donkeys
through a straw. "fbcon" does way too much (it's not a driver, it's more a
text delivery system and a mode switcher). And DRI is too complex and
fluid to be a good low-level driver.

Quite frankly, I'd much rather see a low-level graphics driver that does
_two_ things, and those things only:

 - basic hardware enumeration and setup (and no, "basic setup" does not
   mean "mode switching": it literally means things like doing the 
   pci_enable_device() stuff.

 - serialization and arbitrary command queuing from a _trusted_ party (ie
   it could take command lists from the X server, but not from untrusted
   clients). This part basically boils down to "DMA and interrupts". This 
   is the part that allows others to wait for command completion, "enough 
   space in the ring buffers" etc. But it does _not_ know or care what the 
   commands are.

Then, fbcon and DRI and X could all three use these basics - and they'd be
_so_ basic that the hardware layer could be really stable (unlike the DRI
code that tends to have to upgrade for each new type of command that DRI
adds - since it has to take care of untrusted clients. So DRI would
basically use the low-level driver as a separate module, the way it
already uses AGP).

But I'm _not_ interested in some interfaces to let user mode just bypass 
the kernel. Because they will not solve any of the other problems that 
clearly _do_ need solving, and if the X server continues to believe that 
it can just access the hardware directly, it will never play well together 
with projects like fbcon/dri.

			Linus
