From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Jun 2015 10:16:24 +0000
Subject: [PATCH 2/7] OMAPDSS: refactor dss probe function
Message-Id: <1434449789-13812-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Refactor dss probe function by extracting the setup for video plls into
a separate function. The call to this function is also moved to a
slightly earlier phase, so that in error case we can bail out more
easily.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 125 ++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 56 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 35601ab232e3..1ce47441efe3 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -1026,14 +1026,73 @@ static void __exit dss_uninit_ports(struct platform_device *pdev)
 	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
 }
 
+static int dss_video_pll_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct regulator *pll_regulator;
+	int r;
+
+	if (!np)
+		return 0;
+
+	if (of_property_read_bool(np, "syscon-pll-ctrl")) {
+		dss.syscon_pll_ctrl = syscon_regmap_lookup_by_phandle(np,
+			"syscon-pll-ctrl");
+		if (IS_ERR(dss.syscon_pll_ctrl)) {
+			dev_err(&pdev->dev,
+				"failed to get syscon-pll-ctrl regmap\n");
+			return PTR_ERR(dss.syscon_pll_ctrl);
+		}
+
+		if (of_property_read_u32_index(np, "syscon-pll-ctrl", 1,
+				&dss.syscon_pll_ctrl_offset)) {
+			dev_err(&pdev->dev,
+				"failed to get syscon-pll-ctrl offset\n");
+			return -EINVAL;
+		}
+	}
+
+	pll_regulator = devm_regulator_get(&pdev->dev, "vdda_video");
+	if (IS_ERR(pll_regulator)) {
+		r = PTR_ERR(pll_regulator);
+
+		switch (r) {
+		case -ENOENT:
+			pll_regulator = NULL;
+			break;
+
+		case -EPROBE_DEFER:
+			return -EPROBE_DEFER;
+
+		default:
+			DSSERR("can't get DPLL VDDA regulator\n");
+			return r;
+		}
+	}
+
+	if (of_property_match_string(np, "reg-names", "pll1") >= 0) {
+		dss.video1_pll = dss_video_pll_init(pdev, 0, pll_regulator);
+		if (IS_ERR(dss.video1_pll))
+			return PTR_ERR(dss.video1_pll);
+	}
+
+	if (of_property_match_string(np, "reg-names", "pll2") >= 0) {
+		dss.video2_pll = dss_video_pll_init(pdev, 1, pll_regulator);
+		if (IS_ERR(dss.video2_pll)) {
+			dss_video_pll_uninit(dss.video1_pll);
+			return PTR_ERR(dss.video2_pll);
+		}
+	}
+
+	return 0;
+}
+
 /* DSS HW IP initialisation */
 static int __init omap_dsshw_probe(struct platform_device *pdev)
 {
 	struct resource *dss_mem;
-	struct device_node *np = pdev->dev.of_node;
 	u32 rev;
 	int r;
-	struct regulator *pll_regulator;
 
 	dss.pdev = pdev;
 
@@ -1062,6 +1121,10 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	if (r)
 		goto err_setup_clocks;
 
+	r = dss_video_pll_probe(pdev);
+	if (r)
+		goto err_pll_init;
+
 	pm_runtime_enable(&pdev->dev);
 
 	r = dss_runtime_get();
@@ -1088,57 +1151,6 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 
 	dss_init_ports(pdev);
 
-	if (np && of_property_read_bool(np, "syscon-pll-ctrl")) {
-		dss.syscon_pll_ctrl = syscon_regmap_lookup_by_phandle(np,
-			"syscon-pll-ctrl");
-		if (IS_ERR(dss.syscon_pll_ctrl)) {
-			dev_err(&pdev->dev,
-				"failed to get syscon-pll-ctrl regmap\n");
-			return PTR_ERR(dss.syscon_pll_ctrl);
-		}
-
-		if (of_property_read_u32_index(np, "syscon-pll-ctrl", 1,
-				&dss.syscon_pll_ctrl_offset)) {
-			dev_err(&pdev->dev,
-				"failed to get syscon-pll-ctrl offset\n");
-			return -EINVAL;
-		}
-	}
-
-	pll_regulator = devm_regulator_get(&pdev->dev, "vdda_video");
-	if (IS_ERR(pll_regulator)) {
-		r = PTR_ERR(pll_regulator);
-
-		switch (r) {
-		case -ENOENT:
-			pll_regulator = NULL;
-			break;
-
-		case -EPROBE_DEFER:
-			return -EPROBE_DEFER;
-
-		default:
-			DSSERR("can't get DPLL VDDA regulator\n");
-			return r;
-		}
-	}
-
-	if (of_property_match_string(np, "reg-names", "pll1") >= 0) {
-		dss.video1_pll = dss_video_pll_init(pdev, 0, pll_regulator);
-		if (IS_ERR(dss.video1_pll)) {
-			r = PTR_ERR(dss.video1_pll);
-			goto err_pll_init;
-		}
-	}
-
-	if (of_property_match_string(np, "reg-names", "pll2") >= 0) {
-		dss.video2_pll = dss_video_pll_init(pdev, 1, pll_regulator);
-		if (IS_ERR(dss.video2_pll)) {
-			r = PTR_ERR(dss.video2_pll);
-			goto err_pll_init;
-		}
-	}
-
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
@@ -1153,14 +1165,15 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_pll_init:
+err_runtime_get:
+	pm_runtime_disable(&pdev->dev);
+
 	if (dss.video1_pll)
 		dss_video_pll_uninit(dss.video1_pll);
 
 	if (dss.video2_pll)
 		dss_video_pll_uninit(dss.video2_pll);
-err_runtime_get:
-	pm_runtime_disable(&pdev->dev);
+err_pll_init:
 err_setup_clocks:
 	dss_put_clocks();
 	return r;
-- 
2.1.4

