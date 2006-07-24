From: Dennis Munsie <dmunsie@cecropia.com>
Subject: sysfs question
Date: Mon, 24 Jul 2006 09:47:59 -0400
Message-ID: <E48BC47E-9E17-44F8-8CE7-471785C05B9C@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G50ks-0001pp-9t for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Jul 2006 06:45:54 -0700
Received: from mail7.sea5.speakeasy.net ([69.17.117.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G50kq-0007ux-Sp
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Jul 2006 06:45:54 -0700
Received: from lex098.cecropia.com (HELO [192.168.3.132])
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	24 Jul 2006 13:45:46 -0000
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

quick question regarding sysfs and the framebuffer... I can add my  
own attributes without any problems, but they always show up with the  
device (/sys/class/graphics/fb0/device), not the rest of the  
framebuffer attributes (/sys/class/graphics/fb0).  Is there a good  
way to put them with the fb attributes?  or is this a no-no?

thanks!
dennis

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
