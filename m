From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: Usage of readb() and friends...
Date: Wed, 03 Mar 2004 09:50:13 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1078267813.21578.201.camel@gaston>
References: <1076450411.4250.65.camel@kars.perseus.home>
	 <Pine.GSO.4.58.0402111105230.19627@waterleaf.sonytel.be>
	 <1076535969.4035.104.camel@kars.perseus.home>
	 <20040225101534.GA1103@linux-m68k.org>
	 <20040301175850.L24955@flint.arm.linux.org.uk>
	 <20040301181727.GA2379@linux-m68k.org>
	 <Pine.GSO.4.58.0403020939250.9959@waterleaf.sonytel.be>
	 <1078225776.1321.71.camel@laptop.locamation.com>
	 <Pine.GSO.4.58.0403021313400.9959@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyJ5z-0005my-AW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 15:14:39 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AyIb3-0007ke-C2
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 14:42:41 -0800
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
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kars de Jong <jongk@linux-m68k.org>, Richard Zidlicky <rz@linux-m68k.org>, Russell King <rmk@arm.linux.org.uk>, Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-03-02 at 23:15, Geert Uytterhoeven wrote:
> On Tue, 2 Mar 2004, Kars de Jong wrote:
> > Which reminds me: drivers/video/fbmem.c at least seems to treat the
> > return value of ioremap() as a virtual address, since it calls
> > copy_{to,from}_user on it directly...
> 
> You're right. And the trouble there is that you can't easily find out which
> ioremap() variant was used...

And... it's illegal to call copy_to/from_user on the return of
ioremap anyway. Not only for semantic reasons, but also for practical
reasons, for example, ioremap returns non cacheable space on PPC,
and copy_to/from_user uses "cache hints" to speed up the copy.

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
