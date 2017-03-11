From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Sat, 11 Mar 2017 03:36:10 +0000
Subject: [PATCH 3/3] staging: sm750fb: Alignment should match open parenthesis
Message-Id: <20170311032410.8265-4-arushisinghal19971997@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170311032410.8265-1-arushisinghal19971997@gmail.com>
In-Reply-To: <20170311032410.8265-1-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: outreachy-kernel@googlegroups.com
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Arushi Singhal <arushisinghal19971997@gmail.com>

Fix checkpatch issues: "CHECK: Alignment should match open parenthesis".

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 79 +++++++++++++++++------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 45af806c8d55..eea5aef2956f 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -28,9 +28,9 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 	poke32(CRT_AUTO_CENTERING_TL, 0);
 
 	poke32(CRT_AUTO_CENTERING_BR,
-		(((y - 1) << CRT_AUTO_CENTERING_BR_BOTTOM_SHIFT) &
-			CRT_AUTO_CENTERING_BR_BOTTOM_MASK) |
-		((x - 1) & CRT_AUTO_CENTERING_BR_RIGHT_MASK));
+	       (((y - 1) << CRT_AUTO_CENTERING_BR_BOTTOM_SHIFT) &
+		CRT_AUTO_CENTERING_BR_BOTTOM_MASK) |
+	       ((x - 1) & CRT_AUTO_CENTERING_BR_RIGHT_MASK));
 
 	/*
 	 * Assume common fields in dispControl have been properly set before
@@ -72,8 +72,7 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 }
 
 /* only timing related registers will be  programed */
-static int programModeRegisters(mode_parameter_t *pModeParam,
-						struct pll_value *pll)
+static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *pll)
 {
 	int ret = 0;
 	int cnt = 0;
@@ -83,32 +82,32 @@ static int programModeRegisters(mode_parameter_t *pModeParam,
 		/* programe secondary pixel clock */
 		poke32(CRT_PLL_CTRL, sm750_format_pll_reg(pll));
 		poke32(CRT_HORIZONTAL_TOTAL,
-			(((pModeParam->horizontal_total - 1) <<
-				CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
-				CRT_HORIZONTAL_TOTAL_TOTAL_MASK) |
-			((pModeParam->horizontal_display_end - 1) &
-				CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK));
+		       (((pModeParam->horizontal_total - 1) <<
+			 CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
+			CRT_HORIZONTAL_TOTAL_TOTAL_MASK) |
+		       ((pModeParam->horizontal_display_end - 1) &
+			CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK));
 
 		poke32(CRT_HORIZONTAL_SYNC,
-			((pModeParam->horizontal_sync_width <<
-				CRT_HORIZONTAL_SYNC_WIDTH_SHIFT) &
-				CRT_HORIZONTAL_SYNC_WIDTH_MASK) |
-			((pModeParam->horizontal_sync_start - 1) &
-				CRT_HORIZONTAL_SYNC_START_MASK));
+		       ((pModeParam->horizontal_sync_width <<
+			 CRT_HORIZONTAL_SYNC_WIDTH_SHIFT) &
+			CRT_HORIZONTAL_SYNC_WIDTH_MASK) |
+		       ((pModeParam->horizontal_sync_start - 1) &
+			CRT_HORIZONTAL_SYNC_START_MASK));
 
 		poke32(CRT_VERTICAL_TOTAL,
-			(((pModeParam->vertical_total - 1) <<
-				CRT_VERTICAL_TOTAL_TOTAL_SHIFT) &
-				CRT_VERTICAL_TOTAL_TOTAL_MASK) |
-			((pModeParam->vertical_display_end - 1) &
-				CRT_VERTICAL_TOTAL_DISPLAY_END_MASK));
+		       (((pModeParam->vertical_total - 1) <<
+			 CRT_VERTICAL_TOTAL_TOTAL_SHIFT) &
+			CRT_VERTICAL_TOTAL_TOTAL_MASK) |
+		       ((pModeParam->vertical_display_end - 1) &
+			CRT_VERTICAL_TOTAL_DISPLAY_END_MASK));
 
 		poke32(CRT_VERTICAL_SYNC,
-			((pModeParam->vertical_sync_height <<
-				CRT_VERTICAL_SYNC_HEIGHT_SHIFT) &
-				CRT_VERTICAL_SYNC_HEIGHT_MASK) |
-			((pModeParam->vertical_sync_start - 1) &
-				CRT_VERTICAL_SYNC_START_MASK));
+		       ((pModeParam->vertical_sync_height <<
+			 CRT_VERTICAL_SYNC_HEIGHT_SHIFT) &
+			CRT_VERTICAL_SYNC_HEIGHT_MASK) |
+		       ((pModeParam->vertical_sync_start - 1) &
+			CRT_VERTICAL_SYNC_START_MASK));
 
 		tmp = DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE;
 		if (pModeParam->vertical_sync_polarity)
@@ -140,25 +139,25 @@ static int programModeRegisters(mode_parameter_t *pModeParam,
 		poke32(PANEL_HORIZONTAL_TOTAL, reg);
 
 		poke32(PANEL_HORIZONTAL_SYNC,
-			((pModeParam->horizontal_sync_width <<
-				PANEL_HORIZONTAL_SYNC_WIDTH_SHIFT) &
-				PANEL_HORIZONTAL_SYNC_WIDTH_MASK) |
-			((pModeParam->horizontal_sync_start - 1) &
-				PANEL_HORIZONTAL_SYNC_START_MASK));
+		       ((pModeParam->horizontal_sync_width <<
+			 PANEL_HORIZONTAL_SYNC_WIDTH_SHIFT) &
+			PANEL_HORIZONTAL_SYNC_WIDTH_MASK) |
+		       ((pModeParam->horizontal_sync_start - 1) &
+			PANEL_HORIZONTAL_SYNC_START_MASK));
 
 		poke32(PANEL_VERTICAL_TOTAL,
-			(((pModeParam->vertical_total - 1) <<
-				PANEL_VERTICAL_TOTAL_TOTAL_SHIFT) &
-				PANEL_VERTICAL_TOTAL_TOTAL_MASK) |
-			((pModeParam->vertical_display_end - 1) &
-				PANEL_VERTICAL_TOTAL_DISPLAY_END_MASK));
+		       (((pModeParam->vertical_total - 1) <<
+			 PANEL_VERTICAL_TOTAL_TOTAL_SHIFT) &
+			PANEL_VERTICAL_TOTAL_TOTAL_MASK) |
+		       ((pModeParam->vertical_display_end - 1) &
+			PANEL_VERTICAL_TOTAL_DISPLAY_END_MASK));
 
 		poke32(PANEL_VERTICAL_SYNC,
-			((pModeParam->vertical_sync_height <<
-				PANEL_VERTICAL_SYNC_HEIGHT_SHIFT) &
-				PANEL_VERTICAL_SYNC_HEIGHT_MASK) |
-			((pModeParam->vertical_sync_start - 1) &
-				PANEL_VERTICAL_SYNC_START_MASK));
+		       ((pModeParam->vertical_sync_height <<
+			 PANEL_VERTICAL_SYNC_HEIGHT_SHIFT) &
+			PANEL_VERTICAL_SYNC_HEIGHT_MASK) |
+		       ((pModeParam->vertical_sync_start - 1) &
+			PANEL_VERTICAL_SYNC_START_MASK));
 
 		tmp = DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE;
 		if (pModeParam->vertical_sync_polarity)
-- 
2.11.0

