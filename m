From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 13 Mar 2013 15:24:09 +0000
Subject: [PATCH] fbdev: fsl-diu-fb: optionally configure frame buffer depth in DT
Message-Id: <1363188249-29341-1-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

Add support for 'depth' property to configure default frame
buffer color depth over device tree.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 .../devicetree/bindings/powerpc/fsl/diu.txt        |    2 ++
 drivers/video/fsl-diu-fb.c                         |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/diu.txt b/Documentation/devicetree/bindings/powerpc/fsl/diu.txt
index b66cb6d..502aae5 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/diu.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/diu.txt
@@ -12,6 +12,7 @@ Required properties:
   services interrupts for this device.
 
 Optional properties:
+- depth : default frame buffer color depth
 - edid : verbatim EDID data block describing attached display.
   Data from the detailed timing descriptor will be used to
   program the display controller.
@@ -30,5 +31,6 @@ Example for MPC5121:
 		reg = <0x2100 0x100>;
 		interrupts = <64 0x8>;
 		interrupt-parent = <&ipic>;
+		depth = <16>;
 		edid = [edid-data];
 	};
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 41fbd94..2287817 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1534,6 +1534,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	const void *prop;
 	unsigned int i;
 	int ret;
+	u32 depth;
 
 	data = dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
 				   &dma_addr, GFP_DMA | __GFP_ZERO);
@@ -1584,6 +1585,21 @@ static int fsl_diu_probe(struct platform_device *pdev)
 		data->has_edid = true;
 	}
 
+	if (!of_property_read_u32(np, "depth", &depth)) {
+		switch (depth) {
+		case 32:
+		case 24:
+		case 16:
+		case 8:
+			default_bpp = depth;
+			break;
+		default:
+			dev_err(&pdev->dev,
+				"%s: invalid depth property\n",
+				np->full_name);
+		}
+	}
+
 	data->diu_reg = of_iomap(np, 0);
 	if (!data->diu_reg) {
 		dev_err(&pdev->dev, "cannot map DIU registers\n");
-- 
1.7.5.4

