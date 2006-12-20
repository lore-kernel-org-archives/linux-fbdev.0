From: Mark Pustjens <pustjens@dds.nl>
Subject: [PATCH] savagefb: vsync for twisterP
Date: Wed, 20 Dec 2006 10:38:14 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0612201036130.2728@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GwxuL-0006C5-2G for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 01:38:41 -0800
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GwxuJ-0006YE-JP
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 01:38:40 -0800
Received: from [213.51.146.188] (port=50533 helo=smtp3.tilbu1.nb.home.nl)
	by smtpq1.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1Gwxtw-0003B7-Pu for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 10:38:16 +0100
Received: from cp210686-b.roemd1.lb.home.nl ([84.28.106.175]:37094
	helo=[192.168.1.100])
	by smtp3.tilbu1.nb.home.nl with esmtp (Exim 4.30) id 1Gwxtu-00023D-Fp
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Dec 2006 10:38:14 +0100
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

This patch add support to the savagefb driver for
waiting for vsync for the TwisterP chipset.

The patch adds an ioctl FBIO_WAITFORVSYNC just like the
matroxfb driver.

It probably needs some work.

Merry Greetings,

Mark Pustjens

-- 
I think I would like to go into modelling. Of course, I don't know how to
do it, and wouldn't be any good at it if I did, so I'm going to employ
someone to walk the catwalks on my behalf. It would still be *me*, of
course...
         -- Terry learns Naomi Campbell has written a book.
   (Terry Pratchett, alt.fan.pratchett)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
