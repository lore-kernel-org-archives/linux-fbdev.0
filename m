From: Denis Carikli <denis@eukrea.com>
Date: Mon, 04 Nov 2013 16:15:20 +0000
Subject: [PATCHv4][ 2/6] dma: ipu: Add devicetree support.
Message-Id: <1383581724-14817-2-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383581724-14817-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1383581724-14817-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v3->v4:
- Synced the documentation with the code.

ChangeLog v2->v3:
- The DMA channels are not exposed anymore in order to look more like the I=
PUv3
  bindings.
---
 .../devicetree/bindings/dma/fsl-imx-ipu.txt        |   20 ++++++++++++++++=
++++
 drivers/dma/ipu/ipu_idmac.c                        |    8 ++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt b/Docume=
ntation/devicetree/bindings/dma/fsl-imx-ipu.txt
new file mode 100644
index 0000000..2f3c976
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-ipu.txt
@@ -0,0 +1,20 @@
+* Freescale Image Processing Unit (IPU) support for i.MX3x.
+
+This driver supports the imx31 and imx35 devices.
+
+Required properties:
+- compatible : Should be "fsl,imx31-ipu".
+- reg : Should contain IPU registers location and length.
+- interrupts : First item should be IPU interrupt, second one is optional =
and
+    should contain IPU Error interrupt.
+
+Example:
+
+	ipu: ipu@53fc0000 {
+		compatible =3D "fsl,imx31-ipu";
+		reg =3D <	0x53fc0000 0x5f
+			0x53fc0088 0x2b >;
+		interrupts =3D <42 41>;
+		clocks =3D <&clks 55>;
+		clock-names =3D "";
+	};
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index cb9c0bc..d853ee1 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/dma/ipu-dma.h>
=20
 #include "../dmaengine.h"
@@ -1768,6 +1769,12 @@ static int ipu_remove(struct platform_device *pdev)
 	return 0;
 }
=20
+static const struct of_device_id ipu_dma_of_dev_id[] =3D {
+	{ .compatible =3D "fsl,imx31-ipu", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ipu_dma_of_dev_id);
+
 /*
  * We need two MEM resources - with IPU-common and Image Converter registe=
rs,
  * including PF_CONF and IDMAC_* registers, and two IRQs - function and er=
ror
@@ -1775,6 +1782,7 @@ static int ipu_remove(struct platform_device *pdev)
 static struct platform_driver ipu_platform_driver =3D {
 	.driver =3D {
 		.name	=3D "ipu-core",
+		.of_match_table =3D of_match_ptr(ipu_dma_of_dev_id),
 		.owner	=3D THIS_MODULE,
 	},
 	.remove		=3D ipu_remove,
--=20
1.7.9.5

