From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 12 May 2011 11:40:08 +0000
Subject: [PATCHv2 3/8] OMAP: DSS2: RFBI: add rfbi_bus_lock
Message-Id: <1305200413-23697-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add similar bus lock to RFBI as is in DSI. The panel driver can use the
bus lock to mark that the RFBI bus is currently in use.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/rfbi.c |   16 ++++++++++++++++
 include/video/omapdss.h        |    2 ++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 0985f2f..46817e7 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -32,6 +32,7 @@
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
 #include <linux/seq_file.h>
+#include <linux/semaphore.h>
 
 #include <video/omapdss.h>
 #include "dss.h"
@@ -119,6 +120,8 @@ static struct {
 	struct completion cmd_done;
 	atomic_t          cmd_fifo_full;
 	atomic_t          cmd_pending;
+
+	struct semaphore bus_lock;
 } rfbi;
 
 struct update_region {
@@ -146,6 +149,18 @@ static void rfbi_enable_clocks(bool enable)
 		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 }
 
+void rfbi_bus_lock(void)
+{
+	down(&rfbi.bus_lock);
+}
+EXPORT_SYMBOL(rfbi_bus_lock);
+
+void rfbi_bus_unlock(void)
+{
+	up(&rfbi.bus_lock);
+}
+EXPORT_SYMBOL(rfbi_bus_unlock);
+
 void omap_rfbi_write_command(const void *buf, u32 len)
 {
 	rfbi_enable_clocks(1);
@@ -1022,6 +1037,7 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 	rfbi.pdev = pdev;
 
 	spin_lock_init(&rfbi.cmd_lock);
+	sema_init(&rfbi.bus_lock, 1);
 
 	init_completion(&rfbi.cmd_done);
 	atomic_set(&rfbi.cmd_fifo_full, 0);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ab7d656..1ea151e 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -212,6 +212,8 @@ int omap_rfbi_enable_te(bool enable, unsigned line);
 int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
 			     unsigned hs_pulse_time, unsigned vs_pulse_time,
 			     int hs_pol_inv, int vs_pol_inv, int extif_div);
+void rfbi_bus_lock(void);
+void rfbi_bus_unlock(void);
 
 /* DSI */
 void dsi_bus_lock(void);
-- 
1.7.4.1

