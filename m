From: "Richard Drummond" <evilrich@rcdrummond.net>
Subject: Re: tdfx & multiple voodoo cards : supposed
    to work ?
Date: Thu, 30 Oct 2003 12:34:15 -0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031030123418.7005615CA9@mail03.powweb.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFC0G-00018D-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 04:34:16 -0800
Received: from mail03.powweb.com ([63.251.216.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AFC0F-0003mE-QR
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 04:34:15 -0800
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

> BTW, what is the status of voodoo 4 & 5 with fbdev ? I get reports of
> endianess problems, but this may also be related to XFree86, i will have
> to investigate more.

Voodoo4/5 has a different method of byte-swizzling for big-endian hardware than the Voodoo3 - which isn't supported by the current tdxfb driver or by XFree86. I have been working on a fix for tdfxfb, and have had some success - but since I don't have any documentation, it's involved a lot of guess-work. I haven't looked at this for a while, but I could dig out the code again and supply a patch against what I have got so far.

As to your other problem, I have two Voodoos working on my Mac with 2.6, so I would expect such a set-up to work on the Pegasos too. On PPC hardware, there should be no problem of conflicting VGA ports since the PCI sub-system can remap I/O ports on the PPC.

Actually, there are one or two bugs in the tdfxfb driver which crop up when
using multiple cards - but nothing too serious it would seem. Again, I've been meaning to submit a patch . . . (where does all the time go ;-)

Cheers,
Rich



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
