From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 22 Dec 2010 09:52:21 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: improve MIPI DSI clock configuration
Message-Id: <Pine.LNX.4.64.1012221051430.14483@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Now, that the MIPI DSI driver implements runtime PM, we don't need anymore to
configure clocks statically in the platform code. This patch also adds a DSITX1
clock definition for sh7372 and attaches PHY clocks to respective devices.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   38 ---------------------------------
 arch/arm/mach-shmobile/clock-sh7372.c |   10 +++++---
 2 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index ed999a3..f0b8650 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -531,44 +531,6 @@ static struct platform_device mipidsi0_device = {
 	},
 };
 
-/* This function will disappear when we switch to (runtime) PM */
-static int __init ap4evb_init_display_clk(void)
-{
-	struct clk *lcdc_clk;
-	struct clk *dsitx_clk;
-	int ret;
-
-	lcdc_clk = clk_get(&lcdc_device.dev, "sh_mobile_lcdc_fb.0");
-	if (IS_ERR(lcdc_clk))
-		return PTR_ERR(lcdc_clk);
-
-	dsitx_clk = clk_get(&mipidsi0_device.dev, "sh-mipi-dsi.0");
-	if (IS_ERR(dsitx_clk)) {
-		ret = PTR_ERR(dsitx_clk);
-		goto eclkdsitxget;
-	}
-
-	ret = clk_enable(lcdc_clk);
-	if (ret < 0)
-		goto eclklcdcon;
-
-	ret = clk_enable(dsitx_clk);
-	if (ret < 0)
-		goto eclkdsitxon;
-
-	return 0;
-
-eclkdsitxon:
-	clk_disable(lcdc_clk);
-eclklcdcon:
-	clk_put(dsitx_clk);
-eclkdsitxget:
-	clk_put(lcdc_clk);
-
-	return ret;
-}
-device_initcall(ap4evb_init_display_clk);
-
 static struct platform_device *qhd_devices[] __initdata = {
 	&mipidsi0_device,
 	&keysc_device,
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index eb92fef..1729d6c 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -507,7 +507,7 @@ enum { MSTP001,
        MSTP223,
        MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
        MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313, MSTP312,
-       MSTP415, MSTP413, MSTP411, MSTP410, MSTP406, MSTP403,
+       MSTP423, MSTP415, MSTP413, MSTP411, MSTP410, MSTP406, MSTP403,
        MSTP_NR };
 
 #define MSTP(_parent, _reg, _bit, _flags) \
@@ -543,6 +543,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP314] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 14, 0), /* SDHI0 */
 	[MSTP313] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMC */
+	[MSTP423] = MSTP(&div4_clks[DIV4_B], SMSTPCR4, 23, 0), /* DSITX1 */
 	[MSTP415] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 15, 0), /* SDHI2 */
 	[MSTP413] = MSTP(&pllc1_div2_clk, SMSTPCR4, 13, 0), /* HDMI */
 	[MSTP411] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 11, 0), /* IIC3 */
@@ -597,8 +598,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
 	CLKDEV_CON_ID("hdmi_clk", &div6_reparent_clks[DIV6_HDMI]),
 	CLKDEV_CON_ID("dsit_clk", &div6_clks[DIV6_DSIT]),
-	CLKDEV_CON_ID("dsi0p_clk", &div6_clks[DIV6_DSI0P]),
-	CLKDEV_CON_ID("dsi1p_clk", &div6_clks[DIV6_DSI1P]),
+	CLKDEV_ICK_ID("dsi0p_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
+	CLKDEV_ICK_ID("dsi1p_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* IIC2 */
@@ -610,7 +611,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-mobile-csi2.0", &mstp_clks[MSTP126]), /* CSI2 */
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP125]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP125]), /* TMU01 */
-	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX */
+	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX0 */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1", &mstp_clks[MSTP117]), /* LCDC1 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* IIC0 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.5", &mstp_clks[MSTP106]), /* JPU */
@@ -633,6 +634,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMC */
+	CLKDEV_DEV_ID("sh-mipi-dsi.1", &mstp_clks[MSTP423]), /* DSITX1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP415]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh-mobile-hdmi", &mstp_clks[MSTP413]), /* HDMI */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* IIC3 */
-- 
1.7.2.3

