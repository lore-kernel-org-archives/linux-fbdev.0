From: Anatoly Stepanov <drivengroove@gmail.com>
Date: Sun, 28 Jun 2015 23:43:56 +0000
Subject: [PATCH 03/11] staging: sm750fb: insert space between ')' and '{'
Message-Id: <1435535044-22042-4-git-send-email-drivengroove@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org



Insert spaces according to checkpatch.pl message:
"ERROR: space required before the open brace '{'"

Signed-off-by: Anatoly Stepanov <drivengroove@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 1dd20be..dcb5927 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -52,7 +52,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	/* now map mmio and vidmem*/
 	share->pvReg = ioremap_nocache(share->vidreg_start, share->vidreg_size);
-	if(!share->pvReg){
+	if(!share->pvReg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
@@ -87,7 +87,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	share->pvMem = ioremap_wc(share->vidmem_start, share->vidmem_size);
 
-	if(!share->pvMem){
+	if(!share->pvMem) {
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
@@ -119,7 +119,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 
 	ddk750_initHw((initchip_param_t *)&spec_share->state.initParm);
 	/* for sm718,open pci burst */
-	if(share->devid = 0x718){
+	if(share->devid = 0x718) {
 		POKE32(SYSTEM_CTRL,
 				FIELD_SET(PEEK32(SYSTEM_CTRL), SYSTEM_CTRL, PCI_BURST, ON));
 	}
@@ -133,7 +133,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	if(getChipType() != SM750LE)
 	{
 		/* does user need CRT ?*/
-		if(spec_share->state.nocrt){
+		if(spec_share->state.nocrt) {
 			POKE32(MISC_CTRL,
 					FIELD_SET(PEEK32(MISC_CTRL),
 					MISC_CTRL,
@@ -155,7 +155,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 					DPMS, VPHP));
 		}
 
-		switch (spec_share->state.pnltype){
+		switch (spec_share->state.pnltype) {
 			case sm750_doubleTFT:
 			case sm750_24TFT:
 			case sm750_dualTFT:
@@ -191,7 +191,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	}
 
 	/* init 2d engine */
-	if(!share->accel_off){
+	if(!share->accel_off) {
 		hw_sm750_initAccel(share);
 	}
 
@@ -228,8 +228,8 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 	channel = *output->channel;
 
 
-	if(getChipType() != SM750LE){
-		if(channel = sm750_primary){
+	if(getChipType() != SM750LE) {
+		if(channel = sm750_primary) {
 			pr_info("primary channel\n");
 			if(output->paths & sm750_panel)
 				dispSet |= do_LCD1_PRI;
@@ -270,7 +270,7 @@ int hw_sm750_crtc_checkMode(struct lynxfb_crtc* crtc, struct fb_var_screeninfo*
 
 	share = container_of(crtc, struct lynxfb_par, crtc)->share;
 
-	switch (var->bits_per_pixel){
+	switch (var->bits_per_pixel) {
 		case 8:
 		case 16:
 			break;
@@ -308,9 +308,9 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 	par = container_of(crtc, struct lynxfb_par, crtc);
 	share = par->share;
 #if 1
-	if(!share->accel_off){
+	if(!share->accel_off) {
 		/* set 2d engine pixel format according to mode bpp */
-		switch(var->bits_per_pixel){
+		switch(var->bits_per_pixel) {
 			case 8:
 				fmt = 0;
 				break;
@@ -348,12 +348,12 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 
 	pr_debug("Request pixel clock = %lu\n", modparm.pixel_clock);
 	ret = ddk750_setModeTiming(&modparm, clock);
-	if(ret){
+	if(ret) {
 		pr_err("Set mode timing failed\n");
 		goto exit;
 	}
 
-	if(crtc->channel != sm750_secondary){
+	if(crtc->channel != sm750_secondary) {
 		/* set pitch, offset ,width,start address ,etc... */
 		POKE32(PANEL_FB_ADDRESS,
 			FIELD_SET(0, PANEL_FB_ADDRESS, STATUS, CURRENT)|
@@ -426,7 +426,7 @@ int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
 	return 0;
 }
 
-int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank){
+int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank) {
 	int dpms, crtdb;
 
 	switch(blank)
@@ -473,7 +473,7 @@ int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank){
 			return -EINVAL;
 	}
 
-	if(output->paths & sm750_crt){
+	if(output->paths & sm750_crt) {
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, DPMS, dpms));
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, BLANK, crtdb));
 	}
@@ -535,13 +535,13 @@ int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 			break;
 	}
 
-	if(output->paths & sm750_crt){
+	if(output->paths & sm750_crt) {
 
 		POKE32(SYSTEM_CTRL, FIELD_VALUE(PEEK32(SYSTEM_CTRL), SYSTEM_CTRL, DPMS, dpms));
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, BLANK, crtdb));
 	}
 
-	if(output->paths & sm750_panel){
+	if(output->paths & sm750_panel) {
 		POKE32(PANEL_DISPLAY_CTRL, FIELD_VALUE(PEEK32(PANEL_DISPLAY_CTRL), PANEL_DISPLAY_CTRL, DATA, pps));
 	}
 
@@ -554,7 +554,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 	u32 reg;
 	enable2DEngine(1);
 
-	if(getChipType() = SM750LE){
+	if(getChipType() = SM750LE) {
 		reg = PEEK32(DE_STATE1);
 		reg = FIELD_SET(reg, DE_STATE1, DE_ABORT, ON);
 		POKE32(DE_STATE1, reg);
@@ -581,7 +581,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 int hw_sm750le_deWait(void)
 {
 	int i=0x10000000;
-	while(i--){
+	while(i--) {
 		unsigned int dwVal = PEEK32(DE_STATE2);
 		if((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, DE_STATE2, DE_FIFO)  = DE_STATE2_DE_FIFO_EMPTY) &&
@@ -598,7 +598,7 @@ int hw_sm750le_deWait(void)
 int hw_sm750_deWait(void)
 {
 	int i=0x10000000;
-	while(i--){
+	while(i--) {
 		unsigned int dwVal = PEEK32(SYSTEM_CTRL);
 		if((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_FIFO)  = SYSTEM_CTRL_DE_FIFO_EMPTY) &&
-- 
2.1.0

