From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 30 Jun 2010 09:55:35 +0000
Subject: [PATCH 3/6] ARM: mach-shmobile: extend clock definitions on sh7372
Message-Id: <Pine.LNX.4.64.1006301137290.17489@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add definitions for DV_CLKI and HDMI clocks, extend support for PLLC2 and some
other clocks.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/clock-sh7372.c |  171 +++++++++++++++++++++++++++++++--
 1 files changed, 164 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 26521a7..21cb629 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -50,6 +50,12 @@
 #define SMSTPCR3	0xe615013c
 #define SMSTPCR4	0xe6150140
 
+/* Fixed 27 MHz video clock from DV_CLKI pin */
+static struct clk dv_clki_clk = {
+	.name		= "dv_clki",
+	.rate           = 27000000,
+};
+
 /* Fixed 32 KHz root clock from EXTALR pin */
 static struct clk r_clk = {
 	.rate           = 32768,
@@ -81,14 +87,23 @@ static struct clk_ops div2_clk_ops = {
 	.recalc		= div2_recalc,
 };
 
+/* Divide dv_clki by two */
+static struct clk dv_clki_div2_clk = {
+	.name		= "dv_clki_div2",
+	.ops		= &div2_clk_ops,
+	.parent		= &dv_clki_clk,
+};
+
 /* Divide extal1 by two */
 static struct clk extal1_div2_clk = {
+	.name		= "extal1_div2",
 	.ops		= &div2_clk_ops,
 	.parent		= &sh7372_extal1_clk,
 };
 
 /* Divide extal2 by two */
 static struct clk extal2_div2_clk = {
+	.name		= "extal2_div2",
 	.ops		= &div2_clk_ops,
 	.parent		= &sh7372_extal2_clk,
 };
@@ -130,35 +145,157 @@ static struct clk pllc1_clk = {
 
 /* Divide PLLC1 by two */
 static struct clk pllc1_div2_clk = {
+	.name		= "pllc1_div2",
 	.ops		= &div2_clk_ops,
 	.parent		= &pllc1_clk,
 };
 
 /* PLLC2 */
+
+/* Indices are important - they are the actual src selecting values */
+static struct clk *pllc2_parent[] = {
+	[0] = &extal1_div2_clk,
+	[1] = &extal2_div2_clk,
+	[2] = &dv_clki_div2_clk,
+	[3] = NULL,	/* extal2_div4 not implemented yet*/
+};
+
+/* Only multipliers 20 * 2 to 46 * 2 are valid, last entry for CPUFREQ_TABLE_END */
+static struct cpufreq_frequency_table pllc2_freq_table[28];
+
+static void pllc2_table_rebuild(struct clk *clk)
+{
+	int i;
+
+	/* Initialise PLLC2 frequency table */
+	for (i = 0; i < ARRAY_SIZE(pllc2_freq_table) - 1; i++) {
+		pllc2_freq_table[i].frequency = clk->parent->rate * (i + 20) * 2;
+		pllc2_freq_table[i].index = i;
+	}
+
+	pllc2_freq_table[i].frequency = CPUFREQ_TABLE_END;
+	pllc2_freq_table[i].index = i;
+}
+
 static unsigned long pllc2_recalc(struct clk *clk)
 {
-	unsigned long mult = 1;
+	unsigned long mult;
 
-	if (__raw_readl(PLLC2CR) & (1 << 31))
-		mult = (((__raw_readl(PLLC2CR) >> 24) & 0x3f) + 1) * 2;
+	pllc2_table_rebuild(clk);
+
+	/*
+	 * TODO: If the PLL is off, mult should be = 1, but the clock must be
+	 * stopped during re-parenting, a better solution to this conflict
+	 * should be found.
+	 */
+	mult = (((__raw_readl(PLLC2CR) >> 24) & 0x3f) + 1) * 2;
 
 	return clk->parent->rate * mult;
 }
 
+static long pllc2_round_rate(struct clk *clk, unsigned long rate)
+{
+	return clk_rate_table_round(clk, clk->freq_table, rate);
+}
+
+static int pllc2_enable(struct clk *clk)
+{
+	int i;
+
+	__raw_writel(__raw_readl(PLLC2CR) | 0x80000000, PLLC2CR);
+
+	for (i = 0; i < 100; i++)
+		if (__raw_readl(PLLC2CR) & 0x80000000)
+			return 0;
+
+	pr_err("%s(): timeout!\n", __func__);
+
+	return -ETIMEDOUT;
+}
+
+static void pllc2_disable(struct clk *clk)
+{
+	__raw_writel(__raw_readl(PLLC2CR) & ~0x80000000, PLLC2CR);
+}
+
+static int pllc2_set_rate(struct clk *clk,
+			  unsigned long rate, int algo_id)
+{
+	unsigned long value;
+	int idx;
+
+	idx = clk_rate_table_find(clk, clk->freq_table, rate);
+	if (idx < 0)
+		return idx;
+
+	value = __raw_readl(PLLC2CR) & ~(0x3f << 24);
+
+	if (value & 0x80000000)
+		pllc2_disable(clk);
+
+	__raw_writel((value & ~0x80000000) | ((idx + 19) << 24), PLLC2CR);
+
+	if (value & 0x80000000)
+		return pllc2_enable(clk);
+
+	return 0;
+}
+
+static int pllc2_set_parent(struct clk *clk, struct clk *parent)
+{
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
+	value = __raw_readl(PLLC2CR) & ~(3 << 6);
+
+	__raw_writel(value | (i << 6), PLLC2CR);
+
+	/* Rebiuld the frequency table */
+	pllc2_table_rebuild(clk);
+
+	return 0;
+}
+
 static struct clk_ops pllc2_clk_ops = {
 	.recalc		= pllc2_recalc,
+	.round_rate	= pllc2_round_rate,
+	.set_rate	= pllc2_set_rate,
+	.enable		= pllc2_enable,
+	.disable	= pllc2_disable,
+	.set_parent	= pllc2_set_parent,
 };
 
 static struct clk pllc2_clk = {
+	.name		= "pllc2",
 	.ops		= &pllc2_clk_ops,
 	.flags		= CLK_ENABLE_ON_INIT,
 	.parent		= &extal1_div2_clk,
+	.freq_table	= pllc2_freq_table,
+	.parent_table	= pllc2_parent,
+	.parent_num	= ARRAY_SIZE(pllc2_parent),
 };
 
 static struct clk *main_clks[] = {
+	&dv_clki_clk,
 	&r_clk,
 	&sh7372_extal1_clk,
 	&sh7372_extal2_clk,
+	&dv_clki_div2_clk,
 	&extal1_div2_clk,
 	&extal2_div2_clk,
 	&extal2_div4_clk,
@@ -219,7 +356,7 @@ static struct clk div4_clks[DIV4_NR] = {
 
 enum { DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, DIV6_FMSI, DIV6_FMSO,
        DIV6_FSIA, DIV6_FSIB, DIV6_SUB, DIV6_SPU,
-       DIV6_VOU, DIV6_HDMI, DIV6_DSIT, DIV6_DSI0P, DIV6_DSI1P,
+       DIV6_VOU, DIV6_DSIT, DIV6_DSI0P, DIV6_DSI1P,
        DIV6_NR };
 
 static struct clk div6_clks[DIV6_NR] = {
@@ -233,12 +370,26 @@ static struct clk div6_clks[DIV6_NR] = {
 	[DIV6_SUB] = SH_CLK_DIV6(&sh7372_extal2_clk, SUBCKCR, 0),
 	[DIV6_SPU] = SH_CLK_DIV6(&pllc1_div2_clk, SPUCKCR, 0),
 	[DIV6_VOU] = SH_CLK_DIV6(&pllc1_div2_clk, VOUCKCR, 0),
-	[DIV6_HDMI] = SH_CLK_DIV6(&pllc1_div2_clk, HDMICKCR, 0),
 	[DIV6_DSIT] = SH_CLK_DIV6(&pllc1_div2_clk, DSITCKCR, 0),
 	[DIV6_DSI0P] = SH_CLK_DIV6(&pllc1_div2_clk, DSI0PCKCR, 0),
 	[DIV6_DSI1P] = SH_CLK_DIV6(&pllc1_div2_clk, DSI1PCKCR, 0),
 };
 
+enum { DIV6_HDMI, DIV6_REPARENT_NR };
+
+/* Indices are important - they are the actual src selecting values */
+static struct clk *hdmi_parent[] = {
+	[0] = &pllc1_div2_clk,
+	[1] = &pllc2_clk,
+	[2] = &dv_clki_clk,
+	[3] = NULL,	/* pllc2_div4 not implemented yet */
+};
+
+static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
+	[DIV6_HDMI] = SH_CLK_DIV6_EXT(&pllc1_div2_clk, HDMICKCR, 0,
+				      hdmi_parent, ARRAY_SIZE(hdmi_parent), 6, 2),
+};
+
 enum { MSTP001,
        MSTP131, MSTP130,
        MSTP129, MSTP128,
@@ -247,7 +398,7 @@ enum { MSTP001,
        MSTP223,
        MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
        MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313, MSTP312,
-       MSTP415, MSTP410, MSTP411, MSTP406, MSTP403,
+       MSTP415, MSTP413, MSTP411, MSTP410, MSTP406, MSTP403,
        MSTP_NR };
 
 #define MSTP(_parent, _reg, _bit, _flags) \
@@ -281,6 +432,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP313] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMC */
 	[MSTP415] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 15, 0), /* SDHI2 */
+	[MSTP413] = MSTP(&pllc1_div2_clk, SMSTPCR4, 13, 0), /* HDMI */
 	[MSTP411] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 11, 0), /* IIC3 */
 	[MSTP410] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 10, 0), /* IIC4 */
 	[MSTP406] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 6, 0), /* USB1 */
