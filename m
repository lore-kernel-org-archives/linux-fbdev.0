From: James Simmons <jsimmons@infradead.org>
Subject: Re: fb_write change in your tree
Date: Wed, 24 Mar 2004 00:16:50 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403240014320.6582-100000@phoenix.infradead.org>
References: <1080086342.23716.161.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5w4j-00019f-VA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 16:16:53 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B5w4i-0007F4-UH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 16:16:53 -0800
In-Reply-To: <1080086342.23716.161.camel@gaston>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



> Right. Note that fb_read is still using copy_to_user() with the
> fb as a source, and that is hairy too.

yes. I haven't go to do that.

> But I would still like to allow the fb to just overwrite the whole
> fb_read/write implementation. 

I will think about keeping it. for now I'm experimenting.

> Also, your patch may break things if
> userland did fb_write for an amount that covers several lines but
> ends up in a middle of one afaik, it converts to images that are
> rectangles, and doesn't properly deal with the possible first line
> and last lines not beeing complete

Its not done properly :-( I was busy pushing patches mainline instead of 
perfecting it.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
