From: Dong Aisheng <aisheng.dong@nxp.com>
Date: Tue, 23 Jan 2018 12:50:40 +0000
Subject: [RFC PATCH 1/2] clk: add new APIs to operate on all available clocks
Message-Id: <1516711841-25234-2-git-send-email-aisheng.dong@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1516711841-25234-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1516711841-25234-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch introduces of_clk_bulk_get_all and clk_bulk_x_all APIs
to users who just want to handle all available clocks from device tree
without need to know the detailed clock information likes clock numbers
and names. This is useful in writing some generic drivers to handle clock
part.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
A few question may need discuss:
1)  This patch is written based on of_clk_bulk_get.
[V4,1/1] clk: bulk: add of_clk_bulk_get()
https://patchwork.kernel.org/patch/9971527/
Stepen once said we may not need it, but i guess as we already
have clk_bulk_get, there may be guys who want of_clk_bulk_get as
well if they need specify the clock count information, becaues
of_clk_bulk_get_all will not check the count.
And of_clk_bulk_get is also helpful when implementing
of_clk_bulk_get_all.

2) It only implements the DT type clk_get_all as i see
Stephen said we probably may not need to implement non-dt
type as there're still no users.

If we do want to implement non-dt type as well, we could revise
the patch to add it too.
---
 drivers/clk/clk-bulk.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h    | 61 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 1c1a79d..bac2aae 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -17,9 +17,11 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
@@ -50,6 +52,45 @@ int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	return ret;
 }
 EXPORT_SYMBOL(of_clk_bulk_get);
+
+struct clk_bulk __must_check *of_clk_bulk_get_all(struct device_node *np)
+{
+	struct clk_bulk *clk_bulk;
+	int num_clks;
+	int ret;
+
+	num_clks = of_clk_get_parent_count(np);
+	if (!num_clks)
+		return NULL;
+
+	clk_bulk = kzalloc(sizeof(*clk_bulk) +
+			   num_clks * sizeof(struct clk_bulk_data),
+			   GFP_KERNEL);
+	if (!clk_bulk)
+		return ERR_PTR(-ENOMEM);
+
+	clk_bulk->num_clks = num_clks;
+	ret = of_clk_bulk_get(np, clk_bulk->num_clks, clk_bulk->clks);
+	if (ret) {
+		kfree(clk_bulk);
+		return ERR_PTR(ret);
+	}
+
+	return clk_bulk;
+}
+EXPORT_SYMBOL(of_clk_bulk_get_all);
+
+void of_clk_bulk_put_all(struct clk_bulk *clk_bulk)
+{
+	if (IS_ERR_OR_NULL(clk_bulk))
+		return;
+
+	clk_bulk_put(clk_bulk->num_clks, clk_bulk->clks);
+
+	kfree(clk_bulk->clks);
+	kfree(clk_bulk);
+}
+EXPORT_SYMBOL(of_clk_bulk_put_all);
 #endif
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
@@ -107,6 +148,12 @@ void clk_bulk_unprepare(int num_clks, const struct clk_bulk_data *clks)
 }
 EXPORT_SYMBOL_GPL(clk_bulk_unprepare);
 
