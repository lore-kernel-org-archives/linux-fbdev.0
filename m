From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] Fix get_std_timing
Date: Thu, 11 Mar 2004 17:43:10 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403111715030.5408-100000@phoenix.infradead.org>
References: <1078454250.6327.47.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1UVo-0004RP-Fo
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 10:02:28 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B1ToF-0001Yq-7J
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 09:17:30 -0800
In-Reply-To: <1078454250.6327.47.camel@gaston>
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
Cc: Kronos <kronos@kronoz.cjb.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 5 Mar 2004, Benjamin Herrenschmidt wrote:

> On Fri, 2004-03-05 at 09:31, James Simmons wrote:
> > Ug. I applied the fix. I will be pushing the new monitor code as soon as 
> > ben sends me bugs he found as well.
> 
> I don't have anything with the fbmon at this point. The problems I
> have are local to radeonfb, you can go & push that update

Okay. Then I will send the patch to andrew. The patch is pretty big.
You can grab it at 

http://pheonix.infradead.org/~jsimmons/monitor.diff

Also you can take a look and comment. Its against 2.6.4.





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
