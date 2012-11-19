From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 19 Nov 2012 09:46:06 +0000
Subject: Re: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
Message-Id: <20121119094606.GF3290@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
 <ADE657CA350FB648AAC2C43247A983F00206B2644F3F@AUSP01VMBX24.collaborationhost.net>
 <50A9C1C4.5070907@ti.com> <20121119091504.GB3290@n2100.arm.linux.org.uk>
 <50A9FD98.1060105@ti.com>
In-Reply-To: <50A9FD98.1060105@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 19, 2012 at 11:36:24AM +0200, Tomi Valkeinen wrote:
> Probably not. I can't say anything to that matter, but I wonder if this
> patch is just going around the problem that we get sparse warnings when
> falling into the else ifdef block in fb.h.
> 
> The macros in the else block are defined as:
> 
> #define fb_readb(addr) (*(volatile u8 *) (addr))                                 
> 
> And fb code passes a pointer to __iomem. So shouldn't the cast be to
> (volatile u8 __iomem *)?

No, because sparse won't let you directly dereference an __iomem pointer.

Directly dereferencing an __iomem pointer is wrong, always has been.  It's
marked with __iomem _because_ it's a separate cookied address space from
the virtual address space.

This is one of the situations which has been left because the warning is
correct - and this is one of those situations where silencing them via
casts et.al. is the wrong thing to do.  The right thing to do is to leave
the warning in place.

This is one of the hardest things that I seem to get people to understand:
if the code is wrong then we _should_ get a warning for it and we should
definitely not paper over the warning.
