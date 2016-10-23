From: "Eric S. Stone" <esstone@gmail.com>
Date: Sun, 23 Oct 2016 02:51:29 +0000
Subject: [PATCH 1/1] staging: sm750fb: restructure multi-line comments to follow CodingStyle
Message-Id: <1477191089-2878-1-git-send-email-esstone@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Eliminates all checkpatch.pl BLOCK_COMMENT_STYLE warnings in
sm750fb, and coincidentally eliminates some line-length (80)
warnings.

Signed-off-by: Eric S. Stone <esstone@gmail.com>
---
 drivers/staging/sm750fb/ddk750.h         | 22 ++++++------
 drivers/staging/sm750fb/ddk750_chip.c    | 39 ++++++++++++--------
 drivers/staging/sm750fb/ddk750_chip.h    | 61 +++++++++++++++++++-------------
 drivers/staging/sm750fb/ddk750_display.h | 30 ++++++++++------
 drivers/staging/sm750fb/ddk750_hwi2c.c   |  9 +++--
 drivers/staging/sm750fb/ddk750_mode.c    | 25 +++++++------
 drivers/staging/sm750fb/ddk750_sii164.c  |  3 +-
 drivers/staging/sm750fb/ddk750_swi2c.c   | 27 +++++++-------
 drivers/staging/sm750fb/ddk750_swi2c.h   | 24 ++++++-------
 drivers/staging/sm750fb/sm750.h          |  6 ++--
 drivers/staging/sm750fb/sm750_accel.c    | 40 +++++++++++++--------
 drivers/staging/sm750fb/sm750_hw.c       | 25 ++++++++-----
 12 files changed, 184 insertions(+), 127 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750.h b/drivers/staging/sm750fb/ddk750.h
index 0566911..7340103 100644
--- a/drivers/staging/sm750fb/ddk750.h
+++ b/drivers/staging/sm750fb/ddk750.h
@@ -1,16 +1,16 @@
+/*
+ *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
+ *
+ *  All rights are reserved. Reproduction or in part is prohibited
+ *  without the written consent of the copyright owner.
+ *
+ *  RegSC.h --- SM718 SDK
+ *  This file contains the definitions for the System Configuration registers.
+ */
+
 #ifndef DDK750_H__
 #define DDK750_H__
-/*******************************************************************
-*
-*         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
-*
-*  All rights are reserved. Reproduction or in part is prohibited
-*  without the written consent of the copyright owner.
-*
-*  RegSC.h --- SM718 SDK
-*  This file contains the definitions for the System Configuration registers.
-*
-*******************************************************************/
+
 #include "ddk750_reg.h"
 #include "ddk750_mode.h"
 #include "ddk750_chip.h"
diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index a127eb2..c8c14ee 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -62,17 +62,18 @@ static void set_chip_clock(unsigned int frequency)
 
 	if (frequency) {
 		/*
-		* Set up PLL, a structure to hold the value to be set in clocks.
-		*/
+		 * Set up PLL structure to hold the value to be set in clocks.
+		 */
 		pll.inputFreq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
 		pll.clockType = MXCLK_PLL;
 
 		/*
-		* Call calc_pll_value() to fill the other fields of PLL structure.
-		* Sometime, the chip cannot set up the exact clock
-		* required by the User.
-		* Return value of calc_pll_value gives the actual possible clock.
-		*/
+		 * Call calc_pll_value() to fill the other fields of the PLL
+		 * structure. Sometimes, the chip cannot set up the exact
+		 * clock required by the User.
+		 * Return value of calc_pll_value gives the actual possible
+		 * clock.
+		 */
 		ulActualMxClk = calc_pll_value(frequency, &pll);
 
 		/* Master Clock Control: MXCLK_PLL */
@@ -84,7 +85,8 @@ static void set_memory_clock(unsigned int frequency)
 {
 	unsigned int reg, divisor;
 
-	/* Cheok_0509: For SM750LE, the memory clock is fixed.
+	/*
+	 * Cheok_0509: For SM750LE, the memory clock is fixed.
 	 * Nothing to set.
 	 */
 	if (sm750_get_chip_type() = SM750LE)
@@ -135,14 +137,16 @@ static void set_master_clock(unsigned int frequency)
 {
 	unsigned int reg, divisor;
 
-	/* Cheok_0509: For SM750LE, the memory clock is fixed.
+	/*
+	 * Cheok_0509: For SM750LE, the memory clock is fixed.
 	 * Nothing to set.
 	 */
 	if (sm750_get_chip_type() = SM750LE)
 		return;
 
 	if (frequency) {
-		/* Set the frequency to the maximum frequency
+		/*
+		 * Set the frequency to the maximum frequency
 		 * that the SM750 engine can run, which is about 190 MHz.
 		 */
 		if (frequency > MHz(190))
@@ -241,7 +245,8 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
 	set_master_clock(MHz(pInitParam->masterClock));
 
 
-	/* Reset the memory controller.
+	/*
+	 * Reset the memory controller.
 	 * If the memory controller is not reset in SM750,
 	 * the system might hang when sw accesses the memory.
 	 * The memory should be resetted after changing the MXCLK.
@@ -306,7 +311,8 @@ int ddk750_init_hw(struct initchip_param *pInitParam)
  */
 unsigned int calc_pll_value(unsigned int request_orig, struct pll_value *pll)
 {
-	/* as sm750 register definition,
+	/*
+	 * as sm750 register definition,
 	 * N located in 2,15 and M located in 1,255
 	 */
 	int N, M, X, d;
@@ -318,7 +324,8 @@ unsigned int calc_pll_value(unsigned int request_orig, struct pll_value *pll)
 	int max_d = 6;
 
 	if (sm750_get_chip_type() = SM750LE) {
-		/* SM750LE don't have
+		/*
+		 * SM750LE don't have
 		 * programmable PLL and M/N values to work on.
 		 * Just return the requested clock.
 		 */
@@ -330,14 +337,16 @@ unsigned int calc_pll_value(unsigned int request_orig, struct pll_value *pll)
 	request = request_orig / 1000;
 	input = pll->inputFreq / 1000;
 
-	/* for MXCLK register,
+	/*
+	 * for MXCLK register,
 	 * no POD provided, so need be treated differently
 	 */
 	if (pll->clockType = MXCLK_PLL)
 		max_d = 3;
 
 	for (N = 15; N > 1; N--) {
-		/* RN will not exceed maximum long
+		/*
+		 * RN will not exceed maximum long
 		 * if @request <= 285 MHZ (for 32bit cpu)
 		 */
 		RN = N * request;
diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 3b731b4..5eee29d 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -46,31 +46,42 @@ struct pll_value {
 
 /* input struct to initChipParam() function */
 struct initchip_param {
-	unsigned short powerMode;    /* Use power mode 0 or 1 */
-	unsigned short chipClock;    /**
-				      * Speed of main chip clock in MHz unit
-				      * 0 = keep the current clock setting
-				      * Others = the new main chip clock
-				      */
-	unsigned short memClock;     /**
-				      * Speed of memory clock in MHz unit
-				      * 0 = keep the current clock setting
-				      * Others = the new memory clock
-				      */
-	unsigned short masterClock;  /**
-				      * Speed of master clock in MHz unit
-				      * 0 = keep the current clock setting
-				      * Others = the new master clock
-				      */
-	unsigned short setAllEngOff; /**
-				      * 0 = leave all engine state untouched.
-				      * 1 = make sure they are off: 2D, Overlay,
-				      * video alpha, alpha, hardware cursors
-				      */
-	unsigned char resetMemory;   /**
-				      * 0 = Do not reset the memory controller
-				      * 1 = Reset the memory controller
-				      */
+	/* Use power mode 0 or 1 */
+	unsigned short powerMode;
+
+	/*
+	 * Speed of main chip clock in MHz unit
+	 * 0 = keep the current clock setting
+	 * Others = the new main chip clock
+	 */
+	unsigned short chipClock;
+
+	/*
+	 * Speed of memory clock in MHz unit
+	 * 0 = keep the current clock setting
+	 * Others = the new memory clock
+	 */
+	unsigned short memClock;
+
+	/*
+	 * Speed of master clock in MHz unit
+	 * 0 = keep the current clock setting
+	 * Others = the new master clock
+	 */
+	unsigned short masterClock;
+
+	/*
+	 * 0 = leave all engine state untouched.
+	 * 1 = make sure they are off: 2D, Overlay,
+	 * video alpha, alpha, hardware cursors
+	 */
+	unsigned short setAllEngOff;
+
+	/*
+	 * 0 = Do not reset the memory controller
+	 * 1 = Reset the memory controller
+	 */
+	unsigned char resetMemory;
 
 	/* More initialization parameter can be added if needed */
 };
diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index e3fde42..8abca88 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -1,7 +1,8 @@
 #ifndef DDK750_DISPLAY_H__
 #define DDK750_DISPLAY_H__
 
-/* panel path select
+/*
+ * panel path select
  *	80000[29:28]
  */
 
@@ -12,7 +13,8 @@
 #define PNL_2_SEC	((2 << PNL_2_OFFSET) | PNL_2_USAGE)
 
 
-/* primary timing & plane enable bit
+/*
+ * primary timing & plane enable bit
  *	1: 80000[8] & 80000[2] on
  *	0: both off
  */
@@ -23,7 +25,8 @@
 #define PRI_TP_OFF ((0x0 << PRI_TP_OFFSET) | PRI_TP_USAGE)
 
 
-/* panel sequency status
+/*
+ * panel sequency status
  *	80000[27:24]
  */
 #define PNL_SEQ_OFFSET 6
@@ -32,7 +35,8 @@
 #define PNL_SEQ_ON (BIT(PNL_SEQ_OFFSET) | PNL_SEQ_USAGE)
 #define PNL_SEQ_OFF ((0 << PNL_SEQ_OFFSET) | PNL_SEQ_USAGE)
 
-/* dual digital output
+/*
+ * dual digital output
  *	80000[19]
  */
 #define DUAL_TFT_OFFSET 8
@@ -41,7 +45,8 @@
 #define DUAL_TFT_ON (BIT(DUAL_TFT_OFFSET) | DUAL_TFT_USAGE)
 #define DUAL_TFT_OFF ((0 << DUAL_TFT_OFFSET) | DUAL_TFT_USAGE)
 
-/* secondary timing & plane enable bit
+/*
+ * secondary timing & plane enable bit
  *	1:80200[8] & 80200[2] on
  *	0: both off
  */
@@ -51,7 +56,8 @@
 #define SEC_TP_ON  ((0x1 << SEC_TP_OFFSET) | SEC_TP_USAGE)
 #define SEC_TP_OFF ((0x0 << SEC_TP_OFFSET) | SEC_TP_USAGE)
 
-/* crt path select
+/*
+ * crt path select
  *	80200[19:18]
  */
 #define CRT_2_OFFSET 2
@@ -61,7 +67,8 @@
 #define CRT_2_SEC ((0x2 << CRT_2_OFFSET) | CRT_2_USAGE)
 
 
-/* DAC affect both DVI and DSUB
+/*
+ * DAC affect both DVI and DSUB
  *	4[20]
  */
 #define DAC_OFFSET 7
@@ -70,7 +77,8 @@
 #define DAC_ON ((0x0 << DAC_OFFSET) | DAC_USAGE)
 #define DAC_OFF ((0x1 << DAC_OFFSET) | DAC_USAGE)
 
-/* DPMS only affect D-SUB head
+/*
+ * DPMS only affect D-SUB head
  *	0[31:30]
  */
 #define DPMS_OFFSET 9
@@ -81,7 +89,8 @@
 
 
 
-/* LCD1 means panel path TFT1  & panel path DVI (so enable DAC)
+/*
+ * LCD1 means panel path TFT1  & panel path DVI (so enable DAC)
  * CRT means crt path DSUB
  */
 typedef enum _disp_output_t {
@@ -89,7 +98,8 @@ typedef enum _disp_output_t {
 	do_LCD1_SEC = PNL_2_SEC | SEC_TP_ON | PNL_SEQ_ON | DAC_ON,
 	do_LCD2_PRI = CRT_2_PRI | PRI_TP_ON | DUAL_TFT_ON,
 	do_LCD2_SEC = CRT_2_SEC | SEC_TP_ON | DUAL_TFT_ON,
-	/* do_DSUB_PRI = CRT_2_PRI | PRI_TP_ON | DPMS_ON|DAC_ON,
+	/*
+	 * do_DSUB_PRI = CRT_2_PRI | PRI_TP_ON | DPMS_ON|DAC_ON,
 	 * do_DSUB_SEC = CRT_2_SEC | SEC_TP_ON | DPMS_ON|DAC_ON,
 	 */
 	do_CRT_PRI = CRT_2_PRI | PRI_TP_ON | DPMS_ON | DAC_ON,
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
index 4ce0fbe..b60bedf 100644
--- a/drivers/staging/sm750fb/ddk750_hwi2c.c
+++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
@@ -20,7 +20,8 @@ unsigned char bus_speed_mode
 	value |= (GPIO_MUX_30 | GPIO_MUX_31);
 	POKE32(GPIO_MUX, value);
 
-	/* Enable Hardware I2C power.
+	/*
+	 * Enable Hardware I2C power.
 	 * TODO: Check if we need to enable GPIO power?
 	 */
 	enableI2C(1);
@@ -92,7 +93,8 @@ static unsigned int hw_i2c_write_data(
 	/* Set the Device Address */
 	POKE32(I2C_SLAVE_ADDRESS, addr & ~0x01);
 
-	/* Write data.
+	/*
+	 * Write data.
 	 * Note:
 	 *      Only 16 byte can be accessed per i2c start instruction.
 	 */
@@ -158,7 +160,8 @@ static unsigned int hw_i2c_read_data(
 	/* Set the Device Address */
 	POKE32(I2C_SLAVE_ADDRESS, addr | 0x01);
 
-	/* Read data and save them to the buffer.
+	/*
+	 * Read data and save them to the buffer.
 	 * Note:
 	 *      Only 16 byte can be accessed per i2c start instruction.
 	 */
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index b6af6f3..47d224e 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -3,7 +3,8 @@
 #include "ddk750_mode.h"
 #include "ddk750_chip.h"
 
-/* SM750LE only:
+/*
+ * SM750LE only:
  * This function takes care extra registers and bit fields required to set
  * up a mode in SM750LE
  *
@@ -18,7 +19,8 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 	x = pModeParam->horizontal_display_end;
 	y = pModeParam->vertical_display_end;
 
-	/* SM750LE has to set up the top-left and bottom-right
+	/*
+	 * SM750LE has to set up the top-left and bottom-right
 	 * registers as well.
 	 * Note that normal SM750/SM718 only use those two register for
 	 * auto-centering mode.
@@ -30,7 +32,8 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 			CRT_AUTO_CENTERING_BR_BOTTOM_MASK) |
 		((x - 1) & CRT_AUTO_CENTERING_BR_RIGHT_MASK));
 
-	/* Assume common fields in dispControl have been properly set before
+	/*
+	 * Assume common fields in dispControl have been properly set before
 	 * calling this function.
 	 * This function only sets the extra fields in dispControl.
 	 */
@@ -176,14 +179,14 @@ static int programModeRegisters(mode_parameter_t *pModeParam,
 			  DISPLAY_CTRL_HSYNC_PHASE | DISPLAY_CTRL_TIMING |
 			  DISPLAY_CTRL_PLANE);
 
-		/* May a hardware bug or just my test chip (not confirmed).
-		* PANEL_DISPLAY_CTRL register seems requiring few writes
-		* before a value can be successfully written in.
-		* Added some masks to mask out the reserved bits.
-		* Note: This problem happens by design. The hardware will wait for the
-		*       next vertical sync to turn on/off the plane.
-		*/
-
+		/*
+		 * May a hardware bug or just my test chip (not confirmed).
+		 * PANEL_DISPLAY_CTRL register seems requiring few writes
+		 * before a value can be successfully written in.
+		 * Added some masks to mask out the reserved bits.
+		 * Note: This problem happens by design. The hardware will wait
+		 *       for the next vertical sync to turn on/off the plane.
+		 */
 		POKE32(PANEL_DISPLAY_CTRL, tmp | reg);
 
 		while ((PEEK32(PANEL_DISPLAY_CTRL) & ~reserved) !diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 99a8683..259006a 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -173,7 +173,8 @@ long sii164InitChip(
 
 		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 
-		/* De-skew enabled with default 111b value.
+		/*
+		 * De-skew enabled with default 111b value.
 		 * This fixes some artifacts problem in some mode on board 2.2.
 		 * Somehow this fix does not affect board 2.1.
 		 */
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 78bfba0..7fce55d 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -1,21 +1,20 @@
-/*******************************************************************
-*
-*         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
-*
-*  All rights are reserved. Reproduction or in part is prohibited
-*  without the written consent of the copyright owner.
-*
-*  swi2c.c --- SM750/SM718 DDK
-*  This file contains the source code for I2C using software
-*  implementation.
-*
-*******************************************************************/
+/*
+ *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
+ *
+ *  All rights are reserved. Reproduction or in part is prohibited
+ *  without the written consent of the copyright owner.
+ *
+ *  swi2c.c --- SM750/SM718 DDK
+ *  This file contains the source code for I2C using software
+ *  implementation.
+ */
+
 #include "ddk750_chip.h"
 #include "ddk750_reg.h"
 #include "ddk750_swi2c.h"
 #include "ddk750_power.h"
 
-/*******************************************************************
+/*
  * I2C Software Master Driver:
  * =============  * Each i2c cycle is split into 4 sections. Each of these section marks
@@ -51,7 +50,7 @@
  *                            SCL | L |   | H |   |
  *                 ---------------+---+---+---+---+
  *
- ******************************************************************/
+ */
 
 /* GPIO pins used for this I2C. It ranges from 0 to 63. */
 static unsigned char sw_i2c_clk_gpio = DEFAULT_I2C_SCL;
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.h b/drivers/staging/sm750fb/ddk750_swi2c.h
index b53629c..5a9466e 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.h
+++ b/drivers/staging/sm750fb/ddk750_swi2c.h
@@ -1,15 +1,15 @@
-/*******************************************************************
-*
-*         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
-*
-*  All rights are reserved. Reproduction or in part is prohibited
-*  without the written consent of the copyright owner.
-*
-*  swi2c.h --- SM750/SM718 DDK
-*  This file contains the definitions for i2c using software
-*  implementation.
-*
-*******************************************************************/
+/*
+ *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
+ *
+ *  All rights are reserved. Reproduction or in part is prohibited
+ *  without the written consent of the copyright owner.
+ *
+ *  swi2c.h --- SM750/SM718 DDK
+ *  This file contains the definitions for i2c using software
+ *  implementation.
+ *
+ */
+
 #ifndef _SWI2C_H_
 #define _SWI2C_H_
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index ff31c5c..28f4b9b 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -146,14 +146,16 @@ struct lynxfb_crtc {
 struct lynxfb_output {
 	int dpms;
 	int paths;
-	/* which paths(s) this output stands for,for sm750:
+	/*
+	 * which paths(s) this output stands for,for sm750:
 	 * paths=1:means output for panel paths
 	 * paths=2:means output for crt paths
 	 * paths=3:means output for both panel and crt paths
 	 */
 
 	int *channel;
-	/* which channel these outputs linked with,for sm750:
+	/*
+	 * which channel these outputs linked with,for sm750:
 	 * *channel=0 means primary channel
 	 * *channel=1 means secondary channel
 	 * output->channel => &crtc->channel
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 38adae6..2e9c941 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -65,7 +65,8 @@ void hw_de_init(struct lynx_accel *accel)
 	write_dpr(accel, DE_CONTROL, read_dpr(accel, DE_CONTROL) & ~clr);
 }
 
-/* set2dformat only be called from setmode functions
+/*
+ * set2dformat only be called from setmode functions
  * but if you need dual framebuffer driver,need call set2dformat
  * every time you use 2d function
  */
@@ -90,7 +91,8 @@ int hw_fillrect(struct lynx_accel *accel,
 	u32 deCtrl;
 
 	if (accel->de_wait() != 0) {
-		/* int time wait and always busy,seems hardware
+		/*
+		 * int time wait and always busy,seems hardware
 		 * got something error
 		 */
 		pr_debug("De engine always busy\n");
@@ -213,25 +215,29 @@ unsigned int rop2)   /* ROP value */
 		opSign = (-1);
 	}
 
-	/* Note:
+	/*
+	 * Note:
 	 * DE_FOREGROUND are DE_BACKGROUND are don't care.
 	 * DE_COLOR_COMPARE and DE_COLOR_COMPARE_MAKS
 	 * are set by set deSetTransparency().
 	 */
 
-	/* 2D Source Base.
+	/*
+	 * 2D Source Base.
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
 	write_dpr(accel, DE_WINDOW_SOURCE_BASE, sBase); /* dpr40 */
 
-	/* 2D Destination Base.
+	/*
+	 * 2D Destination Base.
 	 * It is an address offset (128 bit aligned)
 	 * from the beginning of frame buffer.
 	 */
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase); /* dpr44 */
 
-    /* Program pitch (distance between the 1st points of two adjacent lines).
+    /*
+     * Program pitch (distance between the 1st points of two adjacent lines).
      * Note that input pitch is BYTE value, but the 2D Pitch register uses
      * pixel values. Need Byte to pixel conversion.
      */
@@ -240,7 +246,8 @@ unsigned int rop2)   /* ROP value */
 		   DE_PITCH_DESTINATION_MASK) |
 		  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
-    /* Screen Window width in Pixels.
+    /*
+     * Screen Window width in Pixels.
      * 2D engine uses this value to calculate the linear address in frame buffer
      * for a given point.
      */
@@ -316,7 +323,8 @@ int hw_imageblit(struct lynx_accel *accel,
 	if (accel->de_wait() != 0)
 		return -1;
 
-	/* 2D Source Base.
+	/*
+	 * 2D Source Base.
 	 * Use 0 for HOST Blt.
 	 */
 	write_dpr(accel, DE_WINDOW_SOURCE_BASE, 0);
@@ -326,16 +334,19 @@ int hw_imageblit(struct lynx_accel *accel,
 	 * from the beginning of frame buffer.
 	 */
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase);
-    /* Program pitch (distance between the 1st points of two adjacent lines).
-     * Note that input pitch is BYTE value, but the 2D Pitch register uses
-     * pixel values. Need Byte to pixel conversion.
-     */
+
+	/*
+	 * Program pitch (distance between the 1st points of two adjacent
+	 * lines). Note that input pitch is BYTE value, but the 2D Pitch
+	 * register uses pixel values. Need Byte to pixel conversion.
+	 */
 	write_dpr(accel, DE_PITCH,
 		  ((dPitch / bytePerPixel << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
 		  (dPitch / bytePerPixel & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
-	/* Screen Window width in Pixels.
+	/*
+	 * Screen Window width in Pixels.
 	 * 2D engine uses this value to calculate the linear address
 	 * in frame buffer for a given point.
 	 */
@@ -344,7 +355,8 @@ int hw_imageblit(struct lynx_accel *accel,
 		   DE_WINDOW_WIDTH_DST_MASK) |
 		  (dPitch / bytePerPixel & DE_WINDOW_WIDTH_SRC_MASK));
 
-	 /* Note: For 2D Source in Host Write, only X_K1_MONO field is needed,
+	 /*
+	  * Note: For 2D Source in Host Write, only X_K1_MONO field is needed,
 	  * and Y_K2 field is not used.
 	  * For mono bitmap, use startBit for X_K1.
 	  */
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index d5508ba..d2da7a0 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -36,7 +36,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 	pr_info("mmio phyAddr = %lx\n", sm750_dev->vidreg_start);
 
-	/* reserve the vidreg space of smi adaptor
+	/*
+	 * reserve the vidreg space of smi adaptor
 	 * if you do this, you need to add release region code
 	 * in lynxfb_remove, or memory will not be mapped again
 	 * successfully
@@ -65,7 +66,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
-	/* don't use pdev_resource[x].end - resource[x].start to
+	/*
+	 * don't use pdev_resource[x].end - resource[x].start to
 	 * calculate the resource size, it's only the maximum available
 	 * size but not the actual size, using
 	 * @ddk750_get_vm_size function can be safe.
@@ -144,7 +146,8 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		}
 		POKE32(PANEL_DISPLAY_CTRL, val);
 	} else {
-		/* for 750LE, no DVI chip initialization
+		/*
+		 * for 750LE, no DVI chip initialization
 		 * makes Monitor no signal
 		 *
 		 * Set up GPIO for software I2C to program DVI chip in the
@@ -152,13 +155,15 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		 */
 		sm750_sw_i2c_init(0, 1);
 
-		/* Customer may NOT use CH7301 DVI chip, which has to be
+		/*
+		 * Customer may NOT use CH7301 DVI chip, which has to be
 		 * initialized differently.
 		 */
 		if (sm750_sw_i2c_read_reg(0xec, 0x4a) = 0x95) {
-		/* The following register values for CH7301 are from
-		 * Chrontel app note and our experiment.
-		 */
+			/*
+			 * The following register values for CH7301 are from
+			 * Chrontel app note and our experiment.
+			 */
 			pr_info("yes,CH7301 DVI chip found\n");
 			sm750_sw_i2c_write_reg(0xec, 0x1d, 0x16);
 			sm750_sw_i2c_write_reg(0xec, 0x21, 0x9);
@@ -311,7 +316,8 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		       crtc->oScreen & PANEL_FB_ADDRESS_ADDRESS_MASK);
 
 		reg = var->xres * (var->bits_per_pixel >> 3);
-		/* crtc->channel is not equal to par->index on numeric,
+		/*
+		 * crtc->channel is not equal to par->index on numeric,
 		 * be aware of that
 		 */
 		reg = ALIGN(reg, crtc->line_pad);
@@ -345,7 +351,8 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		/* not implemented now */
 		POKE32(CRT_FB_ADDRESS, crtc->oScreen);
 		reg = var->xres * (var->bits_per_pixel >> 3);
-		/* crtc->channel is not equal to par->index on numeric,
+		/*
+		 * crtc->channel is not equal to par->index on numeric,
 		 * be aware of that
 		 */
 		reg = ALIGN(reg, crtc->line_pad) << CRT_FB_WIDTH_WIDTH_SHIFT;
-- 
2.7.4