+void inline clk_bulk_unprepare_all(const struct clk_bulk *clk_bulk)
+{
+	clk_bulk_unprepare(clk_bulk->num_clks, clk_bulk->clks);
+}
+EXPORT_SYMBOL_GPL(clk_bulk_unprepare_all);
+
 /**
  * clk_bulk_prepare - prepare a set of clocks
  * @num_clks: the number of clk_bulk_data
@@ -139,6 +186,11 @@ int __must_check clk_bulk_prepare(int num_clks,
 }
 EXPORT_SYMBOL_GPL(clk_bulk_prepare);
 
+int inline __must_check clk_bulk_prepare_all(const struct clk_bulk *clk_bulk)
+{
+	return clk_bulk_prepare(clk_bulk->num_clks, clk_bulk->clks);
+}
+
 #endif /* CONFIG_HAVE_CLK_PREPARE */
 
 /**
@@ -158,6 +210,12 @@ void clk_bulk_disable(int num_clks, const struct clk_bulk_data *clks)
 }
 EXPORT_SYMBOL_GPL(clk_bulk_disable);
 
+void inline clk_bulk_disable_all(const struct clk_bulk *clk_bulk)
+{
+	return clk_bulk_disable(clk_bulk->num_clks, clk_bulk->clks);
+}
+EXPORT_SYMBOL_GPL(clk_bulk_disable_all);
+
 /**
  * clk_bulk_enable - ungate a set of clocks
  * @num_clks: the number of clk_bulk_data
@@ -188,3 +246,9 @@ int __must_check clk_bulk_enable(int num_clks, const struct clk_bulk_data *clks)
 	return  ret;
 }
 EXPORT_SYMBOL_GPL(clk_bulk_enable);
+
+int inline __must_check clk_bulk_enable_all(const struct clk_bulk *clk_bulk)
+{
+	return clk_bulk_enable(clk_bulk->num_clks, clk_bulk->clks);
+}
+EXPORT_SYMBOL_GPL(clk_bulk_enable_all);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 09ae760..ccafda1 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -92,6 +92,21 @@ struct clk_bulk_data {
 	struct clk		*clk;
 };
 
+/**
+ * struct clk_bulk - bulk clk structure
+ *
+ * @num_clks: the number of avaliable clocks in this bulk
+ * @clks: struct clk_bulk_data * to store the associated clock
+ *
+ * The CLK APIs provide a series of clk_bulk_x_all() API calls as
+ * a convenience to consumers which require multiple clks.  This
+ * structure is used to manage data for these calls.
+ */
+struct clk_bulk {
+	int num_clks;
+	struct clk_bulk_data *clks;
+};
+
 #ifdef CONFIG_COMMON_CLK
 
 /**
@@ -202,6 +217,7 @@ static inline bool clk_is_match(const struct clk *p, const struct clk *q)
 int clk_prepare(struct clk *clk);
 int __must_check clk_bulk_prepare(int num_clks,
 				  const struct clk_bulk_data *clks);
+int __must_check clk_bulk_prepare_all(const struct clk_bulk *clk_bulk);
 #else
 static inline int clk_prepare(struct clk *clk)
 {
@@ -214,6 +230,12 @@ static inline int clk_bulk_prepare(int num_clks, struct clk_bulk_data *clks)
 	might_sleep();
 	return 0;
 }
+
+static inline int clk_bulk_prepare_all(const struct clk_bulk *clk_bulk)
+{
+	might_sleep();
+	return 0;
+}
 #endif
 
 /**
@@ -228,6 +250,7 @@ static inline int clk_bulk_prepare(int num_clks, struct clk_bulk_data *clks)
 #ifdef CONFIG_HAVE_CLK_PREPARE
 void clk_unprepare(struct clk *clk);
 void clk_bulk_unprepare(int num_clks, const struct clk_bulk_data *clks);
+void clk_bulk_unprepare_all(const struct clk_bulk *clk_bulk);
 #else
 static inline void clk_unprepare(struct clk *clk)
 {
@@ -237,6 +260,10 @@ static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
 {
 	might_sleep();
 }
+static inline void clk_bulk_unprepare_all(struct clk_bulk *clk_bulk)
+{
+	might_sleep();
+}
 #endif
 
 #ifdef CONFIG_HAVE_CLK
@@ -389,6 +416,13 @@ int __must_check clk_bulk_enable(int num_clks,
 				 const struct clk_bulk_data *clks);
 
 /**
+ * clk_bulk_enable_all - inform the system when all avaiable clks should
+ * 			 be running.
+ * @clk_bulk: pointer to struct clk_bulk which contains all available clocks
+ */
+int __must_check clk_bulk_enable_all(const struct clk_bulk *clk_bulk);
+
+/**
  * clk_disable - inform the system when the clock source is no longer required.
  * @clk: clock source
  *
@@ -423,6 +457,13 @@ void clk_disable(struct clk *clk);
 void clk_bulk_disable(int num_clks, const struct clk_bulk_data *clks);
 
 /**
+ * clk_bulk_disable_all - inform the system when all avaiable clks are no
+ * 			  longer required.
+ * @clk_bulk: pointer to struct clk_bulk which contains all available clocks
+ */
+void clk_bulk_disable_all(const struct clk_bulk *clk_bulk);
+
+/**
  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
  *		  This is only valid once the clock source has been enabled.
  * @clk: clock source
@@ -650,12 +691,18 @@ static inline int clk_bulk_enable(int num_clks, struct clk_bulk_data *clks)
 	return 0;
 }
 
-static inline void clk_disable(struct clk *clk) {}
+static inline int clk_bulk_enable_all(struct clk_bulk *clk_bulk)
+{
+	return 0;
+}
 
+static inline void clk_disable(struct clk *clk) {}
 
 static inline void clk_bulk_disable(int num_clks,
 				    struct clk_bulk_data *clks) {}
 
+static inline void clk_bulk_disable_all(const struct clk_bulk *clk_bulk) {}
+
 static inline unsigned long clk_get_rate(struct clk *clk)
 {
 	return 0;
@@ -744,6 +791,8 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 				 struct clk_bulk_data *clks);
+struct clk_bulk __must_check *of_clk_bulk_get_all(struct device_node *np);
+void of_clk_bulk_put_all(struct clk_bulk *clk_bulk);
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
@@ -754,6 +803,16 @@ static inline int __must_check of_clk_bulk_get(struct device_node *np, int num_c
 	return -ENOENT;
 }
 
+static struct clk_bulk __must_check *of_clk_bulk_get_all(struct device_node *np)
+{
+	return -ENOENT;
+}
+
+static void of_clk_bulk_put_all(struct clk_bulk *clk_bulk)
+{
+	return -ENOENT;
+}
+
 static inline struct clk *of_clk_get(struct device_node *np, int index)
 {
 	return ERR_PTR(-ENOENT);
-- 
2.7.4

