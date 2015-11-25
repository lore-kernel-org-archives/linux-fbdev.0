From: Bogicevic Sasa <brutallesale@gmail.com>
Date: Wed, 25 Nov 2015 21:56:30 +0000
Subject: [PATCH] drivers:staging:sm750fb Fix all space preferred around messages
Message-Id: <1448488590-1533-1-git-send-email-brutallesale@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bogicevic Sasa <brutallesale@gmail.com>

This fixes all messages from checkpatch.pl about space preferred

Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index fa35926..0fd34fa 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -30,8 +30,8 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 	| FIELD_VALUE(0, CRT_AUTO_CENTERING_TL, LEFT, 0));
 
 	POKE32(CRT_AUTO_CENTERING_BR,
-	FIELD_VALUE(0, CRT_AUTO_CENTERING_BR, BOTTOM, y-1)
-	| FIELD_VALUE(0, CRT_AUTO_CENTERING_BR, RIGHT, x-1));
+	FIELD_VALUE(0, CRT_AUTO_CENTERING_BR, BOTTOM, y - 1)
+	| FIELD_VALUE(0, CRT_AUTO_CENTERING_BR, RIGHT, x - 1));
 
 	/* Assume common fields in dispControl have been properly set before
 	   calling this function.
@@ -101,9 +101,9 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 		| FIELD_VALUE(0, CRT_VERTICAL_SYNC, START, pModeParam->vertical_sync_start - 1));
 
 
-		ulTmpValue = FIELD_VALUE(0, CRT_DISPLAY_CTRL, VSYNC_PHASE, pModeParam->vertical_sync_polarity)|
-					  FIELD_VALUE(0, CRT_DISPLAY_CTRL, HSYNC_PHASE, pModeParam->horizontal_sync_polarity)|
-					  FIELD_SET(0, CRT_DISPLAY_CTRL, TIMING, ENABLE)|
+		ulTmpValue = FIELD_VALUE(0, CRT_DISPLAY_CTRL, VSYNC_PHASE, pModeParam->vertical_sync_polarity) |
+					  FIELD_VALUE(0, CRT_DISPLAY_CTRL, HSYNC_PHASE, pModeParam->horizontal_sync_polarity) |
+					  FIELD_SET(0, CRT_DISPLAY_CTRL, TIMING, ENABLE) |
 					  FIELD_SET(0, CRT_DISPLAY_CTRL, PLANE, ENABLE);
 
 
@@ -116,7 +116,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 					& FIELD_CLEAR(CRT_DISPLAY_CTRL, TIMING)
 					& FIELD_CLEAR(CRT_DISPLAY_CTRL, PLANE);
 
-			 POKE32(CRT_DISPLAY_CTRL, ulTmpValue|ulReg);
+			 POKE32(CRT_DISPLAY_CTRL, ulTmpValue | ulReg);
 		}
 
 	} else if (pll->clockType = PRIMARY_PLL) {
@@ -140,15 +140,15 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 		FIELD_VALUE(0, PANEL_VERTICAL_SYNC, HEIGHT, pModeParam->vertical_sync_height)
 		| FIELD_VALUE(0, PANEL_VERTICAL_SYNC, START, pModeParam->vertical_sync_start - 1));
 
-		ulTmpValue = FIELD_VALUE(0, PANEL_DISPLAY_CTRL, VSYNC_PHASE, pModeParam->vertical_sync_polarity)|
-			     FIELD_VALUE(0, PANEL_DISPLAY_CTRL, HSYNC_PHASE, pModeParam->horizontal_sync_polarity)|
-			     FIELD_VALUE(0, PANEL_DISPLAY_CTRL, CLOCK_PHASE, pModeParam->clock_phase_polarity)|
-			     FIELD_SET(0, PANEL_DISPLAY_CTRL, TIMING, ENABLE)|
+		ulTmpValue = FIELD_VALUE(0, PANEL_DISPLAY_CTRL, VSYNC_PHASE, pModeParam->vertical_sync_polarity) |
+			     FIELD_VALUE(0, PANEL_DISPLAY_CTRL, HSYNC_PHASE, pModeParam->horizontal_sync_polarity) |
+			     FIELD_VALUE(0, PANEL_DISPLAY_CTRL, CLOCK_PHASE, pModeParam->clock_phase_polarity) |
+			     FIELD_SET(0, PANEL_DISPLAY_CTRL, TIMING, ENABLE) |
 			     FIELD_SET(0, PANEL_DISPLAY_CTRL, PLANE, ENABLE);
 
 		ulReservedBits = FIELD_SET(0, PANEL_DISPLAY_CTRL, RESERVED_1_MASK, ENABLE) |
 				 FIELD_SET(0, PANEL_DISPLAY_CTRL, RESERVED_2_MASK, ENABLE) |
-				 FIELD_SET(0, PANEL_DISPLAY_CTRL, RESERVED_3_MASK, ENABLE)|
+				 FIELD_SET(0, PANEL_DISPLAY_CTRL, RESERVED_3_MASK, ENABLE) |
 				 FIELD_SET(0, PANEL_DISPLAY_CTRL, VSYNC, ACTIVE_LOW);
 
 		ulReg = (PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits)
@@ -167,13 +167,13 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 		*       next vertical sync to turn on/off the plane.
 		*/
 
-		POKE32(PANEL_DISPLAY_CTRL, ulTmpValue|ulReg);
+		POKE32(PANEL_DISPLAY_CTRL, ulTmpValue | ulReg);
 
-		while ((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) != (ulTmpValue|ulReg)) {
+		while ((PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits) != (ulTmpValue | ulReg)) {
 			cnt++;
 			if (cnt > 1000)
 				break;
-			POKE32(PANEL_DISPLAY_CTRL, ulTmpValue|ulReg);
+			POKE32(PANEL_DISPLAY_CTRL, ulTmpValue | ulReg);
 		}
 	} else {
 		ret = -1;
-- 
2.1.4

