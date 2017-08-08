From: Michal Simek <michal.simek@xilinx.com>
Date: Tue, 08 Aug 2017 08:10:25 +0000
Subject: [PATCH 1/2] video: fbdev: Fix multiple style issues in xilinxfb
Message-Id: <b07b143769ed5dccf44e9de4cb0d5c6203b3eca0.1502179820.git.michal.simek@xilinx.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Hyun Kwon <hyun.kwon@xilinx.com>

All reported by from checkpatch
./scripts/checkpatch.pl --max-line-length 120 -strict -f
drivers/video/fbdev/xilinxfb.c

WARNING: Block comments should align the * on each line
WARNING: Block comments use a trailing */ on a separate line
WARNING: Block comments use * on subsequent lines
WARNING: please, no space before tabs
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: braces {} are not necessary for single statement blocks
WARNING: Missing a blank line after declarations
WARNING: struct of_device_id should normally be const
CHECK: Please don't use multiple blank lines
CHECK: Blank lines aren't necessary after an open brace '{'
CHECK: Alignment should match open parenthesis
CHECK: 'Endianess' may be misspelled - perhaps 'Endianness'?
CHECK: spaces preferred around that '*' (ctx:VxV)
ERROR: that open brace { should be on the previous line

Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/video/fbdev/xilinxfb.c | 56 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xilinxfb.c
index 17dc119c7a98..0d828e46d704 100644
--- a/drivers/video/fbdev/xilinxfb.c
+++ b/drivers/video/fbdev/xilinxfb.c
@@ -41,7 +41,6 @@
 
 #define DRIVER_NAME		"xilinxfb"
 
-
 /*
  * Xilinx calls it "TFT LCD Controller" though it can also be used for
  * the VGA port on the Xilinx ML40x board. This is a hardware display
@@ -92,8 +91,9 @@ struct xilinxfb_platform_data {
 	u32 xvirt, yvirt;       /* resolution of memory buffer */
 
 	/* Physical address of framebuffer memory; If non-zero, driver
-	* will use provided memory address instead of allocating one from
-	* the consistent pool. */
+	 * will use provided memory address instead of allocating one from
+	 * the consistent pool.
+	 */
 	u32 fb_phys;
 };
 
@@ -128,18 +128,18 @@ struct xilinxfb_platform_data {
 	.activate =	FB_ACTIVATE_NOW
 };
 
-
 #define BUS_ACCESS_FLAG		0x1 /* 1 = BUS, 0 = DCR */
 #define LITTLE_ENDIAN_ACCESS	0x2 /* LITTLE ENDIAN IO functions */
 
 struct xilinxfb_drvdata {
-
 	struct fb_info	info;		/* FB driver info record */
 
 	phys_addr_t	regs_phys;	/* phys. address of the control
-						registers */
+					 * registers
+					 */
 	void __iomem	*regs;		/* virt. address of the control
-						registers */
+					 * registers
+					 */
 #ifdef CONFIG_PPC_DCR
 	dcr_host_t      dcr_host;
 	unsigned int    dcr_len;
@@ -148,7 +148,7 @@ struct xilinxfb_drvdata {
 	dma_addr_t	fb_phys;	/* phys. address of the frame buffer */
 	int		fb_alloced;	/* Flag, was the fb memory alloced? */
 
-	u8 		flags;		/* features of the driver */
+	u8		flags;		/* features of the driver */
 
 	u32		reg_ctrl_default;
 
@@ -165,7 +165,7 @@ struct xilinxfb_drvdata {
  * which bus its connected and call the appropriate write API.
  */
 static void xilinx_fb_out32(struct xilinxfb_drvdata *drvdata, u32 offset,
-				u32 val)
+			    u32 val)
 {
 	if (drvdata->flags & BUS_ACCESS_FLAG) {
 		if (drvdata->flags & LITTLE_ENDIAN_ACCESS)
@@ -195,8 +195,8 @@ static u32 xilinx_fb_in32(struct xilinxfb_drvdata *drvdata, u32 offset)
 }
 
 static int
-xilinx_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
-	unsigned transp, struct fb_info *fbi)
+xilinx_fb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
+		    unsigned int blue, unsigned int transp, struct fb_info *fbi)
 {
 	u32 *palette = fbi->pseudo_palette;
 
@@ -205,9 +205,11 @@ static u32 xilinx_fb_in32(struct xilinxfb_drvdata *drvdata, u32 offset)
 
 	if (fbi->var.grayscale) {
 		/* Convert color to grayscale.
-		 * grayscale = 0.30*R + 0.59*G + 0.11*B */
-		red = green = blue -			(red * 77 + green * 151 + blue * 28 + 127) >> 8;
+		 * grayscale = 0.30*R + 0.59*G + 0.11*B
+		 */
+		blue = (red * 77 + green * 151 + blue * 28 + 127) >> 8;
+		green = blue;
+		red = green;
 	}
 
 	/* fbi->fix.visual is always FB_VISUAL_TRUECOLOR */
@@ -241,13 +243,11 @@ static u32 xilinx_fb_in32(struct xilinxfb_drvdata *drvdata, u32 offset)
 		xilinx_fb_out32(drvdata, REG_CTRL, 0);
 	default:
 		break;
-
 	}
 	return 0; /* success */
 }
 
-static struct fb_ops xilinxfb_ops -{
+static struct fb_ops xilinxfb_ops = {
 	.owner			= THIS_MODULE,
 	.fb_setcolreg		= xilinx_fb_setcolreg,
 	.fb_blank		= xilinx_fb_blank,
@@ -286,7 +286,8 @@ static int xilinxfb_assign(struct platform_device *pdev,
 	} else {
 		drvdata->fb_alloced = 1;
 		drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
-					&drvdata->fb_phys, GFP_KERNEL);
+						      &drvdata->fb_phys,
+						      GFP_KERNEL);
 	}
 
 	if (!drvdata->fb_virt) {
@@ -300,7 +301,7 @@ static int xilinxfb_assign(struct platform_device *pdev,
 	/* Tell the hardware where the frame buffer is */
 	xilinx_fb_out32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
 	rc = xilinx_fb_in32(drvdata, REG_FB_ADDR);
-	/* Endianess detection */
+	/* Endianness detection */
 	if (rc != drvdata->fb_phys) {
 		drvdata->flags |= LITTLE_ENDIAN_ACCESS;
 		xilinx_fb_out32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
@@ -310,8 +311,7 @@ static int xilinxfb_assign(struct platform_device *pdev,
 	drvdata->reg_ctrl_default = REG_CTRL_ENABLE;
 	if (pdata->rotate_screen)
 		drvdata->reg_ctrl_default |= REG_CTRL_ROTATE;
-	xilinx_fb_out32(drvdata, REG_CTRL,
-					drvdata->reg_ctrl_default);
+	xilinx_fb_out32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
 
 	/* Fill struct fb_info */
 	drvdata->info.device = dev;
@@ -364,7 +364,7 @@ static int xilinxfb_assign(struct platform_device *pdev,
 err_cmap:
 	if (drvdata->fb_alloced)
 		dma_free_coherent(dev, PAGE_ALIGN(fbsize), drvdata->fb_virt,
-			drvdata->fb_phys);
+				  drvdata->fb_phys);
 	else
 		iounmap(drvdata->fb_virt);
 
@@ -435,12 +435,12 @@ static int xilinxfb_of_probe(struct platform_device *pdev)
 	 * Fill the resource structure if its direct BUS interface
 	 * otherwise fill the dcr_host structure.
 	 */
-	if (tft_access) {
+	if (tft_access)
 		drvdata->flags |= BUS_ACCESS_FLAG;
-	}
 #ifdef CONFIG_PPC_DCR
 	else {
 		int start;
+
 		start = dcr_resource_start(pdev->dev.of_node, 0);
 		drvdata->dcr_len = dcr_resource_len(pdev->dev.of_node, 0);
 		drvdata->dcr_host = dcr_map(pdev->dev.of_node, start, drvdata->dcr_len);
@@ -452,19 +452,19 @@ static int xilinxfb_of_probe(struct platform_device *pdev)
 #endif
 
 	prop = of_get_property(pdev->dev.of_node, "phys-size", &size);
-	if ((prop) && (size >= sizeof(u32)*2)) {
+	if ((prop) && (size >= sizeof(u32) * 2)) {
 		pdata.screen_width_mm = prop[0];
 		pdata.screen_height_mm = prop[1];
 	}
 
 	prop = of_get_property(pdev->dev.of_node, "resolution", &size);
-	if ((prop) && (size >= sizeof(u32)*2)) {
+	if ((prop) && (size >= sizeof(u32) * 2)) {
 		pdata.xres = prop[0];
 		pdata.yres = prop[1];
 	}
 
 	prop = of_get_property(pdev->dev.of_node, "virtual-resolution", &size);
-	if ((prop) && (size >= sizeof(u32)*2)) {
+	if ((prop) && (size >= sizeof(u32) * 2)) {
 		pdata.xvirt = prop[0];
 		pdata.yvirt = prop[1];
 	}
@@ -482,7 +482,7 @@ static int xilinxfb_of_remove(struct platform_device *op)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id xilinxfb_of_match[] = {
+static const struct of_device_id xilinxfb_of_match[] = {
 	{ .compatible = "xlnx,xps-tft-1.00.a", },
 	{ .compatible = "xlnx,xps-tft-2.00.a", },
 	{ .compatible = "xlnx,xps-tft-2.01.a", },
-- 
1.9.1

