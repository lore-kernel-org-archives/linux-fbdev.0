From: Dong Aisheng <aisheng.dong@nxp.com>
Date: Wed, 21 Mar 2018 03:19:50 +0000
Subject: [PATCH V2 3/4] clk: add managed version of clk_bulk_get_all
Message-Id: <1521602391-30356-4-git-send-email-aisheng.dong@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch introduces the managed version of clk_bulk_get_all.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v1->v2:
 * new patch
---
 drivers/clk/clk-devres.c | 24 ++++++++++++++++++++++++
 include/linux/clk.h      | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index d854e26..6d3ca5e 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -70,6 +70,30 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get);
 
+int __must_check devm_clk_bulk_get_all(struct device *dev,
+				       struct clk_bulk_data **clks)
+{
+	struct clk_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_clk_bulk_release,
+			      sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = clk_bulk_get_all(dev, clks);
+	if (ret > 0) {
+		devres->clks = *clks;
+		devres->num_clks = ret;
+		devres_add(dev, devres);
+	} else {
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
+
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
 	struct clk **c = res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index a76fdff..fe48e01 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -313,6 +313,22 @@ int __must_check clk_bulk_get_all(struct device *dev,
  */
 int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 				   struct clk_bulk_data *clks);
+/**
+ * devm_clk_bulk_get_all - managed get multiple clk consumers
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Returns a positive value for the number of clocks obtained while the
+ * clock references are stored in the clk_bulk_data table in @clks field.
+ * Returns 0 if there're none and a negative value if something failed.
+ *
+ * This helper function allows drivers to get several clk
+ * consumers in one operation with management, the clks will
+ * automatically be freed when the device is unbound.
+ */
+
+int __must_check devm_clk_bulk_get_all(struct device *dev,
+				       struct clk_bulk_data **clks);
 
 /**
  * devm_clk_get - lookup and obtain a managed reference to a clock producer.
@@ -658,6 +674,13 @@ static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clk
 	return 0;
 }
 
+static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
+						     struct clk_bulk_data **clks);
+{
+
+	return 0;
+}
+
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {
-- 
2.7.4

