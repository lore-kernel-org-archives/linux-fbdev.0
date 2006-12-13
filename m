From: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] update to
	fbdev-update-after-backlight-argument-change.patch
Date: Wed, 13 Dec 2006 15:04:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0612131502390.4484@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GuVf8-0007GT-9Y for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 07:04:50 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GuVf7-0001ZH-LG
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 07:04:50 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


This patch contained code that needs to be in another patch. Please update 
this patch.

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 3feddf8..2e976ff 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -1834,7 +1834,7 @@ static void aty128_bl_init(struct aty128fb_par *par)
 
 	snprintf(name, sizeof(name), "aty128bl%d", info->node);
 
-	bd = backlight_device_register(name, par, &aty128_bl_data);
+	bd = backlight_device_register(name, info->dev, par, &aty128_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "aty128: Backlight registration failed\n");
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 176f9b8..96d41c9 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2215,7 +2215,7 @@ static void aty_bl_init(struct atyfb_par *par)
 
 	snprintf(name, sizeof(name), "atybl%d", info->node);
 
-	bd = backlight_device_register(name, par, &aty_bl_data);
+	bd = backlight_device_register(name, info->dev, par, &aty_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "aty: Backlight registration failed\n");
diff --git a/drivers/video/aty/radeon_backlight.c b/drivers/video/aty/radeon_backlight.c
index 585eb7b..3abfd4a 100644
--- a/drivers/video/aty/radeon_backlight.c
+++ b/drivers/video/aty/radeon_backlight.c
@@ -163,7 +163,7 @@ void radeonfb_bl_init(struct radeonfb_info *rinfo)
 
 	snprintf(name, sizeof(name), "radeonbl%d", rinfo->info->node);
 
-	bd = backlight_device_register(name, pdata, &radeon_bl_data);
+	bd = backlight_device_register(name, rinfo->info->dev, pdata, &radeon_bl_data);
 	if (IS_ERR(bd)) {
 		rinfo->info->bl_dev = NULL;
 		printk("radeonfb: Backlight registration failed\n");
diff --git a/drivers/video/nvidia/nv_backlight.c b/drivers/video/nvidia/nv_backlight.c
index 5b75ae4..df934bd 100644
--- a/drivers/video/nvidia/nv_backlight.c
+++ b/drivers/video/nvidia/nv_backlight.c
@@ -141,7 +141,7 @@ void nvidia_bl_init(struct nvidia_par *par)
 
 	snprintf(name, sizeof(name), "nvidiabl%d", info->node);
 
-	bd = backlight_device_register(name, par, &nvidia_bl_data);
+	bd = backlight_device_register(name, info->dev, par, &nvidia_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "nvidia: Backlight registration failed\n");
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 345e8b1..1a13966 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -384,7 +384,7 @@ static void riva_bl_init(struct riva_par *par)
 
 	snprintf(name, sizeof(name), "rivabl%d", info->node);
 
-	bd = backlight_device_register(name, par, &riva_bl_data);
+	bd = backlight_device_register(name, info->dev, par, &riva_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "riva: Backlight registration failed\n");

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
