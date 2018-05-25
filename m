From: Dong Aisheng <aisheng.dong@nxp.com>
Date: Fri, 25 May 2018 10:37:23 +0000
Subject: [PATCH V3 4/4] video: simplefb: switch to use clk_bulk API to simplify clock operations
Message-Id: <1527244643-10736-5-git-send-email-aisheng.dong@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Switching to use clk_bulk API to simplify clock operations.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * fix a build warning on x86 platform due to a wrong
   of the prototype of simplefb_clocks_enable
v1->v2:
 * switch to clk_bulk_get_all from of_clk_bulk_get_all
---
 drivers/video/fbdev/simplefb.c | 66 ++++++++----------------------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index a3c44ec..db74354 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -182,7 +182,7 @@ struct simplefb_par {
 #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
 	bool clks_enabled;
 	unsigned int clk_count;
-	struct clk **clks;
+	struct clk_bulk_data *clks;
 #endif
 #if defined CONFIG_OF && defined CONFIG_REGULATOR
 	bool regulators_enabled;
@@ -214,37 +214,13 @@ static int simplefb_clocks_get(struct simplefb_par *par,
 			       struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct clk *clock;
-	int i;
 
 	if (dev_get_platdata(&pdev->dev) || !np)
 		return 0;
 
-	par->clk_count = of_clk_get_parent_count(np);
-	if (!par->clk_count)
-		return 0;
-
-	par->clks = kcalloc(par->clk_count, sizeof(struct clk *), GFP_KERNEL);
-	if (!par->clks)
-		return -ENOMEM;
-
-	for (i = 0; i < par->clk_count; i++) {
-		clock = of_clk_get(np, i);
-		if (IS_ERR(clock)) {
-			if (PTR_ERR(clock) = -EPROBE_DEFER) {
-				while (--i >= 0) {
-					if (par->clks[i])
-						clk_put(par->clks[i]);
-				}
-				kfree(par->clks);
-				return -EPROBE_DEFER;
-			}
-			dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
-				__func__, i, PTR_ERR(clock));
-			continue;
-		}
-		par->clks[i] = clock;
-	}
+	par->clk_count = clk_bulk_get_all(&pdev->dev, &par->clks);
+	if ((par->clk_count < 0) && (par->clk_count = -EPROBE_DEFER))
+		return -EPROBE_DEFER;
 
 	return 0;
 }
@@ -252,39 +228,21 @@ static int simplefb_clocks_get(struct simplefb_par *par,
 static void simplefb_clocks_enable(struct simplefb_par *par,
 				   struct platform_device *pdev)
 {
-	int i, ret;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(par->clk_count, par->clks);
+	if (ret)
+		dev_warn(&pdev->dev, "failed to enable clocks\n");
 
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			ret = clk_prepare_enable(par->clks[i]);
-			if (ret) {
-				dev_err(&pdev->dev,
-					"%s: failed to enable clock %d: %d\n",
-					__func__, i, ret);
-				clk_put(par->clks[i]);
-				par->clks[i] = NULL;
-			}
-		}
-	}
 	par->clks_enabled = true;
 }
 
 static void simplefb_clocks_destroy(struct simplefb_par *par)
 {
-	int i;
-
-	if (!par->clks)
-		return;
-
-	for (i = 0; i < par->clk_count; i++) {
-		if (par->clks[i]) {
-			if (par->clks_enabled)
-				clk_disable_unprepare(par->clks[i]);
-			clk_put(par->clks[i]);
-		}
-	}
+	if (par->clks_enabled)
+		clk_bulk_disable_unprepare(par->clk_count, par->clks);
 
-	kfree(par->clks);
+	clk_bulk_put_all(par->clk_count, par->clks);
 }
 #else
 static int simplefb_clocks_get(struct simplefb_par *par,
-- 
2.7.4

