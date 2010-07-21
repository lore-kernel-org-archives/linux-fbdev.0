From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 21 Jul 2010 10:13:10 +0000
Subject: [PATCH 2/6 v3] sh: add a reparent function to DIV6 clocks
Message-Id: <Pine.LNX.4.64.1007211149480.16933@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add support for reparenting of div6 clocks on SuperH and SH-Mobile SoCs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3:
No change

v2:
Fixed a typo, noticed by Magnus.

 drivers/sh/clk-cpg.c   |   58 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/sh_clk.h |   19 +++++++++++----
 2 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/drivers/sh/clk-cpg.c b/drivers/sh/clk-cpg.c
index f5c80ba..8c024b9 100644
--- a/drivers/sh/clk-cpg.c
+++ b/drivers/sh/clk-cpg.c
@@ -68,6 +68,39 @@ static unsigned long sh_clk_div6_recalc(struct clk *clk)
 	return clk->freq_table[idx].frequency;
 }
 
+static int sh_clk_div6_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_div_mult_table *table = &sh_clk_div6_table;
+	u32 value;
+	int ret, i;
+
+	if (!clk->parent_table || !clk->parent_num)
+		return -EINVAL;
+
+	/* Search the parent */
+	for (i = 0; i < clk->parent_num; i++)
+		if (clk->parent_table[i] = parent)
+			break;
+
+	if (i = clk->parent_num)
+		return -ENODEV;
+
+	ret = clk_reparent(clk, parent);
+	if (ret < 0)
+		return ret;
+
+	value = __raw_readl(clk->enable_reg) &
+		~(((1 << clk->src_width) - 1) << clk->src_shift);
+
+	__raw_writel(value | (i << clk->src_shift), clk->enable_reg);
+
+	/* Rebuild the frequency table */
+	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
+			     table, &clk->arch_flags);
+
+	return 0;
+}
+
 static int sh_clk_div6_set_rate(struct clk *clk,
 				unsigned long rate, int algo_id)
 {
@@ -117,7 +150,17 @@ static struct clk_ops sh_clk_div6_clk_ops = {
 	.disable	= sh_clk_div6_disable,
 };
 
-int __init sh_clk_div6_register(struct clk *clks, int nr)
+static struct clk_ops sh_clk_div6_reparent_clk_ops = {
+	.recalc		= sh_clk_div6_recalc,
+	.round_rate	= sh_clk_div_round_rate,
+	.set_rate	= sh_clk_div6_set_rate,
+	.enable		= sh_clk_div6_enable,
+	.disable	= sh_clk_div6_disable,
+	.set_parent	= sh_clk_div6_set_parent,
+};
+
+static int __init sh_clk_div6_register_ops(struct clk *clks, int nr,
+					   struct clk_ops *ops)
 {
 	struct clk *clkp;
 	void *freq_table;
@@ -136,7 +179,7 @@ int __init sh_clk_div6_register(struct clk *clks, int nr)
 	for (k = 0; !ret && (k < nr); k++) {
 		clkp = clks + k;
 
-		clkp->ops = &sh_clk_div6_clk_ops;
+		clkp->ops = ops;
 		clkp->id = -1;
 		clkp->freq_table = freq_table + (k * freq_table_size);
 		clkp->freq_table[nr_divs].frequency = CPUFREQ_TABLE_END;
@@ -147,6 +190,17 @@ int __init sh_clk_div6_register(struct clk *clks, int nr)
 	return ret;
 }
 
+int __init sh_clk_div6_register(struct clk *clks, int nr)
+{
+	return sh_clk_div6_register_ops(clks, nr, &sh_clk_div6_clk_ops);
+}
+
+int __init sh_clk_div6_reparent_register(struct clk *clks, int nr)
+{
+	return sh_clk_div6_register_ops(clks, nr,
+					&sh_clk_div6_reparent_clk_ops);
+}
+
 static unsigned long sh_clk_div4_recalc(struct clk *clk)
 {
 	struct clk_div4_table *d4t = clk->priv;
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 08a07b9..875ce50 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -142,13 +142,22 @@ int sh_clk_div4_enable_register(struct clk *clks, int nr,
 int sh_clk_div4_reparent_register(struct clk *clks, int nr,
 			 struct clk_div4_table *table);
 
-#define SH_CLK_DIV6(_parent, _reg, _flags)	\
-{						\
-	.parent = _parent,			\
-	.enable_reg = (void __iomem *)_reg,	\
-	.flags = _flags,			\
+#define SH_CLK_DIV6_EXT(_parent, _reg, _flags, _parents,	\
+			_num_parents, _src_shift, _src_width)	\
+{								\
+	.parent = _parent,					\
+	.enable_reg = (void __iomem *)_reg,			\
+	.flags = _flags,					\
+	.parent_table = _parents,				\
+	.parent_num = _num_parents,				\
+	.src_shift = _src_shift,				\
+	.src_width = _src_width,				\
 }
 
+#define SH_CLK_DIV6(_parent, _reg, _flags)			\
+	SH_CLK_DIV6_EXT(_parent, _reg, _flags, NULL, 0, 0, 0)
+
 int sh_clk_div6_register(struct clk *clks, int nr);
+int sh_clk_div6_reparent_register(struct clk *clks, int nr);
 
 #endif /* __SH_CLOCK_H */
-- 
1.6.2.4

