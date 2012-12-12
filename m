From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Dec 2012 12:27:09 +0000
Subject: [PATCH 2/2] OMAPDSS: DISPC: remove dispc fck uses
Message-Id: <1355315229-25238-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355315229-25238-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1355315229-25238-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The previous patch changes dispc to get the dispc fck rate from dss core
driver. This was the only use of the dispc fck in dispc, and thus we can
now remove the clock handling.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 08137a8..05ff2b9 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -96,7 +96,6 @@ static struct {
 	int		ctx_loss_cnt;
 
 	int irq;
-	struct clk *dss_clk;
 
 	u32 fifo_size[DISPC_MAX_NR_FIFOS];
 	/* maps which plane is using a fifo. fifo-id -> plane-id */
@@ -3619,7 +3618,6 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 	u32 rev;
 	int r = 0;
 	struct resource *dispc_mem;
-	struct clk *clk;
 
 	dispc.pdev = pdev;
 
@@ -3646,15 +3644,6 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	clk = clk_get(&pdev->dev, "fck");
-	if (IS_ERR(clk)) {
-		DSSERR("can't get fck\n");
-		r = PTR_ERR(clk);
-		return r;
-	}
-
-	dispc.dss_clk = clk;
-
 	pm_runtime_enable(&pdev->dev);
 
 	r = dispc_runtime_get();
@@ -3675,7 +3664,6 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
-	clk_put(dispc.dss_clk);
 	return r;
 }
 
@@ -3683,8 +3671,6 @@ static int __exit omap_dispchw_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
-	clk_put(dispc.dss_clk);
-
 	return 0;
 }
 
-- 
1.7.10.4

