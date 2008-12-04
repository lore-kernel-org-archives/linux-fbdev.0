From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] omapfb: Fix argument of blank operation.
Date: Fri,  5 Dec 2008 00:45:55 +0200
Message-ID: <1228430755-4221-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

The blank operation should receive FB_BLANK_POWERDOWN, not
VESA_POWERDOWN.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---

Resending this patch.

The last time it wasn't against HEAD.

 drivers/video/omap/omapfb_main.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 5a5e407..6ac51ec 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -338,7 +338,7 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 
 	omapfb_rqueue_lock(fbdev);
 	switch (blank) {
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANK:
 		if (fbdev->state == OMAPFB_SUSPENDED) {
 			if (fbdev->ctrl->resume)
 				fbdev->ctrl->resume();
@@ -349,7 +349,7 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 				do_update = 1;
 		}
 		break;
-	case VESA_POWERDOWN:
+	case FB_BLANK_POWERDOWN:
 		if (fbdev->state == OMAPFB_ACTIVE) {
 			fbdev->panel->disable(fbdev->panel);
 			if (fbdev->ctrl->suspend)
@@ -1818,7 +1818,7 @@ static int omapfb_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 
-	omapfb_blank(VESA_POWERDOWN, fbdev->fb_info[0]);
+	omapfb_blank(FB_BLANK_POWERDOWN, fbdev->fb_info[0]);
 
 	return 0;
 }
@@ -1828,7 +1828,7 @@ static int omapfb_resume(struct platform_device *pdev)
 {
 	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 
-	omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info[0]);
+	omapfb_blank(FB_BLANK_UNBLANK, fbdev->fb_info[0]);
 	return 0;
 }
 
-- 
1.6.0.4

