From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: tdfx & multiple voodoo cards : supposed to work ?
Date: Thu, 30 Oct 2003 15:31:53 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031030143153.GA9070@iliana>
References: <20031030140342.05AEC15DCC@mail03.powweb.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFDqH-0007PU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 06:32:05 -0800
Received: from smtp6.wanadoo.fr ([193.252.22.25] helo=mwinf0604.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AFDqC-0004aZ-HM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 06:32:00 -0800
Content-Disposition: inline
In-Reply-To: <20031030140342.05AEC15DCC@mail03.powweb.com>
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
To: Richard Drummond <evilrich@rcdrummond.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Sven Luther <sven.luther@wanadoo.fr>

On Thu, Oct 30, 2003 at 02:03:38PM -0000, Richard Drummond wrote:
> Hi Sven
> 
> > Mmm, that sounds nice. do you have OF based drivers for them in your
> > mac ? I need to port the pegasos patches to 2.6.x first though.
> 
> Yes. They are both OF cards and both are initialized by OF. Your cards have a
> VGA BIOS? Well, I guess that shouldn't be a problem. The Peggy's BIOS
> emulator must be able to cope with I/O ports not being in the usual (x86)
> place - because chances are they won't be anyway even for a single card. Does
> the Pegasos boot the BIOS on a secondardy gfx card automatically? If not,

I am not sure, i think it does, at least in the devel tree.

> you're back to the usual x86 problem of having to soft-boot the BIOS
> yourself. Which will be a problem for you because I suppose the BIOS emulator
> isn't accessible post-boot. However, it should be possible to initialize a

But then, i have access to the OF sources, so ...
But then again, i am not much in x86 emulation stuff.

> second Voodoo card without using its BIOS, but I've no idea how easy or
> difficult that might be. Fun and games. ;-)

Thanks for the info, i will be looking into this.

> Of course, you have to get 2.6 working first or hack the 2.4 driver for
> multi-head support . . .

Should not be that much difficult, the only thing stopping me from doing
it was the fact that i had heard no positive records of radeonfb
working in the ppc tree and was busy with other stuff.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
