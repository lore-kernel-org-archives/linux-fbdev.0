From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] interlaced packed pixels
Date: Sun, 6 Apr 2003 12:01:35 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0304061136510.7096-100000@vervain.sonytel.be>
References: <20030404163931.E964@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1926yb-00022m-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 06 Apr 2003 03:02:13 -0700
In-Reply-To: <20030404163931.E964@flint.arm.linux.org.uk>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Fri, 4 Apr 2003, Russell King wrote:
> On Fri, Apr 04, 2003 at 01:17:15PM +0200, Geert Uytterhoeven wrote:
> > I'd like to introduce a new frame buffer type to accommodate packed pixel frame
> > buffers that store the even and odd fields separately. This is typically used
> > in graphics hardware for TV output (e.g. set-top boxes).
> 
> While we're on the subject of framebuffers, one area which needs to be
> looked into is the pixel layout for all of:
> 
> - little endian byte, little endian pixel
> 	1bpp: word 0 bit 31..0 = pixel 31..0)
> 	16bpp: word 0 bit 31..0 = pixel1 bits 15..0 pixel0 bits 15..0) 
> - little endian byte, big endian pixel
> 	1bpp: word 0 bit 31..0 = pixel 24..31, 16..23, 8..15, 0..7)
> 	16bpp: word 0 bit 31..0 = pixel1 bits 15..0 pixel0 bits 15..0) 
> - big endian byte, big endian pixel
> 	1bpp: word 0 bit 31..0 = pixel 0..31)
> 	16bpp: word 0 bit 31..0 = pixel0 bits 15..0 pixel1 bits 15..0) 
> 
> We currently do not support all these combinations, and so far I haven't
> looked into it.  It is on my (great long) to do list.

Yes, this is still a (hard) problem.

BTW, more combinations are possible. E.g. swapped bytes in 16-bit words or
swapped 16-bit words in 32-bit words, due to hardware swapping of data bus
lines. And things get really fishy on such a system for 24-bit wide pixels.

The order within a pixel can already be specified using fb_bitfield.msb_right.
But how pixels are laid out in the frame buffer is a different thing.

I thought
about adding the following FB_TYPE_* flags a few years ago, but I'm not sure
they'll allow us to handle all cases:

  - FB_TYPE_SWAP_8_IN_16: individual bytes within a 16-bit word are swapped
  - FB_TYPE_SWAP_16_IN_32: individual 16-bit words within a 32-bit word are
    swapped
  - FB_TYPE_SWAP_32_IN_64: individual 32-bit words within a 64-bit word are
    swapped

These are supposed to be OR'ed with the current FB_TYPE_* definitions, e.g.
FB_TYPE_SWAP_32_IN_64 | FB_TYPE_SWAP_16_IN_32 | FB_TYPE_SWAP_8_IN_16 |
FB_TYPE_PACKED_PIXELS would indicate a completely swapped video bus.


An alternative solution moves more processing into the kernel. Since the actual
fbdev driver knows about all this (it has to provide fb_ops), it can provide
the following operations to userspace:
  - fillrect()
  - copyrect()
  - put_image()
  - get_image()
This would allow a user space application to perform all simple drawing
operations without having to care at all about the actual frame buffer layout.

For more complex operations, these can be performed by the application on a
shadow frame buffer in a simple packed format, while letting the kernel take
care of the actual drawing, including necessary chunky-to-planar conversions
and bit mangling.

For performance reasons, the driver should report optimal positional and size
alignments for {put,get}_image().

What do you think?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
