From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 0/8] pxafb cleanup
Date: Thu, 28 Feb 2008 08:26:54 +0800
Message-ID: <f17812d70802271626i3bff858fl96988a9deabf8bdb@mail.gmail.com>
References: <f17812d70802261832l78840912r4dcb0403e9fe4385@mail.gmail.com>
	<47C52C78.1020503@ru.mvista.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUWbw-0007zv-Dh for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Feb 2008 16:26:56 -0800
Received: from qb-out-0506.google.com ([72.14.204.232])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JUWbv-0005r9-VU
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Feb 2008 16:26:56 -0800
Received: by qb-out-0506.google.com with SMTP id c8so4489177qbc.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 27 Feb 2008 16:26:55 -0800 (PST)
In-Reply-To: <47C52C78.1020503@ru.mvista.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alexandre Rusev <arusev@ru.mvista.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Wed, Feb 27, 2008 at 5:25 PM, Alexandre Rusev <arusev@ru.mvista.com> wrote:
>
> eric miao wrote:
>  > The following series of patches try to address several issues of the
>  > current PXA framebuffer driver. Some of these patches are already
>  > submitted for review, here are more:
>  >
>  > pxa: un-nest pxafb_parse_options() to cleanup the coding style issue
>  > pxa: fix various coding style issues for pxafb
>  > pxa: purge unnecessary pr_debug and comments from pxafb
>  > pxa: sanitize the usage of #ifdef .. processing pxafb parameters
>  > pxa: convert fb driver to use ioremap() and __raw_{readl, writel}
>  > pxa: introduce "struct pxafb_dma_buff" for palette and dma descriptors
>  > pxa: introduce register independent LCD connection type for pxafb
>  > pxa: make lubbock/mainstone/zylonite/littleton to use new LCD connection type
>  >
>  > Board maintainers are encouraged to use the new way for LCD connection
>  > types.
>  >
>  > To further clean-up the driver, I suggest to make the following changes:
>  > 1. removal of set_ctrlr_state(), the original code is written so because
>  > the fb_blank() is called within interrupt context in 2.4 kernel, but this is
>  > no longer the case in 2.6. And states can be simplified.
>  >
>  > 2. introduce a "vram" module parameter or boot option to indicate the
>  > size of the video memory, so that frame buffer offset can be specified
>  > within this video memory range, and PAN_DISPLAY can be done.
>  > And the start offset of each overlay can also be specified.
>  >
>  > 3. a "pxafb_layer" structure describing each possible layers,
>  > base, overlay1 and overlay2 for pxa27x can be described. From this
>  > layer information, frame buffer device can be dynamically allocated
>  > and registered. Palette manipulation, parameter checking and
>  > layer activation code can be generalized.
>  >
>  Some considerations on dynamic allocation of framebuffer/overlys memory
>  (if applicable).
>  Early implementation of framebuffer/overlays for pxa270 contained the
>  following bug:
>  when resolution of framebuffer/overlay or bpp  was changed and that
>  framebuffer/overlay
>  (or some part of it) was mapped by userspace application the driver just
>  invoke kfree/dma_free_writecombine,
>  with the memory area still leaving mapped to userspace!
>  This could cause the corruption of kernel memory.
>  (for example DirectFB just tried to draw at the previously mapped area
>  so no more new picture appeared at screen;) )
>
>  When we do NOTallocate maximal possible sized piece of memory for
>  baseplane and overlay in advance
>  this problem seems still to be an issue :(
>  I suppose that driver-specific vm_area_ops to be attached by driver to
>  each mapping did by userland
>  due to avoid kernel memory corruption at unmap.
>

Userland app should really unmap and dereference the previously
mapped area for the overlay(s), but a fix in the driver is also necessary.

>  Yet the problem is that if userland applicatein frequently use/unuse and
>  change resolution/bpp of overlay
>  and forget to unmap it each time, then all consistent/writecombine
>  memory would be locked by this application.
>
>
>  Allocating maximal possible size (and not using it) is quite adversary
>  against writecombine/consistent memory pool.
>  With current definition of CONSISTENT_SIZE for architecture it would be
>  even impossible to allocate
>  all the needed memory for all overlays! :(
>
>

Not necessary true. We don't have to allocate the video memory from
consistent pool, which is mainly for things like DMA descriptor and
small FIFO areas. Normal memory can be allocated and reserved
for video usage.

>
>
>
>
>
>
>
>
>
>
>
>
>
>
>



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
