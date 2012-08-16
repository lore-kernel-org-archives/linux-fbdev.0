From: Archit Taneja <archit@ti.com>
Date: Thu, 16 Aug 2012 07:48:33 +0000
Subject: [PATCH 5/6] OMAPDSS: VENC: Maintain copy of venc type in driver data
Message-Id: <1345102594-6222-6-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <343817088-29645-1-git-send-email-archit@ti.com>
 <1345102594-6222-1-git-send-email-archit@ti.com>
In-Reply-To: <1345102594-6222-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The VENC driver currently relies on the omap_dss_device struct to configure the
venc type. This makes the VENC interface driver dependent on the omap_dss_device
struct.

Make the VENC driver data maintain it's own 'venc type' field. A panel driver
is expected to call omapdss_venc_set_type() before enabling the interface or
changing the type via display sysfs attributes.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h        |    2 ++
 drivers/video/omap2/dss/venc.c       |   15 +++++++++++++--
 drivers/video/omap2/dss/venc_panel.c |    2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f919dc8..c17d298 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -477,6 +477,8 @@ int omapdss_venc_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings);
 u32 omapdss_venc_get_wss(struct omap_dss_device *dssdev);
 int omapdss_venc_set_wss(struct omap_dss_device *dssdev, u32 wss);
+void omapdss_venc_set_type(struct omap_dss_device *dssdev,
+		enum omap_dss_venc_type type);
 int venc_panel_init(void);
 void venc_panel_exit(void);
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index d96025e..2d90fcf 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -302,6 +302,7 @@ static struct {
 	struct clk	*tv_dac_clk;
 
 	struct omap_video_timings timings;
+	enum omap_dss_venc_type type;
 } venc;
 
 static inline void venc_write_reg(int idx, u32 val)
@@ -436,12 +437,12 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 	venc_reset();
 	venc_write_config(venc_timings_to_config(&venc.timings));
 
-	dss_set_venc_output(dssdev->phy.venc.type);
+	dss_set_venc_output(venc.type);
 	dss_set_dac_pwrdn_bgz(1);
 
 	l = 0;
 
-	if (dssdev->phy.venc.type = OMAP_DSS_VENC_TYPE_COMPOSITE)
+	if (venc.type = OMAP_DSS_VENC_TYPE_COMPOSITE)
 		l |= 1 << 1;
 	else /* S-Video */
 		l |= (1 << 0) | (1 << 2);
@@ -628,6 +629,16 @@ err:
 	return r;
 }
 
+void omapdss_venc_set_type(struct omap_dss_device *dssdev,
+		enum omap_dss_venc_type type)
+{
+	mutex_lock(&venc.venc_lock);
+
+	venc.type = type;
+
+	mutex_unlock(&venc.venc_lock);
+}
+
 static int __init venc_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
diff --git a/drivers/video/omap2/dss/venc_panel.c b/drivers/video/omap2/dss/venc_panel.c
index 8096369..ef21361 100644
--- a/drivers/video/omap2/dss/venc_panel.c
+++ b/drivers/video/omap2/dss/venc_panel.c
@@ -68,6 +68,7 @@ static ssize_t display_output_type_store(struct device *dev,
 
 	if (dssdev->phy.venc.type != new_type) {
 		dssdev->phy.venc.type = new_type;
+		omapdss_venc_set_type(dssdev, new_type);
 		if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE) {
 			omapdss_venc_display_disable(dssdev);
 			omapdss_venc_display_enable(dssdev);
@@ -128,6 +129,7 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 	}
 
 	omapdss_venc_set_timings(dssdev, &dssdev->panel.timings);
+	omapdss_venc_set_type(dssdev, dssdev->phy.venc.type);
 
 	r = omapdss_venc_display_enable(dssdev);
 	if (r)
-- 
1.7.9.5

