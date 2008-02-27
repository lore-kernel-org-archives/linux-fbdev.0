From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 0/8] pxafb cleanup
Date: Wed, 27 Feb 2008 18:08:19 +0800
Message-ID: <f17812d70802270208s102c4a16u8ae22074f5176d45@mail.gmail.com>
References: <f17812d70802261832l78840912r4dcb0403e9fe4385@mail.gmail.com>
	<47C52628.8010005@ru.mvista.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUJD3-0001kJ-FW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Feb 2008 02:08:21 -0800
Received: from qb-out-0506.google.com ([72.14.204.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JUJD2-0006xn-VI
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Feb 2008 02:08:21 -0800
Received: by qb-out-0506.google.com with SMTP id c8so3839373qbc.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 27 Feb 2008 02:08:19 -0800 (PST)
In-Reply-To: <47C52628.8010005@ru.mvista.com>
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

On Wed, Feb 27, 2008 at 4:58 PM, Alexandre Rusev <arusev@ru.mvista.com> wrote:
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
>  >
>  But what about support of DirectFB applications?
>  DirectFB as we know needs framebuffer memory to be allocated and mapped
>  only once
>  taking in account  the greatest values of colordeepth and resolution.
>
>  Furthermore for support of overlays DirectFB needs a capability to map
>  all overlays and baseplane
>  to be mapped continuously in memory (taking in account greatest bpp and
>  resolution values again)
>
>  I'd prefer to see DirectFB fixed against this, yet the fulfillment of
>  these  a bit strange rules
>  looks like to be the only way to make it possible the DirectFB to work
>  with pxafb driver :(
>

Actually, I don't quite like what the current overlay driver is doing.
I'd prefer some frame buffer APIs so the upper application can
enable/disable and adjust the offset of overlay within the whole
video memory. E.g.

Instead of
    overlay1_fd = open("/dev/fb1", O_RDWR);
    mmap(overlay1_fd, ...)
    ....

I'd prefer:

    fd = open("/dev/fb0", O_RDWR);
    video_mem = mmap(fd, ....)
    /* the whole video memory is mapped, say 4MB */

    offset = claim_overlay_memory_within( video_mem, overlay_mem_size )
    ioctl(fd, FBIOSET_OVERLAY, offset)

Or something like this, thus treating overlay as a sub-feature of the whole
frame buffer driver, instead of an independent frame buffer device.

But it is not impossible to create another frame buffer device for the
overlay, you can still avoid multiple mapping by:

    base_fd = open("/dev/fb0", O_RDWR);
    video_mem = mmap(base_fd, ....)

    overlay1_fd = open("/dev/fb1", O_RDWR);
    ioctl(overlay1_fd, FBIOGET_VSCREENINFO, &var)

    (x_off, y_off) = allocate_rect_area_within( video_mem, x_size, y_size );
    var.x_offset = x_off;
    var.y_offset = y_off;

    ioctl(overlay1_fd, FBIOPUT_VSCREENINFO, &var);

Which is better, I cannot say. Maybe it depends on upper application's
usage. I don't see such kind of overlays being well supported either
in DirectFB or X window server, :(


>
> > layer information, frame buffer device can be dynamically allocated
>  > and registered. Palette manipulation, parameter checking and
>  > layer activation code can be generalized.
>  >
>  >
>
>



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
