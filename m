From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Trying to sync -> nightmare
Date: Mon, 24 May 2004 12:05:10 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1085364309.15025.19.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BS4sI-0005Ws-9R
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 19:07:34 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BS4sH-0003mu-TM
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 19:07:34 -0700
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Ok, it's really a total mess. I'm trying (again) to sync my tree with
fbdev-2.5, but that's almost impossible. Between the changes going
upstream that don't match what is in fbdev-2.5 (and this one not beeing
updated), like find_logo -> fb_find_logo plus various other stuffs,
the apparently broken removeal of outbuf/inbuf in pixmaps, and other
crap like that, it's just impossible to follow the fbdev-2.5 tree.

James _PLEASE_, try to get things a bit more in shape, right now,
it's near to impossible to sync anything with that tree, making it
difficult to help in development.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
