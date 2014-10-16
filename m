From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 16 Oct 2014 09:39:46 +0000
Subject: [PATCH 4/5] OMAPFB: fix overlay disable when freeing resources.
Message-Id: <1413452387-25452-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

When omapfb is shutting down, it will disable all the overlays. However,
instead of actually disabling all the overlays, it disables only all the
overlays that are currently attached to framebuffers.

On OMAP4+, this leaves the fourth overlay left enabled.

Fix the loop so that we actually go through all the overlays.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index 9cbf1ced51c2..36ffb525be73 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -1833,14 +1833,10 @@ static void omapfb_free_resources(struct omapfb2_device *fbdev)
 	if (fbdev = NULL)
 		return;
 
-	for (i = 0; i < fbdev->num_fbs; i++) {
-		struct omapfb_info *ofbi = FB2OFB(fbdev->fbs[i]);
-		int j;
+	for (i = 0; i < fbdev->num_overlays; i++) {
+		struct omap_overlay *ovl = fbdev->overlays[i];
 
-		for (j = 0; j < ofbi->num_overlays; j++) {
-			struct omap_overlay *ovl = ofbi->overlays[j];
-			ovl->disable(ovl);
-		}
+		ovl->disable(ovl);
 	}
 
 	for (i = 0; i < fbdev->num_fbs; i++)
-- 
2.1.1

