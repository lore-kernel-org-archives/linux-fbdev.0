From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 08 Mar 2013 11:51:41 +0000
Subject: [PATCH 06/20] OMAPDSS: APPLY: remove dssdev from dss_mgr_wait_for_vsync
Message-Id: <1362743515-10152-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_mgr_wait_for_vsync() uses dssdev->type to find out if the output is
going to VENC, HDMI, or something else. This creates a dependency on
dssdev, which we want to remove. The task is more logically done by
looking at the output to which the overlay manager in question is
connected to.

This patch changes the code to use output->id to find out which kind of
output we use.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index d446bdf..a4b356a 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -435,20 +435,27 @@ static inline struct omap_dss_device *dss_mgr_get_device(struct omap_overlay_man
 static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
-	struct omap_dss_device *dssdev = mgr->get_device(mgr);
 	u32 irq;
 	int r;
 
+	if (mgr->output = NULL)
+		return -ENODEV;
+
 	r = dispc_runtime_get();
 	if (r)
 		return r;
 
-	if (dssdev->type = OMAP_DISPLAY_TYPE_VENC)
+	switch (mgr->output->id) {
+	case OMAP_DSS_OUTPUT_VENC:
 		irq = DISPC_IRQ_EVSYNC_ODD;
-	else if (dssdev->type = OMAP_DISPLAY_TYPE_HDMI)
+		break;
+	case OMAP_DSS_OUTPUT_HDMI:
 		irq = DISPC_IRQ_EVSYNC_EVEN;
-	else
+		break;
+	default:
 		irq = dispc_mgr_get_vsync_irq(mgr->id);
+		break;
+	}
 
 	r = omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
 
-- 
1.7.10.4

