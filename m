From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Mon, 20 Mar 2017 14:18:56 +0000
Subject: [PATCH v5] staging:sm750fb: Code readability is improved.
Message-Id: <20170320140656.GA5137@arushi-HP-Pavilion-Notebook>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com

New variables are added to make the code more readable.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 changes in v5
 -try to make the code much more readable.
 - defined the variable at the top of a block.
 - change the variable from temp to tmp.

 drivers/staging/sm750fb/ddk750_mode.c | 55 +++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index eea5aef2956f..37b5d4850fb9 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -81,33 +81,38 @@ static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *
 	if (pll->clockType = SECONDARY_PLL) {
 		/* programe secondary pixel clock */
 		poke32(CRT_PLL_CTRL, sm750_format_pll_reg(pll));
-		poke32(CRT_HORIZONTAL_TOTAL,
-		       (((pModeParam->horizontal_total - 1) <<
-			 CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
-			CRT_HORIZONTAL_TOTAL_TOTAL_MASK) |
-		       ((pModeParam->horizontal_display_end - 1) &
-			CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK));
-
-		poke32(CRT_HORIZONTAL_SYNC,
-		       ((pModeParam->horizontal_sync_width <<
-			 CRT_HORIZONTAL_SYNC_WIDTH_SHIFT) &
-			CRT_HORIZONTAL_SYNC_WIDTH_MASK) |
-		       ((pModeParam->horizontal_sync_start - 1) &
-			CRT_HORIZONTAL_SYNC_START_MASK));
 
-		poke32(CRT_VERTICAL_TOTAL,
-		       (((pModeParam->vertical_total - 1) <<
-			 CRT_VERTICAL_TOTAL_TOTAL_SHIFT) &
-			CRT_VERTICAL_TOTAL_TOTAL_MASK) |
-		       ((pModeParam->vertical_display_end - 1) &
-			CRT_VERTICAL_TOTAL_DISPLAY_END_MASK));
+		tmp = ((pModeParam->horizontal_total - 1) <<
+		       CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
+		     CRT_HORIZONTAL_TOTAL_TOTAL_MASK;
+		tmp |= (pModeParam->horizontal_display_end - 1) &
+		      CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK;
 
-		poke32(CRT_VERTICAL_SYNC,
-		       ((pModeParam->vertical_sync_height <<
-			 CRT_VERTICAL_SYNC_HEIGHT_SHIFT) &
-			CRT_VERTICAL_SYNC_HEIGHT_MASK) |
-		       ((pModeParam->vertical_sync_start - 1) &
-			CRT_VERTICAL_SYNC_START_MASK));
+		poke32(CRT_HORIZONTAL_TOTAL, tmp);
+
+		tmp = (pModeParam->horizontal_sync_width <<
+		       CRT_HORIZONTAL_SYNC_WIDTH_SHIFT) &
+		     CRT_HORIZONTAL_SYNC_WIDTH_MASK;
+		tmp |= (pModeParam->horizontal_sync_start - 1) &
+		      CRT_HORIZONTAL_SYNC_START_MASK;
+
+		poke32(CRT_HORIZONTAL_SYNC, tmp);
+
+		tmp = ((pModeParam->vertical_total - 1) <<
+		       CRT_VERTICAL_TOTAL_TOTAL_SHIFT) &
+		     CRT_VERTICAL_TOTAL_TOTAL_MASK;
+		tmp |= (pModeParam->vertical_display_end - 1) &
+		      CRT_VERTICAL_TOTAL_DISPLAY_END_MASK;
+
+		poke32(CRT_VERTICAL_TOTAL, tmp);
+
+		tmp = ((pModeParam->vertical_sync_height <<
+		       CRT_VERTICAL_SYNC_HEIGHT_SHIFT)) &
+		     CRT_VERTICAL_SYNC_HEIGHT_MASK;
+		tmp |= (pModeParam->vertical_sync_start - 1) &
+		      CRT_VERTICAL_SYNC_START_MASK;
+
+		poke32(CRT_VERTICAL_SYNC, tmp);
 
 		tmp = DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE;
 		if (pModeParam->vertical_sync_polarity)
-- 
2.11.0

