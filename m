From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Jan 2013 07:36:07 +0000
Subject: [PATCH 1/2] video: exynos_dp: add missing of_node_put()
Message-Id: <00cb01cdfdf3$4ccdac00$e6690400$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

of_find_node_by_name() returns a node pointer with refcount
incremented, use of_node_put() on it when done.

of_find_node_by_name() will call of_node_put() against
the node pass to from parameter, thus we also need to call
of_node_get(from) before calling of_find_node_by_name().

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 2ed9776..c7374c0 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -965,10 +965,11 @@ static struct exynos_dp_platdata *exynos_dp_dt_parse_pdata(struct device *dev)
 
 static int exynos_dp_dt_parse_phydata(struct exynos_dp_device *dp)
 {
-	struct device_node *dp_phy_node;
+	struct device_node *dp_phy_node = of_node_get(dp->dev->of_node);
 	u32 phy_base;
+	int ret = 0;
 
-	dp_phy_node = of_find_node_by_name(dp->dev->of_node, "dptx-phy");
+	dp_phy_node = of_find_node_by_name(dp_phy_node, "dptx-phy");
 	if (!dp_phy_node) {
 		dev_err(dp->dev, "could not find dptx-phy node\n");
 		return -ENODEV;
@@ -976,22 +977,28 @@ static int exynos_dp_dt_parse_phydata(struct exynos_dp_device *dp)
 
 	if (of_property_read_u32(dp_phy_node, "reg", &phy_base)) {
 		dev_err(dp->dev, "faild to get reg for dptx-phy\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	if (of_property_read_u32(dp_phy_node, "samsung,enable-mask",
 				&dp->enable_mask)) {
 		dev_err(dp->dev, "faild to get enable-mask for dptx-phy\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	dp->phy_addr = ioremap(phy_base, SZ_4);
 	if (!dp->phy_addr) {
 		dev_err(dp->dev, "failed to ioremap dp-phy\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err;
 	}
 
-	return 0;
+err:
+	of_node_put(dp_phy_node);
+
+	return ret;
 }
 
 static void exynos_dp_phy_init(struct exynos_dp_device *dp)
-- 
1.7.2.5


