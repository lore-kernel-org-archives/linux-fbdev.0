From: SRIKANT RITOLIA <srikant.ritolia@gmail.com>
Date: Thu, 01 Dec 2016 18:46:39 +0000
Subject: [PATCH] staging: sm750fb: Aligning Block comments
Message-Id: <CADeeJYBNp+kwS+wfCRPh2RF1ji1nR4rKf4=mBsDuBSwiJ+=Yrw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix checkpatch.pl warnings:-
Block comments should align the * on each line

Signed-off-by: Srikant Ritolia <srikant.ritolia@gmail.com>
---
 drivers/staging/sm750fb/ddk750.h       | 20 ++++++++++----------
 drivers/staging/sm750fb/ddk750_chip.c  | 14 +++++++-------
 drivers/staging/sm750fb/ddk750_chip.h  | 10 +++++-----
 drivers/staging/sm750fb/ddk750_mode.c  | 12 ++++++------
 drivers/staging/sm750fb/ddk750_swi2c.c | 22 +++++++++++-----------
 drivers/staging/sm750fb/ddk750_swi2c.h | 22 +++++++++++-----------
 6 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750.h b/drivers/staging/sm750fb/ddk750.h
index 2c10a08ed964..7ee371443e28 100644
--- a/drivers/staging/sm750fb/ddk750.h
+++ b/drivers/staging/sm750fb/ddk750.h
@@ -1,16 +1,16 @@
 #ifndef DDK750_H__
 #define DDK750_H__
 /*******************************************************************
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
+ *
+ *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
+ *
+ *  All rights are reserved. Reproduction or in part is prohibited
+ *  without the written consent of the copyright owner.
+ *
+ *  RegSC.h --- SM718 SDK
+ *  This file contains the definitions for the System Configuration registers.
+ *
+ *******************************************************************/
 #include "ddk750_reg.h"
 #include "ddk750_mode.h"
 #include "ddk750_chip.h"
diff --git a/drivers/staging/sm750fb/ddk750_chip.c
b/drivers/staging/sm750fb/ddk750_chip.c
index 839d6730bde9..b7697ac206cf 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -63,17 +63,17 @@ static void setChipClock(unsigned int frequency)

  if (frequency) {
  /*
- * Set up PLL, a structure to hold the value to be set in clocks.
- */
+ * Set up PLL, a structure to hold the value to be set in clocks.
+ */
  pll.inputFreq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
  pll.clockType = MXCLK_PLL;

  /*
- * Call calcPllValue() to fill the other fields of PLL structure.
- * Sometime, the chip cannot set up the exact clock
- * required by the User.
- * Return value of calcPllValue gives the actual possible clock.
- */
+ * Call calcPllValue() to fill the other fields of PLL structure.
+ * Sometime, the chip cannot set up the exact clock
+ * required by the User.
+ * Return value of calcPllValue gives the actual possible clock.
+ */
  ulActualMxClk = calcPllValue(frequency, &pll);

  /* Master Clock Control: MXCLK_PLL */
diff --git a/drivers/staging/sm750fb/ddk750_chip.h
b/drivers/staging/sm750fb/ddk750_chip.h
index 14357fd1cc6b..20031f4e03fa 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -40,27 +40,27 @@ pll_value_t;
 /* input struct to initChipParam() function */
 typedef struct _initchip_param_t {
  unsigned short powerMode;    /* Use power mode 0 or 1 */
- unsigned short chipClock;    /**
+ unsigned short chipClock;    /*
       * Speed of main chip clock in MHz unit
       * 0 = keep the current clock setting
       * Others = the new main chip clock
       */
- unsigned short memClock;     /**
+ unsigned short memClock;     /*
       * Speed of memory clock in MHz unit
       * 0 = keep the current clock setting
       * Others = the new memory clock
       */
- unsigned short masterClock;  /**
+ unsigned short masterClock;  /*
       * Speed of master clock in MHz unit
       * 0 = keep the current clock setting
       * Others = the new master clock
       */
- unsigned short setAllEngOff; /**
+ unsigned short setAllEngOff; /*
       * 0 = leave all engine state untouched.
       * 1 = make sure they are off: 2D, Overlay,
       * video alpha, alpha, hardware cursors
       */
- unsigned char resetMemory;   /**
+ unsigned char resetMemory;   /*
       * 0 = Do not reset the memory controller
       * 1 = Reset the memory controller
       */
diff --git a/drivers/staging/sm750fb/ddk750_mode.c
b/drivers/staging/sm750fb/ddk750_mode.c
index 05b83646c2d5..4c0012b81c7f 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -177,12 +177,12 @@ static int programModeRegisters(mode_parameter_t
*pModeParam, pll_value_t *pll)
   DISPLAY_CTRL_PLANE);

  /* May a hardware bug or just my test chip (not confirmed).
- * PANEL_DISPLAY_CTRL register seems requiring few writes
- * before a value can be successfully written in.
- * Added some masks to mask out the reserved bits.
- * Note: This problem happens by design. The hardware will wait for the
- *       next vertical sync to turn on/off the plane.
- */
+ * PANEL_DISPLAY_CTRL register seems requiring few writes
+ * before a value can be successfully written in.
+ * Added some masks to mask out the reserved bits.
+ * Note: This problem happens by design. The hardware will wait for the
+ *       next vertical sync to turn on/off the plane.
+ */

  POKE32(PANEL_DISPLAY_CTRL, tmp | reg);

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c
b/drivers/staging/sm750fb/ddk750_swi2c.c
index 72a42330e7a1..c0686050c0bc 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -1,15 +1,15 @@
 /*******************************************************************
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
+ *
+ *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
+ *
+ *  All rights are reserved. Reproduction or in part is prohibited
+ *  without the written consent of the copyright owner.
+ *
+ *  swi2c.c --- SM750/SM718 DDK
+ *  This file contains the source code for I2C using software
+ *  implementation.
+ *
+ *******************************************************************/
 #include "ddk750_help.h"
 #include "ddk750_reg.h"
 #include "ddk750_swi2c.h"
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.h
b/drivers/staging/sm750fb/ddk750_swi2c.h
index b53629cda095..9dd4107ace54 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.h
+++ b/drivers/staging/sm750fb/ddk750_swi2c.h
@@ -1,15 +1,15 @@
 /*******************************************************************
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
+ *
+ *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
+ *
+ *  All rights are reserved. Reproduction or in part is prohibited
+ *  without the written consent of the copyright owner.
+ *
+ *  swi2c.h --- SM750/SM718 DDK
+ *  This file contains the definitions for i2c using software
+ *  implementation.
+ *
+ *******************************************************************/
 #ifndef _SWI2C_H_
 #define _SWI2C_H_

-- 
2.11.0.windows.1
