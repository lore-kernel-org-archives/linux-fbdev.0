From: Allen Pais <allen.lkml@gmail.com>
Date: Thu, 21 Sep 2017 11:17:31 +0000
Subject: [PATCH 1/1] drivers:video: use setup_timer
Message-Id: <1505991931-30437-1-git-send-email-allen.lkml@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>

    Use setup_timer function instead of initializing timer with the
    function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 933619d..c474751 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -520,9 +520,7 @@ static void pxa3xx_gcu_debug_timedout(unsigned long ptr)
 	QERROR("Timer DUMP");
 
 	/* init the timer structure */
-	init_timer(&pxa3xx_gcu_debug_timer);
-	pxa3xx_gcu_debug_timer.function = pxa3xx_gcu_debug_timedout;
-	pxa3xx_gcu_debug_timer.data = ptr;
+	setup_timer(&pxa3xx_gcu_debug_timer, pxa3xx_gcu_debug_timeout, ptr);
 	pxa3xx_gcu_debug_timer.expires = jiffies + 5*HZ; /* one second */
 
 	add_timer(&pxa3xx_gcu_debug_timer);
-- 
2.7.4

