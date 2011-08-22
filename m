From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 08:27:45 +0000
Subject: [PATCH 04/10] OMAP: DSS2: Add GLOBAL_ALPHA & PRE_MULT_ALPHA to ovl caps
Message-Id: <1314001671-18123-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add OMAP_DSS_OVL_CAP_GLOBAL_ALPHA and OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA to
overlay capabilities. Use these instead of FEAT_GLOBAL_ALPHA,
FEAT_GLOBAL_ALPHA_VID1 and FEAT_PRE_MULT_ALPHA in code.

Remove FEAT_GLOBAL_ALPHA_VID1 and FEAT_PRE_MULT_ALPHA which are no
longer used. FEAT_GLOBAL_ALPHA is still used to decide if the HW has
global alpha register.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   13 ++++---------
 drivers/video/omap2/dss/dss_features.c |   27 +++++++++++++++------------
 drivers/video/omap2/dss/dss_features.h |    2 --
 drivers/video/omap2/dss/overlay.c      |   23 ++++++-----------------
 include/video/omapdss.h                |    2 ++
 5 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f7451fe..2cc6237 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -725,11 +725,9 @@ static void _dispc_set_vid_size(enum omap_plane plane, int width, int height)
 
 static void _dispc_set_pre_mult_alpha(enum omap_plane plane, bool enable)
 {
-	if (!dss_has_feature(FEAT_PRE_MULT_ALPHA))
-		return;
+	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 
-	if (!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
-		plane = OMAP_DSS_VIDEO1)
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA) = 0)
 		return;
 
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 28, 28);
@@ -739,12 +737,9 @@ static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 {
 	static const unsigned shifts[] = { 0, 8, 16, };
 	int shift;
+	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 
-	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
-		return;
-
-	if (!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
-		plane = OMAP_DSS_VIDEO1)
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_GLOBAL_ALPHA) = 0)
 		return;
 
 	shift = shifts[plane];
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 6bf508d..b63c5f8 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -225,35 +225,38 @@ static const enum omap_overlay_caps omap2_dss_overlay_caps[] = {
 
 static const enum omap_overlay_caps omap3430_dss_overlay_caps[] = {
 	/* OMAP_DSS_GFX */
-	0,
+	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA,
 
 	/* OMAP_DSS_VIDEO1 */
 	OMAP_DSS_OVL_CAP_SCALE,
 
 	/* OMAP_DSS_VIDEO2 */
-	OMAP_DSS_OVL_CAP_SCALE,
+	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA,
 };
 
 static const enum omap_overlay_caps omap3630_dss_overlay_caps[] = {
 	/* OMAP_DSS_GFX */
-	0,
+	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA | OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA,
 
 	/* OMAP_DSS_VIDEO1 */
 	OMAP_DSS_OVL_CAP_SCALE,
 
 	/* OMAP_DSS_VIDEO2 */
-	OMAP_DSS_OVL_CAP_SCALE,
+	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA |
+		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA,
 };
 
 static const enum omap_overlay_caps omap4_dss_overlay_caps[] = {
 	/* OMAP_DSS_GFX */
-	0,
+	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA | OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA,
 
 	/* OMAP_DSS_VIDEO1 */
-	OMAP_DSS_OVL_CAP_SCALE,
+	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA |
+		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA,
 
 	/* OMAP_DSS_VIDEO2 */
-	OMAP_DSS_OVL_CAP_SCALE,
+	OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA |
+		OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA,
 };
 
 static const char * const omap2_dss_clk_source_names[] = {
@@ -359,7 +362,7 @@ static const struct omap_dss_features omap3630_dss_features = {
 	.has_feature     		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
-		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED |
+		FEAT_FUNCGATED |
 		FEAT_ROWREPEATENABLE | FEAT_LINEBUFFERSPLIT |
 		FEAT_RESIZECONF | FEAT_DSI_PLL_PWR_BUG |
 		FEAT_DSI_PLL_FREQSEL | FEAT_CPR | FEAT_PRELOAD |
@@ -383,8 +386,8 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
 
 	.has_feature	-		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
-		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1 |
+		FEAT_GLOBAL_ALPHA |
+		FEAT_MGR_LCD2 |
 		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
 		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
 		FEAT_DSI_GNQ | FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2 |
@@ -407,8 +410,8 @@ static const struct omap_dss_features omap4_dss_features = {
 	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
 
 	.has_feature	-		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
-		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1 |
+		FEAT_GLOBAL_ALPHA |
+		FEAT_MGR_LCD2 |
 		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
 		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
 		FEAT_DSI_GNQ | FEAT_HDMI_CTS_SWMODE |
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index fd09196..4271e96 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -28,8 +28,6 @@
 /* DSS has feature id */
 enum dss_feat_id {
 	FEAT_GLOBAL_ALPHA		= 1 << 0,
-	FEAT_GLOBAL_ALPHA_VID1		= 1 << 1,
-	FEAT_PRE_MULT_ALPHA		= 1 << 2,
 	FEAT_LCDENABLEPOL		= 1 << 3,
 	FEAT_LCDENABLESIGNAL		= 1 << 4,
 	FEAT_PCKFREEENABLE		= 1 << 5,
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 8cbc1ae..a95f25e 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -248,7 +248,7 @@ static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
 	u8 alpha;
 	struct omap_overlay_info info;
 
-	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_GLOBAL_ALPHA) = 0)
 		return -ENODEV;
 
 	r = kstrtou8(buf, 0, &alpha);
@@ -257,14 +257,7 @@ static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
 
 	ovl->get_overlay_info(ovl, &info);
 
-	/* Video1 plane does not support global alpha
-	 * to always make it 255 completely opaque
-	 */
-	if (!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
-			ovl->id = OMAP_DSS_VIDEO1)
-		info.global_alpha = 255;
-	else
-		info.global_alpha = alpha;
+	info.global_alpha = alpha;
 
 	r = ovl->set_overlay_info(ovl, &info);
 	if (r)
@@ -293,20 +286,16 @@ static ssize_t overlay_pre_mult_alpha_store(struct omap_overlay *ovl,
 	u8 alpha;
 	struct omap_overlay_info info;
 
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA) = 0)
+		return -ENODEV;
+
 	r = kstrtou8(buf, 0, &alpha);
 	if (r)
 		return r;
 
 	ovl->get_overlay_info(ovl, &info);
 
-	/* only GFX and Video2 plane support pre alpha multiplied
-	 * set zero for Video1 plane
-	 */
-	if (!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
-		ovl->id = OMAP_DSS_VIDEO1)
-		info.pre_mult_alpha = 0;
-	else
-		info.pre_mult_alpha = alpha;
+	info.pre_mult_alpha = alpha;
 
 	r = ovl->set_overlay_info(ovl, &info);
 	if (r)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 5721de8..b6b9a4a 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -162,6 +162,8 @@ enum omap_dss_rotation_angle {
 
 enum omap_overlay_caps {
 	OMAP_DSS_OVL_CAP_SCALE = 1 << 0,
+	OMAP_DSS_OVL_CAP_GLOBAL_ALPHA = 1 << 1,
+	OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA = 1 << 2,
 };
 
 enum omap_overlay_manager_caps {
-- 
1.7.4.1

