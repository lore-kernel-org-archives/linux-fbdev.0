From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Tue, 10 Jan 2012 21:06:08 +0000
Subject: Re: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove
Message-Id: <20120110210608.GB1068@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
 <4F0AC2B1.8010601@atmel.com> <87ty45dt89.fsf@macbook.be.48ers.dk>
 <20120110140218.GB7180@jl-vm1.vm.bytemark.co.uk>
In-Reply-To: <20120110140218.GB7180@jl-vm1.vm.bytemark.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 10, 2012 at 02:02:18PM +0000, Jamie Lokier wrote:
> If you're connecting an RGB555 or RGB444 panel, don't you want the
> software using the framebuffer to know this so it will dither appropriately?
> 
> E.g. gradients look "bandy" if drawn in RGB565 then green's LSB is dropped.

This is why you use the bitfield stuff to tell userspace what the
actual properties of the framebuffer are.

(However, there are some userspace programs which ignore that
information and think they know better than the kernel about how a
frame buffer is organised - which is a constant pain in the butt when
you have a display which isn't BGR.  But that's really a userspace
bug in those silly programs.)
