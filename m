From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: addition to mach64.diff
Date: Sun, 14 Mar 2004 11:28:07 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1079224087.1968.120.camel@gaston>
References: <200403132046.56579.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2JZD-0005Ef-GJ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Mar 2004 16:33:23 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B2JZA-0006cE-W3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 13 Mar 2004 16:33:21 -0800
In-Reply-To: <200403132046.56579.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2004-03-14 at 06:46, Alexander Kern wrote:
> Hello James,
> 
> here two additions from me,
> 
> first, one more define in include/video/mach64.h
> 
> second, improvements in code, tested with mach64 Mobility on my ARMADA.
> 
> P.S. Changes proposed by BenH are not here, wait_for_idle on the end of each 
> accelerated function, causes a freeze by me ;-( 

Depends where you put it, you mustn't put it in the call done just
before feeding the fifo in imageblt of course, I got bitten by that
same mistake at first.

Note that we really shouldn't have to do that anyway. There is
something wrong causing the problem, though I haven't figured out what
at this point.

Ben




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
