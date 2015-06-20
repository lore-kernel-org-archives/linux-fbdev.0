From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 18:36:53 +0000
Subject: [PATCH 19/19] staging: sm750fb: add missing blank line after declarations
Message-Id: <1434825413-4994-19-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
In-Reply-To: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl warning:
WARNING: Missing a blank line after declarations

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c    | 1 +
 drivers/staging/sm750fb/ddk750_display.c | 2 ++
 drivers/staging/sm750fb/ddk750_dvi.c     | 1 +
 drivers/staging/sm750fb/ddk750_mode.c    | 3 +++
 drivers/staging/sm750fb/ddk750_power.c   | 1 +
 drivers/staging/sm750fb/ddk750_sii164.c  | 1 +
 drivers/staging/sm750fb/sm750_accel.c    | 1 +
 drivers/staging/sm750fb/sm750_cursor.c   | 2 ++
 drivers/staging/sm750fb/sm750_hw.c       | 7 +++++++
 9 files changed, 19 insertions(+)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index d7435d7..5e6798e 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -474,6 +474,7 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 			M += (fl_quo*X % 10000) > 5000?1:0;
 			if (M < 256 && M > 0) {
 				unsigned int diff;
+
 				tmpClock = pll->inputFreq * M / N / X;
 				diff = absDiff(tmpClock, request_orig);
 				if (diff < miniDiff) {
diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 90c5c9e..70e7f10 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -121,6 +121,7 @@ static void setDisplayControl(int ctrl, int dispState)
 static void waitNextVerticalSync(int ctrl, int delay)
 {
 	unsigned int status;
+
 	if (!ctrl) {
 		/* primary controller */
 
@@ -210,6 +211,7 @@ static void swPanelPowerSequence(int disp, int delay)
 void ddk750_setLogicalDispOut(disp_output_t output)
 {
 	unsigned int reg;
+
 	if (output & PNL_2_USAGE) {
 		/* set panel path controller select */
 		reg = PEEK32(PANEL_DISPLAY_CTRL);
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index a18bb4c..a7a2351 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -43,6 +43,7 @@ int dviInit(
 			)
 {
 	dvi_ctrl_device_t *pCurrentDviCtrl;
+
 	pCurrentDviCtrl = g_dcftSupportedDviController;
 	if (pCurrentDviCtrl->pfnInit != NULL) {
 		return pCurrentDviCtrl->pfnInit(edgeSelect, busSelect, dualEdgeClkSelect, hsyncEnable,
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 9d10446..2399b17 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -80,6 +80,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 	int ret = 0;
 	int cnt = 0;
 	unsigned int ulTmpValue, ulReg;
+
 	if (pll->clockType = SECONDARY_PLL) {
 		/* programe secondary pixel clock */
 		POKE32(CRT_PLL_CTRL, formatPllReg(pll));
@@ -120,6 +121,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 
 	} else if (pll->clockType = PRIMARY_PLL) {
 		unsigned int ulReservedBits;
+
 		POKE32(PANEL_PLL_CTRL, formatPllReg(pll));
 
 		POKE32(PANEL_HORIZONTAL_TOTAL,
@@ -184,6 +186,7 @@ int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
 {
 	pll_value_t pll;
 	unsigned int uiActualPixelClk;
+
 	pll.inputFreq = DEFAULT_INPUT_CLOCK;
 	pll.clockType = clock;
 
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index c545c2d..c8c51be 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -5,6 +5,7 @@
 void ddk750_setDPMS(DPMS_t state)
 {
 	unsigned int value;
+
 	if (getChipType() = SM750LE) {
 		value = PEEK32(CRT_DISPLAY_CTRL);
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL, DPMS, state));
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index a5153be..0bdf3db 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -340,6 +340,7 @@ void sii164EnableHotPlugDetection(
 )
 {
 	unsigned char detectReg;
+
 	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
 
 	/* Depending on each DVI controller, need to enable the hot plug based on each
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 291a47b..b75ffbd 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -152,6 +152,7 @@ unsigned int rop2)   /* ROP value */
 {
 	unsigned int nDirection, de_ctrl;
 	int opSign;
+
 	nDirection = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
 	opSign = 1;
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index ab61fe6..2400c6c 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -61,6 +61,7 @@ writel((data), cursor->mmio + (addr))
 void hw_cursor_enable(struct lynx_cursor *cursor)
 {
 	u32 reg;
+
 	reg = FIELD_VALUE(0, HWC_ADDRESS, ADDRESS, cursor->offset)|
 			FIELD_SET(0, HWC_ADDRESS, EXT, LOCAL)|
 			FIELD_SET(0, HWC_ADDRESS, ENABLE, ENABLE);
@@ -81,6 +82,7 @@ void hw_cursor_setPos(struct lynx_cursor *cursor,
 						int x, int y)
 {
 	u32 reg;
+
 	reg = FIELD_VALUE(0, HWC_LOCATION, Y, y)|
 			FIELD_VALUE(0, HWC_LOCATION, X, x);
 	POKE32(HWC_LOCATION, reg);
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 97a0f63..10f15b5 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -243,6 +243,7 @@ int hw_sm750_output_setMode(struct lynxfb_output* output,
 	} else {
 		/* just open DISPLAY_CONTROL_750LE register bit 3:0*/
 		u32 reg;
+
 		reg = PEEK32(DISPLAY_CONTROL_750LE);
 		reg |= 0xf;
 		POKE32(DISPLAY_CONTROL_750LE, reg);
@@ -417,6 +418,7 @@ int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
 								ushort red, ushort green, ushort blue)
 {
 	static unsigned int add[] = {PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
+
 	POKE32(add[crtc->channel] + index*4, (red<<16)|(green<<8)|blue);
 	return 0;
 }
@@ -545,6 +547,7 @@ int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 void hw_sm750_initAccel(struct lynx_share *share)
 {
 	u32 reg;
+
 	enable2DEngine(1);
 
 	if (getChipType() = SM750LE) {
@@ -574,8 +577,10 @@ void hw_sm750_initAccel(struct lynx_share *share)
 int hw_sm750le_deWait(void)
 {
 	int i = 0x10000000;
+
 	while (i--) {
 		unsigned int dwVal = PEEK32(DE_STATE2);
+
 		if ((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, DE_STATE2, DE_FIFO)  = DE_STATE2_DE_FIFO_EMPTY) &&
 			(FIELD_GET(dwVal, DE_STATE2, DE_MEM_FIFO) = DE_STATE2_DE_MEM_FIFO_EMPTY)) {
@@ -590,8 +595,10 @@ int hw_sm750le_deWait(void)
 int hw_sm750_deWait(void)
 {
 	int i = 0x10000000;
+
 	while (i--) {
 		unsigned int dwVal = PEEK32(SYSTEM_CTRL);
+
 		if ((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_FIFO)  = SYSTEM_CTRL_DE_FIFO_EMPTY) &&
 			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_MEM_FIFO) = SYSTEM_CTRL_DE_MEM_FIFO_EMPTY)) {
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
