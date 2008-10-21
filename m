From: roel kluin <roel.kluin@gmail.com>
Subject: [PATCH] atmel_lcdfb: unsigned irq_base cannot
	be negative
Date: Mon, 20 Oct 2008 23:41:50 -0400
Message-ID: <48FD4F7E.6010708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1Ks4Yh-0006Bi-FB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Oct 2008 23:53:11 +0000
Received: from ug-out-1314.google.com ([66.249.92.172])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ks4Yd-0004G3-5c for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Oct 2008 23:53:11 +0000
Received: by ug-out-1314.google.com with SMTP id z36so922283uge.17
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 20 Oct 2008 16:53:04 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: nicolas.ferre@atmel.com, linux-fbdev-devel@lists.sourceforge.net

unsigned irq_base cannot be negative

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index f8d0a57..f93f57a 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -857,12 +857,12 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 		goto stop_clk;
 	}
 
-	sinfo->irq_base = platform_get_irq(pdev, 0);
-	if (sinfo->irq_base < 0) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
 		dev_err(dev, "unable to get irq\n");
-		ret = sinfo->irq_base;
 		goto stop_clk;
 	}
+	sinfo->irq_base = ret;
 
 	/* Initialize video memory */
 	map = platform_get_resource(pdev, IORESOURCE_MEM, 1);



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
