From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 16 Apr 2012 00:33:12 +0000
Subject: [PATCH v2] video: exynos_dp: add analog and pll control setting
Message-Id: <000e01cd1b68$81562e70$84028b50$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds analog and pll control setting. This control setting
is used for DP TX PHY block to set the values as below. It is beneficial
to improve analog characteristics.
 - TX terminal registor is 50 Ohm.
 - Reference clock of PHY is 24 MHz.
 - Power source for TX digital logic is 1.0625 V.
 - Power source for internal clock driver is 1.0625 V.
 - PLL VCO range setting is 600 uA.
 - Power down ring osc is turned off.
 - AUX terminal resistor is 50 Ohm.
 - AUX channel current is 8 mA and multiplied by 2.
 - TX channel output amplitude is 400 mV.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.h |    1 +
 drivers/video/exynos/exynos_dp_reg.c  |   23 +++++++++++++++++++++++
 drivers/video/exynos/exynos_dp_reg.h  |   29 +++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
index 90ceaca..519c3a6 100644
--- a/drivers/video/exynos/exynos_dp_core.h
+++ b/drivers/video/exynos/exynos_dp_core.h
@@ -39,6 +39,7 @@ struct exynos_dp_device {
 void exynos_dp_enable_video_mute(struct exynos_dp_device *dp, bool enable);
 void exynos_dp_stop_video(struct exynos_dp_device *dp);
 void exynos_dp_lane_swap(struct exynos_dp_device *dp, bool enable);
+void exynos_dp_init_analog_param(struct exynos_dp_device *dp);
 void exynos_dp_init_interrupt(struct exynos_dp_device *dp);
 void exynos_dp_reset(struct exynos_dp_device *dp);
 void exynos_dp_config_interrupt(struct exynos_dp_device *dp);
diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
index 6548afa..38177d0 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -65,6 +65,28 @@ void exynos_dp_lane_swap(struct exynos_dp_device *dp, bool enable)
 	writel(reg, dp->reg_base + EXYNOS_DP_LANE_MAP);
 }
 
+void exynos_dp_init_analog_param(struct exynos_dp_device *dp)
+{
+	u32 reg;
+
+	reg = TX_TERMINAL_CTRL_50_OHM;
+	writel(reg, dp->reg_base + EXYNOS_DP_ANALOG_CTL_1);
+
+	reg = SEL_24M | TX_DVDD_BIT_1_0625V;
+	writel(reg, dp->reg_base + EXYNOS_DP_ANALOG_CTL_2);
+
+	reg = DRIVE_DVDD_BIT_1_0625V | VCO_BIT_600_MICRO;
+	writel(reg, dp->reg_base + EXYNOS_DP_ANALOG_CTL_3);
+
+	reg = PD_RING_OSC | AUX_TERMINAL_CTRL_50_OHM |
+		TX_CUR1_2X | TX_CUR_8_MA;
+	writel(reg, dp->reg_base + EXYNOS_DP_PLL_FILTER_CTL_1);
+
+	reg = CH3_AMP_400_MV | CH2_AMP_400_MV |
+		CH1_AMP_400_MV | CH0_AMP_400_MV;
+	writel(reg, dp->reg_base + EXYNOS_DP_TX_AMP_TUNING_CTL);
+}
+
 void exynos_dp_init_interrupt(struct exynos_dp_device *dp)
 {
 	/* Set interrupt pin assertion polarity as high */
@@ -131,6 +153,7 @@ void exynos_dp_reset(struct exynos_dp_device *dp)
 
 	writel(0x00000101, dp->reg_base + EXYNOS_DP_SOC_GENERAL_CTL);
 
+	exynos_dp_init_analog_param(dp);
 	exynos_dp_init_interrupt(dp);
 }
 
diff --git a/drivers/video/exynos/exynos_dp_reg.h b/drivers/video/exynos/exynos_dp_reg.h
index 42f608e..125b27c 100644
--- a/drivers/video/exynos/exynos_dp_reg.h
+++ b/drivers/video/exynos/exynos_dp_reg.h
@@ -24,6 +24,12 @@
 
 #define EXYNOS_DP_LANE_MAP			0x35C
 
+#define EXYNOS_DP_ANALOG_CTL_1			0x370
+#define EXYNOS_DP_ANALOG_CTL_2			0x374
+#define EXYNOS_DP_ANALOG_CTL_3			0x378
+#define EXYNOS_DP_PLL_FILTER_CTL_1		0x37C
+#define EXYNOS_DP_TX_AMP_TUNING_CTL		0x380
+
 #define EXYNOS_DP_AUX_HW_RETRY_CTL		0x390
 
 #define EXYNOS_DP_COMMON_INT_STA_1		0x3C4
@@ -166,6 +172,29 @@
 #define LANE0_MAP_LOGIC_LANE_2			(0x2 << 0)
 #define LANE0_MAP_LOGIC_LANE_3			(0x3 << 0)
 
+/* EXYNOS_DP_ANALOG_CTL_1 */
+#define TX_TERMINAL_CTRL_50_OHM			(0x1 << 4)
+
+/* EXYNOS_DP_ANALOG_CTL_2 */
+#define SEL_24M					(0x1 << 3)
+#define TX_DVDD_BIT_1_0625V			(0x4 << 0)
+
+/* EXYNOS_DP_ANALOG_CTL_3 */
+#define DRIVE_DVDD_BIT_1_0625V			(0x4 << 5)
+#define VCO_BIT_600_MICRO			(0x5 << 0)
+
+/* EXYNOS_DP_PLL_FILTER_CTL_1 */
+#define PD_RING_OSC				(0x1 << 6)
+#define AUX_TERMINAL_CTRL_50_OHM		(0x2 << 4)
+#define TX_CUR1_2X				(0x1 << 2)
+#define TX_CUR_8_MA				(0x2 << 0)
+
+/* EXYNOS_DP_TX_AMP_TUNING_CTL */
+#define CH3_AMP_400_MV				(0x0 << 24)
+#define CH2_AMP_400_MV				(0x0 << 16)
+#define CH1_AMP_400_MV				(0x0 << 8)
+#define CH0_AMP_400_MV				(0x0 << 0)
+
 /* EXYNOS_DP_AUX_HW_RETRY_CTL */
 #define AUX_BIT_PERIOD_EXPECTED_DELAY(x)	(((x) & 0x7) << 8)
 #define AUX_HW_RETRY_INTERVAL_MASK		(0x3 << 3)
-- 
1.7.1


