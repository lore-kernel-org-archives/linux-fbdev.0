From: James Simmons <jsimmons@infradead.org>
Subject: resizing results.
Date: Mon, 15 Mar 2004 17:38:46 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403151732090.19671-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2w3B-0007Jw-Lj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Mar 2004 09:38:53 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B2w38-0006hq-N4
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Mar 2004 09:38:50 -0800
Received: from localhost ([127.0.0.1])
	by phoenix.infradead.org with esmtp (Exim 4.30 #5 (Red Hat Linux))
	id 1B2w35-0005CH-CF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Mar 2004 17:38:47 +0000
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi folks. 

   I have been doing some work on cleaning up and debugging the resize 
issue of fbcon. The first think I discovered where I never paid attention 
to before was that the number of columns and rows change you you run 
setfont. Isn't this wrong. The number of rows and columns should remain 
the same. Only the font size chaneg which causes a console resolution 
change.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