@@ -292,6 +444,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
+	CLKDEV_CON_ID("dv_clki_div2_clk", &dv_clki_div2_clk),
 	CLKDEV_CON_ID("r_clk", &r_clk),
 	CLKDEV_CON_ID("extal1", &sh7372_extal1_clk),
 	CLKDEV_CON_ID("extal2", &sh7372_extal2_clk),
@@ -331,7 +484,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("sub_clk", &div6_clks[DIV6_SUB]),
 	CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_SPU]),
 	CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
-	CLKDEV_CON_ID("hdmi_clk", &div6_clks[DIV6_HDMI]),
+	CLKDEV_CON_ID("hdmi_clk", &div6_reparent_clks[DIV6_HDMI]),
 	CLKDEV_CON_ID("dsit_clk", &div6_clks[DIV6_DSIT]),
 	CLKDEV_CON_ID("dsi0p_clk", &div6_clks[DIV6_DSI0P]),
 	CLKDEV_CON_ID("dsi1p_clk", &div6_clks[DIV6_DSI1P]),
@@ -366,6 +519,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMC */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP415]), /* SDHI2 */
+	CLKDEV_CON_ID("sh-hdmi.0", &mstp_clks[MSTP413]), /* HDMI */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* IIC3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* IIC4 */
 	CLKDEV_DEV_ID("r8a66597_hcd.1", &mstp_clks[MSTP406]), /* USB1 */
@@ -387,6 +541,9 @@ void __init sh7372_clock_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
+		ret = sh_clk_div6_reparent_register(div6_reparent_clks, DIV6_NR);
+
+	if (!ret)
 		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-- 
1.6.2.4

