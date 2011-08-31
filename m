From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 31 Aug 2011 13:21:46 +0000
Subject: [PATCH 6/8] OMAP: DSS2: add dss_get_hdmi_venc_clk_source()
Message-Id: <1314796908-17354-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add dss_get_hdmi_venc_clk_source(), which can be used to get the value
programmed with dss_select_hdmi_venc_clk_source(). This can be used to
find out if the digit output is going to VENC or HDMI.

For OMAP2/3 dss_get_hdmi_venc_clk_source() always returns
DSS_VENC_TV_CLK.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   11 +++++++++++
 drivers/video/omap2/dss/dss.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 356d3c1..3e09726 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -639,6 +639,17 @@ void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select hdmi)
 	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* VENC_HDMI_SWITCH */
 }
 
+enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void)
+{
+	enum omap_display_type displays;
+
+	displays = dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_DIGIT);
+	if ((displays & OMAP_DISPLAY_TYPE_HDMI) = 0)
+		return DSS_VENC_TV_CLK;
+
+	return REG_GET(DSS_CONTROL, 15, 15);
+}
+
 static int dss_get_clocks(void)
 {
 	struct clk *clk;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a095a62..57b1a01 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -210,6 +210,7 @@ int dss_runtime_get(void);
 void dss_runtime_put(void);
 
 void dss_select_hdmi_venc_clk_source(enum dss_hdmi_venc_clk_source_select);
+enum dss_hdmi_venc_clk_source_select dss_get_hdmi_venc_clk_source(void);
 const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
-- 
1.7.4.1

