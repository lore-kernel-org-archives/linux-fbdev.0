From: Moshe Green <mgmoshes@gmail.com>
Date: Tue, 30 Aug 2016 19:05:23 +0000
Subject: [PATCH 6/9] staging: sm750fb: fix line length coding style issue in ddk750_chip.c
Message-Id: <a27547bad4e077c2a444648400a6f575e564cbb0.1472583825.git.mgmoshes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
In-Reply-To: <7011104f5ba6d400b550d2f25d16b1183efa0f35.1472583825.git.mgmoshes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix a line length warning found by the checkpatch.pl tool in
ddk750_chip.c.

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 13f8a36..5e954ea 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -308,7 +308,9 @@ int ddk750_initHw(initchip_param_t *pInitParam)
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
-- 
2.7.4

