From: Moshe Green <mgmoshes@gmail.com>
Date: Tue, 30 Aug 2016 19:05:10 +0000
Subject: [PATCH 5/9] staging: sm750fb: fix coding style issues in ddk750_chip.c
Message-Id: <f9296a079b378bee64233959ca231e633ebc4205.1472583825.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
In-Reply-To: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix line length and block comment * prefix warnings found
by the checkpatch.pl tool in ddk750_chip.c.

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f15800a..13f8a36 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -290,21 +290,22 @@ int ddk750_initHw(initchip_param_t *pInitParam)
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
+ *	some mathematics tricks and shortcut when it doing
+ *	the calculation of the best N,M,D combination
+ *	I think this version gives a little upgrade in speed
+ *
+ *  750 pll clock formular:
+ *  Request Clock = (Input Clock * M )/(N * X)
+ *
+ * Input Clock = 14318181 hz
+ * X = 2 power D
+ * D ={0,1,2,3,4,5,6}
+ * M = {1,...,255}
+ * N = {2,...,15}
+ */
 unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 {
 	/* as sm750 register definition, N located in 2,15 and M located in 1,255	*/
-- 
2.7.4

