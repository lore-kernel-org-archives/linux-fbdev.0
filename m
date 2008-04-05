From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: nvidiafb and Quadro FX 570M
Date: Sat, 5 Apr 2008 18:39:08 +0200
Message-ID: <20080405163907.GA5625@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JiBQF-0001QD-Id for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 Apr 2008 09:39:20 -0700
Received: from smtpout.hostsharing.net ([83.223.95.98])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JiBQD-0002yC-PB
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 Apr 2008 09:39:19 -0700
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id 99EB32000115
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat,  5 Apr 2008 18:39:12 +0200 (CEST)
Received: from mail.home.lxtec.de (p5B144F58.dip.t-dialin.net [91.20.79.88])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 5C2F71839C023
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat,  5 Apr 2008 18:39:12 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.69 1 (LXTEC))
	id 1JiBQ7-0001sR-9M for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 Apr 2008 18:39:11 +0200
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mg4trGqFEP59
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat,  5 Apr 2008 18:39:08 +0200 (CEST)
Received: from aragorn.home.lxtec.de ([192.168.200.203] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.69 1 (LXTEC))
	id 1JiBQ4-0001sG-HM for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 Apr 2008 18:39:08 +0200
Content-Disposition: inline
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

Hi there,

is framebuffer support for the FX 570M available? dmesg tells:

nvidiafb: unknown NV_ARCH

Elimar


-- 
  Never make anything simple and efficient when a way 
  can be found to make it complex and wonderful ;-)

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
