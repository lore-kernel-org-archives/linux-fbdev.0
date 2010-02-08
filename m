From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Mon, 08 Feb 2010 15:56:05 +0000
Subject: [PATCH 06/13] OMAP: DSS2: fix irq-stats compilation
Message-Id: <1265644572-3578-7-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-6-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1265644572-3578-6-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Fix compilation of the CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS feature.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/core.c  |    4 +++-
 drivers/video/omap2/dss/dispc.c |    2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 791e1cb..5939da9 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -446,10 +446,12 @@ static int dss_initialize_debugfs(void)
 	debugfs_create_file("clk", S_IRUGO, dss_debugfs_dir,
 			&dss_debug_dump_clocks, &dss_debug_fops);
 
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
 	debugfs_create_file("dispc_irq", S_IRUGO, dss_debugfs_dir,
 			&dispc_dump_irqs, &dss_debug_fops);
+#endif
 
-#ifdef CONFIG_OMAP2_DSS_DSI
+#if defined(CONFIG_OMAP2_DSS_DSI) && defined(CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS)
 	debugfs_create_file("dsi_irq", S_IRUGO, dss_debugfs_dir,
 			&dsi_dump_irqs, &dss_debug_fops);
 #endif
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index de8bfba..7781c65 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2301,8 +2301,6 @@ void dispc_dump_irqs(struct seq_file *s)
 	PIS(WAKEUP);
 #undef PIS
 }
-#else
-void dispc_dump_irqs(struct seq_file *s) { }
 #endif
 
 void dispc_dump_regs(struct seq_file *s)
-- 
1.6.5

