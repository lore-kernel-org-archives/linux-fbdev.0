From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: fbdev cursor part 1.
Date: Wed, 10 Mar 2004 17:49:29 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403101747120.24760-100000@phoenix.infradead.org>
References: <200403051003.45536.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B186w-00060D-Bg
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Mar 2004 10:07:18 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B17pm-0006D3-4e
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Mar 2004 09:49:34 -0800
In-Reply-To: <200403051003.45536.alex.kern@gmx.de>
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
Cc: linux-fbdev-devel@lists.sourceforge.net


Sorry about the delay. I have been bug bashing other code in fbdev. Here 
is your latest driver against the vanillia tree. It works because I have 
tested on my laptop. I even did some repairs on the software cursor. It 
now behaves better, except it doesn't like none 8 bit wide fonts.

http://phoenix.infradead.org/~jsimmons/mach64.diff.gz



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
