From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Usage of readb() and friends...
Date: Tue, 2 Mar 2004 13:15:00 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403021313400.9959@waterleaf.sonytel.be>
References: <1076450411.4250.65.camel@kars.perseus.home>
 <Pine.GSO.4.58.0402111105230.19627@waterleaf.sonytel.be>
 <1076535969.4035.104.camel@kars.perseus.home> <20040225101534.GA1103@linux-m68k.org>
 <20040301175850.L24955@flint.arm.linux.org.uk> <20040301181727.GA2379@linux-m68k.org>
 <Pine.GSO.4.58.0403020939250.9959@waterleaf.sonytel.be>
 <1078225776.1321.71.camel@laptop.locamation.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ay906-0003Fn-Ab
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 04:27:54 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ay8Vn-0005Ea-A8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 03:56:35 -0800
In-Reply-To: <1078225776.1321.71.camel@laptop.locamation.com>
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
To: Kars de Jong <jongk@linux-m68k.org>
Cc: Richard Zidlicky <rz@linux-m68k.org>, Russell King <rmk@arm.linux.org.uk>, Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2 Mar 2004, Kars de Jong wrote:
> Which reminds me: drivers/video/fbmem.c at least seems to treat the
> return value of ioremap() as a virtual address, since it calls
> copy_{to,from}_user on it directly...

You're right. And the trouble there is that you can't easily find out which
ioremap() variant was used...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
