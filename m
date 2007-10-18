From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] mbxfb: fix incorrect argument type
Date: Thu, 18 Oct 2007 23:46:10 +0200
Message-ID: <20071018234610.1498b21e.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iid2q-0007FT-K3 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 14:36:44 -0700
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Iid2p-0002d0-22
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 14:36:44 -0700
Received: from poczta.interia.pl (mi01.poczta.interia.pl [10.217.12.1])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 87B4A13FFC2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 18 Oct 2007 23:36:39 +0200 (CEST)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id AB6C8769BD1
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 18 Oct 2007 23:36:39 +0200 (CEST)
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
the dev_dbg() function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch was done against the 2.6.23-git13 kernel.

diff -urp linux-ref/drivers/video/mbx/mbxfb.c linux-new/drivers/video/mbx/mbxfb.c
--- linux-ref/drivers/video/mbx/mbxfb.c	2007-10-18 22:32:50.984989900 +0200
+++ linux-new/drivers/video/mbx/mbxfb.c	2007-10-18 23:38:03.775967147 +0200
@@ -889,7 +889,7 @@ static int __devinit mbxfb_probe(struct 
 	struct mbxfb_info *mfbi;
 	struct mbxfb_platform_data *pdata;
 
-	dev_dbg(dev, "mbxfb_probe\n");
+	dev_dbg(&dev->dev, "mbxfb_probe\n");
 
 	pdata = dev->dev.platform_data;
 	if (!pdata) {

----------------------------------------------------------------------
Rusz pupe na wybory!
Kliknij >>> http://link.interia.pl/f1bfc


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
