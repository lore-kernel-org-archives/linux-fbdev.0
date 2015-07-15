From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 15 Jul 2015 04:14:33 +0000
Subject: [PATCH v5 04/19] staging: sm750fb: add space before open parenthesis
Message-Id: <1436933688-5408-4-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
In-Reply-To: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl error:
ERROR: space required before the open parenthesis '('

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 20 ++++++++++----------
 drivers/staging/sm750fb/ddk750_dvi.c     |  2 +-
 drivers/staging/sm750fb/ddk750_help.c    |  2 +-
 drivers/staging/sm750fb/ddk750_mode.c    | 12 ++++++------
 drivers/staging/sm750fb/ddk750_power.c   |  6 +++---
 drivers/staging/sm750fb/sm750_accel.c    |  8 ++++----
 drivers/staging/sm750fb/sm750_cursor.c   | 32 ++++++++++++++++----------------
 drivers/staging/sm750fb/sm750_help.h     |  2 +-
 8 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 1c4049f..973dec3 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -49,7 +49,7 @@ static void setDisplayControl(int ctrl, int dispState)
 			{
 				cnt++;
 				POKE32(PANEL_DISPLAY_CTRL, ulDisplayCtrlReg);
-			} while((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) !+			} while ((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) ! 					(ulDisplayCtrlReg & ~ulReservedBits));
 			printk("Set Panel Plane enbit:after tried %d times\n", cnt);
 		}
@@ -104,7 +104,7 @@ static void setDisplayControl(int ctrl, int dispState)
 			{
 				cnt++;
 				POKE32(CRT_DISPLAY_CTRL, ulDisplayCtrlReg);
-			} while((PEEK32(CRT_DISPLAY_CTRL) & ~ulReservedBits) !+			} while ((PEEK32(CRT_DISPLAY_CTRL) & ~ulReservedBits) ! 					(ulDisplayCtrlReg & ~ulReservedBits));
 				printk("Set Crt Plane enbit:after tried %d times\n", cnt);
 		}
