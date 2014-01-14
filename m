From: Zhou Zhu <zzhu3@marvell.com>
Date: Tue, 14 Jan 2014 11:16:23 +0000
Subject: [PATCH v2 3/4] video: mmp: add devm_mmp_get_path_by_phandle for DT
Message-Id: <1389698184-28761-4-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389698184-28761-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1389698184-28761-1-git-send-email-zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chao Xie <chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Guoqing Li <ligq-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Zhou Zhu <zzhu3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

add devm_mmp_get_path_by_phandle to replace mmp_get_path
for DT usage

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
---
 drivers/video/mmp/core.c |   35 +++++++++++++++++++++++++++++++++++
 include/video/mmp_disp.h |    2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
index b563b92..0538458 100644
--- a/drivers/video/mmp/core.c
+++ b/drivers/video/mmp/core.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <linux/of.h>
 #include <video/mmp_disp.h>
 
 static struct mmp_overlay *path_get_overlay(struct mmp_path *path,
@@ -156,6 +157,40 @@ struct mmp_path *mmp_get_path(const char *name)
 EXPORT_SYMBOL_GPL(mmp_get_path);
 
 /*
+ * devm_mmp_get_path_by_phandle - get path by phandle
+ * @dev: device that want to get path
+ * @phandle: name of phandle in device node that want to get path
+ *
+ * this function gets path according to node pointed by phandle
+ * return NULL if no matching path
+ */
+struct mmp_path *devm_mmp_get_path_by_phandle(struct device *dev,
+	const char *phandle)
+{
+	struct mmp_path *path;
+	struct device_node *node;
+
+	if (!dev->of_node) {
+		dev_err(dev, "device does not have a device node entry\n");
+		return NULL;
+	}
+
+	node = of_parse_phandle(dev->of_node, phandle, 0);
+	if (!node) {
+		dev_err(dev, "failed to get %s phandle in %s node\n", phandle,
+			dev->of_node->name);
+		return NULL;
+	}
+
+	path = mmp_get_path(node->name);
+
+	of_node_put(node);
+
+	return path;
+}
+EXPORT_SYMBOL_GPL(devm_mmp_get_path_by_phandle);
+
+/*
  * mmp_register_path - init and register path by path_info
  * @p: path info provided by display controller
  *
diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
index 05a3a60..63138b8 100644
--- a/include/video/mmp_disp.h
+++ b/include/video/mmp_disp.h
@@ -248,6 +248,8 @@ struct mmp_path {
 };
 
 extern struct mmp_path *mmp_get_path(const char *name);
+struct mmp_path *devm_mmp_get_path_by_phandle(struct device *dev,
+		const char *phandle);
 static inline void mmp_path_set_mode(struct mmp_path *path,
 		struct mmp_mode *mode)
 {
-- 
1.7.9.5

