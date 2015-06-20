From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 18:36:40 +0000
Subject: [PATCH 06/19] staging: sm750fb: add space before open brace
Message-Id: <1434825413-4994-6-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
In-Reply-To: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl error:
ERROR: space required before the open brace '{'

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 14 ++++----
 drivers/staging/sm750fb/ddk750_mode.c    |  8 ++---
 drivers/staging/sm750fb/ddk750_power.c   |  4 +--
 drivers/staging/sm750fb/sm750_accel.c    |  6 ++--
 drivers/staging/sm750fb/sm750_cursor.c   | 14 ++++----
 drivers/staging/sm750fb/sm750_hw.c       | 56 ++++++++++++++++----------------
 6 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 973dec3..c7171a4 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -132,7 +132,7 @@ static void setDisplayControl(int ctrl, int dispState)
 static void waitNextVerticalSync(int ctrl, int delay)
 {
 	unsigned int status;
-	if (!ctrl){
+	if (!ctrl) {
 		/* primary controller */
 
 		/* Do not wait when the Primary PLL is off or display control is already off.
@@ -166,7 +166,7 @@ static void waitNextVerticalSync(int ctrl, int delay)
 			while (status = SYSTEM_CTRL_PANEL_VSYNC_INACTIVE);
 		}
 
-	}else{
+	}else {
 
 		/* Do not wait when the Primary PLL is off or display control is already off.
 			   This will prevent the software to wait forever. */
@@ -233,14 +233,14 @@ static void swPanelPowerSequence(int disp, int delay)
 void ddk750_setLogicalDispOut(disp_output_t output)
 {
 	unsigned int reg;
-	if (output & PNL_2_USAGE){
+	if (output & PNL_2_USAGE) {
 		/* set panel path controller select */
 		reg = PEEK32(PANEL_DISPLAY_CTRL);
 		reg = FIELD_VALUE(reg, PANEL_DISPLAY_CTRL, SELECT, (output & PNL_2_MASK)>>PNL_2_OFFSET);
 		POKE32(PANEL_DISPLAY_CTRL, reg);
 	}
 
-	if (output & CRT_2_USAGE){
+	if (output & CRT_2_USAGE) {
 		/* set crt path controller select */
 		reg = PEEK32(CRT_DISPLAY_CTRL);
 		reg = FIELD_VALUE(reg, CRT_DISPLAY_CTRL, SELECT, (output & CRT_2_MASK)>>CRT_2_OFFSET);
@@ -250,17 +250,17 @@ void ddk750_setLogicalDispOut(disp_output_t output)
 
 	}
 
-	if (output & PRI_TP_USAGE){
+	if (output & PRI_TP_USAGE) {
 		/* set primary timing and plane en_bit */
 		setDisplayControl(0, (output&PRI_TP_MASK)>>PRI_TP_OFFSET);
 	}
 
-	if (output & SEC_TP_USAGE){
+	if (output & SEC_TP_USAGE) {
 		/* set secondary timing and plane en_bit*/
 		setDisplayControl(1, (output&SEC_TP_MASK)>>SEC_TP_OFFSET);
 	}
 
-	if (output & PNL_SEQ_USAGE){
+	if (output & PNL_SEQ_USAGE) {
 		/* set  panel sequence */
 		swPanelPowerSequence((output&PNL_SEQ_MASK)>>PNL_SEQ_OFFSET, 4);
 	}
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index cfe528c..efc1fab 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -107,9 +107,9 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 					  FIELD_SET(0, CRT_DISPLAY_CTRL, PLANE, ENABLE);
 
 
-		if (getChipType() = SM750LE){
+		if (getChipType() = SM750LE) {
 			displayControlAdjust_SM750LE(pModeParam, ulTmpValue);
-		}else{
+		}else {
 			ulReg = PEEK32(CRT_DISPLAY_CTRL)
 					& FIELD_CLEAR(CRT_DISPLAY_CTRL, VSYNC_PHASE)
 					& FIELD_CLEAR(CRT_DISPLAY_CTRL, HSYNC_PHASE)
@@ -179,7 +179,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 		}
 #endif
 	}
-	else{
+	else {
 		ret = -1;
 	}
 	return ret;
@@ -193,7 +193,7 @@ int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
 	pll.clockType = clock;
 
 	uiActualPixelClk = calcPllValue(parm->pixel_clock, &pll);
-	if (getChipType() = SM750LE){
+	if (getChipType() = SM750LE) {
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index a2d9ee6..e2c0bb3 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -5,10 +5,10 @@
 void ddk750_setDPMS(DPMS_t state)
 {
 	unsigned int value;
-	if (getChipType() = SM750LE){
+	if (getChipType() = SM750LE) {
 		value = PEEK32(CRT_DISPLAY_CTRL);
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL, DPMS, state));
-	}else{
+	}else {
 		value = PEEK32(SYSTEM_CTRL);
 		value= FIELD_VALUE(value, SYSTEM_CTRL, DPMS, state);
 		POKE32(SYSTEM_CTRL, value);
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index bb96ea5..25dc15b 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -248,7 +248,7 @@ unsigned int rop2)   /* ROP value */
        Note that input pitch is BYTE value, but the 2D Pitch register uses
        pixel values. Need Byte to pixel conversion.
     */
-	if (Bpp = 3){
+	if (Bpp = 3) {
 			sx *= 3;
 			dx *= 3;
 			width *= 3;
@@ -271,7 +271,7 @@ unsigned int rop2)   /* ROP value */
 	FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/Bpp)) |
 	FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (sPitch/Bpp))); /* dpr3c */
 
-	if (accel->de_wait() != 0){
+	if (accel->de_wait() != 0) {
 		return -1;
 	}
 
@@ -363,7 +363,7 @@ int hw_imageblit(struct lynx_accel *accel,
        Note that input pitch is BYTE value, but the 2D Pitch register uses
        pixel values. Need Byte to pixel conversion.
     */
-	if (bytePerPixel = 3){
+	if (bytePerPixel = 3) {
 		dx *= 3;
 		width *= 3;
 		startBit *= 3;
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 95cfb8f..3a21af9 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -143,14 +143,14 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 			if (opr & (0x80 >> j))
 			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
-			}else{
+			}else {
 				/* use bg color,id = 1 */
 				data |= 1 << (j*2);
 			}
 		}
 #else
-		for (j=0;j<8;j++){
-			if (mask & (0x80>>j)){
+		for (j=0;j<8;j++) {
+			if (mask & (0x80>>j)) {
 				if (rop = ROP_XOR)
 					opr = mask ^ color;
 				else
@@ -173,7 +173,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-		}else{
+		}else {
 			pbuffer += sizeof(u16);
 		}
 
@@ -223,13 +223,13 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 			if (opr & (0x80 >> j))
 			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
-			}else{
+			}else {
 				/* use bg color,id = 1 */
 				data |= 1 << (j*2);
 			}
 		}
 #else
-		for (j=0;j<8;j++){
+		for (j=0;j<8;j++) {
 			if (mask & (1<<j))
 				data |= ((color & (1<<j))?1:2)<<(j*2);
 		}
@@ -242,7 +242,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-		}else{
+		}else {
 			pbuffer += sizeof(u16);
 		}
 
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 5abac9b..4dfc6e6 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -52,11 +52,11 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	/* now map mmio and vidmem*/
 	share->pvReg = ioremap_nocache(share->vidreg_start, share->vidreg_size);
-	if (!share->pvReg){
+	if (!share->pvReg) {
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
-	}else{
+	}else {
 		pr_info("mmio virtual addr = %p\n", share->pvReg);
 	}
 
@@ -87,11 +87,11 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	share->pvMem = ioremap_wc(share->vidmem_start, share->vidmem_size);
 
-	if (!share->pvMem){
+	if (!share->pvMem) {
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
-	}else{
+	}else {
 		pr_info("video memory vaddr = %p\n", share->pvMem);
 	}
 exit:
@@ -119,7 +119,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 
 	ddk750_initHw((initchip_param_t *)&spec_share->state.initParm);
 	/* for sm718,open pci burst */
-	if (share->devid = 0x718){
+	if (share->devid = 0x718) {
 		POKE32(SYSTEM_CTRL,
 				FIELD_SET(PEEK32(SYSTEM_CTRL), SYSTEM_CTRL, PCI_BURST, ON));
 	}
@@ -133,7 +133,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	if (getChipType() != SM750LE)
 	{
 		/* does user need CRT ?*/
-		if (spec_share->state.nocrt){
+		if (spec_share->state.nocrt) {
 			POKE32(MISC_CTRL,
 					FIELD_SET(PEEK32(MISC_CTRL),
 					MISC_CTRL,
@@ -143,7 +143,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 					FIELD_SET(PEEK32(SYSTEM_CTRL),
 					SYSTEM_CTRL,
 					DPMS, VNHN));
-		}else{
+		}else {
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
@@ -166,7 +166,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 							spec_share->state.pnltype));
 			break;
 		}
-	}else{
+	}else {
 		/* for 750LE ,no DVI chip initilization makes Monitor no signal */
 		/* Set up GPIO for software I2C to program DVI chip in the
 		   Xilinx SP605 board, in order to have video signal.
@@ -191,7 +191,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	}
 
 	/* init 2d engine */
-	if (!share->accel_off){
+	if (!share->accel_off) {
 		hw_sm750_initAccel(share);
 	}
 
@@ -228,15 +228,15 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 	channel = *output->channel;
 
 
-	if (getChipType() != SM750LE){
-		if (channel = sm750_primary){
+	if (getChipType() != SM750LE) {
+		if (channel = sm750_primary) {
 			pr_info("primary channel\n");
 			if (output->paths & sm750_panel)
 				dispSet |= do_LCD1_PRI;
 			if (output->paths & sm750_crt)
 				dispSet |= do_CRT_PRI;
 
-		}else{
+		}else {
 			pr_info("secondary channel\n");
 			if (output->paths & sm750_panel)
 				dispSet |= do_LCD1_SEC;
@@ -245,7 +245,7 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 
 		}
 		ddk750_setLogicalDispOut(dispSet);
-	}else{
+	}else {
 		/* just open DISPLAY_CONTROL_750LE register bit 3:0*/
 		u32 reg;
 		reg = PEEK32(DISPLAY_CONTROL_750LE);
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
-	if (!share->accel_off){
+	if (!share->accel_off) {
 		/* set 2d engine pixel format according to mode bpp */
-		switch (var->bits_per_pixel){
+		switch (var->bits_per_pixel) {
 			case 8:
 				fmt = 0;
 				break;
@@ -348,12 +348,12 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 
 	pr_debug("Request pixel clock = %lu\n", modparm.pixel_clock);
 	ret = ddk750_setModeTiming(&modparm, clock);
-	if (ret){
+	if (ret) {
 		pr_err("Set mode timing failed\n");
 		goto exit;
 	}
 
-	if (crtc->channel != sm750_secondary){
+	if (crtc->channel != sm750_secondary) {
 		/* set pitch, offset ,width,start address ,etc... */
 		POKE32(PANEL_FB_ADDRESS,
 			FIELD_SET(0, PANEL_FB_ADDRESS, STATUS, CURRENT)|
@@ -389,7 +389,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc* crtc,
 			PANEL_DISPLAY_CTRL, FORMAT,
 			(var->bits_per_pixel >> 4)
 			));
-	}else{
+	}else {
 		/* not implemented now */
 		POKE32(CRT_FB_ADDRESS, crtc->oScreen);
 		reg = var->xres * (var->bits_per_pixel >> 3);
@@ -426,7 +426,7 @@ int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
 	return 0;
 }
 
-int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank){
+int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank) {
 	int dpms, crtdb;
 	
 	switch (blank)
@@ -473,7 +473,7 @@ int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank){
 			return -EINVAL;
 	}
 
-	if (output->paths & sm750_crt){
+	if (output->paths & sm750_crt) {
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, DPMS, dpms));
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, BLANK, crtdb));
 	}
@@ -535,13 +535,13 @@ int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 			break;
 	}
 
-	if (output->paths & sm750_crt){
+	if (output->paths & sm750_crt) {
 
 		POKE32(SYSTEM_CTRL, FIELD_VALUE(PEEK32(SYSTEM_CTRL), SYSTEM_CTRL, DPMS, dpms));
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, BLANK, crtdb));
 	}
 
-	if (output->paths & sm750_panel){
+	if (output->paths & sm750_panel) {
 		POKE32(PANEL_DISPLAY_CTRL, FIELD_VALUE(PEEK32(PANEL_DISPLAY_CTRL), PANEL_DISPLAY_CTRL, DATA, pps));
 	}
 
@@ -554,7 +554,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 	u32 reg;
 	enable2DEngine(1);
 
-	if (getChipType() = SM750LE){
+	if (getChipType() = SM750LE) {
 		reg = PEEK32(DE_STATE1);
 		reg = FIELD_SET(reg, DE_STATE1, DE_ABORT, ON);
 		POKE32(DE_STATE1, reg);
@@ -563,7 +563,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 		reg = FIELD_SET(reg, DE_STATE1, DE_ABORT, OFF);
 		POKE32(DE_STATE1, reg);
 
-	}else{
+	}else {
 		/* engine reset */
 		reg = PEEK32(SYSTEM_CTRL);
 	    reg = FIELD_SET(reg, SYSTEM_CTRL, DE_ABORT, ON);
@@ -581,7 +581,7 @@ void hw_sm750_initAccel(struct lynx_share *share)
 int hw_sm750le_deWait(void)
 {
 	int i=0x10000000;
-	while (i--){
+	while (i--) {
 		unsigned int dwVal = PEEK32(DE_STATE2);
 		if ((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, DE_STATE2, DE_FIFO)  = DE_STATE2_DE_FIFO_EMPTY) &&
@@ -598,7 +598,7 @@ int hw_sm750le_deWait(void)
 int hw_sm750_deWait(void)
 {
 	int i=0x10000000;
-	while (i--){
+	while (i--) {
 		unsigned int dwVal = PEEK32(SYSTEM_CTRL);
 		if ((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_FIFO)  = SYSTEM_CTRL_DE_FIFO_EMPTY) &&
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
