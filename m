From: Rithvik Patibandla <rithvikp98@gmail.com>
Date: Sun, 12 Jun 2016 13:42:41 +0000
Subject: [PATCH] Staging:sm750fb:ddk750_chip.c:Fixed coding style in comments
Message-Id: <20160612133041.GA3709@rithvik-IdeaPad>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

The following patch fixes format of some comments.

Signed-off-by: Rithvik Patibandla <rithvikp98@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 71 +++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f80ee77..8cb5cb9 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -70,11 +70,11 @@ static void setChipClock(unsigned int frequency)
 		pll.inputFreq = DEFAULT_INPUT_CLOCK; /* Defined in CLOCK.H */
 		pll.clockType = MXCLK_PLL;
 
-		/*
-		* Call calcPllValue() to fill up the other fields for PLL structure.
-		* Sometime, the chip cannot set up the exact clock required by User.
-		* Return value from calcPllValue() gives the actual possible clock.
-		*/
+	/*
+	 * Call calcPllValue() to fill up the other fields for PLL structure.
+	 * Sometime, the chip cannot set up the exact clock required by User.
+	 * Return value from calcPllValue() gives the actual possible clock.
+	 */
 		ulActualMxClk = calcPllValue(frequency, &pll);
 
 		/* Master Clock Control: MXCLK_PLL */
@@ -86,13 +86,15 @@ static void setMemoryClock(unsigned int frequency)
 {
 	unsigned int reg, divisor;
 
-	/* Cheok_0509: For SM750LE, the memory clock is fixed. Nothing to set. */
+/* Cheok_0509: For SM750LE, the memory clock is fixed. Nothing to set. */
 	if (getChipType() = SM750LE)
 		return;
 
 	if (frequency) {
-		/* Set the frequency to the maximum frequency that the DDR Memory can take
-		which is 336MHz. */
+	/*
+	 * Set the frequency to the maximum frequency that the DDR Memory can
+	 * take which is 336MHz.
+	 */
 		if (frequency > MHz(336))
 			frequency = MHz(336);
 
@@ -133,13 +135,15 @@ static void setMasterClock(unsigned int frequency)
 {
 	unsigned int reg, divisor;
 
-	/* Cheok_0509: For SM750LE, the memory clock is fixed. Nothing to set. */
+/* Cheok_0509: For SM750LE, the memory clock is fixed. Nothing to set. */
 	if (getChipType() = SM750LE)
 		return;
 
 	if (frequency) {
-		/* Set the frequency to the maximum frequency that the SM750 engine can
-		run, which is about 190 MHz. */
+	/*
+	 * Set the frequency to the maximum frequency that the SM750 engine can
+	 * run, which is about 190 MHz.
+	 */
 		if (frequency > MHz(190))
 			frequency = MHz(190);
 
@@ -236,9 +240,10 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 	setMasterClock(MHz(pInitParam->masterClock));
 
 
-	/* Reset the memory controller. If the memory controller is not reset in SM750,
-	   the system might hang when sw accesses the memory.
-	   The memory should be resetted after changing the MXCLK.
+	/*
+	 * Reset the memory controller. If the memory controller is not reset
+	 * in SM750, the system might hang when sw accesses the memory.The
+	 * memory should be resetted after changing the MXCLK.
 	 */
 	if (pInitParam->resetMemory = 1) {
 		reg = PEEK32(MISC_CTRL);
@@ -282,24 +287,23 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 }
 
 /*
-	monk liu @ 4/6/2011:
-		   re-write the calculatePLL function of ddk750.
-		   the original version function does not use some mathematics tricks and shortcut
-		   when it doing the calculation of the best N,M,D combination
-		   I think this version gives a little upgrade in speed
-
-	750 pll clock formular:
-	Request Clock = (Input Clock * M )/(N * X)
-
-	Input Clock = 14318181 hz
-	X = 2 power D
-	D ={0,1,2,3,4,5,6}
-	M = {1,...,255}
-	N = {2,...,15}
-*/
+ * monk liu @ 4/6/2011:
+ *	re-write the calculatePLL function of ddk750. the original version
+ *	function does not use some mathematics tricks and shortcut when it
+ *	doing the calculation of the best N,M,D combination. I think this
+ *	version gives a little upgrade in speed
+ *
+ *	750 pll clock formular:
+*		Request Clock = (Input Clock * M )/(N * X)
+ *		Input Clock = 14318181 hz
+ *		X = 2 power D
+ *		D ={0,1,2,3,4,5,6}
+ *		M = {1,...,255}
+ *		N = {2,...,15}
+ */
 unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 {
-	/* as sm750 register definition, N located in 2,15 and M located in 1,255	*/
+/* as sm750 register definition, N located in 2,15 and M located in  1,255 */
 	int N, M, X, d;
 	int mini_diff;
 	unsigned int RN, quo, rem, fl_quo;
@@ -310,7 +314,8 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 
 	if (getChipType() = SM750LE) {
 		/* SM750LE don't have prgrammable PLL and M/N values to work on.
-		Just return the requested clock. */
+		 * Just return the requested clock.
+		 */
 		return request_orig;
 	}
 
@@ -319,12 +324,12 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 	request = request_orig / 1000;
 	input = pll->inputFreq / 1000;
 
-	/* for MXCLK register , no POD provided, so need be treated differently	*/
+/* for MXCLK register , no POD provided, so need be treated differently	*/
 	if (pll->clockType = MXCLK_PLL)
 		max_d = 3;
 
 	for (N = 15; N > 1; N--) {
-		/* RN will not exceed maximum long if @request <= 285 MHZ (for 32bit cpu) */
+/* RN will not exceed maximum long if @request <= 285 MHZ (for 32bit cpu) */
 		RN = N * request;
 		quo = RN / input;
 		rem = RN % input;/* rem always small than 14318181 */
-- 
2.7.4

