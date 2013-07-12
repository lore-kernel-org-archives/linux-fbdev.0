From: Alison Wang <b18965@freescale.com>
Date: Fri, 12 Jul 2013 06:07:54 +0000
Subject: [PATCH 3/5] ARM: clk: vf610: Add DCU and TCON clock support
Message-Id: <1373609276-14566-4-git-send-email-b18965@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373609276-14566-1-git-send-email-b18965@freescale.com>
In-Reply-To: <1373609276-14566-1-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds DCU and TCON clock support for Vybrid VF610 platform.

Signed-off-by: Alison Wang <b18965@freescale.com>
---
Changes in v2: None

 arch/arm/mach-imx/clk-vf610.c           | 5 +++++
 include/dt-bindings/clock/vf610-clock.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-vf610.c b/arch/arm/mach-imx/clk-vf610.c
index d617c0b..c4dbe32 100644
--- a/arch/arm/mach-imx/clk-vf610.c
+++ b/arch/arm/mach-imx/clk-vf610.c
@@ -245,6 +245,8 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_DCU1_DIV] = imx_clk_divider("dcu1_div", "dcu1_en", CCM_CSCDR3, 20, 3);
 	clk[VF610_CLK_DCU1] = imx_clk_gate2("dcu1", "dcu1_div", CCM_CCGR9, CCM_CCGRx_CGn(8));
 
+	clk[VF610_CLK_TCON0] = imx_clk_gate2("tcon0", "platform_bus", CCM_CCGR1, CCM_CCGRx_CGn(13));
+
 	clk[VF610_CLK_ESAI_SEL] = imx_clk_mux("esai_sel", CCM_CSCMR1, 20, 2, esai_sels, 4);
 	clk[VF610_CLK_ESAI_EN] = imx_clk_gate("esai_en", "esai_sel", CCM_CSCDR2, 30);
 	clk[VF610_CLK_ESAI_DIV] = imx_clk_divider("esai_div", "esai_en", CCM_CSCDR2, 24, 4);
@@ -311,6 +313,9 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(clk[VF610_CLK_SAI2_SEL], clk[VF610_CLK_AUDIO_EXT]);
 	clk_set_parent(clk[VF610_CLK_SAI3_SEL], clk[VF610_CLK_AUDIO_EXT]);
 
+	clk_set_parent(clk[VF610_CLK_DCU0_SEL], clk[VF610_CLK_PLL1_PFD2]);
+	clk_set_rate(clk[VF610_CLK_DCU0_DIV], 113200000);
+
 	/* Add the clocks to provider list */
 	clk_data.clks = clk;
 	clk_data.clk_num = ARRAY_SIZE(clk);
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index 15e997f..a2fc6d9 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -158,6 +158,7 @@
 #define VF610_CLK_GPU_SEL		145
 #define VF610_CLK_GPU_EN		146
 #define VF610_CLK_GPU2D			147
-#define VF610_CLK_END			148
+#define VF610_CLK_TCON0			148
+#define VF610_CLK_END			149
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
1.8.0


