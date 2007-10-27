From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] Free when fb can't be registered in
	video/aty/atyfb_base.c
Date: Sat, 27 Oct 2007 03:55:54 +0200
Message-ID: <47229AAA.9020907@tiscali.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ilau9-0002qi-TC for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 18:56:02 -0700
Received: from smtp-out2.tiscali.nl ([195.241.79.177])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ilau9-0001Xw-AN
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 18:56:01 -0700
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out2.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1Ilau7-0003hb-4W for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 27 Oct 2007 03:55:59 +0200
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

I am a bit uncertain about this one, but I think a 'free' is required here?
--
Free buffer when the framebuffer can't be registered

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index d775eb6..7ccc78e 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2680,10 +2680,13 @@ static int __devinit aty_init(struct fb_info *info)
 #endif /* CONFIG_FB_ATY_CT */
 	info->var = var;
 
-	fb_alloc_cmap(&info->cmap, 256, 0);
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
+		goto aty_init_exit;
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info) < 0) {
+                fb_dealloc_cmap(&info->cmap);
 		goto aty_init_exit;
+	}
 
 	fb_list = info;
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
