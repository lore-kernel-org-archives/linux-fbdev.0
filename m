From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] cg6: fix memory size detection
Date: Thu, 2 Aug 2007 01:11:33 +0200
Message-ID: <20070802011133.7b78fb84.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGNID-0001dx-Ja for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 16:07:49 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IGNIC-0006GQ-3e
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 16:07:49 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 2 Aug 2007 01:07:43 +0200
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
Cc: David Miller <davem@davemloft.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes memory size detection on the CG6 card. 
The 1MB TGX card has dblbuf property set to 0.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This patch requires the cg6-cleanup patch posted earlier to apply cleanly.

--- linux-2.6.23smp/drivers/video/cg6.c	2007-08-02 00:24:06.000000000 +0200
+++ linux-2.6.23/drivers/video/cg6.c	2007-08-02 00:27:34.000000000 +0200
@@ -669,6 +669,7 @@ static int __devinit cg6_probe(struct of
 	struct fb_info *info;
 	struct cg6_par *par;
 	int linebytes, err;
+	int dblbuf;
 
 	info = framebuffer_alloc(sizeof(struct cg6_par), &op->dev);
 
@@ -690,7 +691,9 @@ static int __devinit cg6_probe(struct of
 	linebytes = of_getintprop_default(dp, "linebytes",
 					  info->var.xres);
 	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
-	if (of_find_property(dp, "dblbuf", NULL))
+
+	dblbuf = of_getintprop_default(dp, "dblbuf", 0);
+	if (dblbuf)
 		par->fbsize *= 4;
 
 	par->fbc = of_ioremap(&op->resource[0], CG6_FBC_OFFSET,

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
