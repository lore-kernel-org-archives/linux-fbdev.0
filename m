From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 24 Oct 2012 09:29:03 +0000
Subject: [PATCH 12/20] OMAPDSS: HDMI: use core power on/off with edid & detect
Message-Id: <1351070951-18616-13-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ricardo Neri <ricardo.neri@ti.com>

This patch makes use of the hdmi_power_[on|off]_core() functions added
in the previous patch. The functions are used when reading EDID or
detecting if a monitor is connected.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/dss.h        |    2 ++
 drivers/video/omap2/dss/hdmi.c       |   35 ++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/hdmi_panel.c |    8 ++++----
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8bf9047..2305b80 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -510,6 +510,8 @@ static inline unsigned long hdmi_get_pixel_clock(void)
 #endif
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev);
+int omapdss_hdmi_core_enable(struct omap_dss_device *dssdev);
+void omapdss_hdmi_core_disable(struct omap_dss_device *dssdev);
 void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings);
 int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 50d5a10..b809490 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -759,6 +759,41 @@ void omapdss_hdmi_display_disable(struct omap_dss_device *dssdev)
 	mutex_unlock(&hdmi.lock);
 }
 
+int omapdss_hdmi_core_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	DSSDBG("ENTER omapdss_hdmi_core_enable\n");
+
+	mutex_lock(&hdmi.lock);
+
+	hdmi.ip_data.hpd_gpio = hdmi.hpd_gpio;
+
+	r = hdmi_power_on_core(dssdev);
+	if (r) {
+		DSSERR("failed to power on device\n");
+		goto err0;
+	}
+
+	mutex_unlock(&hdmi.lock);
+	return 0;
+
+err0:
+	mutex_unlock(&hdmi.lock);
+	return r;
+}
+
+void omapdss_hdmi_core_disable(struct omap_dss_device *dssdev)
+{
+	DSSDBG("Enter omapdss_hdmi_core_disable\n");
+
+	mutex_lock(&hdmi.lock);
+
+	hdmi_power_off_core(dssdev);
+
+	mutex_unlock(&hdmi.lock);
+}
+
 static int hdmi_get_clocks(struct platform_device *pdev)
 {
 	struct clk *clk;
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 3f9a4b9..a385b69 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -334,7 +334,7 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 	need_enable = dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
 	if (need_enable) {
-		r = omapdss_hdmi_display_enable(dssdev);
+		r = omapdss_hdmi_core_enable(dssdev);
 		if (r)
 			goto err;
 	}
@@ -342,7 +342,7 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 	r = omapdss_hdmi_read_edid(buf, len);
 
 	if (need_enable)
-		omapdss_hdmi_display_disable(dssdev);
+		omapdss_hdmi_core_disable(dssdev);
 err:
 	mutex_unlock(&hdmi.lock);
 
@@ -359,7 +359,7 @@ static bool hdmi_detect(struct omap_dss_device *dssdev)
 	need_enable = dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
 	if (need_enable) {
-		r = omapdss_hdmi_display_enable(dssdev);
+		r = omapdss_hdmi_core_enable(dssdev);
 		if (r)
 			goto err;
 	}
@@ -367,7 +367,7 @@ static bool hdmi_detect(struct omap_dss_device *dssdev)
 	r = omapdss_hdmi_detect();
 
 	if (need_enable)
-		omapdss_hdmi_display_disable(dssdev);
+		omapdss_hdmi_core_disable(dssdev);
 err:
 	mutex_unlock(&hdmi.lock);
 
-- 
1.7.9.5

