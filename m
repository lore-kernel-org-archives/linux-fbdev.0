From: Denis Carikli <denis@eukrea.com>
Date: Fri, 14 Mar 2014 09:12:48 +0000
Subject: [PATCH v7][ 4/5] ARM: dts: i.MX35: Add display support.
Message-Id: <1394788369-5096-4-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1394788369-5096-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

There is already a "dma ipu driver" for the mx3*
that is currently at drivers/dma/ipu/ipu_idmac.c

The mx3fb framebuffer driver uses this "dma ipu driver".

The goal is not to expose the "dma ipu driver" in the device
tree bindings, to make the mx3fb bindings look similar
to the ipuv3 ones.

In the device tree bindings, the "dma ipu driver" is absent,
and the mx3fb compatible is "fsl,imx<soc>-ipu".

An node for the mx3fb was also added in the imx35 dtsi.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v6->v7:
- Removed the Cc from the patch, they went into 
  git send-email instead.
- Removed the comment, and instead a commit messaage was 
  added to explain the non-straingtforward part of the change.

ChangeLog v5->v6:
- Shrinked the Cc list.

ChangeLog v4->v5:
- Added Grant Likely and Shawn Guo in the Cc list.
- Adapted to the new non-dma ipu bindings.
- Adapted to the use of imx35-pingrp.h
- The pinctrl ipu node addition was moved in this commit.

ChangeLog v3->v4:
- Splitted the imx35.dtsi display support (new patch).
---
 arch/arm/boot/dts/imx35.dtsi |    7 +++++++
 arch/arm/mach-imx/imx35-dt.c |    6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index e59ccb4..b9bf6a0 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -230,6 +230,13 @@
 				status = "disabled";
 			};
 
+			ipu: ipu@53fc0000 {
+				compatible = "fsl,imx35-ipu";
+				reg = <0x53fc0000 0x4000>;
+				clocks = <&clks 55>;
+				status = "disabled";
+			};
+
 			audmux: audmux@53fc4000 {
 				compatible = "fsl,imx35-audmux", "fsl,imx31-audmux";
 				reg = <0x53fc4000 0x4000>;
diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
index 9d48e00..657cc5d 100644
--- a/arch/arm/mach-imx/imx35-dt.c
+++ b/arch/arm/mach-imx/imx35-dt.c
@@ -18,14 +18,20 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "common.h"
+#include "devices-imx35.h"
 #include "mx35.h"
 
 static void __init imx35_dt_init(void)
 {
+	struct device_node *np;
 	mxc_arch_reset_init_dt();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     NULL, NULL);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx35-ipu");
+	if (of_device_is_available(np))
+		imx35_add_ipu_core();
 }
 
 static void __init imx35_irq_init(void)
-- 
1.7.9.5

