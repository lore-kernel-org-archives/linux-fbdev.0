From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: fbset noaccel
Date: Sat, 29 May 2004 07:14:23 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1085832863.40b87e9fde073@mail.theboonies.us>
References: <40B7296B.4030804@winischhofer.net>
	<1085819816.40b84ba84f22d@mail.theboonies.us>
Reply-To: David Eger <eger-dated-1086437670.7c6138@theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BU2jQ-0001xb-E3
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 May 2004 05:14:32 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BU2jQ-0004wA-3b
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 29 May 2004 05:14:32 -0700
In-Reply-To: <1085819816.40b84ba84f22d@mail.theboonies.us>
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
To: linux-fbdev-devel@lists.sourceforge.net


[ reads through fbset code ]

So it looks like fbset turns off acceleration by setting up the accel flag in
var (that FB_ACCELF_TEXT oddity).

While it makes sense that changing acceleration is a mode-switch item (quiescing
video engine and such), it seems more like it should be an ioctl (or sysfs!)
thing now...  Changing certain bits of var and hoping that set_var() will guess
in the correct way seems generally b0rken...

comments?

-dte


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
