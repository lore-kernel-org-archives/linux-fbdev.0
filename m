From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH 6/7] uvesafb: use the default refresh
	rate if the monitor	limits are not set
Date: Sat, 11 Aug 2007 16:42:32 +0200
Message-ID: <20070811144232.GG13632@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJsB7-0005hk-1r for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Aug 2007 07:42:57 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148] helo=spock.one.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IJsB6-0004yK-Ez
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Aug 2007 07:42:56 -0700
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
Cc: linux-kernel@vger.kernel.org

Use the default refresh rate if the monitor limits aren't set (either using
data from the EDID block, or explicitly by the user).

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 2f1e5af..2e5f1b5 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -689,10 +689,13 @@ static void __devinit uvesafb_vbe_getmonspecs(struct uvesafb_ktask *task,
 
 	/*
 	 * If we don't get all necessary data from the EDID block,
-	 * mark it as incompatible with the GTF.
+	 * mark it as incompatible with the GTF and set nocrtc so
+	 * that we always use the default BIOS refresh rate.
 	 */
-	if (uvesafb_vbe_getedid(task, info))
+	if (uvesafb_vbe_getedid(task, info)) {
 		info->monspecs.gtf = 0;
+		par->nocrtc = 1;
+	}
 
 	/* Kernel command line overrides. */
 	if (maxclk)
@@ -711,6 +714,7 @@ static void __devinit uvesafb_vbe_getmonspecs(struct uvesafb_ktask *task,
 		info->monspecs.vfmin = 60;
 		info->monspecs.hfmin = 29000;
 		info->monspecs.gtf = 1;
+		par->nocrtc = 0;
 	}
 
 	if (info->monspecs.gtf)
@@ -720,7 +724,8 @@ static void __devinit uvesafb_vbe_getmonspecs(struct uvesafb_ktask *task,
 			(int)(info->monspecs.hfmax / 1000),
 			(int)(info->monspecs.dclkmax / 1000000));
 	else
-		printk(KERN_INFO "uvesafb: no monitor limits have been set\n");
+		printk(KERN_INFO "uvesafb: no monitor limits have been set, "
+				 "default refresh rate will be used\n");
 
 	/* Add VBE modes to the modelist. */
 	for (i = 0; i < par->vbe_modes_cnt; i++) {



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
