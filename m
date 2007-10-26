From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] Fix priority mistakes in
	drivers/video/i810/i810_main.c
Date: Sat, 27 Oct 2007 00:32:42 +0200
Message-ID: <47226B0A.7090305@tiscali.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IlXjV-0001HA-KZ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 15:32:49 -0700
Received: from smtp-out2.tiscali.nl ([195.241.79.177])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IlXjU-0000XI-2I
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 15:32:49 -0700
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out2.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IlXjR-0002vW-SV for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 27 Oct 2007 00:32:45 +0200
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

Fixes priority mistakes similar to '!x & y'
    
Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 1a7d778..1d13dd0 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -1476,7 +1476,7 @@ static int i810fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	struct i810fb_par *par = info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 
-	if (!par->dev_flags & LOCKUP)
+	if (!(par->dev_flags & LOCKUP))
 		return -ENXIO;
 
 	if (cursor->image.width > 64 || cursor->image.height > 64)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
