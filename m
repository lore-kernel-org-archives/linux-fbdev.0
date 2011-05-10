From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2011 16:24:15 +0000
Subject: [PATCH 7/8] OMAP: DSS2: OMAPFB: remove dead code
Message-Id: <1305044656-31512-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove old unused code lying inside #if 0.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   29 -----------------------------
 1 files changed, 0 insertions(+), 29 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 1f9cb3a..30c958b 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -757,35 +757,6 @@ static int omapfb_open(struct fb_info *fbi, int user)
 
 static int omapfb_release(struct fb_info *fbi, int user)
 {
-#if 0
-	struct omapfb_info *ofbi = FB2OFB(fbi);
-	struct omapfb2_device *fbdev = ofbi->fbdev;
-	struct omap_dss_device *display = fb2display(fbi);
-
-	DBG("Closing fb with plane index %d\n", ofbi->id);
-
-	omapfb_lock(fbdev);
-
-	if (display && display->get_update_mode && display->update) {
-		/* XXX this update should be removed, I think. But it's
-		 * good for debugging */
-		if (display->get_update_mode(display) =
-				OMAP_DSS_UPDATE_MANUAL) {
-			u16 w, h;
-
-			if (display->sync)
-				display->sync(display);
-
-			display->get_resolution(display, &w, &h);
-			display->update(display, 0, 0, w, h);
-		}
-	}
-
-	if (display && display->sync)
-		display->sync(display);
-
-	omapfb_unlock(fbdev);
-#endif
 	return 0;
 }
 
-- 
1.7.4.1

