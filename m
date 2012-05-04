From: Grazvydas Ignotas <notasas@gmail.com>
Date: Fri, 04 May 2012 15:16:21 +0000
Subject: [PATCH] OMAPDSS: OMAPFB: always allow to configure overlay
Message-Id: <1336144581-25151-1-git-send-email-notasas@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Currently when multiple overlays are active, OMAPFB_SETUP_PLANE fails.
Instead of failing, allow it to configure the first overlay as if there
was only one overlay, the remaining ones will have to be configured in
other ways (sysfs).

This allows overlay-controlling programs (like video players) to function
properly when framebuffer is cloned to another display (like TV).

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   36 ++++++++++------------------
 1 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 6a09ef8..58b7f2d 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -70,11 +70,6 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 
 	DBG("omapfb_setup_plane\n");
 
-	if (ofbi->num_overlays != 1) {
-		r = -EINVAL;
-		goto out;
-	}
-
 	/* XXX uses only the first overlay */
 	ovl = ofbi->overlays[0];
 
@@ -184,25 +179,20 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 static int omapfb_query_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omap_overlay *ovl;
+	struct omap_overlay_info ovli;
 
-	if (ofbi->num_overlays != 1) {
-		memset(pi, 0, sizeof(*pi));
-	} else {
-		struct omap_overlay *ovl;
-		struct omap_overlay_info ovli;
-
-		ovl = ofbi->overlays[0];
-		ovl->get_overlay_info(ovl, &ovli);
-
-		pi->pos_x = ovli.pos_x;
-		pi->pos_y = ovli.pos_y;
-		pi->enabled = ovl->is_enabled(ovl);
-		pi->channel_out = 0; /* xxx */
-		pi->mirror = 0;
-		pi->mem_idx = get_mem_idx(ofbi);
-		pi->out_width = ovli.out_width;
-		pi->out_height = ovli.out_height;
-	}
+	ovl = ofbi->overlays[0];
+	ovl->get_overlay_info(ovl, &ovli);
+
+	pi->pos_x = ovli.pos_x;
+	pi->pos_y = ovli.pos_y;
+	pi->enabled = ovl->is_enabled(ovl);
+	pi->channel_out = 0; /* xxx */
+	pi->mirror = 0;
+	pi->mem_idx = get_mem_idx(ofbi);
+	pi->out_width = ovli.out_width;
+	pi->out_height = ovli.out_height;
 
 	return 0;
 }
-- 
1.7.0.4

