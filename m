From: Dong Aisheng <aisheng.dong@nxp.com>
Date: Wed, 21 Mar 2018 02:54:51 +0000
Subject: [PATCH V2 1/4] clk: bulk: add of_clk_bulk_get()
Message-Id: <1521600894-29919-2-git-send-email-aisheng.dong@nxp.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

'clock-names' property is optional in DT, so of_clk_bulk_get() is
introduced here to handle this for DT users without 'clock-names'
specified. Later clk_bulk_get_all() will be implemented on top of
it and this API will be kept private until someone proves they need
it because they don't have a struct device pointer.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Russell King <linux@arm.linux.org.uk>
Reported-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk-bulk.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 4c10456..4b357b2 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -19,6 +19,38 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/of.h>
+
+#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
+static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
+					struct clk_bulk_data *clks)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < num_clks; i++)
+		clks[i].clk = NULL;
+
+	for (i = 0; i < num_clks; i++) {
+		clks[i].clk = of_clk_get(np, i);
+		if (IS_ERR(clks[i].clk)) {
+			ret = PTR_ERR(clks[i].clk);
+			pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
+			       np, i, ret);
+			clks[i].clk = NULL;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	clk_bulk_put(i, clks);
+
+	return ret;
+}
+EXPORT_SYMBOL(of_clk_bulk_get);
+#endif
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
-- 
2.7.4

