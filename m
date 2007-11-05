From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] Fix incorrect usage of strncat in
	aty128_init(); drivers/video/aty/aty128fb.c
Date: Mon, 05 Nov 2007 21:53:23 +0100
Message-ID: <472F82C3.3080705@tiscali.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ip8wv-0007WO-KQ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 12:53:33 -0800
Received: from smtp-out0.tiscali.nl ([195.241.79.175])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ip8wu-0006Z8-9w
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 12:53:33 -0800
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out0.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1Ip8wn-0004eI-Dp for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 05 Nov 2007 21:53:25 +0100
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

Fix incorrect length for strncat by replacing it with strlcat

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index cbd3308..27faffd 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -1885,7 +1885,7 @@ static int __devinit aty128_init(struct pci_dev *pdev, const struct pci_device_i
 
 	/* range check to make sure */
 	if (ent->driver_data < ARRAY_SIZE(r128_family))
-	    strncat(video_card, r128_family[ent->driver_data], sizeof(video_card));
+	    strlcat(video_card, r128_family[ent->driver_data], sizeof(video_card));
 
 	printk(KERN_INFO "aty128fb: %s [chip rev 0x%x] ", video_card, chip_rev);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
