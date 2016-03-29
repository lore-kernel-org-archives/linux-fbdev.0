From: Colin King <colin.king@canonical.com>
Date: Tue, 29 Mar 2016 16:53:23 +0000
Subject: [PATCH] staging: sm750fb: initialize max_d to maximum D value of 6
Message-Id: <1459270403-15811-1-git-send-email-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

max_d is not initialized and should be set to the largest D
value of 6.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 95f7cae..f80ee77 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -306,7 +306,7 @@ unsigned int calcPllValue(unsigned int request_orig, pll_value_t *pll)
 	unsigned int input, request;
 	unsigned int tmpClock, ret;
 	const int max_OD = 3;
-	int max_d;
+	int max_d = 6;
 
 	if (getChipType() = SM750LE) {
 		/* SM750LE don't have prgrammable PLL and M/N values to work on.
-- 
2.7.4

