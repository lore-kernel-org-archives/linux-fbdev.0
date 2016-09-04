From: Moshe Green <mgmoshes@gmail.com>
Date: Sun, 04 Sep 2016 18:04:10 +0000
Subject: [PATCH 2/2] staging: sm750fb: fix block comment style and spelling issues in ddk750_chip.c
Message-Id: <c90da1d298fa859130d1c6cab39d0034b09fe4d8.1472932508.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <523e16874da50855062fcc51b6754e2b9c42b9e5.1472932508.git.mgmoshes@gmail.com>
In-Reply-To: <523e16874da50855062fcc51b6754e2b9c42b9e5.1472932508.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix the following warning types:
 - line length
 - block comment line * prefix
 - trailing */ on a separate line
found by the checkpatch.pl tool in multiple block comments.

Fix a single spelling error in a comment.

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 49 +++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 76aaeaa..09fda26 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -144,8 +144,9 @@ static void setMasterClock(unsigned int frequency)
 		return;
 
 	if (frequency) {
-		/* Set the frequency to the maximum frequency that the SM750 engine can
-		run, which is about 190 MHz. */
+		/* Set the frequency to the maximum frequency
+		 * that the SM750 engine can run, which is about 190 MHz.
+		 */
 		if (frequency > MHz(190))
 			frequency = MHz(190);
 
@@ -242,9 +243,10 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 	setMasterClock(MHz(pInitParam->masterClock));
 
 
-	/* Reset the memory controller. If the memory controller is not reset in SM750,
-	   the system might hang when sw accesses the memory.
-	   The memory should be resetted after changing the MXCLK.
+	/* Reset the memory controller.
+	 * If the memory controller is not reset in SM750,
+	 * the system might hang when sw accesses the memory.
+	 * The memory should be resetted after changing the MXCLK.
 	 */
 	if (pInitParam->resetMemory = 1) {
 		reg = PEEK32(MISC_CTRL);
@@ -288,21 +290,22 @@ int ddk750_initHw(initchip_param_t *pInitParam)
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
+ *	re-write the calculatePLL function of ddk750.
+ *	the original version function does not use
+ *	some mathematics tricks and shortcut
+ *	when it doing the calculation of the best N,M,D combination
+ *	I think this version gives a little upgrade in speed
+ *
+ * 750 pll clock formular:
+ * Request Clock = (Input Clock * M )/(N * X)
+ *
+ * Input Clock = 14318181 hz
+ * X = 2 power D
+ * D ={0,1,2,3,4,5,6}
+ * M = {1,...,255}
+ * N = {2,...,15}
+ */
 unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 {
 	/* as sm750 register definition,
@@ -317,8 +320,10 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 	int max_d = 6;
 
 	if (getChipType() = SM750LE) {
-		/* SM750LE don't have prgrammable PLL and M/N values to work on.
-		Just return the requested clock. */
+		/* SM750LE don't have
+		 * programmable PLL and M/N values to work on.
+		 * Just return the requested clock.
+		 */
 		return request_orig;
 	}
 
-- 
2.7.4

