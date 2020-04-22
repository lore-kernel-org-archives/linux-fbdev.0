From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 22 Apr 2020 07:19:03 +0000
Subject: [PATCH] omapfb/dss: fix comparison to bool warning
Message-Id: <20200422071903.637-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, afd@ti.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>

Fix the following coccicheck warning:

drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:461:15-32: WARNING:
Comparison to bool
drivers/video/fbdev/omap2/omapfb/dss/dispc.c:891:5-35: WARNING:
Comparison of 0/1 to bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 4a16798b2ecd..3bb951eb29c7 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -888,7 +888,7 @@ static void dispc_ovl_set_color_mode(enum omap_plane plane,
 static void dispc_ovl_configure_burst_type(enum omap_plane plane,
 		enum omap_dss_rotation_type rotation_type)
 {
-	if (dss_has_feature(FEAT_BURST_2D) = 0)
+	if (!dss_has_feature(FEAT_BURST_2D))
 		return;
 
 	if (rotation_type = OMAP_DSS_ROT_TILER)
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
index 7060ae56c062..ef659c89ba58 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
@@ -455,11 +455,9 @@ static void hdmi_disconnect(struct omap_dss_device *dssdev,
 static int hdmi_read_edid(struct omap_dss_device *dssdev,
 		u8 *edid, int len)
 {
-	bool need_enable;
+	bool need_enable = !hdmi.core_enabled;
 	int r;
 
-	need_enable = hdmi.core_enabled = false;
-
 	if (need_enable) {
 		r = hdmi_core_enable(dssdev);
 		if (r)
-- 
2.21.1
