From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: Usage of readb() and friends...
Date: Tue, 2 Mar 2004 17:42:59 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403021742241.18264-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0403021313400.9959@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyE7Z-0006dR-Rr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 09:55:57 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AyDcy-0007l6-HM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 09:24:20 -0800
In-Reply-To: <Pine.GSO.4.58.0403021313400.9959@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kars de Jong <jongk@linux-m68k.org>, Richard Zidlicky <rz@linux-m68k.org>, Russell King <rmk@arm.linux.org.uk>, Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


Hopefully one fb_write and fb_read in fbmem.c moves over to using 
accelerated blits this can go away.


On Tue, 2 Mar 2004, Geert Uytterhoeven wrote:

> On Tue, 2 Mar 2004, Kars de Jong wrote:
> > Which reminds me: drivers/video/fbmem.c at least seems to treat the
> > return value of ioremap() as a virtual address, since it calls
> > copy_{to,from}_user on it directly...
> 
> You're right. And the trouble there is that you can't easily find out which
> ioremap() variant was used...
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
> 
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
