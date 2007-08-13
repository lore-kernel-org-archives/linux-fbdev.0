From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 21/22] uvesafb: use the default refresh
 rate if the monitor limits are not set
Date: Mon, 13 Aug 2007 20:43:41 +0800
Message-ID: <46C051FD.8080704@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKdGH-0003RV-Ok for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 09:59:25 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZLR-0005O6-SS
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:48:31 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:48:29 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Januszewski <spock@gentoo.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Michal Januszewski <spock@gentoo.org>

Use the default refresh rate if the monitor limits aren't set (either using
data from the EDID block, or explicitly by the user).

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/uvesafb.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 2f1e5af..2e5f1b5 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -689,10 +689,13 @@ static void __devinit uvesafb_vbe_getmon
 
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
@@ -711,6 +714,7 @@ static void __devinit uvesafb_vbe_getmon
 		info->monspecs.vfmin = 60;
 		info->monspecs.hfmin = 29000;
 		info->monspecs.gtf = 1;
+		par->nocrtc = 0;
 	}
 
 	if (info->monspecs.gtf)
@@ -720,7 +724,8 @@ static void __devinit uvesafb_vbe_getmon
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
