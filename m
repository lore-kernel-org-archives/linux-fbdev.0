From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 19 Apr 2012 02:43:21 +0000
Subject: [PATCH] blackfin: fix compile error in bfin-lq035q1-fb.c
Message-Id: <1334803401-26780-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This file has an implicit dependency on GPIO stuff, showing
up as the following build failure:

drivers/video/bfin-lq035q1-fb.c:369:6: error: 'GPIOF_OUT_INIT_LOW' undeclared

Other more global bfin build issues prevent an automated bisect, but
it really doesn't matter - simply add in the appropriate header.

Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
index 86922ac..353c02f 100644
--- a/drivers/video/bfin-lq035q1-fb.c
+++ b/drivers/video/bfin-lq035q1-fb.c
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/types.h>
-- 
1.7.9.1

