From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 15 Jul 2015 04:14:35 +0000
Subject: [PATCH v5 06/19] staging: sm750fb: add space before open brace
Message-Id: <1436933688-5408-6-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
In-Reply-To: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl error:
ERROR: space required before the open brace '{'

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 14 +++++++-------
 drivers/staging/sm750fb/ddk750_mode.c    |  8 ++++----
 drivers/staging/sm750fb/ddk750_power.c   |  4 ++--
 drivers/staging/sm750fb/sm750_accel.c    |  6 +++---
 drivers/staging/sm750fb/sm750_cursor.c   | 14 +++++++-------
 5 files changed, 23 insertions(+), 23 deletions(-)

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
index 982cf1e..afe73e8 100644
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
 
-- 
2.4.5

