From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 26 Aug 2013 08:57:34 +0000
Subject: [PATCH 3/3] video: exynos_dp: Use the generic PHY driver
Message-Id: <004201cea23a$4e2c44d0$ea84ce70$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <003e01cea23a$03aac850$0b0058f0$%han@samsung.com>
In-Reply-To: <003e01cea23a$03aac850$0b0058f0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, 'devicetree' <devicetree@vger.kernel.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Felipe Balbi' <balbi@ti.com>, 'Tomasz Figa' <t.figa@samsung.com>, 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Jingoo Han' <jg1.han@samsung.com>

Use the generic PHY API to control the DP PHY.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 Documentation/devicetree/bindings/video/exynos_dp.txt |   17 +++++++++--------
 drivers/video/exynos/exynos_dp_core.c                 |   16 ++++++++++++----
 drivers/video/exynos/exynos_dp_core.h                 |    1 +
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
index 84f10c1..3289d76 100644
--- a/Documentation/devicetree/bindings/video/exynos_dp.txt
+++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
@@ -6,10 +6,10 @@ We use two nodes:
 	-dptx-phy node(defined inside dp-controller node)
 
 For the DP-PHY initialization, we use the dptx-phy node.
-Required properties for dptx-phy:
-	-reg:
+Required properties for dptx-phy: deprecated, use phys and phy-names
+	-reg: deprecated
 		Base address of DP PHY register.
-	-samsung,enable-mask:
+	-samsung,enable-mask: deprecated
 		The bit-mask used to enable/disable DP PHY.
 
 For the Panel initialization, we read data from dp-controller node.
@@ -27,6 +27,10 @@ Required properties for dp-controller:
 		from common clock binding: Shall be "dp".
 	-interrupt-parent:
 		phandle to Interrupt combiner node.
+	-phys:
+		from general PHY binding: the phandle for the PHY device.
+	-phy-names:
+		from general PHY binding: Should be "dp".
 	-samsung,color-space:
 		input video data format.
 			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
@@ -68,11 +72,8 @@ SOC specific portion:
 		clocks = <&clock 342>;
 		clock-names = "dp";
 
-		dptx-phy {
-			reg = <0x10040720>;
-			samsung,enable-mask = <1>;
-		};
-
+		phys = <&dp_phy>;
+		phy-names = "dp";
 	};
 
 Board Specific portion:
diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 05fed7d..5e1a715 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/of.h>
+#include <linux/phy/phy.h>
 
 #include "exynos_dp_core.h"
 
@@ -960,8 +961,11 @@ static int exynos_dp_dt_parse_phydata(struct exynos_dp_device *dp)
 
 	dp_phy_node = of_find_node_by_name(dp_phy_node, "dptx-phy");
 	if (!dp_phy_node) {
-		dev_err(dp->dev, "could not find dptx-phy node\n");
-		return -ENODEV;
+		dp->phy = devm_phy_get(dp->dev, "dp");
+		if (IS_ERR(dp->phy))
+			return PTR_ERR(dp->phy);
+		else
+			return 0;
 	}
 
 	if (of_property_read_u32(dp_phy_node, "reg", &phy_base)) {
@@ -992,7 +996,9 @@ err:
 
 static void exynos_dp_phy_init(struct exynos_dp_device *dp)
 {
-	if (dp->phy_addr) {
+	if (dp->phy) {
+		phy_power_on(dp->phy);
+	} else if (dp->phy_addr) {
 		u32 reg;
 
 		reg = __raw_readl(dp->phy_addr);
@@ -1003,7 +1009,9 @@ static void exynos_dp_phy_init(struct exynos_dp_device *dp)
 
 static void exynos_dp_phy_exit(struct exynos_dp_device *dp)
 {
-	if (dp->phy_addr) {
+	if (dp->phy) {
+		phy_power_off(dp->phy);
+	} else if (dp->phy_addr) {
 		u32 reg;
 
 		reg = __raw_readl(dp->phy_addr);
diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
index 56cfec8..607e36d 100644
--- a/drivers/video/exynos/exynos_dp_core.h
+++ b/drivers/video/exynos/exynos_dp_core.h
@@ -151,6 +151,7 @@ struct exynos_dp_device {
 	struct video_info	*video_info;
 	struct link_train	link_train;
 	struct work_struct	hotplug_work;
+	struct phy		*phy;
 };
 
 /* exynos_dp_reg.c */
-- 
1.7.10.4


