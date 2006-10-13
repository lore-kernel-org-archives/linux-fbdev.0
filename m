From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: SM501 framebuffer driver
Date: Fri, 13 Oct 2006 21:11:38 +0900
Message-ID: <20061013121138.GA21744@linux-sh.org>
References: <45268042.8050207@billgatliff.com> <452691A2.2020209@anagramm.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYLtV-0002on-2K for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 05:12:05 -0700
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GYLtS-0006jx-7h
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 05:12:04 -0700
Content-Disposition: inline
In-Reply-To: <452691A2.2020209@anagramm.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Robert Whaley <rwhaley@applieddata.net>, sm5xx-devel@lists.berlios.de

On Fri, Oct 06, 2006 at 07:25:54PM +0200, Clemens Koller wrote:
> Great! Where shall we collect the code?
> I have some 
> 
> - a working fb driver kernel module
> 	(I did lots of code cleanup, but still needs a lot)
> 
There's at least half a dozen of these floating around, with some
disagreement on the actual implementation. We had one in the old SH tree
that specifically registered a different framebuffer device for each
plane, which we had some code in DirectFB and mplayer for making use of
for overlays and so on.

There's also another framebuffer driver for this in the Linux/MIPS tree
that's reasonably clean and might make a better starting point. The main
issue is supporting both PCI and platform device handling from the same
driver, since there seem to be just as many in both configurations
floating around.

> - kernel code for an functional complete(?) SM501 implementation for
> 	an RTS7751R2D Renesas SH-4 Board running Linux.
> 
It's largely complete, yes, but most of the code is fairly messy, or
against outdated APIs. It might make a good reference point, but little
else. The OHCI and i2c drivers are probably the "cleanest" out of these,
though I haven't gotten around to tidying them up and merging them in to
mainline as of yet. It might be beneficial to get these in to your sm5xx
tree though, before we end up having even more duplication (it seems
there already is with i2c..).

The OHCI thing was a bit of a mess since the DMA requests need to be in
the 8051 address space via the accessible SRAM there. You can see our
lame allocator for that in arch/sh/cchips/voyagergx/consistent.c.

> Oh, I will need to get the AC97 working, too :-/
> (my hardware is more or less ready to test some software)
> 
We also have an OSS driver for SM501, but it contains a lot of 8051
microcode that needs to be shoved in to userspace, and it needs to be
reworked for ALSA.

It should be fairly trivial to rework this for the mfd approach and work
from there, which I'll look at doing if no one beats me to it and I
finish some more pressing matters first.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
