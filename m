From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Mach64Gx not working on pmac 9500 (Was : tdfx & multiple voodoo cards : supposed to work ? + Mach64Gx question.)
Date: Thu, 30 Oct 2003 10:56:20 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031030095620.GA5088@iliana>
References: <20031030064940.GC2115@iliana> <Pine.GSO.4.21.0310301031110.15545-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AF9XY-0007tL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 01:56:28 -0800
Received: from smtp4.wanadoo.fr ([193.252.22.27] helo=mwinf0401.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AF9XX-0002BE-Pk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 01:56:27 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0310301031110.15545-100000@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, debian-powerpc@lists.debian.org, debian-boot@lists.debian.org
Cc: Chris Tillman <toff1@cox.net>, Sven Luther <sven.luther@wanadoo.fr>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Ok.

Chris, can you have a look at this, and see if can provide this
information, by using a serial console, or maybe blindly typing :
  # dmesg >somplace
and also by visual confirmation ?

Friendly,

Sven Luther

On Thu, Oct 30, 2003 at 10:38:45AM +0100, Geert Uytterhoeven wrote:
> On Thu, 30 Oct 2003, Sven Luther wrote:
> > BTW, i had had reports from Chris Tillman about what seems an fbdev
> > failure on his 9500 powermac with 2.4.22 kernels. The pci greaphic cards
> > declares to be a Mach64GX, and lspci gives :
> > 
> > 00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 02)
> > 00:0f.0 VGA comppatible controller: ATI Technolgies Inc 210888GX [Mach64 GX] (rev 02)
> > 00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
> > 
> > 00:0f.0 Class 0300: 1002:4758 (rev 02)
> > 	Flags: stepping, medium devsel, IRQ 25
> > 	Memory at 81000000 (32-bit, non-prefetchable)
> > 
> > Any idea on what is going on here (the kernel works, but there is no
> > video output).
> 
> Mach64 GX is difficult to handle, since it needs an external clockchip and
> RAMDAC, unlike the later variants.
> 
> The first thing to know is which external clockchip and RAMDAC are used on this
> particular board? Atyfb should print it during initialization, but it's better
> to do a visual verification on the board, too.
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
