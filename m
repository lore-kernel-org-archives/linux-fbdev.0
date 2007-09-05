From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: replace busy waiting with
	cpu_relax
Date: Wed, 5 Sep 2007 22:04:30 +0200
Message-ID: <20070905220430.2dfc70e9.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IT10s-0001wF-Nh for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Sep 2007 12:58:10 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1IT10s-0007Cc-CY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Sep 2007 12:58:10 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 5 Sep 2007 21:58:06 +0200
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
This makes scrolling 25% faster (!) on Permedia2V and 333MHz CPU.

This patch is done against 2.6.23-rc4-mm1 tree.

--- linux-2.6.22/drivers/video/pm2fb.c	2007-09-05 21:55:45.214876598 +0200
+++ linux-2.6.23-mm/drivers/video/pm2fb.c	2007-09-05 21:57:40.997474673 +0200
@@ -193,8 +193,8 @@ static inline void pm2v_RDAC_WR(struct p
 #else
 static inline void WAIT_FIFO(struct pm2fb_par *p, u32 a)
 {
-	while (pm2_RD(p, PM2R_IN_FIFO_SPACE) < a);
-	mb();
+	while (pm2_RD(p, PM2R_IN_FIFO_SPACE) < a)
+		cpu_relax();
 }
 #endif
 
@@ -328,7 +328,7 @@ static void reset_card(struct pm2fb_par 
 	pm2_WR(p, PM2R_RESET_STATUS, 0);
 	mb();
 	while (pm2_RD(p, PM2R_RESET_STATUS) & PM2F_BEING_RESET)
-		;
+		cpu_relax();
 	mb();
 #ifdef CONFIG_FB_PM2_FIFO_DISCONNECT
 	DPRINTK("FIFO disconnect enabled\n");
@@ -1041,8 +1041,7 @@ static int pm2fb_sync(struct fb_info *in
 	mb();
 	do {
 		while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0)
-			udelay(10);
-		rmb();
+			cpu_relax();
 	} while (pm2_RD(par, PM2R_OUT_FIFO) != PM2TAG(PM2R_SYNC));
 
 	return 0;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
