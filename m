From: Hauke Mehrtens <hauke@hauke-m.de>
Date: Thu, 21 Mar 2013 14:38:35 +0000
Subject: [PATCH for 3.8+] drivers/video/ep93xx-fb.c: fix missing declaration of devm_ioremap()
Message-Id: <1363876715-22039-1-git-send-email-hauke@hauke-m.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This fixes the following compile error:
drivers/video/ep93xx-fb.c: In function 'ep93xxfb_probe':
drivers/video/ep93xx-fb.c:532:2: error: implicit declaration of function 'devm_ioremap' [-Werror=implicit-function-declaration]
drivers/video/ep93xx-fb.c:532:17: warning: assignment makes pointer from integer without a cast [enabled by default]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: stable@vger.kernel.org
---

This patch should go into kernel 3.8, 3.9 and 3.10.

 drivers/video/ep93xx-fb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/ep93xx-fb.c b/drivers/video/ep93xx-fb.c
index 3f2519d..e06cd5d 100644
--- a/drivers/video/ep93xx-fb.c
+++ b/drivers/video/ep93xx-fb.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/fb.h>
+#include <linux/io.h>
 
 #include <linux/platform_data/video-ep93xx.h>
 
-- 
1.7.10.4

