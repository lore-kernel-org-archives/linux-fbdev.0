From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Wed, 21 Apr 2004 12:50:19 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404211249570.7657@waterleaf.sonytel.be>
References: <1082339577.15101.4.camel@gaston>
 <Pine.LNX.4.44.0404202032210.29160-100000@phoenix.infradead.org>
 <12573.10.250.10.1.1082504618.squirrel@sq01.pol.net> <1082507437.2077.28.camel@gaston>
 <Pine.GSO.4.58.0404211027300.7657@waterleaf.sonytel.be> <1082543782.2076.66.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGFJC-0007Av-Q4
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 03:50:26 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGFJC-0001s8-EP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 03:50:26 -0700
In-Reply-To: <1082543782.2076.66.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 21 Apr 2004, Benjamin Herrenschmidt wrote:
> On Wed, 2004-04-21 at 18:28, Geert Uytterhoeven wrote:
> > On Wed, 21 Apr 2004, Benjamin Herrenschmidt wrote:
> > > > I find that a soft copyarea is always expensive than a soft imageblit as a
> > > > copyarea will involve an fb read (10-20x slower than fb write).  Tested
> > > > this before with an old pci nvidia card. Not o sure with newer hardware.
> > >
> > > I confirm, reading from the fb shall be avoided at all cost
> >
> > This is true for PCI/AGP, but may not be true for unified memory systems.
>
> Right, but that confirms my opinion that the choice of the technique used
> shall be under control of the driver

Agreed. So a hint would be the most appropriate.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
