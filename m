From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Reading the EDID block for x86 machines
Date: Tue, 11 Mar 2003 14:54:07 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030311225407.15850.qmail@web14905.mail.yahoo.com>
References: <1047421959.1100.103.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14905.mail.yahoo.com ([216.136.225.57])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ssdM-0000oo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 14:54:08 -0800
In-Reply-To: <1047421959.1100.103.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

--- Antonino Daplas <adaplas@pol.net> wrote:
> On Wed, 2003-03-12 at 06:05, Jon Smirl wrote:
> > If your in messing with the early boot sequence,
> why
> > don't you make the kernel initialize all of the
> video
> > cards in the system instead of only the primary
> one.
> 
> Because I don't know how to :)?  It basically just
> involves a far call
> no, if we know where the VBIOS code actually starts?

It is more complicated. You need to call the PCI Bios
to find the video cards by their PCI class. There is
already code in the kernel that calls PCIBios.
arch/i386/pci/*

Then you need to one by one map their ROMs (via PCI
config registers) into C000:0 and call C000:3. But as
you swap out the other adapters you need to disable
their VGA emulation as there can only be on VGA device
per system.  By default the VBIOS code will enable VGA
emulation on all of the adapters and they won't. You
also need to record the INT vectors and make sure they
get set back to the primary ones.

> Note that this will still be arch-specific. 
> Separate non-primary card
> initialization code for each arch is still
> necessary.

Having X86 work is better than nothing.

> Again, most BIOS code cannot run in protected mode,
> so we need to
> emulate a real-mode environment for them.  It's
> doubtful that Linus
> would want that in his kernel.  Our only chance to
> do this is during
> early boot, or in user space.

The right answer is to get the vendors to give us the
info and then write protected mode versions of
reset/DDC into the fb drivers. Until they do this
everything else is a major hack.

It is not possible to enter VM86 mode from a device
driver. Only two choices are: early boot time or as a
user app.  I have to send you the app directly, it is
too big for SF list.

Early boot time may be a better solution. A complete
implementation would reset all video adapters in the
system and record their DDC info for retrieval by the
FB drivers.

> Tony
> 
> 

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - establish your business online
http://webhosting.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
