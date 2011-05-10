From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2011 16:24:09 +0000
Subject: [PATCH 1/8] OMAP: DSS2: Add missing dummy functions
Message-Id: <1305044656-31512-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dpi.c does not compile if DSI is not compiled in. Add the missing dummy
functions so that dpi.c compiles.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index eea5c7d..f659cfb 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -313,6 +313,27 @@ static inline unsigned long dsi_get_pll_hsdiv_dispc_rate(void)
 	WARN("%s: DSI not compiled in, returning rate as 0\n", __func__);
 	return 0;
 }
+static inline int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
+{
+	WARN("%s: DSI not compiled in\n", __func__);
+	return -ENODEV;
+}
+static inline int dsi_pll_calc_clock_div_pck(bool is_tft, unsigned long req_pck,
+		struct dsi_clock_info *cinfo,
+		struct dispc_clock_info *dispc_cinfo)
+{
+	WARN("%s: DSI not compiled in\n", __func__);
+	return -ENODEV;
+}
+static inline int dsi_pll_init(struct omap_dss_device *dssdev,
+		bool enable_hsclk, bool enable_hsdiv)
+{
+	WARN("%s: DSI not compiled in\n", __func__);
+	return -ENODEV;
+}
+static inline void dsi_pll_uninit(bool disconnect_lanes)
+{
+}
 static inline void dsi_wait_pll_hsdiv_dispc_active(void)
 {
 }
-- 
1.7.4.1

