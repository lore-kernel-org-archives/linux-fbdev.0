From: Alison Wang <b18965@freescale.com>
Date: Thu, 15 Aug 2013 08:01:52 +0000
Subject: [PATCH v3 3/5] ARM: clk: vf610: Add DCU and TCON clock support
Message-Id: <1376553714-25922-4-git-send-email-b18965@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376553714-25922-1-git-send-email-b18965@freescale.com>
In-Reply-To: <1376553714-25922-1-git-send-email-b18965@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds DCU and TCON clock support for Vybrid VF610 platform.

Signed-off-by: Alison Wang <b18965@freescale.com>
---
Changes in v3: None
Changes in v2: None

 arch/arm/mach-imx/clk-vf610.c           | 5 +++++
 include/dt-bindings/clock/vf610-clock.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-vf610.c b/arch/arm/mach-imx/clk-vf610.c
index b169a39..689d3da 100644
--- a/arch/arm/mach-imx/clk-vf610.c
+++ b/arch/arm/mach-imx/clk-vf610.c
@@ -247,6 +247,8 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_DCU1_DIV] = imx_clk_divider("dcu1_div", "dcu1_en", CCM_CSCDR3, 20, 3);
 	clk[VF610_CLK_DCU1] = imx_clk_gate2("dcu1", "dcu1_div", CCM_CCGR9, CCM_CCGRx_CGn(8));
 
+	clk[VF610_CLK_TCON0] = imx_clk_gate2("tcon0", "platform_bus", CCM_CCGR1, CCM_CCGRx_CGn(13));
+
 	clk[VF610_CLK_ESAI_SEL] = imx_clk_mux("esai_sel", CCM_CSCMR1, 20, 2, esai_sels, 4);
 	clk[VF610_CLK_ESAI_EN] = imx_clk_gate("esai_en", "esai_sel", CCM_CSCDR2, 30);
 	clk[VF610_CLK_ESAI_DIV] = imx_clk_divider("esai_div", "esai_en", CCM_CSCDR2, 24, 4);
@@ -313,6 +315,9 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(clk[VF610_CLK_SAI2_SEL], clk[VF610_CLK_AUDIO_EXT]);
 	clk_set_parent(clk[VF610_CLK_SAI3_SEL], clk[VF610_CLK_AUDIO_EXT]);
 
+	clk_set_parent(clk[VF610_CLK_DCU0_SEL], clk[VF610_CLK_PLL1_PFD2]);
+	clk_set_rate(clk[VF610_CLK_DCU0_DIV], 113200000);
+
 	/* Add the clocks to provider list */
 	clk_data.clks = clk;
 	clk_data.clk_num = ARRAY_SIZE(clk);
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index 4aa2b48..4ccf563 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -160,6 +160,7 @@
 #define VF610_CLK_GPU2D			147
 #define VF610_CLK_ENET0			148
 #define VF610_CLK_ENET1			149
-#define VF610_CLK_END			150
+#define VF610_CLK_TCON0			150
+#define VF610_CLK_END			151
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
1.8.0


