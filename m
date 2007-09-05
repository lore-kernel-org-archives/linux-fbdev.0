From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm3fb: replace busy waiting with
	cpu_relax
Date: Wed, 5 Sep 2007 22:06:10 +0200
Message-ID: <20070905220610.aaa38324.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IT12R-00023k-II for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Sep 2007 12:59:47 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IT12Q-0007hb-Bi
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Sep 2007 12:59:47 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 5 Sep 2007 21:59:43 +0200
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

This patch replaces busy waiting with the cpu_relax() call.
This makes scrolling faster.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This patch is done against 2.6.23-rc4-mm1 tree.

--- linux-2.6.22/drivers/video/pm3fb.c	2007-09-05 21:57:21.972390495 +0200
+++ linux-2.6.23-mm/drivers/video/pm3fb.c	2007-09-05 21:57:34.101081669 +0200
@@ -110,7 +110,8 @@ static inline void PM3_WRITE_REG(struct 
 
 static inline void PM3_WAIT(struct pm3_par *par, u32 n)
 {
-	while (PM3_READ_REG(par, PM3InFIFOSpace) < n);
+	while (PM3_READ_REG(par, PM3InFIFOSpace) < n)
+		cpu_relax();
 }
 
 static inline void PM3_WRITE_DAC_REG(struct pm3_par *par, unsigned r, u8 v)
@@ -209,8 +210,8 @@ static int pm3fb_sync(struct fb_info *in
 	PM3_WRITE_REG(par, PM3Sync, 0);
 	mb();
 	do {
-		while ((PM3_READ_REG(par, PM3OutFIFOWords)) == 0);
-		rmb();
+		while ((PM3_READ_REG(par, PM3OutFIFOWords)) == 0)
+			cpu_relax();
 	} while ((PM3_READ_REG(par, PM3OutputFifo)) != PM3Sync_Tag);
 
 	return 0;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
