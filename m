From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Tue, 28 Oct 2003 14:09:40 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031028220940.65607.qmail@web14913.mail.yahoo.com>
References: <1067376950.3332.19.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEc4e-0008Hc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 14:12:24 -0800
Received: from web14913.mail.yahoo.com ([216.136.225.240])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AEc20-0007HO-Hm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Oct 2003 14:09:40 -0800
In-Reply-To: <1067376950.3332.19.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ian Romanick <idr@us.ibm.com>, David Dawes <dawes@XFree86.Org>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> The problem is the same. DMA or not DMA, what we want is arbitration.
> 
> When fbdev sets up a mode, the X server mustn't blast 2D engine (either
> using PIO or sending DMA commands) etc... So that "arbitration" module
> will have to provide the necessary arbitration so that the 2D/3D DMA
> command flow can be interrupted (if any), and/or the hw access "lock"
> passed between things like fbdev/fbcon and userland clients.

Do we really want arbitration between multiple things (FB, X, DRI, etc) all
trying to control the video hardware at a register level? This is like writing
a multitaking system for device drivers.

Or do we want a single device driver with multiple clients?

A major complaint from the framebuffer console people is that we have to do
mode setting/EDID in the device driver so that there is a console to look at
from the first second the kernel boots. This also means we have to map the
framebuffer into kernel space (sucking up to 256MB of kernel address space).

In the 2.7 time frame is it possible to write a low level driver like Linus
proposed plus a small DSO for mode setting/EDID. Then write fbconsole as a user
space app that is loaded much eariler in the boot process than user-mode
currently starts? In other words is there a solution to having a boot time
console that doesn't involve running it in a device driver?

Another possible solution to the boot time problem would be to write a
disposable device driver. The disposable driver would set the mode/EDID and run
the console until user mode started; then self destruct. 

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
