From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] Fix get_std_timing
Date: Thu, 11 Mar 2004 23:26:20 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403112325330.7443-100000@phoenix.infradead.org>
References: <1079045305.9745.300.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1ZrI-0004hu-DR
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 15:45:00 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B1ZZP-0000uu-9k
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 15:26:31 -0800
In-Reply-To: <1079045305.9745.300.camel@gaston>
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
Cc: Andrew Morton <akpm@osdl.org>, Kronos <kronos@kronoz.cjb.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Ben does your driver support the Rage Theater? That is the card I have at 
> > my desk.
> 
> The Rage Theater per-se isn't a card, but a brand name for cards wich
> an additional chip dedicated to video input and TV stuffs.
> 
> The core ASIC is one of the normal radeons. Radeonfb should work.
> 
> Note that the name "Rage Theater" was also used for mach64 and r128 cards
> with the "thater" extension, so it could be any of those ;)

I tried it out. Yes I have had fun with eth weird ATI naming scheme 
before :-/ It is a radeon. I plan to do more testing tonight for the stty 
crashes. 




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
