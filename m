From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: [PATCH] Fix get_std_timing
Date: Fri, 12 Mar 2004 09:46:45 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1079045205.9746.297.camel@gaston>
References: <Pine.LNX.4.44.0403111931050.7084-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1ZJP-0004zT-6P
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 15:09:59 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B1YbT-0000sy-Hk
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 14:24:35 -0800
In-Reply-To: <Pine.LNX.4.44.0403111931050.7084-100000@phoenix.infradead.org>
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

On Fri, 2004-03-12 at 06:32, James Simmons 

> > None of my test boxes have radeon.   Your comment makes me worry about the
> > readiness of this code.   Please say reassuring things to me ;)
> 
> I just tested the vanilla kernel with the radeon card. Then I tested it 
> with my montior patch. It worked :-) I'm writing to you from that machine. 
> So it is safe to apply the patch.

I'll give it a try. Note that if that's the fbmon changes (plus GTF fix)
that were in the fbdev tree so far, I can confirm they work fine.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
