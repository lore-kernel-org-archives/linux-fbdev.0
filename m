From: Qiang Chen <qiang2.chen@sonymobile.com>
Date: Mon, 17 Nov 2014 09:25:01 +0000
Subject: [PATCH] video: ARM CLCD: Remove duplicated include in amba-clcd.c
Message-Id: <1416216301-15854-1-git-send-email-qiang2.chen@sonymobile.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, linux@arm.linux.org.uk, pawel.moll@arm.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, qcwj.lk@gmail.com

This patch fixes duplicated include dma-mapping.h in
drivers/video/fbdev/amba-clcd.c

Signed-off-by: Qiang Chen <qiang2.chen@sonymobile.com>
---
 drivers/video/fbdev/amba-clcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 6ad23bd..32c0b6b 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -27,7 +27,6 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/hardirq.h>
-#include <linux/dma-mapping.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
-- 
1.8.2.2