@@ -132,7 +132,7 @@ static void setDisplayControl(int ctrl, int dispState)
 static void waitNextVerticalSync(int ctrl, int delay)
 {
 	unsigned int status;
-	if(!ctrl){
+	if (!ctrl){
 		/* primary controller */
 
 		/* Do not wait when the Primary PLL is off or display control is already off.
@@ -233,14 +233,14 @@ static void swPanelPowerSequence(int disp, int delay)
 void ddk750_setLogicalDispOut(disp_output_t output)
 {
 	unsigned int reg;
-	if(output & PNL_2_USAGE){
+	if (output & PNL_2_USAGE){
 		/* set panel path controller select */
 		reg = PEEK32(PANEL_DISPLAY_CTRL);
 		reg = FIELD_VALUE(reg, PANEL_DISPLAY_CTRL, SELECT, (output & PNL_2_MASK)>>PNL_2_OFFSET);
 		POKE32(PANEL_DISPLAY_CTRL, reg);
 	}
 
-	if(output & CRT_2_USAGE){
+	if (output & CRT_2_USAGE){
 		/* set crt path controller select */
 		reg = PEEK32(CRT_DISPLAY_CTRL);
 		reg = FIELD_VALUE(reg, CRT_DISPLAY_CTRL, SELECT, (output & CRT_2_MASK)>>CRT_2_OFFSET);
@@ -250,25 +250,25 @@ void ddk750_setLogicalDispOut(disp_output_t output)
 
 	}
 
-	if(output & PRI_TP_USAGE){
+	if (output & PRI_TP_USAGE){
 		/* set primary timing and plane en_bit */
 		setDisplayControl(0, (output&PRI_TP_MASK)>>PRI_TP_OFFSET);
 	}
 
-	if(output & SEC_TP_USAGE){
+	if (output & SEC_TP_USAGE){
 		/* set secondary timing and plane en_bit*/
 		setDisplayControl(1, (output&SEC_TP_MASK)>>SEC_TP_OFFSET);
 	}
 
-	if(output & PNL_SEQ_USAGE){
+	if (output & PNL_SEQ_USAGE){
 		/* set  panel sequence */
 		swPanelPowerSequence((output&PNL_SEQ_MASK)>>PNL_SEQ_OFFSET, 4);
 	}
 
-	if(output & DAC_USAGE)
+	if (output & DAC_USAGE)
 		setDAC((output & DAC_MASK)>>DAC_OFFSET);
 
-	if(output & DPMS_USAGE)
+	if (output & DPMS_USAGE)
 		ddk750_setDPMS((output & DPMS_MASK) >> DPMS_OFFSET);
 }
 
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 35866fa..4c64436 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -45,7 +45,7 @@ int dviInit(
 {
 	dvi_ctrl_device_t *pCurrentDviCtrl;
 	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if(pCurrentDviCtrl->pfnInit != NULL)
+	if (pCurrentDviCtrl->pfnInit != NULL)
 	{
 		return pCurrentDviCtrl->pfnInit(edgeSelect, busSelect, dualEdgeClkSelect, hsyncEnable,
 						vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
diff --git a/drivers/staging/sm750fb/ddk750_help.c b/drivers/staging/sm750fb/ddk750_help.c
index f027df5..9637dd3 100644
--- a/drivers/staging/sm750fb/ddk750_help.c
+++ b/drivers/staging/sm750fb/ddk750_help.c
@@ -10,7 +10,7 @@ void ddk750_set_mmio(void __iomem *addr, unsigned short devId, char revId)
 	mmio750 = addr;
 	devId750 = devId;
 	revId750 = revId;
-	if(revId = 0xfe)
+	if (revId = 0xfe)
 		printk("found sm750le\n");
 }
 
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 4ee9ceb..cfe528c 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -80,7 +80,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 	int ret = 0;
 	int cnt = 0;
 	unsigned int ulTmpValue, ulReg;
-	if(pll->clockType = SECONDARY_PLL)
+	if (pll->clockType = SECONDARY_PLL)
 	{
 		/* programe secondary pixel clock */
 		POKE32(CRT_PLL_CTRL, formatPllReg(pll));
@@ -107,7 +107,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 					  FIELD_SET(0, CRT_DISPLAY_CTRL, PLANE, ENABLE);
 
 
-		if(getChipType() = SM750LE){
+		if (getChipType() = SM750LE){
 			displayControlAdjust_SM750LE(pModeParam, ulTmpValue);
 		}else{
 			ulReg = PEEK32(CRT_DISPLAY_CTRL)
@@ -120,7 +120,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 		}
 
 	}
-	else if(pll->clockType = PRIMARY_PLL)
+	else if (pll->clockType = PRIMARY_PLL)
 	{
 		unsigned int ulReservedBits;
 		POKE32(PANEL_PLL_CTRL, formatPllReg(pll));
@@ -170,10 +170,10 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 
 		POKE32(PANEL_DISPLAY_CTRL, ulTmpValue|ulReg);
 #if 1
-		while((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) != (ulTmpValue|ulReg))
+		while ((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) != (ulTmpValue|ulReg))
 		{
 			cnt++;
-			if(cnt > 1000)
+			if (cnt > 1000)
 				break;
 			POKE32(PANEL_DISPLAY_CTRL, ulTmpValue|ulReg);
 		}
@@ -193,7 +193,7 @@ int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
 	pll.clockType = clock;
 
 	uiActualPixelClk = calcPllValue(parm->pixel_clock, &pll);
-	if(getChipType() = SM750LE){
+	if (getChipType() = SM750LE){
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 44b8eb1..a2d9ee6 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -5,7 +5,7 @@
 void ddk750_setDPMS(DPMS_t state)
 {
 	unsigned int value;
-	if(getChipType() = SM750LE){
+	if (getChipType() = SM750LE){
 		value = PEEK32(CRT_DISPLAY_CTRL);
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL, DPMS, state));
 	}else{
@@ -17,7 +17,7 @@ void ddk750_setDPMS(DPMS_t state)
 
 unsigned int getPowerMode(void)
 {
-	if(getChipType() = SM750LE)
+	if (getChipType() = SM750LE)
 		return 0;
 	return (FIELD_GET(PEEK32(POWER_MODE_CTRL), POWER_MODE_CTRL, MODE));
 }
@@ -33,7 +33,7 @@ void setPowerMode(unsigned int powerMode)
 
 	control_value = PEEK32(POWER_MODE_CTRL);
 
-	if(getChipType() = SM750LE)
+	if (getChipType() = SM750LE)
 		return;
 
 	switch (powerMode)
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 10cc022..73d84de 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -96,7 +96,7 @@ int hw_fillrect(struct lynx_accel *accel,
 {
 	u32 deCtrl;
 
-	if(accel->de_wait() != 0)
+	if (accel->de_wait() != 0)
 	{
 		/* int time wait and always busy,seems hardware
 		 * got something error */
@@ -248,7 +248,7 @@ unsigned int rop2)   /* ROP value */
        Note that input pitch is BYTE value, but the 2D Pitch register uses
        pixel values. Need Byte to pixel conversion.
     */
-	if(Bpp = 3){
+	if (Bpp = 3){
 			sx *= 3;
 			dx *= 3;
 			width *= 3;
@@ -344,7 +344,7 @@ int hw_imageblit(struct lynx_accel *accel,
 	ul4BytesPerScan = ulBytesPerScan & ~3;
 	ulBytesRemain = ulBytesPerScan & 3;
 
-	if(accel->de_wait() != 0)
+	if (accel->de_wait() != 0)
 	{
 		return -1;
 	}
@@ -363,7 +363,7 @@ int hw_imageblit(struct lynx_accel *accel,
        Note that input pitch is BYTE value, but the 2D Pitch register uses
        pixel values. Need Byte to pixel conversion.
     */
-	if(bytePerPixel = 3){
+	if (bytePerPixel = 3){
 		dx *= 3;
 		width *= 3;
 		startBit *= 3;
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 405e24b..95cfb8f 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -122,7 +122,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		odd=0;
 */
 
-	for(i=0;i<count;i++)
+	for (i=0;i<count;i++)
 	{
 		color = *pcol++;
 		mask = *pmsk++;
@@ -132,15 +132,15 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		 * but method 2 shows no lag
 		 * and method 1 seems a bit wrong*/
 #if 0
-		if(rop = ROP_XOR)
+		if (rop = ROP_XOR)
 			opr = mask ^ color;
 		else
 			opr = mask & color;
 
-		for(j=0;j<8;j++)
+		for (j=0;j<8;j++)
 		{
 
-			if(opr & (0x80 >> j))
+			if (opr & (0x80 >> j))
 			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
 			}else{
@@ -149,9 +149,9 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 			}
 		}
 #else
-		for(j=0;j<8;j++){
-			if(mask & (0x80>>j)){
-				if(rop = ROP_XOR)
+		for (j=0;j<8;j++){
+			if (mask & (0x80>>j)){
+				if (rop = ROP_XOR)
 					opr = mask ^ color;
 				else
 					opr = mask & color;
@@ -165,9 +165,9 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 
 		/* assume pitch is 1,2,4,8,...*/
 #if 0
-		if(!((i+1)&(pitch-1)))   /* below line equal to is line */
+		if (!((i+1)&(pitch-1)))   /* below line equal to is line */
 #else
-		if((i+1) % pitch = 0)
+		if ((i+1) % pitch = 0)
 #endif
 		{
 			/* need a return */
@@ -204,7 +204,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 	pstart = cursor->vstart;
 	pbuffer = pstart;
 
-	for(i=0;i<count;i++)
+	for (i=0;i<count;i++)
 	{
 		color = *pcol++;
 		mask = *pmsk++;
@@ -212,15 +212,15 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 
 		/* either method below works well, but method 2 shows no lag */
 #if 0
-		if(rop = ROP_XOR)
+		if (rop = ROP_XOR)
 			opr = mask ^ color;
 		else
 			opr = mask & color;
 
-		for(j=0;j<8;j++)
+		for (j=0;j<8;j++)
 		{
 
-			if(opr & (0x80 >> j))
+			if (opr & (0x80 >> j))
 			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
 			}else{
@@ -229,15 +229,15 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 			}
 		}
 #else
-		for(j=0;j<8;j++){
-			if(mask & (1<<j))
+		for (j=0;j<8;j++){
+			if (mask & (1<<j))
 				data |= ((color & (1<<j))?1:2)<<(j*2);
 		}
 #endif
 		iowrite16(data, pbuffer);
 
 		/* assume pitch is 1,2,4,8,...*/
-		if(!(i&(pitch-1)))
+		if (!(i&(pitch-1)))
 		{
 			/* need a return */
 			pstart += offset;
diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
index 8ba4f8d..544ac41 100644
--- a/drivers/staging/sm750fb/sm750_help.h
+++ b/drivers/staging/sm750fb/sm750_help.h
@@ -73,7 +73,7 @@
 
 static inline unsigned int absDiff(unsigned int a, unsigned int b)
 {
-	if(a<b)
+	if (a<b)
 		return b-a;
 	else
 		return a-b;
-- 
2.4.5

