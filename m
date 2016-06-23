From: wolzstefan@web.de
Date: Thu, 23 Jun 2016 12:00:12 +0000
Subject: [PATCH 3/4] sm750fb/sm750_hw.c: fixed comments
Message-Id: <1466683213-17477-4-git-send-email-wolzstefan@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1466683213-17477-1-git-send-email-wolzstefan@web.de>
In-Reply-To: <1466683213-17477-1-git-send-email-wolzstefan@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de, Stefan Wolz <wolzstefan@web.de>, Christian Halder <christian.halder@fau.de>, Sebastian Handwerker <sebastian.handwerker@posteo.de>

From: Stefan Wolz <wolzstefan@web.de>

Fixed multiline comments to meet style standards,
fixed typos and split comment lines over 80 characters.

Signed-off-by: Stefan Wolz <wolzstefan@web.de>
Signed-off-by: Christian Halder <christian.halder@fau.de>
Signed-off-by: Sebastian Handwerker <sebastian.handwerker@posteo.de>
---
 drivers/staging/sm750fb/sm750_hw.c | 48 +++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 052f113..f2ed82e 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -35,17 +35,17 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	pr_info("mmio phyAddr = %lx\n", sm750_dev->vidreg_start);
 
 	/* reserve the vidreg space of smi adaptor
-	 * if you do this, u need to add release region code
+	 * if you do this, you need to add release region code
 	 * in lynxfb_remove, or memory will not be mapped again
 	 * successfully
-	 * */
+	 */
 	ret = pci_request_region(pdev, 1, "sm750fb");
 	if (ret) {
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
 	}
 
-	/* now map mmio and vidmem*/
+	/* now map mmio and vidmem */
 	sm750_dev->pvReg = ioremap_nocache(sm750_dev->vidreg_start,
 					   sm750_dev->vidreg_size);
 	if (!sm750_dev->pvReg) {
@@ -63,10 +63,10 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
 	/* don't use pdev_resource[x].end - resource[x].start to
-	 * calculate the resource size,its only the maximum available
-	 * size but not the actual size,use
+	 * calculate the resource size, it's only the maximum available
+	 * size but not the actual size, using
 	 * @ddk750_getVMSize function can be safe.
-	 * */
+	 */
 	sm750_dev->vidmem_size = ddk750_getVMSize();
 	pr_info("video memory phyAddr = %lx, size = %u bytes\n",
 		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
@@ -101,7 +101,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		parm->master_clk = parm->chip_clk / 3;
 
 	ddk750_initHw((initchip_param_t *)&sm750_dev->initParm);
-	/* for sm718,open pci burst */
+	/* for sm718, open pci burst */
 	if (sm750_dev->devid = 0x718) {
 		POKE32(SYSTEM_CTRL,
 		       PEEK32(SYSTEM_CTRL) | SYSTEM_CTRL_PCI_BURST);
@@ -109,7 +109,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 	if (getChipType() != SM750LE) {
 		unsigned int val;
-		/* does user need CRT ?*/
+		/* does user need CRT? */
 		if (sm750_dev->nocrt) {
 			POKE32(MISC_CTRL,
 			       PEEK32(MISC_CTRL) | MISC_CTRL_DAC_POWER_OFF);
@@ -141,19 +141,21 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		}
 		POKE32(PANEL_DISPLAY_CTRL, val);
 	} else {
-		/* for 750LE ,no DVI chip initialization makes Monitor no signal */
-		/* Set up GPIO for software I2C to program DVI chip in the
-		   Xilinx SP605 board, in order to have video signal.
+		/* for 750LE, no DVI chip initialization
+		 * makes Monitor no signal
+		 *
+		 * Set up GPIO for software I2C to program DVI chip in the
+		 * Xilinx SP605 board, in order to have video signal.
 		 */
 		sm750_sw_i2c_init(0, 1);
 
 		/* Customer may NOT use CH7301 DVI chip, which has to be
-		initialized differently.
-		*/
+		 * initialized differently.
+		 */
 		if (sm750_sw_i2c_read_reg(0xec, 0x4a) = 0x95) {
 		/* The following register values for CH7301 are from
-		   Chrontel app note and our experiment.
-		*/
+		 * Chrontel app note and our experiment.
+		 */
 			pr_info("yes,CH7301 DVI chip found\n");
 			sm750_sw_i2c_write_reg(0xec, 0x1d, 0x16);
 			sm750_sw_i2c_write_reg(0xec, 0x21, 0x9);
@@ -198,7 +200,7 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 		}
 		ddk750_setLogicalDispOut(dispSet);
 	} else {
-		/* just open DISPLAY_CONTROL_750LE register bit 3:0*/
+		/* just open DISPLAY_CONTROL_750LE register bit 3:0 */
 		u32 reg;
 
 		reg = PEEK32(DISPLAY_CONTROL_750LE);
@@ -234,9 +236,7 @@ int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc, struct fb_var_screeninfo *
 	return 0;
 }
 
-/*
-	set the controller's mode for @crtc charged with @var and @fix parameters
-*/
+/* set the controller's mode for @crtc charged with @var and @fix parameters */
 int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 			  struct fb_var_screeninfo *var,
 			  struct fb_fix_screeninfo *fix)
@@ -300,12 +300,14 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 	}
 
 	if (crtc->channel != sm750_secondary) {
-		/* set pitch, offset ,width,start address ,etc... */
+		/* set pitch, offset, width, start address, etc... */
 		POKE32(PANEL_FB_ADDRESS,
 		       crtc->oScreen & PANEL_FB_ADDRESS_ADDRESS_MASK);
 
 		reg = var->xres * (var->bits_per_pixel >> 3);
-		/* crtc->channel is not equal to par->index on numeric,be aware of that */
+		/* crtc->channel is not equal to par->index on numeric,
+		 * be aware of that
+		 */
 		reg = ALIGN(reg, crtc->line_pad);
 		reg = (reg << PANEL_FB_WIDTH_WIDTH_SHIFT) &
 		       PANEL_FB_WIDTH_WIDTH_MASK;
@@ -337,7 +339,9 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		/* not implemented now */
 		POKE32(CRT_FB_ADDRESS, crtc->oScreen);
 		reg = var->xres * (var->bits_per_pixel >> 3);
-		/* crtc->channel is not equal to par->index on numeric,be aware of that */
+		/* crtc->channel is not equal to par->index on numeric,
+		 * be aware of that
+		 */
 		reg = ALIGN(reg, crtc->line_pad) << CRT_FB_WIDTH_WIDTH_SHIFT;
 		reg &= CRT_FB_WIDTH_WIDTH_MASK;
 		reg |= (fix->line_length & CRT_FB_WIDTH_OFFSET_MASK);
-- 
1.9.1

