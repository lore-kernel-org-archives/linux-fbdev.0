From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: [PATCH] Fix get_std_timing
Date: Thu, 11 Mar 2004 19:32:17 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403111931050.7084-100000@phoenix.infradead.org>
References: <20040311101334.414624d1.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1WCg-0001VZ-GO
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 11:50:50 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B1VV6-0005m4-Qc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Mar 2004 11:05:49 -0800
In-Reply-To: <20040311101334.414624d1.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, kronos@kronoz.cjb.net, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net


> >  Various fixes and enhancements to the monitor hardware detection 
code.
> >  The only driver that uses it is the radeon driver. Give it a try before 
> >  you apply it.
> 
> None of my test boxes have radeon.   Your comment makes me worry about the
> readiness of this code.   Please say reassuring things to me ;)

I just tested the vanilla kernel with the radeon card. Then I tested it 
with my montior patch. It worked :-) I'm writing to you from that machine. 
So it is safe to apply the patch.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
