From: Alexandre Rusev <arusev@ru.mvista.com>
Subject: Re: [PATCH 0/8] pxafb cleanup
Date: Wed, 27 Feb 2008 12:25:12 +0300
Message-ID: <47C52C78.1020503@ru.mvista.com>
References: <f17812d70802261832l78840912r4dcb0403e9fe4385@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <f17812d70802261832l78840912r4dcb0403e9fe4385@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: eric miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

eric miao wrote:
> The following series of patches try to address several issues of the
> current PXA framebuffer driver. Some of these patches are already
> submitted for review, here are more:
>
> pxa: un-nest pxafb_parse_options() to cleanup the coding style issue
> pxa: fix various coding style issues for pxafb
> pxa: purge unnecessary pr_debug and comments from pxafb
> pxa: sanitize the usage of #ifdef .. processing pxafb parameters
> pxa: convert fb driver to use ioremap() and __raw_{readl, writel}
> pxa: introduce "struct pxafb_dma_buff" for palette and dma descriptors
> pxa: introduce register independent LCD connection type for pxafb
> pxa: make lubbock/mainstone/zylonite/littleton to use new LCD connection type
>
> Board maintainers are encouraged to use the new way for LCD connection
> types.
>
> To further clean-up the driver, I suggest to make the following changes:
> 1. removal of set_ctrlr_state(), the original code is written so because
> the fb_blank() is called within interrupt context in 2.4 kernel, but this is
> no longer the case in 2.6. And states can be simplified.
>
> 2. introduce a "vram" module parameter or boot option to indicate the
> size of the video memory, so that frame buffer offset can be specified
> within this video memory range, and PAN_DISPLAY can be done.
> And the start offset of each overlay can also be specified.
>
> 3. a "pxafb_layer" structure describing each possible layers,
> base, overlay1 and overlay2 for pxa27x can be described. From this
> layer information, frame buffer device can be dynamically allocated
> and registered. Palette manipulation, parameter checking and
> layer activation code can be generalized.
>   
Some considerations on dynamic allocation of framebuffer/overlys memory
(if applicable).
Early implementation of framebuffer/overlays for pxa270 contained the
following bug:
when resolution of framebuffer/overlay or bpp  was changed and that
framebuffer/overlay
(or some part of it) was mapped by userspace application the driver just
invoke kfree/dma_free_writecombine,
with the memory area still leaving mapped to userspace!
This could cause the corruption of kernel memory.
(for example DirectFB just tried to draw at the previously mapped area
so no more new picture appeared at screen;) )

When we do NOTallocate maximal possible sized piece of memory for
baseplane and overlay in advance
this problem seems still to be an issue :(
I suppose that driver-specific vm_area_ops to be attached by driver to
each mapping did by userland
due to avoid kernel memory corruption at unmap.

Yet the problem is that if userland applicatein frequently use/unuse and
change resolution/bpp of overlay
and forget to unmap it each time, then all consistent/writecombine
memory would be locked by this application.


Allocating maximal possible size (and not using it) is quite adversary
against writecombine/consistent memory pool.
With current definition of CONSISTENT_SIZE for architecture it would be
even impossible to allocate
all the needed memory for all overlays! :(

















-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
