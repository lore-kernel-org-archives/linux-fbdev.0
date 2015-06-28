From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:43:57 +0000
Subject: [PATCH 04/11] staging: sm750fb: insert space before open parenthesis
Message-Id: <1435535044-22042-5-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



Insert spaces before '(' according to checkpatch.pl message:
"ERROR: space required before the open parenthesis"

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 62 +++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index dcb5927..0e98cd3 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -44,7 +44,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 	 * successfully
 	 * */
 
-	if((ret = pci_request_region(pdev, 1, "sm750fb")))
+	if ((ret = pci_request_region(pdev, 1, "sm750fb")))
 	{
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
@@ -52,7 +52,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	/* now map mmio and vidmem*/
 	share->pvReg = ioremap_nocache(share->vidreg_start, share->vidreg_size);
-	if(!share->pvReg) {
+	if (!share->pvReg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
@@ -78,7 +78,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	/* reserve the vidmem space of smi adaptor */
 #if 0
-	if((ret = pci_request_region(pdev, 0, _moduleName_)))
+	if ((ret = pci_request_region(pdev, 0, _moduleName_)))
 	{
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
@@ -87,7 +87,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	share->pvMem = ioremap_wc(share->vidmem_start, share->vidmem_size);
 
-	if(!share->pvMem) {
+	if (!share->pvMem) {
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
@@ -107,19 +107,19 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 
 	spec_share = container_of(share, struct sm750_share, share);
 	parm = &spec_share->state.initParm;
-	if(parm->chip_clk = 0)
+	if (parm->chip_clk = 0)
 		parm->chip_clk = (getChipType() = SM750LE)?
 						DEFAULT_SM750LE_CHIP_CLOCK :
 						DEFAULT_SM750_CHIP_CLOCK;
 
-	if(parm->mem_clk = 0)
+	if (parm->mem_clk = 0)
 		parm->mem_clk = parm->chip_clk;
-	if(parm->master_clk = 0)
+	if (parm->master_clk = 0)
 		parm->master_clk = parm->chip_clk/3;
 
 	ddk750_initHw((initchip_param_t *)&spec_share->state.initParm);
 	/* for sm718,open pci burst */
-	if(share->devid = 0x718) {
+	if (share->devid = 0x718) {
 		POKE32(SYSTEM_CTRL,
 				FIELD_SET(PEEK32(SYSTEM_CTRL), SYSTEM_CTRL, PCI_BURST, ON));
 	}
@@ -130,10 +130,10 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	ddk750_initDVIDisp();
 #endif
 
-	if(getChipType() != SM750LE)
+	if (getChipType() != SM750LE)
 	{
 		/* does user need CRT ?*/
-		if(spec_share->state.nocrt) {
+		if (spec_share->state.nocrt) {
 			POKE32(MISC_CTRL,
 					FIELD_SET(PEEK32(MISC_CTRL),
 					MISC_CTRL,
@@ -191,7 +191,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	}
 
 	/* init 2d engine */
-	if(!share->accel_off) {
+	if (!share->accel_off) {
 		hw_sm750_initAccel(share);
 	}
 
@@ -228,19 +228,19 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 	channel = *output->channel;
 
 
-	if(getChipType() != SM750LE) {
-		if(channel = sm750_primary) {
+	if (getChipType() != SM750LE) {
+		if (channel = sm750_primary) {
 			pr_info("primary channel\n");
-			if(output->paths & sm750_panel)
+			if (output->paths & sm750_panel)
 				dispSet |= do_LCD1_PRI;
-			if(output->paths & sm750_crt)
+			if (output->paths & sm750_crt)
 				dispSet |= do_CRT_PRI;
 
 		}else{
 			pr_info("secondary channel\n");
-			if(output->paths & sm750_panel)
+			if (output->paths & sm750_panel)
 				dispSet |= do_LCD1_SEC;
-			if(output->paths & sm750_crt)
+			if (output->paths & sm750_crt)
 				dispSet |= do_CRT_SEC;
 
 		}
@@ -308,9 +308,9 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 	par = container_of(crtc, struct lynxfb_par, crtc);
 	share = par->share;
 #if 1
-	if(!share->accel_off) {
+	if (!share->accel_off) {
 		/* set 2d engine pixel format according to mode bpp */
-		switch(var->bits_per_pixel) {
+		switch (var->bits_per_pixel) {
 			case 8:
 				fmt = 0;
 				break;
@@ -341,19 +341,19 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 	modparm.vertical_total = var->yres + var->upper_margin + var->lower_margin + var->vsync_len;
 
 	/* choose pll */
-	if(crtc->channel != sm750_secondary)
+	if (crtc->channel != sm750_secondary)
 		clock = PRIMARY_PLL;
 	else
 		clock = SECONDARY_PLL;
 
 	pr_debug("Request pixel clock = %lu\n", modparm.pixel_clock);
 	ret = ddk750_setModeTiming(&modparm, clock);
-	if(ret) {
+	if (ret) {
 		pr_err("Set mode timing failed\n");
 		goto exit;
 	}
 
-	if(crtc->channel != sm750_secondary) {
+	if (crtc->channel != sm750_secondary) {
 		/* set pitch, offset ,width,start address ,etc... */
 		POKE32(PANEL_FB_ADDRESS,
 			FIELD_SET(0, PANEL_FB_ADDRESS, STATUS, CURRENT)|
@@ -429,7 +429,7 @@ int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
 int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank) {
 	int dpms, crtdb;
 
-	switch(blank)
+	switch (blank)
 	{
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
 		case FB_BLANK_UNBLANK:
@@ -473,7 +473,7 @@ int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank) {
 			return -EINVAL;
 	}
 
-	if(output->paths & sm750_crt) {
+	if (output->paths & sm750_crt) {
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, DPMS, dpms));
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, BLANK, crtdb));
 	}
@@ -535,13 +535,13 @@ int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 			break;
 	}
 
-	if(output->paths & sm750_crt) {
+	if (output->paths & sm750_crt) {
 
 		POKE32(SYSTEM_CTRL, FIELD_VALUE(PEEK32(SYSTEM_CTRL), SYSTEM_CTRL, DPMS, dpms));
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, BLANK, crtdb));
 	}
 
-	if(output->paths & sm750_panel) {
+	if (output->paths & sm750_panel) {
 		POKE32(PANEL_DISPLAY_CTRL, FIELD_VALUE(PEEK32(PANEL_DISPLAY_CTRL), PANEL_DISPLAY_CTRL, DATA, pps));
 	}
 
@@ -554,7 +554,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 	u32 reg;
 	enable2DEngine(1);
 
-	if(getChipType() = SM750LE) {
+	if (getChipType() = SM750LE) {
 		reg = PEEK32(DE_STATE1);
 		reg = FIELD_SET(reg, DE_STATE1, DE_ABORT, ON);
 		POKE32(DE_STATE1, reg);
@@ -581,9 +581,9 @@ void hw_sm750_initAccel(struct lynx_share *share)
 int hw_sm750le_deWait(void)
 {
 	int i=0x10000000;
-	while(i--) {
+	while (i--) {
 		unsigned int dwVal = PEEK32(DE_STATE2);
-		if((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
+		if ((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, DE_STATE2, DE_FIFO)  = DE_STATE2_DE_FIFO_EMPTY) &&
 			(FIELD_GET(dwVal, DE_STATE2, DE_MEM_FIFO) = DE_STATE2_DE_MEM_FIFO_EMPTY))
 		{
@@ -598,9 +598,9 @@ int hw_sm750le_deWait(void)
 int hw_sm750_deWait(void)
 {
 	int i=0x10000000;
-	while(i--) {
+	while (i--) {
 		unsigned int dwVal = PEEK32(SYSTEM_CTRL);
-		if((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
+		if ((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_FIFO)  = SYSTEM_CTRL_DE_FIFO_EMPTY) &&
 			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_MEM_FIFO) = SYSTEM_CTRL_DE_MEM_FIFO_EMPTY))
 		{
-- 
2.1.0

