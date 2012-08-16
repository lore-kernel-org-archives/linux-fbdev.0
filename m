From: Archit Taneja <archit@ti.com>
Date: Thu, 16 Aug 2012 07:48:34 +0000
Subject: [PATCH 6/6] OMAPDSS: VENC: Maintian copy of video output polarity in private data
Message-Id: <1345102594-6222-7-git-send-email-archit@ti.com>
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
video output polarity. This makes the VENC interface driver dependent on the
omap_dss_device struct.

Make the VENC driver data maintain it's own polarity field. A panel driver
is expected to call omapdss_venc_set_vid_out_polarity() before enabling the
interface.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h        |    2 ++
 drivers/video/omap2/dss/venc.c       |   13 ++++++++++++-
 drivers/video/omap2/dss/venc_panel.c |    6 ++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index c17d298..b2cf5530 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -479,6 +479,8 @@ u32 omapdss_venc_get_wss(struct omap_dss_device *dssdev);
 int omapdss_venc_set_wss(struct omap_dss_device *dssdev, u32 wss);
 void omapdss_venc_set_type(struct omap_dss_device *dssdev,
 		enum omap_dss_venc_type type);
+void omapdss_venc_set_vid_out_polarity(struct omap_dss_device *dssdev,
+		enum omap_dss_signal_level vid_out_pol);
 int venc_panel_init(void);
 void venc_panel_exit(void);
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 2d90fcf..8cb372f 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -303,6 +303,7 @@ static struct {
 
 	struct omap_video_timings timings;
 	enum omap_dss_venc_type type;
+	enum omap_dss_signal_level vid_out_pol;
 } venc;
 
 static inline void venc_write_reg(int idx, u32 val)
@@ -447,7 +448,7 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 	else /* S-Video */
 		l |= (1 << 0) | (1 << 2);
 
-	if (dssdev->phy.venc.invert_polarity = false)
+	if (venc.vid_out_pol = OMAPDSS_SIG_ACTIVE_HIGH)
 		l |= 1 << 3;
 
 	venc_write_reg(VENC_OUTPUT_CONTROL, l);
@@ -639,6 +640,16 @@ void omapdss_venc_set_type(struct omap_dss_device *dssdev,
 	mutex_unlock(&venc.venc_lock);
 }
 
+void omapdss_venc_set_vid_out_polarity(struct omap_dss_device *dssdev,
+		enum omap_dss_signal_level vid_out_pol)
+{
+	mutex_lock(&venc.venc_lock);
+
+	venc.vid_out_pol = vid_out_pol;
+
+	mutex_unlock(&venc.venc_lock);
+}
+
 static int __init venc_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
diff --git a/drivers/video/omap2/dss/venc_panel.c b/drivers/video/omap2/dss/venc_panel.c
index ef21361..a8117d0 100644
--- a/drivers/video/omap2/dss/venc_panel.c
+++ b/drivers/video/omap2/dss/venc_panel.c
@@ -118,6 +118,7 @@ static void venc_panel_remove(struct omap_dss_device *dssdev)
 static int venc_panel_enable(struct omap_dss_device *dssdev)
 {
 	int r;
+	enum omap_dss_signal_level vid_out_pol;
 
 	dev_dbg(&dssdev->dev, "venc_panel_enable\n");
 
@@ -131,6 +132,11 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 	omapdss_venc_set_timings(dssdev, &dssdev->panel.timings);
 	omapdss_venc_set_type(dssdev, dssdev->phy.venc.type);
 
+	vid_out_pol = dssdev->phy.venc.invert_polarity ?
+			OMAPDSS_SIG_ACTIVE_LOW : OMAPDSS_SIG_ACTIVE_HIGH;
+
+	omapdss_venc_set_vid_out_polarity(dssdev, vid_out_pol);
+
 	r = omapdss_venc_display_enable(dssdev);
 	if (r)
 		goto err;
-- 
1.7.9.5

