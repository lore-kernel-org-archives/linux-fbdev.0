From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Sun, 19 Mar 2017 13:19:44 +0000
Subject: [PATCH v3] staging: sm750fb: Code readability is improved
Message-Id: <20170319130744.GA24605@arushi-HP-Pavilion-Notebook>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com

New variables are added to make the code more readable.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 changes in v3
 -try to make the code much more readable.
 
 drivers/staging/sm750fb/ddk750_mode.c | 61 ++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index eea5aef2956f..5f18ce4d10de 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -81,33 +81,42 @@ static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *
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
-
-		poke32(CRT_VERTICAL_SYNC,
-		       ((pModeParam->vertical_sync_height <<
-			 CRT_VERTICAL_SYNC_HEIGHT_SHIFT) &
-			CRT_VERTICAL_SYNC_HEIGHT_MASK) |
-		       ((pModeParam->vertical_sync_start - 1) &
-			CRT_VERTICAL_SYNC_START_MASK));
+		unsigned int a = (pModeParam->horizontal_total - 1) <<
+				CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT;
+		unsigned int b = a & CRT_HORIZONTAL_TOTAL_TOTAL_MASK;
+		unsigned int c = (pModeParam->horizontal_display_end - 1) &
+				CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK;
+		unsigned int temp = b | c;
+
+		poke32(CRT_HORIZONTAL_TOTAL, temp);
+
+		unsigned int a = (pModeParam->horizontal_sync_width <<
+				CRT_HORIZONTAL_SYNC_WIDTH_SHIFT);
+		unsigned int b = a & CRT_HORIZONTAL_SYNC_WIDTH_MASK;
+		unsigned int c = (pModeParam->horizontal_sync_start - 1) &
+				CRT_HORIZONTAL_SYNC_START_MASK;
+		unsigned int temp = b | c;
+
+		poke32(CRT_HORIZONTAL_SYNC, temp);
+
+		unsigned int a = (pModeParam->vertical_total - 1) <<
+				CRT_VERTICAL_TOTAL_TOTAL_SHIFT;
+		unsigned int b = a & CRT_VERTICAL_TOTAL_TOTAL_MASK;
+		unsigned int c = (pModeParam->vertical_display_end - 1) &
+				CRT_VERTICAL_TOTAL_DISPLAY_END_MASK;
+		unsigned int temp = b | c;
+
+		poke32(CRT_VERTICAL_TOTAL, temp);
+
+		unsigned int a = pModeParam->vertical_sync_height <<
+				CRT_VERTICAL_SYNC_HEIGHT_SHIFT;
+		unsigned int b = a & CRT_VERTICAL_SYNC_HEIGHT_MASK;
+		unsigned int c = (pModeParam->vertical_sync_start - 1) &
+				CRT_VERTICAL_SYNC_START_MASK;
+		unsigned int temp = b | c;
+
+		poke32(CRT_VERTICAL_SYNC, temp);
 
 		tmp = DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE;
 		if (pModeParam->vertical_sync_polarity)
-- 
2.11.0

