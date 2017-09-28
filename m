From: Himanshu Jha <himanshujha199640@gmail.com>
Date: Thu, 28 Sep 2017 20:28:31 +0000
Subject: [PATCH] video: fbdev: pxa3xx_gcu: Use setup_timer and mod_timer
Message-Id: <1506629791-11695-1-git-send-email-himanshujha199640@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: gustavo@embeddedor.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>

Use setup_timer and mod_timer API instead of structure assignments.

This is done using Coccinelle and semantic patch used
for this as follows:

@@
expression x,y,z,a,b;
@@

-init_timer (&x);
+setup_timer (&x, y, z);
+mod_timer (&a, b);
-x.function = y;
-x.data = z;
-x.expires = b;
-add_timer(&a);

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 933619d..3366076 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -520,12 +520,8 @@ static void pxa3xx_gcu_debug_timedout(unsigned long ptr)
 	QERROR("Timer DUMP");
 
 	/* init the timer structure */
-	init_timer(&pxa3xx_gcu_debug_timer);
-	pxa3xx_gcu_debug_timer.function = pxa3xx_gcu_debug_timedout;
-	pxa3xx_gcu_debug_timer.data = ptr;
-	pxa3xx_gcu_debug_timer.expires = jiffies + 5*HZ; /* one second */
-
-	add_timer(&pxa3xx_gcu_debug_timer);
+	setup_timer(&pxa3xx_gcu_debug_timer, pxa3xx_gcu_debug_timedout, ptr);
+	mod_timer(&pxa3xx_gcu_debug_timer, jiffies + 5 * HZ);
 }
 
 static void pxa3xx_gcu_init_debug_timer(void)
-- 
2.7.4

