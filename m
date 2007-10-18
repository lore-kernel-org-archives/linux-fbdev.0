From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] s3c2410fb: fix incorrect argument type
Date: Thu, 18 Oct 2007 22:50:03 +0200
Message-ID: <20071018225003.0b3adc59.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IicAX-0001l6-Rd for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 13:40:37 -0700
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IicAV-0002GS-BN
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 13:40:37 -0700
Received: from poczta.interia.pl (mi03.poczta.interia.pl [10.217.12.3])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 0605E140637
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 18 Oct 2007 22:40:31 +0200 (CEST)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 9B93E4521E
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 18 Oct 2007 22:40:30 +0200 (CEST)
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes wrong pointer type passed into
the s3c2410fb_init_registers() function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
My bad - this error is due to my changes to the driver.

This patch was done against the 2.6.23-git13 kernel.


diff -urp linux-ref/drivers/video/s3c2410fb.c linux-new/drivers/video/s3c2410fb.c
--- linux-ref/drivers/video/s3c2410fb.c	2007-10-18 22:32:51.353010872 +0200
+++ linux-new/drivers/video/s3c2410fb.c	2007-10-18 22:35:25.141774794 +0200
@@ -1026,7 +1026,7 @@ static int s3c2410fb_resume(struct platf
 	clk_enable(info->clk);
 	msleep(1);
 
-	s3c2410fb_init_registers(info);
+	s3c2410fb_init_registers(fbinfo);
 
 	return 0;
 }


------------------------------------------------------------
Mordal Kombat pod Sejmem  - zagraj 
Kliknij >>> http://link.interia.pl/f1c31


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
