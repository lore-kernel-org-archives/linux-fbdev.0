From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 14 Feb 2014 08:29:32 +0000
Subject: [PATCH 2/2] OMAPDSS: Remove unused get_context_loss_count support
Message-Id: <1392366572-31729-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392366572-31729-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1392366572-31729-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The omapdss driver no longer uses get_context_loss_count call, so we can
remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |  1 -
 drivers/video/omap2/dss/dss.c | 16 ----------------
 drivers/video/omap2/dss/dss.h |  2 --
 include/video/omapdss.h       |  1 -
 4 files changed, 20 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 4cf165502b35..93ebb4007ea9 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -301,7 +301,6 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	board_data->version = ver;
 	board_data->dsi_enable_pads = omap_dsi_enable_pads;
 	board_data->dsi_disable_pads = omap_dsi_disable_pads;
-	board_data->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 	board_data->set_min_bus_tput = omap_dss_set_min_bus_tput;
 
 	omap_display_device.dev.platform_data = board_data;
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 9a145da35ad3..96e400c51001 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -154,22 +154,6 @@ static void dss_restore_context(void)
 #undef SR
 #undef RR
 
-int dss_get_ctx_loss_count(void)
-{
-	struct platform_device *core_pdev = dss_get_core_pdev();
-	struct omap_dss_board_info *board_data = core_pdev->dev.platform_data;
-	int cnt;
-
-	if (!board_data->get_context_loss_count)
-		return -ENOENT;
-
-	cnt = board_data->get_context_loss_count(&dss.pdev->dev);
-
-	WARN_ONCE(cnt < 0, "get_context_loss_count failed: %d\n", cnt);
-
-	return cnt;
-}
-
 void dss_sdi_init(int datapairs)
 {
 	u32 l;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 057f24c8a332..570f7ed2bcbc 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -225,8 +225,6 @@ void dss_dump_clocks(struct seq_file *s);
 void dss_debug_dump_clocks(struct seq_file *s);
 #endif
 
-int dss_get_ctx_loss_count(void);
-
 void dss_sdi_init(int datapairs);
 int dss_sdi_enable(void);
 void dss_sdi_disable(void);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 3d7c51a6f9ff..1eb9aa605eee 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -323,7 +323,6 @@ enum omapdss_version {
 
 /* Board specific data */
 struct omap_dss_board_info {
-	int (*get_context_loss_count)(struct device *dev);
 	int num_devices;
 	struct omap_dss_device **devices;
 	struct omap_dss_device *default_device;
-- 
1.8.3.2

