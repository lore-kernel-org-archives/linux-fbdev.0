From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] Fix get_std_timing
Date: Fri, 12 Mar 2004 09:48:26 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1079045305.9745.300.camel@gaston>
References: <Pine.LNX.4.44.0403111822450.5794-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1ZKm-0005LD-Dk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 15:11:24 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B1Ycx-0001FX-2t
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 14:26:07 -0800
In-Reply-To: <Pine.LNX.4.44.0403111822450.5794-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Kronos <kronos@kronoz.cjb.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2004-03-12 at 05:23, James Simmons wrote:
> Ben does your driver support the Rage Theater? That is the card I have at 
> my desk.

The Rage Theater per-se isn't a card, but a brand name for cards wich
an additional chip dedicated to video input and TV stuffs.

The core ASIC is one of the normal radeons. Radeonfb should work.

Note that the name "Rage Theater" was also used for mach64 and r128 cards
with the "thater" extension, so it could be any of those ;)

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
