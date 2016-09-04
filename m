From: Moshe Green <mgmoshes@gmail.com>
Date: Sun, 04 Sep 2016 18:03:27 +0000
Subject: [PATCH 1/2] staging: sm750fb: fix line length coding style issues in ddk750_chip.c
Message-Id: <523e16874da50855062fcc51b6754e2b9c42b9e5.1472932508.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix multiple line length warnings found by the checkpatch.pl tool
in ddk750_chip.c.

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index c1356bb..76aaeaa 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -71,7 +71,7 @@ static void setChipClock(unsigned int frequency)
 		pll.clockType = MXCLK_PLL;
 
 		/*
-		* Call calcPllValue() to fill up the other fields for PLL structure.
+		* Call calcPllValue() to fill the other fields of PLL structure.
 		* Sometime, the chip cannot set up the exact clock required by User.
 		* Return value from calcPllValue() gives the actual possible clock.
 		*/
@@ -94,8 +94,8 @@ static void setMemoryClock(unsigned int frequency)
 
 	if (frequency) {
 		/*
-		 * Set the frequency to the maximum frequency that the DDR Memory can take
-		 * which is 336MHz.
+		 * Set the frequency to the maximum frequency
+		 * that the DDR Memory can take which is 336MHz.
 		 */
 		if (frequency > MHz(336))
 			frequency = MHz(336);
@@ -305,7 +305,9 @@ int ddk750_initHw(initchip_param_t *pInitParam)
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
@@ -325,12 +327,16 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
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

