From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 08:48:34 +0000
Subject: [PATCH 3/4] staging: sm750fb: fix brace placement
Message-Id: <1434790115-21683-3-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F83JesFGDeEPbcUsMHSuXjeYocZDWyjMfUON02hf3HbCg@mail.gmail.com>
In-Reply-To: <CAFow2F83JesFGDeEPbcUsMHSuXjeYocZDWyjMfUON02hf3HbCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fix brace placement errors and warnings caught by checkpatch.pl
ERROR: that open brace { should be on the previous line
WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.h    | 12 ++----
 drivers/staging/sm750fb/ddk750_display.c | 66 ++++++++++----------------------
 drivers/staging/sm750fb/ddk750_display.h |  3 +-
 drivers/staging/sm750fb/ddk750_dvi.c     |  6 +--
 drivers/staging/sm750fb/ddk750_dvi.h     |  3 +-
 drivers/staging/sm750fb/ddk750_hwi2c.c   |  6 +--
 drivers/staging/sm750fb/ddk750_mode.c    | 13 ++-----
 drivers/staging/sm750fb/ddk750_mode.h    |  6 +--
 drivers/staging/sm750fb/ddk750_power.c   | 27 ++++---------
 drivers/staging/sm750fb/ddk750_power.h   |  3 +-
 drivers/staging/sm750fb/ddk750_sii164.c  | 16 +++-----
 drivers/staging/sm750fb/ddk750_sii164.h  |  3 +-
 drivers/staging/sm750fb/sm750_accel.c    | 46 +++++++---------------
 drivers/staging/sm750fb/sm750_cursor.c   | 23 +++++------
 drivers/staging/sm750fb/sm750_hw.c       | 33 ++++++----------
 15 files changed, 86 insertions(+), 180 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 4e030e8..6ff0436 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -8,8 +8,7 @@
 #include <linux/io.h>
 
 /* This is all the chips recognized by this library */
-typedef enum _logical_chip_type_t
-{
+typedef enum _logical_chip_type_t {
 	SM_UNKNOWN,
 	SM718,
 	SM750,
@@ -18,8 +17,7 @@ typedef enum _logical_chip_type_t
 logical_chip_type_t;
 
 
-typedef enum _clock_type_t
-{
+typedef enum _clock_type_t {
 	MXCLK_PLL,
 	PRIMARY_PLL,
 	SECONDARY_PLL,
@@ -28,8 +26,7 @@ typedef enum _clock_type_t
 }
 clock_type_t;
 
-typedef struct _pll_value_t
-{
+typedef struct _pll_value_t {
 	clock_type_t clockType;
 	unsigned long inputFreq; /* Input clock frequency to the PLL */
 
@@ -42,8 +39,7 @@ typedef struct _pll_value_t
 pll_value_t;
 
 /* input struct to initChipParam() function */
-typedef struct _initchip_param_t
-{
+typedef struct _initchip_param_t {
 	unsigned short powerMode;    /* Use power mode 0 or 1 */
 	unsigned short chipClock;    /**
 				      * Speed of main chip clock in MHz unit
diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 4a3cb86..90c5c9e 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -15,12 +15,10 @@ static void setDisplayControl(int ctrl, int dispState)
 	cnt = 0;
 
 	/* Set the primary display control */
-	if (!ctrl)
-	{
+	if (!ctrl) {
 		ulDisplayCtrlReg = PEEK32(PANEL_DISPLAY_CTRL);
 		/* Turn on/off the Panel display control */
-		if (dispState)
-		{
+		if (dispState) {
 			/* Timing should be enabled first before enabling the plane
 			 * because changing at the same time does not guarantee that
 			 * the plane will also enabled or disabled.
@@ -45,16 +43,13 @@ static void setDisplayControl(int ctrl, int dispState)
 			 * until a few delay. Need to write
 			 * and read it a couple times
 			 */
-			do
-			{
+			do {
 				cnt++;
 				POKE32(PANEL_DISPLAY_CTRL, ulDisplayCtrlReg);
 			} while ((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) ! 					(ulDisplayCtrlReg & ~ulReservedBits));
 			printk("Set Panel Plane enbit:after tried %d times\n", cnt);
-		}
-		else
-		{
+		} else {
 			/* When turning off, there is no rule on the programming
 			 * sequence since whenever the clock is off, then it does not
 			 * matter whether the plane is enabled or disabled.
@@ -71,14 +66,11 @@ static void setDisplayControl(int ctrl, int dispState)
 			POKE32(PANEL_DISPLAY_CTRL, ulDisplayCtrlReg);
 		}
 
-	}
 	/* Set the secondary display control */
-	else
-	{
+	} else {
 		ulDisplayCtrlReg = PEEK32(CRT_DISPLAY_CTRL);
 
-		if (dispState)
-		{
+		if (dispState) {
 			/* Timing should be enabled first before enabling the plane because changing at the
 			   same time does not guarantee that the plane will also enabled or disabled.
 			   */
@@ -100,16 +92,13 @@ static void setDisplayControl(int ctrl, int dispState)
 				FIELD_SET(0, CRT_DISPLAY_CTRL, RESERVED_3_MASK, ENABLE) |
 				FIELD_SET(0, CRT_DISPLAY_CTRL, RESERVED_4_MASK, ENABLE);
 
-			do
-			{
+			do {
 				cnt++;
 				POKE32(CRT_DISPLAY_CTRL, ulDisplayCtrlReg);
 			} while ((PEEK32(CRT_DISPLAY_CTRL) & ~ulReservedBits) ! 					(ulDisplayCtrlReg & ~ulReservedBits));
 				printk("Set Crt Plane enbit:after tried %d times\n", cnt);
-		}
-		else
-		{
+		} else {
 			/* When turning off, there is no rule on the programming
 			 * sequence since whenever the clock is off, then it does not
 			 * matter whether the plane is enabled or disabled.
@@ -140,30 +129,24 @@ static void waitNextVerticalSync(int ctrl, int delay)
 		if ((FIELD_GET(PEEK32(PANEL_PLL_CTRL), PANEL_PLL_CTRL, POWER) =
 			 PANEL_PLL_CTRL_POWER_OFF) ||
 			(FIELD_GET(PEEK32(PANEL_DISPLAY_CTRL), PANEL_DISPLAY_CTRL, TIMING) =
-			 PANEL_DISPLAY_CTRL_TIMING_DISABLE))
-		{
+			 PANEL_DISPLAY_CTRL_TIMING_DISABLE)) {
 			return;
 		}
 
-		while (delay-- > 0)
-		{
+		while (delay-- > 0) {
 			/* Wait for end of vsync. */
-			do
-			{
+			do {
 				status = FIELD_GET(PEEK32(SYSTEM_CTRL),
 						   SYSTEM_CTRL,
 						   PANEL_VSYNC);
-			}
-			while (status = SYSTEM_CTRL_PANEL_VSYNC_ACTIVE);
+			} while (status = SYSTEM_CTRL_PANEL_VSYNC_ACTIVE);
 
 			/* Wait for start of vsync. */
-			do
-			{
+			do {
 				status = FIELD_GET(PEEK32(SYSTEM_CTRL),
 						   SYSTEM_CTRL,
 						   PANEL_VSYNC);
-			}
-			while (status = SYSTEM_CTRL_PANEL_VSYNC_INACTIVE);
+			} while (status = SYSTEM_CTRL_PANEL_VSYNC_INACTIVE);
 		}
 
 	} else {
@@ -173,30 +156,24 @@ static void waitNextVerticalSync(int ctrl, int delay)
 		if ((FIELD_GET(PEEK32(CRT_PLL_CTRL), CRT_PLL_CTRL, POWER) =
 			 CRT_PLL_CTRL_POWER_OFF) ||
 			(FIELD_GET(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, TIMING) =
-			 CRT_DISPLAY_CTRL_TIMING_DISABLE))
-		{
+			 CRT_DISPLAY_CTRL_TIMING_DISABLE)) {
 			return;
 		}
 
-		while (delay-- > 0)
-		{
+		while (delay-- > 0) {
 			/* Wait for end of vsync. */
-			do
-			{
+			do {
 				status = FIELD_GET(PEEK32(SYSTEM_CTRL),
 								   SYSTEM_CTRL,
 								   CRT_VSYNC);
-			}
-			while (status = SYSTEM_CTRL_CRT_VSYNC_ACTIVE);
+			} while (status = SYSTEM_CTRL_CRT_VSYNC_ACTIVE);
 
 			/* Wait for start of vsync. */
-			do
-			{
+			do {
 				status = FIELD_GET(PEEK32(SYSTEM_CTRL),
 								   SYSTEM_CTRL,
 								   CRT_VSYNC);
-			}
-			while (status = SYSTEM_CTRL_CRT_VSYNC_INACTIVE);
+			} while (status = SYSTEM_CTRL_CRT_VSYNC_INACTIVE);
 		}
 	}
 }
@@ -293,8 +270,7 @@ int ddk750_initDVIDisp(void)
 		     1,  /* Enable continuous Sync */
 		     1,  /* Enable PLL Filter */
 		     4   /* Use the recommended value for PLL Filter value */
-		     ) != 0) && (dviGetVendorID() != 0x0000) && (dviGetDeviceID() != 0x0000))
-	{
+		     ) != 0) && (dviGetVendorID() != 0x0000) && (dviGetDeviceID() != 0x0000)) {
 		return (-1);
 	}
 
diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index afdf201..abccf84 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -86,8 +86,7 @@
 	CRT means crt path DSUB
 */
 #if 0
-typedef enum _disp_output_t
-{
+typedef enum _disp_output_t {
 	NO_DISPLAY = DPMS_OFF,
 
 	LCD1_PRI = PNL_2_PRI|PRI_TP_ON|PNL_SEQ_ON|DPMS_OFF|DAC_ON,
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index c42db85..a18bb4c 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -9,8 +9,7 @@
 /* This global variable contains all the supported driver and its corresponding
    function API. Please set the function pointer to NULL whenever the function
    is not supported. */
-static dvi_ctrl_device_t g_dcftSupportedDviController[] -{
+static dvi_ctrl_device_t g_dcftSupportedDviController[] = {
 #ifdef DVI_CTRL_SII164
 	{
 		.pfnInit = sii164InitChip,
@@ -45,8 +44,7 @@ int dviInit(
 {
 	dvi_ctrl_device_t *pCurrentDviCtrl;
 	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if (pCurrentDviCtrl->pfnInit != NULL)
-	{
+	if (pCurrentDviCtrl->pfnInit != NULL) {
 		return pCurrentDviCtrl->pfnInit(edgeSelect, busSelect, dualEdgeClkSelect, hsyncEnable,
 						vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
 						pllFilterEnable, pllFilterValue);
diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index 83bbd6d..e1d4c9a 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -26,8 +26,7 @@ typedef unsigned char (*PFN_DVICTRL_CHECKINTERRUPT)(void);
 typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
 
 /* Structure to hold all the function pointer to the DVI Controller. */
-typedef struct _dvi_ctrl_device_t
-{
+typedef struct _dvi_ctrl_device_t {
 	PFN_DVICTRL_INIT		pfnInit;
 	PFN_DVICTRL_RESETCHIP		pfnResetChip;
 	PFN_DVICTRL_GETCHIPSTRING	pfnGetChipString;
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
index 7f3b1f9..5ddac43 100644
--- a/drivers/staging/sm750fb/ddk750_hwi2c.c
+++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
@@ -106,8 +106,7 @@ static unsigned int hwI2CWriteData(
 	 * Note:
 	 *      Only 16 byte can be accessed per i2c start instruction.
 	 */
-	do
-	{
+	do {
 		/* Reset I2C by writing 0 to I2C_RESET register to clear the previous status. */
 		POKE32(I2C_RESET, 0);
 
@@ -173,8 +172,7 @@ static unsigned int hwI2CReadData(
 	 * Note:
 	 *      Only 16 byte can be accessed per i2c start instruction.
 	 */
-	do
-	{
+	do {
 		/* Reset I2C by writing 0 to I2C_RESET register to clear all the status. */
 		POKE32(I2C_RESET, 0);
 
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index d451e7a..9d10446 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -80,8 +80,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 	int ret = 0;
 	int cnt = 0;
 	unsigned int ulTmpValue, ulReg;
-	if (pll->clockType = SECONDARY_PLL)
-	{
+	if (pll->clockType = SECONDARY_PLL) {
 		/* programe secondary pixel clock */
 		POKE32(CRT_PLL_CTRL, formatPllReg(pll));
 		POKE32(CRT_HORIZONTAL_TOTAL,
@@ -119,9 +118,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 			 POKE32(CRT_DISPLAY_CTRL, ulTmpValue|ulReg);
 		}
 
-	}
-	else if (pll->clockType = PRIMARY_PLL)
-	{
+	} else if (pll->clockType = PRIMARY_PLL) {
 		unsigned int ulReservedBits;
 		POKE32(PANEL_PLL_CTRL, formatPllReg(pll));
 
@@ -170,16 +167,14 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 
 		POKE32(PANEL_DISPLAY_CTRL, ulTmpValue|ulReg);
 #if 1
-		while ((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) != (ulTmpValue|ulReg))
-		{
+		while ((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) != (ulTmpValue|ulReg)) {
 			cnt++;
 			if (cnt > 1000)
 				break;
 			POKE32(PANEL_DISPLAY_CTRL, ulTmpValue|ulReg);
 		}
 #endif
-	}
-	else{
+	} else {
 		ret = -1;
 	}
 	return ret;
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index 3548d67..e846dc2 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -3,16 +3,14 @@
 
 #include "ddk750_chip.h"
 
-typedef enum _spolarity_t
-{
+typedef enum _spolarity_t {
 	POS = 0, /* positive */
 	NEG, /* negative */
 }
 spolarity_t;
 
 
-typedef struct _mode_parameter_t
-{
+typedef struct _mode_parameter_t {
 	/* Horizontal timing. */
 	unsigned long horizontal_total;
 	unsigned long horizontal_display_end;
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 28d4402..c545c2d 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -36,8 +36,7 @@ void setPowerMode(unsigned int powerMode)
 	if (getChipType() = SM750LE)
 		return;
 
-	switch (powerMode)
-	{
+	switch (powerMode) {
 	case POWER_MODE_CTRL_MODE_MODE0:
 		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, MODE0);
 		break;
@@ -55,16 +54,13 @@ void setPowerMode(unsigned int powerMode)
 	}
 
 	/* Set up other fields in Power Control Register */
-	if (powerMode = POWER_MODE_CTRL_MODE_SLEEP)
-	{
+	if (powerMode = POWER_MODE_CTRL_MODE_SLEEP) {
 		control_value  #ifdef VALIDATION_CHIP
 		FIELD_SET(control_value, POWER_MODE_CTRL, 336CLK, OFF) |
 #endif
 		FIELD_SET(control_value, POWER_MODE_CTRL, OSC_INPUT,  OFF);
-	}
-	else
-	{
+	} else {
 		control_value  #ifdef VALIDATION_CHIP
 		FIELD_SET(control_value, POWER_MODE_CTRL, 336CLK, ON) |
@@ -84,8 +80,7 @@ void setCurrentGate(unsigned int gate)
 	/* Get current power mode. */
 	mode = getPowerMode();
 
-	switch (mode)
-	{
+	switch (mode) {
 	case POWER_MODE_CTRL_MODE_MODE0:
 		gate_reg = MODE0_GATE;
 		break;
@@ -111,13 +106,10 @@ void enable2DEngine(unsigned int enable)
 	uint32_t gate;
 
 	gate = PEEK32(CURRENT_GATE);
-	if (enable)
-	{
+	if (enable) {
 		gate = FIELD_SET(gate, CURRENT_GATE, DE,  ON);
 		gate = FIELD_SET(gate, CURRENT_GATE, CSC, ON);
-	}
-	else
-	{
+	} else {
 		gate = FIELD_SET(gate, CURRENT_GATE, DE,  OFF);
 		gate = FIELD_SET(gate, CURRENT_GATE, CSC, OFF);
 	}
@@ -135,8 +127,7 @@ void enableZVPort(unsigned int enable)
 
 	/* Enable ZV Port Gate */
 	gate = PEEK32(CURRENT_GATE);
-	if (enable)
-	{
+	if (enable) {
 		gate = FIELD_SET(gate, CURRENT_GATE, ZVPORT, ON);
 #if 1
 		/* Using Software I2C */
@@ -145,9 +136,7 @@ void enableZVPort(unsigned int enable)
 		/* Using Hardware I2C */
 		gate = FIELD_SET(gate, CURRENT_GATE, I2C,    ON);
 #endif
-	}
-	else
-	{
+	} else {
 		/* Disable ZV Port Gate. There is no way to know whether the GPIO pins are being used
 		 or not. Therefore, do not disable the GPIO gate. */
 		gate = FIELD_SET(gate, CURRENT_GATE, ZVPORT, OFF);
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index a20d438..b7cf6b2 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -1,8 +1,7 @@
 #ifndef DDK750_POWER_H__
 #define DDK750_POWER_H__
 
-typedef enum _DPMS_t
-{
+typedef enum _DPMS_t {
 	crtDPMS_ON = 0x0,
 	crtDPMS_STANDBY = 0x1,
 	crtDPMS_SUSPEND = 0x2,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index c09748c..3c55df1 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -136,8 +136,7 @@ long sii164InitChip(
 #endif
 
 	/* Check if SII164 Chip exists */
-	if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID))
-	{
+	if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
@@ -183,8 +182,7 @@ long sii164InitChip(
 		else
 			config = SII164_DESKEW_ENABLE;
 
-		switch (deskewSetting)
-		{
+		switch (deskewSetting) {
 		case 0:
 			config |= SII164_DESKEW_1_STEP;
 			break;
@@ -284,15 +282,12 @@ void sii164SetPower(unsigned char powerUp)
 	unsigned char config;
 
 	config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-	if (powerUp = 1)
-	{
+	if (powerUp = 1) {
 		/* Power up the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
 		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
-	}
-	else
-	{
+	} else {
 		/* Power down the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_DOWN;
@@ -310,8 +305,7 @@ static void sii164SelectHotPlugDetectionMode(sii164_hot_plug_mode_t hotPlugMode)
 	unsigned char detectReg;
 
 	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) & ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
-	switch (hotPlugMode)
-	{
+	switch (hotPlugMode) {
 	case SII164_HOTPLUG_DISABLE:
 		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
 		break;
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index bb0ed25..18c1c3e 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -4,8 +4,7 @@
 #define USE_DVICHIP
 
 /* Hot Plug detection mode structure */
-typedef enum _sii164_hot_plug_mode_t
-{
+typedef enum _sii164_hot_plug_mode_t {
 	SII164_HOTPLUG_DISABLE = 0,         /* Disable Hot Plug output bit (always high). */
 	SII164_HOTPLUG_USE_MDI,             /* Use Monitor Detect Interrupt bit. */
 	SII164_HOTPLUG_USE_RSEN,            /* Use Receiver Sense detect bit. */
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 391fced..0b5758b 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -96,8 +96,7 @@ int hw_fillrect(struct lynx_accel *accel,
 {
 	u32 deCtrl;
 
-	if (accel->de_wait() != 0)
-	{
+	if (accel->de_wait() != 0) {
 		/* int time wait and always busy,seems hardware
 		 * got something error */
 		pr_debug("%s:De engine always bussy\n", __func__);
@@ -159,11 +158,9 @@ unsigned int rop2)   /* ROP value */
 	de_ctrl = 0;
 
 	/* If source and destination are the same surface, need to check for overlay cases */
-	if (sBase = dBase && sPitch = dPitch)
-	{
+	if (sBase = dBase && sPitch = dPitch) {
 		/* Determine direction of operation */
-		if (sy < dy)
-		{
+		if (sy < dy) {
 			/* +----------+
 			   |S         |
 			   |   +----------+
@@ -174,9 +171,7 @@ unsigned int rop2)   /* ROP value */
 			   +----------+ */
 
 			nDirection = BOTTOM_TO_TOP;
-		}
-		else if (sy > dy)
-		{
+		} else if (sy > dy) {
 			/* +----------+
 			   |D         |
 			   |   +----------+
@@ -187,12 +182,9 @@ unsigned int rop2)   /* ROP value */
 			   +----------+ */
 
 			nDirection = TOP_TO_BOTTOM;
-		}
-		else
-		{
+		} else {
 			/* sy = dy */
-			if (sx <= dx)
-			{
+			if (sx <= dx) {
 				/* +------+---+------+
 				   |S     |   |     D|
 				   |      |   |      |
@@ -201,9 +193,7 @@ unsigned int rop2)   /* ROP value */
 				   +------+---+------+ */
 
 				nDirection = RIGHT_TO_LEFT;
-			}
-			else
-			{
+			} else {
 			/* sx > dx */
 
 				/* +------+---+------+
@@ -218,8 +208,7 @@ unsigned int rop2)   /* ROP value */
 		}
 	}
 
-	if ((nDirection = BOTTOM_TO_TOP) || (nDirection = RIGHT_TO_LEFT))
-	{
+	if ((nDirection = BOTTOM_TO_TOP) || (nDirection = RIGHT_TO_LEFT)) {
 		sx += width - 1;
 		sy += height - 1;
 		dx += width - 1;
@@ -254,8 +243,7 @@ unsigned int rop2)   /* ROP value */
 		write_dpr(accel, DE_PITCH,
 				FIELD_VALUE(0, DE_PITCH, DESTINATION, dPitch) |
 				FIELD_VALUE(0, DE_PITCH, SOURCE,      sPitch)); /* dpr10 */
-	}
-	else
+	} else
 #endif
 	{
 		write_dpr(accel, DE_PITCH,
@@ -270,9 +258,8 @@ unsigned int rop2)   /* ROP value */
 	FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/Bpp)) |
 	FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (sPitch/Bpp))); /* dpr3c */
 
-	if (accel->de_wait() != 0) {
+	if (accel->de_wait() != 0)
 		return -1;
-	}
 
 	write_dpr(accel, DE_SOURCE,
 		  FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
@@ -339,9 +326,7 @@ int hw_imageblit(struct lynx_accel *accel,
 	ulBytesRemain = ulBytesPerScan & 3;
 
 	if (accel->de_wait() != 0)
-	{
 		return -1;
-	}
 
 	/* 2D Source Base.
 	 Use 0 for HOST Blt.
@@ -365,8 +350,7 @@ int hw_imageblit(struct lynx_accel *accel,
 				FIELD_VALUE(0, DE_PITCH, DESTINATION, dPitch) |
 				FIELD_VALUE(0, DE_PITCH, SOURCE,      dPitch)); /* dpr10 */
 
-	}
-	else
+	} else
 #endif
 	{
 		write_dpr(accel, DE_PITCH,
@@ -408,16 +392,12 @@ int hw_imageblit(struct lynx_accel *accel,
 	write_dpr(accel, DE_CONTROL, de_ctrl | deGetTransparency(accel));
 
 	/* Write MONO data (line by line) to 2D Engine data port */
-	for (i = 0; i < height; i++)
-	{
+	for (i = 0; i < height; i++) {
 		/* For each line, send the data in chunks of 4 bytes */
 		for (j = 0; j < (ul4BytesPerScan/4); j++)
-		{
 			write_dpPort(accel, *(unsigned int *)(pSrcbuf + (j * 4)));
-		}
 
-		if (ulBytesRemain)
-		{
+		if (ulBytesRemain) {
 			memcpy(ajRemain, pSrcbuf+ul4BytesPerScan, ulBytesRemain);
 			write_dpPort(accel, *(unsigned int *)ajRemain);
 		}
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 4ed7ca2..ab61fe6 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -122,8 +122,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		odd=0;
 */
 
-	for (i = 0; i < count; i++)
-	{
+	for (i = 0; i < count; i++) {
 		color = *pcol++;
 		mask = *pmsk++;
 		data = 0;
@@ -137,11 +136,10 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		else
 			opr = mask & color;
 
-		for (j = 0; j < 8; j++)
-		{
+		for (j = 0; j < 8; j++) {
 
-			if (opr & (0x80 >> j))
-			{	/* use fg color,id = 2 */
+			if (opr & (0x80 >> j)) {
+				/* use fg color,id = 2 */
 				data |= 2 << (j*2);
 			} else {
 				/* use bg color,id = 1 */
@@ -204,8 +202,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 	pstart = cursor->vstart;
 	pbuffer = pstart;
 
-	for (i = 0; i < count; i++)
-	{
+	for (i = 0; i < count; i++) {
 		color = *pcol++;
 		mask = *pmsk++;
 		data = 0;
@@ -217,11 +214,10 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 		else
 			opr = mask & color;
 
-		for (j = 0; j < 8; j++)
-		{
+		for (j = 0; j < 8; j++) {
 
-			if (opr & (0x80 >> j))
-			{	/* use fg color,id = 2 */
+			if (opr & (0x80 >> j)) {
+				/* use fg color,id = 2 */
 				data |= 2 << (j*2);
 			} else {
 				/* use bg color,id = 1 */
@@ -237,8 +233,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 		iowrite16(data, pbuffer);
 
 		/* assume pitch is 1,2,4,8,...*/
-		if (!(i&(pitch-1)))
-		{
+		if (!(i&(pitch-1))) {
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index af7ea2e..a3362d8 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -43,8 +43,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 	 * successfully
 	 * */
 
-	if ((ret = pci_request_region(pdev, 1, "sm750fb")))
-	{
+	if ((ret = pci_request_region(pdev, 1, "sm750fb"))) {
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
 	}
@@ -77,8 +76,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 
 	/* reserve the vidmem space of smi adaptor */
 #if 0
-	if ((ret = pci_request_region(pdev, 0, _moduleName_)))
-	{
+	if ((ret = pci_request_region(pdev, 0, _moduleName_))) {
 		pr_err("Can not request PCI regions.\n");
 		goto exit;
 	}
@@ -129,8 +127,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	ddk750_initDVIDisp();
 #endif
 
-	if (getChipType() != SM750LE)
-	{
+	if (getChipType() != SM750LE) {
 		/* does user need CRT ?*/
 		if (spec_share->state.nocrt) {
 			POKE32(MISC_CTRL,
@@ -176,8 +173,7 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 		/* Customer may NOT use CH7301 DVI chip, which has to be
 		   initialized differently.
 		 */
-		if (swI2CReadReg(0xec, 0x4a) = 0x95)
-		{
+		if (swI2CReadReg(0xec, 0x4a) = 0x95) {
 			/* The following register values for CH7301 are from
 			   Chrontel app note and our experiment.
 			 */
@@ -190,9 +186,8 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 	}
 
 	/* init 2d engine */
-	if (!share->accel_off) {
+	if (!share->accel_off)
 		hw_sm750_initAccel(share);
-	}
 
 	return 0;
 }
@@ -420,11 +415,11 @@ int hw_sm750_setColReg(struct lynxfb_crtc* crtc, ushort index,
 	return 0;
 }
 
-int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank) {
+int hw_sm750le_setBLANK(struct lynxfb_output * output, int blank)
+{
 	int dpms, crtdb;
 
-	switch (blank)
-	{
+	switch (blank) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
 		case FB_BLANK_UNBLANK:
 #else
@@ -480,8 +475,7 @@ int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 
 	dpms = pps = crtdb = 0;
 
-	switch (blank)
-	{
+	switch (blank) {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
 		case FB_BLANK_UNBLANK:
 #else
@@ -535,9 +529,8 @@ int hw_sm750_setBLANK(struct lynxfb_output* output, int blank)
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(PEEK32(CRT_DISPLAY_CTRL), CRT_DISPLAY_CTRL, BLANK, crtdb));
 	}
 
-	if (output->paths & sm750_panel) {
+	if (output->paths & sm750_panel)
 		POKE32(PANEL_DISPLAY_CTRL, FIELD_VALUE(PEEK32(PANEL_DISPLAY_CTRL), PANEL_DISPLAY_CTRL, DATA, pps));
-	}
 
 	return 0;
 }
@@ -579,8 +572,7 @@ int hw_sm750le_deWait(void)
 		unsigned int dwVal = PEEK32(DE_STATE2);
 		if ((FIELD_GET(dwVal, DE_STATE2, DE_STATUS) = DE_STATE2_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, DE_STATE2, DE_FIFO)  = DE_STATE2_DE_FIFO_EMPTY) &&
-			(FIELD_GET(dwVal, DE_STATE2, DE_MEM_FIFO) = DE_STATE2_DE_MEM_FIFO_EMPTY))
-		{
+			(FIELD_GET(dwVal, DE_STATE2, DE_MEM_FIFO) = DE_STATE2_DE_MEM_FIFO_EMPTY)) {
 			return 0;
 		}
 	}
@@ -596,8 +588,7 @@ int hw_sm750_deWait(void)
 		unsigned int dwVal = PEEK32(SYSTEM_CTRL);
 		if ((FIELD_GET(dwVal, SYSTEM_CTRL, DE_STATUS) = SYSTEM_CTRL_DE_STATUS_IDLE) &&
 			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_FIFO)  = SYSTEM_CTRL_DE_FIFO_EMPTY) &&
-			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_MEM_FIFO) = SYSTEM_CTRL_DE_MEM_FIFO_EMPTY))
-		{
+			(FIELD_GET(dwVal, SYSTEM_CTRL, DE_MEM_FIFO) = SYSTEM_CTRL_DE_MEM_FIFO_EMPTY)) {
 			return 0;
 		}
 	}
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
