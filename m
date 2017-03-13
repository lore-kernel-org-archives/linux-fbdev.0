From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Mon, 13 Mar 2017 18:38:53 +0000
Subject: [PATCH v2] staging: sm750fb: Improved code readability
Message-Id: <20170313182652.GA19882@arushi-HP-Pavilion-Notebook>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com

New variables are added to make the code more readable.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 changes in v2
 - removed the error.

 drivers/staging/sm750fb/ddk750_mode.c | 103 ++++++++++++++++------------------
 1 file changed, 49 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 25da678179f7..6dd52b450367 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -77,37 +77,34 @@ static int programModeRegisters(struct _mode_parameter_t *pModeParam, struct pll
 	int ret = 0;
 	int cnt = 0;
 	unsigned int tmp, reg;
+	unsigned int cht = CRT_HORIZONTAL_TOTAL;
+	unsigned int cvt = CRT_VERTICAL_TOTAL;
+	unsigned int chs = CRT_HORIZONTAL_SYNC;
+	unsigned int cvs = CRT_VERTICAL_SYNC;
+	unsigned int chssm = CRT_HORIZONTAL_SYNC_START_MASK;
+	unsigned int cvssm = CRT_VERTICAL_SYNC_START_MASK;
+	unsigned int chtdem = CRT_HORIZONTAL_TOTAL_DISPLAY_END_MASK;
+	unsigned int cvtdem = CRT_VERTICAL_TOTAL_DISPLAY_END_MASK;
+	unsigned int chttm = CRT_HORIZONTAL_TOTAL_TOTAL_MASK;
+	unsigned int cvttm = CRT_VERTICAL_TOTAL_TOTAL_MASK;
+	unsigned int chswm = CRT_HORIZONTAL_SYNC_WIDTH_MASK;
+	unsigned int cvshm = CRT_VERTICAL_SYNC_HEIGHT_MASK;
+	unsigned int phde = pModeParam->horizontal_display_end - 1;
+	unsigned int pvde = pModeParam->vertical_display_end - 1;
+	unsigned int phss = pModeParam->horizontal_sync_start - 1;
+	unsigned int pvss = pModeParam->vertical_sync_start - 1;
 
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
-
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
+
+		poke32(cht, (((pModeParam->horizontal_total - 1) << CRT_HORIZONTAL_TOTAL_TOTAL_SHIFT) & chttm) | (phde & chtdem));
+
+		poke32(chs, ((pModeParam->horizontal_sync_width << CRT_HORIZONTAL_SYNC_WIDTH_SHIFT) & chswm) | (phss & chssm));
+
+		poke32(cvt, (((pModeParam->vertical_total - 1) << CRT_VERTICAL_TOTAL_TOTAL_SHIFT) & cvttm) | (pvde & cvtdem));
+
+		poke32(cvs, ((pModeParam->vertical_sync_height << CRT_VERTICAL_SYNC_HEIGHT_SHIFT) & cvshm) | (pvss & cvssm));
 
 		tmp = DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE;
 		if (pModeParam->vertical_sync_polarity)
@@ -128,36 +125,34 @@ static int programModeRegisters(struct _mode_parameter_t *pModeParam, struct pll
 
 	} else if (pll->clockType = PRIMARY_PLL) {
 		unsigned int reserved;
+		unsigned int pht = PANEL_HORIZONTAL_TOTAL;
+		unsigned int pvt = PANEL_VERTICAL_TOTAL;
+		unsigned int phs = PANEL_HORIZONTAL_SYNC;
+		unsigned int pvs = PANEL_VERTICAL_SYNC;
+		unsigned int phssm = PANEL_HORIZONTAL_SYNC_START_MASK;
+		unsigned int pvssm = PANEL_VERTICAL_SYNC_START_MASK;
+		unsigned int phtdem = PANEL_HORIZONTAL_TOTAL_DISPLAY_END_MASK;
+		unsigned int pvtdem = PANEL_VERTICAL_TOTAL_DISPLAY_END_MASK;
+		unsigned int phttm = PANEL_HORIZONTAL_TOTAL_TOTAL_MASK;
+		unsigned int pvttm = PANEL_VERTICAL_TOTAL_TOTAL_MASK;
+		unsigned int phswm = PANEL_HORIZONTAL_SYNC_WIDTH_MASK;
+		unsigned int pvshm = PANEL_VERTICAL_SYNC_HEIGHT_MASK;
+		unsigned int phde = pModeParam->horizontal_display_end - 1;
+		unsigned int pvde = pModeParam->vertical_display_end - 1;
+		unsigned int phss = pModeParam->horizontal_sync_start - 1;
+		unsigned int pvss = pModeParam->vertical_sync_start - 1;
 
 		poke32(PANEL_PLL_CTRL, sm750_format_pll_reg(pll));
 
-		reg = ((pModeParam->horizontal_total - 1) <<
-			PANEL_HORIZONTAL_TOTAL_TOTAL_SHIFT) &
-			PANEL_HORIZONTAL_TOTAL_TOTAL_MASK;
-		reg |= ((pModeParam->horizontal_display_end - 1) &
-			PANEL_HORIZONTAL_TOTAL_DISPLAY_END_MASK);
-		poke32(PANEL_HORIZONTAL_TOTAL, reg);
-
-		poke32(PANEL_HORIZONTAL_SYNC,
-		       ((pModeParam->horizontal_sync_width <<
-			 PANEL_HORIZONTAL_SYNC_WIDTH_SHIFT) &
-			PANEL_HORIZONTAL_SYNC_WIDTH_MASK) |
-		       ((pModeParam->horizontal_sync_start - 1) &
-			PANEL_HORIZONTAL_SYNC_START_MASK));
-
-		poke32(PANEL_VERTICAL_TOTAL,
-		       (((pModeParam->vertical_total - 1) <<
-			 PANEL_VERTICAL_TOTAL_TOTAL_SHIFT) &
-			PANEL_VERTICAL_TOTAL_TOTAL_MASK) |
-		       ((pModeParam->vertical_display_end - 1) &
-			PANEL_VERTICAL_TOTAL_DISPLAY_END_MASK));
-
-		poke32(PANEL_VERTICAL_SYNC,
-		       ((pModeParam->vertical_sync_height <<
-			 PANEL_VERTICAL_SYNC_HEIGHT_SHIFT) &
-			PANEL_VERTICAL_SYNC_HEIGHT_MASK) |
-		       ((pModeParam->vertical_sync_start - 1) &
-			PANEL_VERTICAL_SYNC_START_MASK));
+		reg = ((pModeParam->horizontal_total - 1) << PANEL_HORIZONTAL_TOTAL_TOTAL_SHIFT) & phttm;
+		reg |= (phde & phtdem);
+		poke32(pht, reg);
+
+		poke32(phs, ((pModeParam->horizontal_sync_width << PANEL_HORIZONTAL_SYNC_WIDTH_SHIFT) & phswm) | (phss & phssm));
+
+		poke32(pvt, (((pModeParam->vertical_total - 1) << PANEL_VERTICAL_TOTAL_TOTAL_SHIFT) & pvttm) | (pvde & pvtdem));
+
+		poke32(pvs, ((pModeParam->vertical_sync_height << PANEL_VERTICAL_SYNC_HEIGHT_SHIFT) & pvshm) | (pvss & pvssm));
 
 		tmp = DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE;
 		if (pModeParam->vertical_sync_polarity)
-- 
2.11.0

