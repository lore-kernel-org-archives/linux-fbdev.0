From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] vesafb: misplaced parentheses
Date: Sun, 15 Feb 2009 18:31:52 +0100
Message-ID: <49985188.1070701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LYkqS-0000SN-7B
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Feb 2009 17:31:56 +0000
Received: from mail-ew0-f15.google.com ([209.85.219.15])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LYkqQ-0008DM-Gj for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Feb 2009 17:31:56 +0000
Received: by ewy8 with SMTP id 8so1647593ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 15 Feb 2009 09:31:52 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: spock@gentoo.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

Fix misplaced parentheses

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index e16322d..d6856f4 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -438,7 +438,7 @@ static int __init vesafb_probe(struct platform_device *dev)
 	info->var = vesafb_defined;
 	info->fix = vesafb_fix;
 	info->flags = FBINFO_FLAG_DEFAULT |
-		(ypan) ? FBINFO_HWACCEL_YPAN : 0;
+		(ypan ? FBINFO_HWACCEL_YPAN : 0);
 
 	if (!ypan)
 		info->fbops->fb_pan_display = NULL;

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
