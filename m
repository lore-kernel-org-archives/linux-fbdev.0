From: "Richard Drummond" <evilrich@rcdrummond.net>
Subject: Re: tdfx & multiple voodoo cards : supposed
    to work ?
Date: Thu, 30 Oct 2003 14:03:38 -0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031030140342.05AEC15DCC@mail03.powweb.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFDOk-00041v-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 06:03:38 -0800
Received: from mail03.powweb.com ([63.251.216.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AFDOk-0001DQ-4z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 06:03:38 -0800
Content-Disposition: inline
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>

Hi Sven

> Mmm, that sounds nice. do you have OF based drivers for them in your
> mac ? I need to port the pegasos patches to 2.6.x first though.

Yes. They are both OF cards and both are initialized by OF. Your cards have a
VGA BIOS? Well, I guess that shouldn't be a problem. The Peggy's BIOS
emulator must be able to cope with I/O ports not being in the usual (x86)
place - because chances are they won't be anyway even for a single card. Does
the Pegasos boot the BIOS on a secondardy gfx card automatically? If not,
you're back to the usual x86 problem of having to soft-boot the BIOS
yourself. Which will be a problem for you because I suppose the BIOS emulator
isn't accessible post-boot. However, it should be possible to initialize a
second Voodoo card without using its BIOS, but I've no idea how easy or
difficult that might be. Fun and games. ;-)

Of course, you have to get 2.6 working first or hack the 2.4 driver for
multi-head support . . .

Cheers,
Rich



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
