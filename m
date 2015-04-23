From: Charles Rose <charles.rose.linux@gmail.com>
Date: Thu, 23 Apr 2015 21:04:08 +0000
Subject: [PATCH] staging: sm750fb: cleanup white space and indent
Message-Id: <1429823048-9094-1-git-send-email-charles.rose.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: charles.rose.linux@gmail.com

This patch fixes "space prohibited" errors reported by checkpatch.pl
and related indentation. The module builds without error.

Signed-off-by: Charles Rose <charles.rose.linux@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c  | 12 ++++++------
 drivers/staging/sm750fb/ddk750_mode.c  | 26 +++++++++++++++++---------
 drivers/staging/sm750fb/ddk750_power.c |  8 ++++----
 drivers/staging/sm750fb/sm750_accel.c  |  2 +-
 drivers/staging/sm750fb/sm750_help.h   |  2 +-
 5 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 7b28328..60ae39a 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -268,7 +268,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 #endif
 
 
-	if (pInitParam->powerMode != 0 )
+	if (pInitParam->powerMode != 0)
 		pInitParam->powerMode = 0;
 	setPowerMode(pInitParam->powerMode);
 
@@ -285,7 +285,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 		ulReg = FIELD_SET(ulReg, VGA_CONFIGURATION, MODE, GRAPHIC);
 		POKE32(VGA_CONFIGURATION, ulReg);
 	} else {
-#if defined(__i386__) || defined( __x86_64__)
+#if defined(__i386__) || defined(__x86_64__)
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
@@ -382,7 +382,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 
 unsigned int absDiff(unsigned int a, unsigned int b)
 {
-	if ( a > b )
+	if (a > b)
 		return(a - b);
 	else
 		return(b - a);
@@ -606,9 +606,9 @@ unsigned int formatPllReg(pll_value_t *pPLL)
        On returning a 32 bit number, the value can be applied to any PLL in the calling function.
     */
 	ulPllReg -	FIELD_SET(  0, PANEL_PLL_CTRL, BYPASS, OFF)
-	| FIELD_SET(  0, PANEL_PLL_CTRL, POWER,  ON)
-	| FIELD_SET(  0, PANEL_PLL_CTRL, INPUT,  OSC)
+	FIELD_SET(0, PANEL_PLL_CTRL, BYPASS, OFF)
+	| FIELD_SET(0, PANEL_PLL_CTRL, POWER,  ON)
+	| FIELD_SET(0, PANEL_PLL_CTRL, INPUT,  OSC)
 #ifndef VALIDATION_CHIP
 	| FIELD_VALUE(0, PANEL_PLL_CTRL, POD,    pPLL->POD)
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 2e418fb..a7e2f9a 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -43,22 +43,30 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 
 	/* Set bit 29:27 of display control register for the right clock */
 	/* Note that SM750LE only need to supported 7 resoluitons. */
-	if ( x = 800 && y = 600 )
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL41);
+	if (x = 800 && y = 600)
+		dispControl = FIELD_SET(dispControl,
+				CRT_DISPLAY_CTRL, CLK, PLL41);
 	else if (x = 1024 && y = 768)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL65);
+		dispControl = FIELD_SET(dispControl,
+				CRT_DISPLAY_CTRL, CLK, PLL65);
 	else if (x = 1152 && y = 864)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL80);
+		dispControl = FIELD_SET(dispControl,
+				CRT_DISPLAY_CTRL, CLK, PLL80);
 	else if (x = 1280 && y = 768)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL80);
+		dispControl = FIELD_SET(dispControl,
+				CRT_DISPLAY_CTRL, CLK, PLL80);
 	else if (x = 1280 && y = 720)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL74);
+		dispControl = FIELD_SET(dispControl,
+				CRT_DISPLAY_CTRL, CLK, PLL74);
 	else if (x = 1280 && y = 960)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL108);
+		dispControl = FIELD_SET(dispControl,
+				CRT_DISPLAY_CTRL, CLK, PLL108);
 	else if (x = 1280 && y = 1024)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL108);
+		dispControl = FIELD_SET(dispControl,
+				CRT_DISPLAY_CTRL, CLK, PLL108);
 	else /* default to VGA clock */
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL25);
+		dispControl = FIELD_SET(dispControl,
+				CRT_DISPLAY_CTRL, CLK, PLL25);
 
 	/* Set bit 25:24 of display controller */
     dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CRTSELECT, CRT);
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index cbb9767..0e3c028 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -59,17 +59,17 @@ void setPowerMode(unsigned int powerMode)
     {
         control_value  #ifdef VALIDATION_CHIP
-            FIELD_SET(  control_value, POWER_MODE_CTRL, 336CLK, OFF) |
+		FIELD_SET(control_value, POWER_MODE_CTRL, 336CLK, OFF) |
 #endif
-            FIELD_SET(  control_value, POWER_MODE_CTRL, OSC_INPUT,  OFF);
+		FIELD_SET(control_value, POWER_MODE_CTRL, OSC_INPUT, OFF);
     }
     else
     {
         control_value  #ifdef VALIDATION_CHIP
-            FIELD_SET(  control_value, POWER_MODE_CTRL, 336CLK, ON) |
+		FIELD_SET(control_value, POWER_MODE_CTRL, 336CLK, ON) |
 #endif
-            FIELD_SET(  control_value, POWER_MODE_CTRL, OSC_INPUT,  ON);
+		FIELD_SET(control_value, POWER_MODE_CTRL, OSC_INPUT, ON);
     }
 
     /* Program new power mode. */
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index c5a3726..e308646 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -364,7 +364,7 @@ int hw_imageblit(struct lynx_accel *accel,
        Note that input pitch is BYTE value, but the 2D Pitch register uses
        pixel values. Need Byte to pixel convertion.
     */
-	if(bytePerPixel = 3 ){
+	if (bytePerPixel = 3) {
 		dx *= 3;
 		width *= 3;
 		startBit *= 3;
diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
index e0128d2..cdac9e2 100644
--- a/drivers/staging/sm750fb/sm750_help.h
+++ b/drivers/staging/sm750fb/sm750_help.h
@@ -57,7 +57,7 @@
 
 #define FIELD_CLEAR(reg, field) \
 ( \
-    ~ _F_MASK(reg ## _ ## field) \
+	~_F_MASK(reg ## _ ## field) \
 )
 
 
-- 
2.1.0

