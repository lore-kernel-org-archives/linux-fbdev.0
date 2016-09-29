From: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
Date: Thu, 29 Sep 2016 10:26:31 +0000
Subject: [PATCH] Staging: sm750fb: Fix block comments
Message-Id: <64eb1190cc20615f22594b1f16a75737f42cfdf2.1475144602.git.roliveir@synopsys.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160606190432.GA5308@moshe-Lenovo-Yoga-2-Pro>
In-Reply-To: <20160606190432.GA5308@moshe-Lenovo-Yoga-2-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>

Correct the styling of some block comments as reported by checkpatch.

Signed-off-by: Ramiro Oliveira <roliveir@synopsys.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 6c1ffa1..011c1bd 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -1,15 +1,15 @@
 /*******************************************************************
-*
-*         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
-*
-*  All rights are reserved. Reproduction or in part is prohibited
-*  without the written consent of the copyright owner.
-*
-*  swi2c.c --- SM750/SM718 DDK
-*  This file contains the source code for I2C using software
-*  implementation.
-*
-*******************************************************************/
+ *
+ *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
+ *
+ *  All rights are reserved. Reproduction or in part is prohibited
+ *  without the written consent of the copyright owner.
+ *
+ *  swi2c.c --- SM750/SM718 DDK
+ *  This file contains the source code for I2C using software
+ *  implementation.
+ *
+ *******************************************************************/
 #include "ddk750_help.h"
 #include "ddk750_reg.h"
 #include "ddk750_swi2c.h"
@@ -89,12 +89,12 @@ static void sw_i2c_wait(void)
 	 * always be non-zero,which makes the while loop
 	 * never finish.
 	 * use non-ultimate for loop below is safe
-	 * */
+	 */
 
-    /* Change wait algorithm to use PCI bus clock,
-       it's more reliable than counter loop ..
-       write 0x61 to 0x3ce and read from 0x3cf
-       */
+	/* Change wait algorithm to use PCI bus clock,
+	 * it's more reliable than counter loop ..
+	 * write 0x61 to 0x3ce and read from 0x3cf
+	 */
 	int i, tmp;
 
 	for (i = 0; i < 600; i++) {
@@ -501,8 +501,8 @@ long sm750_sw_i2c_write_reg(
 	sw_i2c_start();
 
 	/* Send the device address and read the data. All should return success
-	   in order for the writing processed to be successful
-	*/
+	 * in order for the writing processed to be successful
+	 */
 	if ((sw_i2c_write_byte(addr) != 0) ||
 	    (sw_i2c_write_byte(reg) != 0) ||
 	    (sw_i2c_write_byte(data) != 0)) {
-- 
2.9.3


