From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: radeon, apertures & memory mapping
Date: Sun, 13 Mar 2005 12:35:43 +1100
Message-ID: <1110677744.19810.80.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, dri-devel@lists.sourceforge.net, xorg@lists.freedesktop.org
Cc: Jon Smirl <jonsmirl@yahoo.com>

Hi !

I'm currently rewriting radeonfb to implement support for dual head, and
ultimately, to make it more friendly to be hooked on DRM for mesa-solo
style setups.

I have some issues however related to the way memory is mapped and
dealing with apertures. Here is the story, suggestions welcome:

The radeon card exposes to the system 2 separate apertures. That is, the
PCI region is actually cut by the hardware in two halves, each of them
beeing an "aperture". Each aperture can have different configuration for
the endian swappers (and possibly the surface tiling registers).

I can configure the apertures to both map to the same bit of video
memory (both covering the framebuffer from 0), or to be "split", that is
aperture 0 covering the framebuffer from 0 to CONFIG_APER_SIZE (size of
an aperture, that is half of the PCI BAR allocation), and aperture 1
covering the framebuffer from CONFIG_APER_SIZE to CONFIG_APER_SIZE*2.

However, I can't change anything to CONFIG_APER_SIZE itself, it's
decided by straps, either HW or in the ROM. So we end up with different
setups depending on how the BIOS has configured things. I know that
Apple chips are usually wired so that CONFIG_APER_SIZE is half the video
memory, so if I use the first mode, I can only access half of the video
RAM from PCI, if I use the second, each aperture maps a different half
of video memory with possibly different endian swapping.

But I think the setups in real life are more diverse and some BIOSes
will have CONFIG_APER_SIZE at least as big as the entire video memory,
thus forcing me to use the "overlapped" setup. In fact, CONFIG_APER_SIZE
may even be smaller than half of the vram and thus limiting the CPU to
part of the VRAM anyway.

I have toyed with all sort of setups, and I have +/- decided to not
bother, and always do this, please tell me what you think:

Always setup HOST_PATH_CNTL.HDP_APER_CNTL to 0. That is, both apertures
are always overlapping. On Macs, or other machines that strap
CONFIG_APER_SIZE to half of VRAM, that means only half of vram can be
directly accessed by the CPU. I think this is fine because of these:

 - We only really need to bother about CPU access for the framebuffer
itself (and possibly the cursor). That is normal non-accelerated fbdev
operations an mmap'ing of the framebuffer in user space. This is not
really a problem if that is limited to some part of vram. It puts a
small constraint on the allocation of video memory: the framebuffer has
to be near the beginning. But my opinion is that a mode switch will
pretty much always invalidate everything that is cached in video memory,
so the whole allocation can be re-done at that point. Things like
texture uploads etc... should use the CP engine and DMA (from either
system or AGP memory).

 - It's actually making things easier for me since I can allocate both
framebuffers next to each other, and probably easier for the future
video memory allocator since it then gets a larger contiguous chunk of
memory to deal with.

 - It's also easier because If I wanted to take advantage of the "split"
setting, I would still need some fallback mecanism for cards who have
the aperture size set to all of vram size.

Note that I also noticed rather inconsistent usage of memory size vs
aperture size in DRI/X. I'm not sure X actually deals with the 2
scenarios here (X always only uses aperture 0 for both heads and changes
the swapper control on each access).

The only drawback is that on the kernel side, for the console, I end up
with the ioremap for the second crtc beeing twice as big as necessary
since I can't "dynamically" ioremap/iounmap on mode switches (that would
be guaranteed to fail after the system has been running for a while). It
would be nice if I could play mapping tricks by doing something like
allocating the 2 bits of virtual space at boot (get_vm_area), and just
remap the pages in them ((un)map_vm_area), but that wouldn't work with
architectures like MIPS who have limitations on where in virtual space
non-cacheable things are.

I could maybe use a single ioremap though, that is use a single
aperture, and then switch the swapper on accesses. Though I should also
be careful not to end up conflicting with a userland process relying on
having the 2 separate aperture swappers stable for the mode on the 2
separate framebuffer mappings... Like X would use fb0 while console
would use fb1 with a different swapper setting. That would blow up for
sure unless fbcon arbitrates accesses with X, which I don't see
happening right away. I suppose we'll have to consider both heads linked
as far as console ownership is concerned, at least for now, until the
kernel console subsystem is overhauled significantly.

Ben.
