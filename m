From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Dri-devel] Re: DRM and pci_driver
	conversion
Date: Wed, 29 Oct 2003 08:35:51 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1067376950.3332.19.camel@gaston>
References: <Pine.LNX.4.44.0310281855430.5142-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0310281855430.5142-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ian Romanick <idr@us.ibm.com>, David Dawes <dawes@XFree86.Org>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>


>    Unfortunely most fbdev drivers set the hardware in IO access mode. Plus 
> some of the devices lack any kind of DMA support. In this case seperating 
> out the parts of the driver that program the "high level" stuff leaves 
> almost nothing left. Would it still be wise to seperate it out as you 
> suggest? Would we really gain that much doing this for the case of IO 
> access only graphics hardware?  	

The problem is the same. DMA or not DMA, what we want is arbitration.

When fbdev sets up a mode, the X server mustn't blast 2D engine (either
using PIO or sending DMA commands) etc... So that "arbitration" module
will have to provide the necessary arbitration so that the 2D/3D DMA
command flow can be interrupted (if any), and/or the hw access "lock"
passed between things like fbdev/fbcon and userland clients.

Right now, even plain fbdev as it exist is racy in this regard. Nothing
prevent an accelerated printk or cursor operation to happen in the middle
of a userland initiated mode switch, potentially locking up the card. My
latest radeonfb has minimal spinlock so at least the indirect register
accesses (like PLL) are safe, but it's still broken in some way.

Unfortunately, the way fbcon currently works, the only way to deal with
those issues is by taking the console semaphore on every fbdev operations.
(Thanks to printk & blanking coming from irq). If fbcon can completely
separate update of the text/attr buffer from actual refresh of the
framebuffer, it may be possible to do something smarter.

This problem isn't really an issue we need to deal with in that proposed
"low level" driver though. It's entirely an fbdev/fbcon issue that is
caused by having fbcon active on a VT, that is by having a KDTEXT VT.

I expect that when such a console is frontmost, the HW lock will be solely
owned by fbdev/fbcon. Only a KDGRAPHICS vt shall release that HW lock,
letting userland grab it for drawing operations, fbdev taking it only when
requested to do things like mode changes or palette changes.

Ben.
 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
