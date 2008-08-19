From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: i.MX Framebuffer patches
Date: Tue, 19 Aug 2008 17:06:39 +0200
Message-ID: <1219158403-5180-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVSnK-0000aY-Lw for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 08:06:50 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVSnJ-0005N5-5Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 08:06:50 -0700
Received: from octopus.labnet.pengutronix.de ([10.1.1.3])
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <sha@pengutronix.de>) id 1KVSnD-0000Jv-Ai
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 17:06:43 +0200
Received: from sha by octopus.labnet.pengutronix.de with local (Exim 4.69)
	(envelope-from <sha@pengutronix.de>) id 1KVSnD-0001M3-0j
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 17:06:43 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Here are some patches for the i.MX framebuffer driver. They mainly prepare
the driver for use with other i.MX processors like the i.MX27.

Sascha



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
