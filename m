From: James Simmons <jsimmons@infradead.org>
Subject: Re: addition to mach64.diff
Date: Wed, 17 Mar 2004 22:04:50 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403172204170.19415-100000@phoenix.infradead.org>
References: <200403132046.56579.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3j9h-0006zA-Nd
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 14:04:53 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B3j9g-0007CH-Ms
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 14:04:52 -0800
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Kern <alex.kern@gmx.de>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


I tested your patch. Works fine for me. I will included it in BK.

On Sat, 13 Mar 2004, Alexander Kern wrote:

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
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
