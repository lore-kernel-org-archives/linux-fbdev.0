From: Moshe Green <mgmoshes@gmail.com>
Date: Sun, 05 Jun 2016 19:09:24 +0000
Subject: [PATCH] Staging: sm750fb: fix line length coding style issue in ddk750_chip.c
Message-Id: <20160605190924.GA7845@moshe-Lenovo-Yoga-2-Pro>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This is a patch to the ddk750_chip.c file that fixes up a line length
warning found by the checkpatch.pl tool

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f80ee77..9780659 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -86,7 +86,9 @@ static void setMemoryClock(unsigned int frequency)
 {
 	unsigned int reg, divisor;
 
-	/* Cheok_0509: For SM750LE, the memory clock is fixed. Nothing to set. */
+	/* Cheok_0509: For SM750LE, the memory clock is fixed.
+	 * Nothing to set.
+	 */
 	if (getChipType() = SM750LE)
 		return;
 
-- 
2.7.4

