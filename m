From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: fbcon & resize
Date: Mon, 24 May 2004 11:08:33 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1085360912.15281.7.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BS3zO-00049c-J9
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 18:10:50 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BS3zO-00038g-74
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 May 2004 18:10:50 -0700
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

I still think the whole resize stuff is broken, despite your latest
changes. The main problem is blindly using the modedb and not whatever
mode list is provided by the driver (but we need an interface for that).

We need to cleanup and generalize a function for matching a mode to
the mode list to be used by drivers for validation in check_var() too,
my current algorithm in radeonfb is a bit broken for CRTs for example,
and has the nasty habit of refusing modes rather than "adapting" them.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
