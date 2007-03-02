From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Warnings from matroxfb i2c driver
Date: Fri, 2 Mar 2007 21:00:57 +0100
Message-ID: <200703022100.58028.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNDw6-0003LD-Rh for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 12:01:03 -0800
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HNDw5-0002yD-8U
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 12:01:02 -0800
Received: from hanslin.local.208.168.192.in-addr.arpa
	(HSI-KBW-085-216-099-221.hsi.kabelbw.de [85.216.99.221])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.tglx.de (Postfix) with ESMTP id BA15165C065
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri,  2 Mar 2007 21:00:59 +0100 (CET)
Content-Disposition: inline
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

In my boot logs I find the following warnings:

matroxfb: Matrox G550 detected
PInS memtype = 5
matroxfb: MTRR's turned on
matroxfb: 1280x1024x24bpp (virtual: 1280x4369)
matroxfb: framebuffer at 0xD4000000, mapped to 0xf8880000, size 33554432
Console: switching to colour frame buffer device 160x64
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
**WARNING** I2C adapter driver [DDC:fb0 #0] forgot to specify physical device; 
fix it!
**WARNING** I2C adapter driver [DDC:fb0 #1] forgot to specify physical device; 
fix it!
**WARNING** I2C adapter driver [MAVEN:fb0] forgot to specify physical device; 
fix it!

Kernel is a vanilla 2.6.20.1. Can somebody please explain this to me? Can I 
ignore these warnings?

Thanks,
Hans

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
