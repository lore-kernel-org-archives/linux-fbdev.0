From: Moshe Green <mgmoshes@gmail.com>
Date: Thu, 15 Sep 2016 20:15:50 +0000
Subject: [PATCH 1/2] staging: sm750fb: fix line length coding style issues in ddk750_chip.c
Message-Id: <3073702d63fb782f3b4f3932eb183433f76ce91b.1473970394.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <523e16874da50855062fcc51b6754e2b9c42b9e5.1472932508.git.mgmoshes@gmail.com>
In-Reply-To: <523e16874da50855062fcc51b6754e2b9c42b9e5.1472932508.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix multiple line length warnings found by the checkpatch.pl tool
in ddk750_chip.c.

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index c1356bb..7cba1ab 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -71,9 +71,10 @@ static void setChipClock(unsigned int frequency)
 		pll.clockType = MXCLK_PLL;
 
 		/*
-		* Call calcPllValue() to fill up the other fields for PLL structure.
-		* Sometime, the chip cannot set up the exact clock required by User.
-		* Return value from calcPllValue() gives the actual possible clock.
+		* Call calcPllValue() to fill the other fields of PLL structure.
+		* Sometime, the chip cannot set up the exact clock
+		* required by the User.
+		* Return value of calcPllValue gives the actual possible clock.
 		*/
 		ulActualMxClk = calcPllValue(frequency, &pll);
 
@@ -94,8 +95,8 @@ static void setMemoryClock(unsigned int frequency)
 
 	if (frequency) {
 		/*
-		 * Set the frequency to the maximum frequency that the DDR Memory can take
-		 * which is 336MHz.
+		 * Set the frequency to the maximum frequency
+		 * that the DDR Memory can take which is 336MHz.
 		 */
 		if (frequency > MHz(336))
 			frequency = MHz(336);
@@ -305,7 +306,9 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 */
 unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 {
-	/* as sm750 register definition, N located in 2,15 and M located in 1,255	*/
+	/* as sm750 register definition,
+	 * N located in 2,15 and M located in 1,255
+	 */
 	int N, M, X, d;
 	int mini_diff;
 	unsigned int RN, quo, rem, fl_quo;
@@ -325,12 +328,16 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 	request = request_orig / 1000;
 	input = pll->inputFreq / 1000;
 
-	/* for MXCLK register , no POD provided, so need be treated differently	*/
+	/* for MXCLK register,
+	 * no POD provided, so need be treated differently
+	 */
 	if (pll->clockType = MXCLK_PLL)
 		max_d = 3;
 
 	for (N = 15; N > 1; N--) {
-		/* RN will not exceed maximum long if @request <= 285 MHZ (for 32bit cpu) */
+		/* RN will not exceed maximum long
+		 * if @request <= 285 MHZ (for 32bit cpu)
+		 */
 		RN = N * request;
 		quo = RN / input;
 		rem = RN % input;/* rem always small than 14318181 */
-- 
2.7.4

