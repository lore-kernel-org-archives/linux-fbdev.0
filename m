From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] s3c2443: fix section mismatch in irq.c
	file (3rd ver)
Date: Sat, 18 Aug 2007 23:40:12 +0200
Message-ID: <20070818234012.b61e0aac.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IMVxD-00035k-Ce for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Aug 2007 14:35:32 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1IMVxC-0006Z1-Tc
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Aug 2007 14:35:31 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	18 Aug 2007 23:35:28 +0200
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
Cc: Ben Dooks <ben-linux-arm@fluff.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes section mismatches related to irq functions.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch is a result of Sam Ravnborg comments.

diff -urp linux-2.6.22.base/arch/arm/mach-s3c2443/irq.c linux-arm/arch/arm/mach-s3c2443/irq.c
--- linux-2.6.22.base/arch/arm/mach-s3c2443/irq.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-arm/arch/arm/mach-s3c2443/irq.c	2007-08-11 07:20:54.018029312 +0200
@@ -252,7 +252,7 @@ static int __init s3c2443_add_sub(unsign
 	return 0;
 }
 
-static int s3c2443_irq_add(struct sys_device *sysdev)
+static int __init s3c2443_irq_add(struct sys_device *sysdev)
 {
 	printk("S3C2443: IRQ Support\n");
 
@@ -280,7 +280,7 @@ static struct sysdev_driver s3c2443_irq_
 	.add		= s3c2443_irq_add,
 };
 
-static int s3c2443_irq_init(void)
+static int __init s3c2443_irq_init(void)
 {
 	return sysdev_driver_register(&s3c2443_sysclass, &s3c2443_irq_driver);
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
