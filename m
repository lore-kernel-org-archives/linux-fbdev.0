From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Wed, 21 Apr 2004 10:30:37 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1082507437.2077.28.camel@gaston>
References: <1082339577.15101.4.camel@gaston>
	 <Pine.LNX.4.44.0404202032210.29160-100000@phoenix.infradead.org>
	 <12573.10.250.10.1.1082504618.squirrel@sq01.pol.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BG5dp-0004i4-Bf
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 17:31:05 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BG5dp-0002ZY-2m
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 17:31:05 -0700
In-Reply-To: <12573.10.250.10.1.1082504618.squirrel@sq01.pol.net>
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
To: adaplas@pol.net
Cc: James Simmons <jsimmons@infradead.org>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> I find that a soft copyarea is always expensive than a soft imageblit as a
> copyarea will involve an fb read (10-20x slower than fb write).  Tested
> this before with an old pci nvidia card. Not o sure with newer hardware.

I confirm, reading from the fb shall be avoided at all cost

> >    As for hardware panning should we prefer it above everthing?
> 
> Probably not.  Hardware panning + slow ymove will result in an unsmooth
> scrolling action.
> 
> I prefer an algo like this:
> 
> if (yres < vyres/2 || !ypanstep || soft_copyarea)
>      yredraw
> else
>      ymove
> 
> Tony
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
