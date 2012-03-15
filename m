From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 15 Mar 2012 09:14:49 +0000
Subject: [PATCH] fbdev: bfin_adv7393fb: Drop needless include
Message-Id: <20120315101449.65566857@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Kernel drivers don't need <linux/i2c-dev.h>.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/bfin_adv7393fb.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-3.3-rc7.orig/drivers/video/bfin_adv7393fb.c	2012-01-06 11:21:14.000000000 +0100
+++ linux-3.3-rc7/drivers/video/bfin_adv7393fb.c	2012-03-15 10:09:32.345820005 +0100
@@ -36,9 +36,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/proc_fs.h>
 #include <linux/platform_device.h>
-
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #include "bfin_adv7393fb.h"
 


-- 
Jean Delvare
