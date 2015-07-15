From: Sunil Shahu <shshahu@gmail.com>
Date: Wed, 15 Jul 2015 05:55:36 +0000
Subject: [PATCH v2] staging: sm750fb: ddk750_chip: use consistent spacing
Message-Id: <1436939719-386-1-git-send-email-shshahu@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove all checkpatch error by using consistent spacing.

Signed-off-by: Sunil Shahu <shshahu@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f4975d2..de682dc 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -268,7 +268,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 #endif
 
 
-	if (pInitParam->powerMode != 0 )
+	if (pInitParam->powerMode != 0)
 		pInitParam->powerMode = 0;
 	setPowerMode(pInitParam->powerMode);
 
@@ -464,17 +464,17 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 		RN = N * request;
 		quo = RN / input;
 		rem = RN % input;/* rem always small than 14318181 */
-		fl_quo = (rem * 10000 /input);
+		fl_quo = (rem * 10000 / input);
 
 		for (d = xcnt - 1; d >= 0; d--) {
 			X = xparm[d].value;
 			M = quo*X;
 			M += fl_quo * X / 10000;
 			/* round step */
-			M += (fl_quo*X % 10000)>5000?1:0;
+			M += (fl_quo * X % 10000) > 5000 ? 1 : 0;
 			if (M < 256 && M > 0) {
 				unsigned int diff;
-				tmpClock = pll->inputFreq *M / N / X;
+				tmpClock = pll->inputFreq * M / N / X;
 				diff = absDiff(tmpClock, request_orig);
 				if (diff < miniDiff) {
 					pll->M = M;
@@ -599,9 +599,9 @@ unsigned int formatPllReg(pll_value_t *pPLL)
        On returning a 32 bit number, the value can be applied to any PLL in the calling function.
     */
 	ulPllReg -	FIELD_SET(  0, PANEL_PLL_CTRL, BYPASS, OFF)
-	| FIELD_SET(  0, PANEL_PLL_CTRL, POWER,  ON)
-	| FIELD_SET(  0, PANEL_PLL_CTRL, INPUT,  OSC)
+	FIELD_SET(0, PANEL_PLL_CTRL, BYPASS, OFF)
+	| FIELD_SET(0, PANEL_PLL_CTRL, POWER, ON)
+	| FIELD_SET(0, PANEL_PLL_CTRL, INPUT, OSC)
 #ifndef VALIDATION_CHIP
 	| FIELD_VALUE(0, PANEL_PLL_CTRL, POD,    pPLL->POD)
 #endif
-- 
1.9.1

