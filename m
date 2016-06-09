From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Thu, 09 Jun 2016 09:44:18 +0000
Subject: [RFC v4 01/14] regulator: of: Add helper for getting all supplies
Message-Id: <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Few drivers have a need of getting regulator supplies without knowing
their names:
1. The Simple Framebuffer driver works on setup provided by bootloader
   (outside of scope of kernel);
2. Generic power sequence driver may be attached to any device node.

Add a Device Tree helper for parsing "-supply" properties and returning
allocated bulk regulator consumers.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/of_regulator.c       | 86 ++++++++++++++++++++++++++++++++++
 include/linux/regulator/of_regulator.h | 13 +++++
 2 files changed, 99 insertions(+)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index cd828dbf9d52..0d2c8dd0ebc0 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -350,3 +350,89 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 
 	return init_data;
 }
+
+/**
+ * devm_of_regulator_all_get - get all regulator consumers
+ *
+ * @dev:           Device to supply
+ * @num_consumers  Number of consumers registered (only on success)
+ * @consumers:     Configuration of consumers; names of supplies and clients
+ *                 are stored here; allocated only on success (NULL otherwise);
+ *
+ * @return 0 on success, an errno on failure.
+ *
+ * This helper function allows drivers to get all regulator consumers
+ * for given device in one operation.  The names of regulator supplies
+ * do not have to be provided.  If any of the regulators cannot be
+ * acquired then any regulators that were allocated will be freed
+ * before returning to the caller.
+ */
+int devm_of_regulator_all_get(struct device *dev, unsigned int *num_consumers,
+			      struct regulator_bulk_data **consumers)
+{
+	struct device_node *np = dev->of_node;
+	struct regulator_bulk_data *bulk;
+	unsigned int count = 0, i = 0;
+	struct property *prop;
+	const char *p;
+	int ret;
+
+	if (!np) {
+		ret = 0;
+		goto err; /* Not really an error */
+	}
+
+	/* Count the number of regulator supplies */
+	for_each_property_of_node(np, prop) {
+		p = strstr(prop->name, "-supply");
+		if (p && p != prop->name)
+			count++;
+	}
+
+	if (!count) {
+		ret = 0;
+		goto err; /* Not really an error */
+	}
+
+	bulk = devm_kcalloc(dev, count, sizeof(**consumers), GFP_KERNEL);
+	if (!bulk) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/* Get all the names for supplies */
+	for_each_property_of_node(np, prop) {
+		char *name;
+		int len;
+
+		p = strstr(prop->name, "-supply");
+		if (!p || p = prop->name)
+			continue;
+
+		len = strlen(prop->name) - strlen("-supply") + 1;
+		name = devm_kzalloc(dev, len, GFP_KERNEL);
+		if (!name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		strlcpy(name, prop->name, len);
+		bulk[i++].supply = name;
+	}
+
+	ret = devm_regulator_bulk_get(dev, i, bulk);
+	if (ret)
+		goto err;
+
+	*consumers = bulk;
+	*num_consumers = i;
+
+	return 0;
+
+err:
+	*num_consumers = 0;
+	*consumers = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_of_regulator_all_get);
diff --git a/include/linux/regulator/of_regulator.h b/include/linux/regulator/of_regulator.h
index 763953f7e3b8..93a3b7fe92e8 100644
--- a/include/linux/regulator/of_regulator.h
+++ b/include/linux/regulator/of_regulator.h
@@ -7,6 +7,7 @@
 #define __LINUX_OF_REG_H
 
 struct regulator_desc;
+struct regulator_bulk_data;
 
 struct of_regulator_match {
 	const char *name;
@@ -24,6 +25,9 @@ extern struct regulator_init_data
 extern int of_regulator_match(struct device *dev, struct device_node *node,
 			      struct of_regulator_match *matches,
 			      unsigned int num_matches);
+extern int devm_of_regulator_all_get(struct device *dev,
+				     unsigned int *num_consumers,
+				     struct regulator_bulk_data **consumers);
 #else
 static inline struct regulator_init_data
 	*of_get_regulator_init_data(struct device *dev,
@@ -40,6 +44,15 @@ static inline int of_regulator_match(struct device *dev,
 {
 	return 0;
 }
+static inline int devm_of_regulator_all_get(struct device *dev,
+					    unsigned int *num_consumers,
+					    struct regulator_bulk_data **consumers)
+{
+	*num_consumers = 0;
+	*consumers = NULL;
+
+	return 0;
+}
 #endif /* CONFIG_OF */
 
 #endif /* __LINUX_OF_REG_H */
-- 
1.9.1

