From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 20 Dec 2010 21:50:11 +0000
Subject: [PATCH 02/13] sisfb: delete HAVE_CONFIG_H checks
Message-Id: <1292881822-32630-3-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1292881822-32630-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1292881822-32630-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, thomas@winischhofer.net
Cc: aaro.koskinen@iki.fi

Delete unneeded HAVE_CONFIG_H checks.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
---
 drivers/video/sis/init.c    |    4 ----
 drivers/video/sis/init301.c |    4 ----
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/video/sis/init.c b/drivers/video/sis/init.c
index 31137ad..5f49db1 100644
--- a/drivers/video/sis/init.c
+++ b/drivers/video/sis/init.c
@@ -56,10 +56,6 @@
  * Used by permission.
  */
 
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#endif
-
 #include "init.h"
 
 #ifdef CONFIG_FB_SIS_300
diff --git a/drivers/video/sis/init301.c b/drivers/video/sis/init301.c
index 9fa66fd..e24c5ca 100644
--- a/drivers/video/sis/init301.c
+++ b/drivers/video/sis/init301.c
@@ -57,10 +57,6 @@
  *
  */
 
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#endif
-
 #if 1
 #define SET_EMI		/* 302LV/ELV: Set EMI values */
 #endif
-- 
1.5.6.5

