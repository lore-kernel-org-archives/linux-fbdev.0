From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 18 Nov 2013 12:50:07 +0000
Subject: [PATCH 4/6] OMAPDSS: remove dss_get_ctx_loss_count
Message-Id: <1384779009-10512-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAPDSS driver no longer needs dss_get_ctx_loss_count, so it can be
removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |  1 -
 drivers/video/omap2/dss/dss.c | 16 ----------------
 drivers/video/omap2/dss/dss.h |  2 --
 include/video/omapdss.h       |  1 -
 4 files changed, 20 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 03a0516..e6d219c 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -341,7 +341,6 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	board_data->version = ver;
 	board_data->dsi_enable_pads = omap_dsi_enable_pads;
 	board_data->dsi_disable_pads = omap_dsi_disable_pads;
-	board_data->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 	board_data->set_min_bus_tput = omap_dss_set_min_bus_tput;
 
 	omap_display_device.dev.platform_data = board_data;
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index a5f674f..0b78c89 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -116,22 +116,6 @@ static inline u32 dss_read_reg(const struct dss_reg idx)
 	return __raw_readl(dss.base + idx.idx);
 }
 
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
index f538e86..af83c4d 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -233,8 +233,6 @@ void dss_dump_clocks(struct seq_file *s);
 void dss_debug_dump_clocks(struct seq_file *s);
 #endif
 
-int dss_get_ctx_loss_count(void);
-
 void dss_sdi_init(int datapairs);
 int dss_sdi_enable(void);
 void dss_sdi_disable(void);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 3d7c51a..1eb9aa6 100644
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

