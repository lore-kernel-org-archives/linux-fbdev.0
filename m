From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: tdfx & multiple voodoo cards : supposed to
 work ? + Mach64Gx question.
Date: Thu, 30 Oct 2003 10:38:45 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310301031110.15545-100000@waterleaf.sonytel.be>
References: <20031030064940.GC2115@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AF9Gw-0005Yy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 01:39:18 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AF9Gv-00008R-CZ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 01:39:17 -0800
In-Reply-To: <20031030064940.GC2115@iliana>
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
To: Chris Tillman <toff1@cox.net>, Sven Luther <sven.luther@wanadoo.fr>
Cc: Kronos <kronos@kronoz.cjb.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 30 Oct 2003, Sven Luther wrote:
> BTW, i had had reports from Chris Tillman about what seems an fbdev
> failure on his 9500 powermac with 2.4.22 kernels. The pci greaphic cards
> declares to be a Mach64GX, and lspci gives :
> 
> 00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 02)
> 00:0f.0 VGA comppatible controller: ATI Technolgies Inc 210888GX [Mach64 GX] (rev 02)
> 00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
> 
> 00:0f.0 Class 0300: 1002:4758 (rev 02)
> 	Flags: stepping, medium devsel, IRQ 25
> 	Memory at 81000000 (32-bit, non-prefetchable)
> 
> Any idea on what is going on here (the kernel works, but there is no
> video output).

Mach64 GX is difficult to handle, since it needs an external clockchip and
RAMDAC, unlike the later variants.

The first thing to know is which external clockchip and RAMDAC are used on this
particular board? Atyfb should print it during initialization, but it's better
to do a visual verification on the board, too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
