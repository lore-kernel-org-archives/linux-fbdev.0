From: Moshe Green <mgmoshes@gmail.com>
Date: Mon, 06 Jun 2016 19:04:32 +0000
Subject: [PATCH] Staging: sm750fb: fix block comment coding style issue in ddk750_chip.c
Message-Id: <20160606190432.GA5308@moshe-Lenovo-Yoga-2-Pro>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This is a patch to the ddk750_chip.c file that fixes up two block
comment coding style warnings found by the checkpatch.pl tool

Signed-off-by: Moshe Green <mgmoshes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f80ee77..3d408d6 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -91,8 +91,10 @@ static void setMemoryClock(unsigned int frequency)
 		return;
 
 	if (frequency) {
-		/* Set the frequency to the maximum frequency that the DDR Memory can take
-		which is 336MHz. */
+		/*
+		 * Set the frequency to the maximum frequency that the DDR Memory can take
+		 * which is 336MHz.
+		 */
 		if (frequency > MHz(336))
 			frequency = MHz(336);
 
-- 
2.7.4

