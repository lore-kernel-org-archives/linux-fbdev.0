From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 17:43:09 +1100
Message-ID: <1110696189.5787.100.camel@gaston>
References: <1110677744.19810.80.camel@gaston>
	<9e47339105031219223e606a52@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105031219223e606a52@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, xorg@lists.freedesktop.org

On Sat, 2005-03-12 at 22:22 -0500, Jon Smirl wrote:
> What about using the overlapped mode and dividing memory into four regions
> 
> FB0
> PCI visible free mem
> FB1
> APER_SIZE
> non-visible free mem
> 
> This way setting the mode on FB0 doesn't always bump into FB1.

I think we don't really have a problem with setting the mode on fb0
possibly bumping into fb1. I mean, setting the mode will require
re-allocation of stuffs in fb memory anyway from what I can tell. I'm
pretty sure than on OS X, applications are notified before an after and
all context stored in fb memory is either lost or backed up into main
memory (though we could be smarter indeed).

The card will be reprogrammed completely, so anybody using it has to be
put on hold, wether it's an fb0 or an fb1 client (and to avoid "issues"
with X among others, I intend to have the setting of MC_FB_LOCATION,
SURFACE registers, etc... to be part of the mode setting, that is). And
finally, I want to blank the screen (using the accel engine) before
setting the new mode, so that we come out "clean" of the mode setting
(without ugly artifact), and I will probably clean both fb's (simpler).

Now there is one reason why putting fb1 on top of the accessible address
space is a good idea though :) It's the ioremap issue. At least, that
way, I can have 2 independant ioremap's of MAX_MAPPED_VRAM from 0 and
from top. If I have fb1 after fb0, since I don't know where fb1 will
actually start, I have no choice but ioremap'ing the second aperture
from the beginning, thus "losing" space.

So I think I'll go your way, it's a good idea, but I'm not 100% sure it
will help much about "not stomping on the other fb". Maybe our allocator
can be smart enough to only invalidate "some" things, or to be able to
move things around (if we have some kind of "indirect" handles to
objects in vram instead of just offsets). 

> The DRM could do this:
> FB0
> back0
> depth0
> aux0, etc
> PCI visible free mem - textures priority 2
> aux1, etc
> depth1
> back1
> FB1
> APER_SIZE
> non-visible free mem - textures priority 1

And AGP memory for textures priority 3 ?

> 
> On Sun, 13 Mar 2005 12:35:43 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > I could maybe use a single ioremap though, that is use a single
> > aperture, and then switch the swapper on accesses. Though I should also
> > be careful not to end up conflicting with a userland process relying on
> > having the 2 separate aperture swappers stable for the mode on the 2
> > separate framebuffer mappings... Like X would use fb0 while console
> > would use fb1 with a different swapper setting. That would blow up for
> > sure unless fbcon arbitrates accesses with X, which I don't see
> > happening right away. I suppose we'll have to consider both heads linked
> > as far as console ownership is concerned, at least for now, until the
> > kernel console subsystem is overhauled significantly.
> 
> In the long term I was hoping to design thing such that the two heads
> can be used by two independent users, each could be running X or
> fbdev.

You mean fbcon ? Unless there is proper arbitration, there can't be 2
users. Hopefully we'll get there. But in any way, there can be only one
driver in charge of the "card". That is, if X is using UseFBDev, then
yes, it can use one head and fbcon the other. But if X is reprogramming
the whole card, no way fbdev (and I mean -dev in this case) can use the
other head at the same time, that's just not realistic.

> A user space console implementation also makes a lot of sense in the
> multiuser case. User space console can be a DRI application instead of
> fbdev reducing the need to map.

Sure. Though the mapping done by fbdev stops beeing necessary if we use
only accel ops for everything, including HW cursor. The only issue
becomes implementation of fb_read/fb_write from userspace, but for that,
we can do temporary ioremap's of a few pages, or even use tricks like
locking user pages and doing DMA from them.

Ben.
