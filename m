From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:49 +0000
Subject: [PATCH 21/23] OMAPDSS: make a two dss feat funcs internal to omapdss
Message-Id: <1449676791-26304-22-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

dss_feat_get_supported_displays() and dss_feat_get_supported_outputs()
are not used outside omapdss, but are exported. We can thus remove the
export and move the declarations to the omapdss internal header.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss_features.c | 2 --
 drivers/video/fbdev/omap2/dss/dss_features.h | 4 ++++
 include/video/omapdss.h                      | 2 --
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss_features.c b/drivers/video/fbdev/omap2/dss/dss_features.c
index 48951c5cb352..c886a2927f73 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/dss/dss_features.c
@@ -835,13 +835,11 @@ enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel
 {
 	return omap_current_dss_features->supported_displays[channel];
 }
-EXPORT_SYMBOL(dss_feat_get_supported_displays);
 
 enum omap_dss_output_id dss_feat_get_supported_outputs(enum omap_channel channel)
 {
 	return omap_current_dss_features->supported_outputs[channel];
 }
-EXPORT_SYMBOL(dss_feat_get_supported_outputs);
 
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane)
 {
diff --git a/drivers/video/fbdev/omap2/dss/dss_features.h b/drivers/video/fbdev/omap2/dss/dss_features.h
index 0e75927339c7..3d67d39f192f 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.h
+++ b/drivers/video/fbdev/omap2/dss/dss_features.h
@@ -101,4 +101,8 @@ bool dss_feat_rotation_type_supported(enum omap_dss_rotation_type rot_type);
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
 void dss_features_init(enum omapdss_version version);
+
+enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
+enum omap_dss_output_id dss_feat_get_supported_outputs(enum omap_channel channel);
+
 #endif
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 0fedd93a639d..bbf942ebdd28 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -867,8 +867,6 @@ void omap_video_timings_to_videomode(const struct omap_video_timings *ovt,
 
 int dss_feat_get_num_mgrs(void);
 int dss_feat_get_num_ovls(void);
-enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
-enum omap_dss_output_id dss_feat_get_supported_outputs(enum omap_channel channel);
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
 
 
-- 
2.5.0

