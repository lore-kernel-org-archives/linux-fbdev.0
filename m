From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 19 Sep 2013 10:19:18 +0000
Subject: [PATCH] OMAPDSS: DISPC: set irq_safe for runtime PM
Message-Id: <1379585958-24537-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We have a bug with omapdrm, where omapdrm calls dispc's pm_runtime
function in atomic context, and dispc's pm_runtime is not marked as
irq_safe:

BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:952

Dispc's runtime PM callbacks are irq safe, so we can just set the
irq_safe flag to fix the issue.

However, in the long term, I'd rather have omapdrm manage the runtime PM
calls in a better way. Calling get/put for every small operation that
touches the dispc registers is very inefficient. It'd be better and
cleaner to have clear "in-use" and "not-in-use" states for dispc, so
that we don't need to do register context restore for small operations,
only to turn dispc off right afterwards.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 02a7340..4779750 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3691,6 +3691,7 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
 
 	r = dispc_runtime_get();
 	if (r)
-- 
1.8.1.2

