From: Moshe Green <mgmoshes@gmail.com>
Date: Tue, 30 Aug 2016 19:06:13 +0000
Subject: [PATCH 9/9] staging: sm750fb: fix line length coding style issue in ddk750_chip.c
Message-Id: <f200291405f5a504f6d3f5e4a7618dce94cdc3e1.1472583825.git.mgmoshes@gmail.com>
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
index 07c2537..0049e5d 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -339,7 +339,9 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
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

