From: Denis Carikli <denis@eukrea.com>
Date: Wed, 26 Feb 2014 09:59:58 +0000
Subject: [PATCHv6][ 4/5] ARM: dts: i.MX35: Add display support.
Message-Id: <1393408800-8946-4-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393408800-8946-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1393408800-8946-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

A pinctrl node for the IPU was also added.

Cc: Eric B=C3=A9nard <eric@eukrea.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
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
 arch/arm/mach-imx/imx35-dt.c |    7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 88b218f..e6ad2a4 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -229,6 +229,13 @@
 				status =3D "disabled";
 			};
=20
+			ipu: ipu@53fc0000 {
+				compatible =3D "fsl,imx35-ipu";
+				reg =3D <0x53fc0000 0x4000>;
+				clocks =3D <&clks 55>;
+				status =3D "disabled";
+			};
+
 			audmux: audmux@53fc4000 {
 				compatible =3D "fsl,imx35-audmux", "fsl,imx31-audmux";
 				reg =3D <0x53fc4000 0x4000>;
diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
index 9d48e00..c2919a8 100644
--- a/arch/arm/mach-imx/imx35-dt.c
+++ b/arch/arm/mach-imx/imx35-dt.c
@@ -18,14 +18,21 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "common.h"
+#include "devices-imx35.h"
 #include "mx35.h"
=20
 static void __init imx35_dt_init(void)
 {
+	struct device_node *np;
 	mxc_arch_reset_init_dt();
=20
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     NULL, NULL);
+
+	/* We don't want to export the IPU as DT bindings. */
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx35-ipu");
+	if (of_device_is_available(np))
+		imx35_add_ipu_core();
 }
=20
 static void __init imx35_irq_init(void)
--=20
1.7.9.5

