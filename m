From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: tdfx & multiple voodoo cards : supposed to
 work ? + Mach64Gx question.
Date: Thu, 30 Oct 2003 21:47:08 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310302132000.16880-100000@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0310301845220.5296-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFJhI-0007dY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 12:47:12 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AFJhI-0002GB-C2
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 12:47:12 -0800
In-Reply-To: <Pine.LNX.4.44.0310301845220.5296-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 30 Oct 2003, James Simmons wrote:
> > > > 00:0f.0 VGA comppatible controller: ATI Technolgies Inc 210888GX [Mach64 GX] (rev 02)
> > > > 
> > > > Any idea on what is going on here (the kernel works, but there is no
> > > > video output).
> > > 
> > > I have this card as well and never got it to work.
> > 
> > On x86 ? But Chris is telling that it used to work well with his 2.2.20
> > or thereabout kernel.
> 
> Yes. Maybe it is a different card but I think it is that one.
> Have to check.

Which RAMDAC and clockchip does it have?

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
