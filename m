From: Moshe Green <mgmoshes@gmail.com>
Date: Tue, 30 Aug 2016 19:05:54 +0000
Subject: [PATCH 8/9] staging: sm750fb: fix line length coding style issue in ddk750_chip.c
Message-Id: <cdb7841ba8c67579ed8256fb8d71e2e1a07eab01.1472583825.git.mgmoshes@gmail.com>
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
index c59fe22..07c2537 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -332,7 +332,9 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 	request = request_orig / 1000;
 	input = pll->inputFreq / 1000;
 
-	/* for MXCLK register , no POD provided, so need be treated differently	*/
+	/* for MXCLK register,
+	 * no POD provided, so need be treated differently.
+	 */
 	if (pll->clockType = MXCLK_PLL)
 		max_d = 3;
 
-- 
2.7.4

