From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Wed, 21 Apr 2004 20:36:22 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1082543782.2076.66.camel@gaston>
References: <1082339577.15101.4.camel@gaston>
	 <Pine.LNX.4.44.0404202032210.29160-100000@phoenix.infradead.org>
	 <12573.10.250.10.1.1082504618.squirrel@sq01.pol.net>
	 <1082507437.2077.28.camel@gaston>
	 <Pine.GSO.4.58.0404211027300.7657@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGF6x-0003yU-MJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 03:37:47 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BGF6x-0007ep-9d
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Apr 2004 03:37:47 -0700
In-Reply-To: <Pine.GSO.4.58.0404211027300.7657@waterleaf.sonytel.be>
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
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-04-21 at 18:28, Geert Uytterhoeven wrote:
> On Wed, 21 Apr 2004, Benjamin Herrenschmidt wrote:
> > > I find that a soft copyarea is always expensive than a soft imageblit as a
> > > copyarea will involve an fb read (10-20x slower than fb write).  Tested
> > > this before with an old pci nvidia card. Not o sure with newer hardware.
> >
> > I confirm, reading from the fb shall be avoided at all cost
> 
> This is true for PCI/AGP, but may not be true for unified memory systems.

Right, but that confirms my opinion that the choice of the technique used
shall be under control of the driver

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
