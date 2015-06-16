From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Jun 2015 10:16:25 +0000
Subject: [PATCH 3/7] OMAPDSS: fix dss_init_ports error handling
Message-Id: <1434449789-13812-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The return value of dss_init_ports() is not handled at all, causing
crashes later if the call failed.

This patch adds the error handling, and we also move the call to a
slightly earlier place to make bailing out easier.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 1ce47441efe3..28e6ff053b47 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -1125,6 +1125,10 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	if (r)
 		goto err_pll_init;
 
+	r = dss_init_ports(pdev);
+	if (r)
+		goto err_init_ports;
+
 	pm_runtime_enable(&pdev->dev);
 
 	r = dss_runtime_get();
@@ -1149,8 +1153,6 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
-	dss_init_ports(pdev);
-
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
@@ -1167,7 +1169,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 
 err_runtime_get:
 	pm_runtime_disable(&pdev->dev);
-
+	dss_uninit_ports(pdev);
+err_init_ports:
 	if (dss.video1_pll)
 		dss_video_pll_uninit(dss.video1_pll);
 
-- 
2.1.4

