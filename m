From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] pm2fb: corrects error values returned
	from probe function
Date: Wed, 31 Oct 2007 21:58:03 +0100
Message-ID: <20071031215803.f3736d6f.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InKTU-00022u-LL for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 13:47:40 -0700
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1InKTR-0005HC-V3
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Oct 2007 13:47:40 -0700
Received: from poczta.interia.pl (mi01.poczta.interia.pl [10.217.12.1])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 5E6F2431D31
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 31 Oct 2007 21:47:34 +0100 (CET)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 3C138769BA9
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 31 Oct 2007 21:47:34 +0100 (CET)
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

This patch fixes error values returned in some code branches
in the pm2fb_probe() function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch was done against the 2.6.24-rc1-git4 kernel.

diff -urp linux-ref/drivers/video/pm2fb.c linux-2.6.23/drivers/video/pm2fb.c
--- linux-ref/drivers/video/pm2fb.c	2007-10-28 08:31:16.883366340 +0100
+++ linux-2.6.23/drivers/video/pm2fb.c	2007-10-30 22:40:48.152286777 +0100
@@ -1684,10 +1684,12 @@ static int __devinit pm2fb_probe(struct 
 	if (!err || err == 4)
 		info->var = pm2fb_var;
 
-	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+	retval = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (retval < 0)
 		goto err_exit_both;
 
-	if (register_framebuffer(info) < 0)
+	retval = register_framebuffer(info);
+	if (retval < 0)
 		goto err_exit_all;
 
 	printk(KERN_INFO "fb%d: %s frame buffer device, memory = %dK.\n",


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
