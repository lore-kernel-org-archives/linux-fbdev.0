From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fw: [Bugme-new] [Bug 4295] New: Garbage all over the screen
 when using radeonfb
Date: Sun, 06 Mar 2005 09:45:47 +1100
Message-ID: <1110062747.13593.79.camel@gaston>
References: <20050305100413.176213f7.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7i5J-0002e5-FK
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 14:49:21 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D7i5J-0000wG-0m
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 14:49:21 -0800
In-Reply-To: <20050305100413.176213f7.akpm@osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, hans.oischinger@h3c.de

On Sat, 2005-03-05 at 10:04 -0800, Andrew Morton wrote:

>    
> Steps to reproduce:   
> modprobe radeonfb   
> every 1/2 second some garbage pixels appear all over the screen. When the   
> screen is not updated by clear or something that scrolls the 'garbaged' lines  
> out of the screen, the whole screen becomes white.  
>   
> Starting X (with radeon driver or fglrx) changes nothing... Garbage production  
> continues...  
>  
The 1/2 second thing smells like a cursor issue ... 

Can you try booting with radeonfb.default_dynclk=-1 and tell me if that
makes any difference ? Also try with radeonfb.noaccel=1 (do separate
tests).

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
