From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] omapfb: Fix argument of blank operation.
Date: Wed, 26 Nov 2008 22:35:18 +0200
Message-ID: <1227731718-15422-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <felipe.contreras@gmail.com>) id 1L5R6g-0005gw-7n
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Nov 2008 20:35:30 +0000
Received: from fk-out-0910.google.com ([209.85.128.186])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L5R6b-0001SS-IL for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Nov 2008 20:35:30 +0000
Received: by fk-out-0910.google.com with SMTP id 18so576752fkq.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 26 Nov 2008 12:35:23 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

The blank operation should receive FB_BLANK_POWERDOWN, not
VESA_POWERDOWN.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/video/omap/omapfb_main.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 3bb4247..c8db8b2 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -348,7 +348,7 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 
 	omapfb_rqueue_lock(fbdev);
 	switch (blank) {
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANK:
 		if (fbdev->state == OMAPFB_SUSPENDED) {
 			if (fbdev->ctrl->resume)
 				fbdev->ctrl->resume();
@@ -359,7 +359,7 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 				do_update = 1;
 		}
 		break;
-	case VESA_POWERDOWN:
+	case FB_BLANK_POWERDOWN:
 		if (fbdev->state == OMAPFB_ACTIVE) {
 			fbdev->panel->disable(fbdev->panel);
 			if (fbdev->ctrl->suspend)
@@ -1842,7 +1842,7 @@ static int omapfb_suspend(struct platform_device *pdev, pm_message_t mesg)
 	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 
 	if (fbdev != NULL)
-		omapfb_blank(VESA_POWERDOWN, fbdev->fb_info[0]);
+		omapfb_blank(FB_BLANK_POWERDOWN, fbdev->fb_info[0]);
 	return 0;
 }
 
@@ -1852,7 +1852,7 @@ static int omapfb_resume(struct platform_device *pdev)
 	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 
 	if (fbdev != NULL)
-		omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info[0]);
+		omapfb_blank(FB_BLANK_UNBLANK, fbdev->fb_info[0]);
 	return 0;
 }
 
-- 
1.6.0.4


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
