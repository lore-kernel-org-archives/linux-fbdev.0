From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: mach64 broken in current fbdev tree on LT-G
Date: Mon, 09 Feb 2004 17:29:21 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076308086.986.1.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aq4vB-0004jq-LQ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Feb 2004 22:29:29 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Aq4vB-00086C-24
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Feb 2004 22:29:29 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i196NDUn028281
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 9 Feb 2004 00:23:14 -0600
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The current mach64 driver doesn't work properly on the LT-G model
of the wallstreet here, not sure what's up, looks like the old
memory fifo problem that was fixed a while ago. I can't investigate
right now though.

The one upstream works. GENERIC LCD support isn't enabled as it
doesn't work on PPC.

Ben.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
