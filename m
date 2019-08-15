From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Aug 2019 12:30:09 +0000
Subject: [PATCH] staging: sm750fb: fix odd license text
Message-Id: <20190815123009.16499-1-gregkh@linuxfoundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

There is some "confusing" license text in some of the sm750fb driver
files.  After discussing it with the company, it turns out to have been
a mistake and these lines can be safely removed.  The files are all to
be licensed under the GPLv2 license.

Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: linux-fbdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/sm750fb/ddk750.h       | 3 ---
 drivers/staging/sm750fb/ddk750_swi2c.c | 3 ---
 drivers/staging/sm750fb/ddk750_swi2c.h | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750.h b/drivers/staging/sm750fb/ddk750.h
index 482c1c6ba422..64ef4d258a91 100644
--- a/drivers/staging/sm750fb/ddk750.h
+++ b/drivers/staging/sm750fb/ddk750.h
@@ -2,9 +2,6 @@
 /*
  *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
  *
- *  All rights are reserved. Reproduction or in part is prohibited
- *  without the written consent of the copyright owner.
- *
  *  RegSC.h --- SM718 SDK
  *  This file contains the definitions for the System Configuration registers.
  */
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 5c0ac747ea2b..0ef8d4ff2ef9 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -2,9 +2,6 @@
 /*
  *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
  *
- *  All rights are reserved. Reproduction or in part is prohibited
- *  without the written consent of the copyright owner.
- *
  *  swi2c.c --- SM750/SM718 DDK
  *  This file contains the source code for I2C using software
  *  implementation.
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.h b/drivers/staging/sm750fb/ddk750_swi2c.h
index 5868feea791b..dfa166060da7 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.h
+++ b/drivers/staging/sm750fb/ddk750_swi2c.h
@@ -2,9 +2,6 @@
 /*
  *         Copyright (c) 2007 by Silicon Motion, Inc. (SMI)
  *
- *  All rights are reserved. Reproduction or in part is prohibited
- *  without the written consent of the copyright owner.
- *
  *  swi2c.h --- SM750/SM718 DDK
  *  This file contains the definitions for i2c using software
  *  implementation.
-- 
2.22.1
