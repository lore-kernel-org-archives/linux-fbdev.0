From: Archit Taneja <archit@ti.com>
Date: Thu, 28 Jun 2012 14:42:32 +0000
Subject: [PATCH 02/12] OMAPDSS: Add struct to hold LCD overlay manager configuration
Message-Id: <1340893842-10626-4-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a struct dss_lcd_mgr_config which holds LCD overlay manager related
parameters. These are currently partially contained in the omap_dss_device
connected to the manager, and the rest are in the interface driver.

The parameters are directly written to the DISPC registers in the interface
drivers. These should eventually be applied at the correct time using the
shadow register programming model. This struct would help in grouping these
parameters so that they can be applied together.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f8289e9..6688eaf 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -152,6 +152,19 @@ struct dsi_clock_info {
 	u16 lp_clk_div;
 };
 
+struct dss_lcd_mgr_config {
+	enum dss_io_pad_mode io_pad_mode;
+
+	bool stallmode;
+	bool fifohandcheck;
+
+	struct dispc_clock_info clock_info;
+
+	int video_port_width;
+
+	int lcden_sig_polarity;
+};
+
 struct seq_file;
 struct platform_device;
 
-- 
1.7.9.5

