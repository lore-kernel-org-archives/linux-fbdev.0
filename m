From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Linux-fbdev-devel] Re: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 20:47:08 -0500
Message-ID: <9e47339105031317474b9a6234@mail.gmail.com>
References: <20050313082216.GA7362@sci.fi> <1110715499.14684.132.camel@gaston>
	<9e473391050313081937cde207@mail.gmail.com>
	<1110750553.5787.155.camel@gaston>
	<9e47339105031314101c89e50e@mail.gmail.com>
	<1110752401.19810.177.camel@gaston>
	<9e47339105031315002a444f00@mail.gmail.com>
	<16948.56755.114690.200854@cargo.ozlabs.ibm.com>
	<20050314005613.GA21434@sci.fi> <1110762359.19810.209.camel@gaston>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110762359.19810.209.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org

On Mon, 14 Mar 2005 12:05:59 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> 
> > It should be the responsibility of the memory manager. If anything wants
> > to access the memory it would call lock() and when it's done with the
> > memory it calls unlock(). That's exactly how DirectFB's memory manager
> > works.
> 
> In an ideal world ... However, since we are planning to move the memory
> manager to the kernel, that would mean a kernel access (syscall, ioctl,
> whatever...) twice per access to AGP memory. Not realistic.

I'm only suggesting this for the DRM/fbdev stack. Anything else from
user space can use a non-cached mapping.

It shouldn't hurt to have a parallel non-cached mapping being used in
conjuction with this protocol. By definition the non-cached mapping
never gets into an inconsistent state.

> 
> The case of the CP ring is easy to deal with by the macros we have there
> already and it would be kernel-kernel. But it would be a hit for a lot
> of other things I suppose.

The performance trade off is, how long does the invalidate take?  If
the CPU has 2MB of unflushed write data the instruction is going to
take a while to finish. In the non-cached scheme this data is flushed
in parallel with us playing with the AGP memory.  To flush 2MB takes
something like 2MB / 400Mhz * 64bytes * 2 (DDR) = 20 microseconds but
it may be more like 1 microsecond on average.

Thinking about this for a while you can't compute which is the better
strategy because everything depends on the workload and how dirty the
cache is. Best thing to do would be to code it up and try it. But I
want to get a dual head radeon driver working first.

It may also be true that the CP Ring is better left non-cached and
only access to the graphics buffers be done with the caching scheme.

BTW, you can implement super fast texture load/unload using a similar
scheme. Start with the texture in the user space program. Program
wants to upload the texture. Flush CPU cache. Point the GART at the
physical pages allocated to the user holding the texture. Now walk the
user's page table and mark those pages copy on write. Free the memory
the pages the GART was originally pointing at. Reverse the scheme to
get data from the GPU. For small textures it is faster to copy them
but if you are moving 20MB of data this is much faster.

-- 
Jon Smirl
jonsmirl@gmail.com
