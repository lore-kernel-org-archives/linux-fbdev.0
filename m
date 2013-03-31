From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Sun, 31 Mar 2013 14:39:05 +0000
Subject: [PATCH V4 4/4] fbcon: queue work on unbound wq
Message-Id: <2a30b6c081a7899fbce88bddf20b94c348eb4654.1364739015.git.viresh.kumar@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

fbcon uses workqueues and it has no real dependency of scheduling these on the
cpu which scheduled them.

On a idle system, it is observed that and idle cpu wakes up many times just to
service this work. It would be better if we can schedule it on a cpu which the
scheduler believes to be the most appropriate one.

This patch replaces system_wq with system_unbound_wq.

Cc: Dave Airlie <airlied@redhat.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/video/console/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 3cd6759..6c1f7c3 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -404,7 +404,7 @@ static void cursor_timer_handler(unsigned long dev_addr)
 	struct fb_info *info = (struct fb_info *) dev_addr;
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	schedule_work(&info->queue);
+	queue_work(system_unbound_wq, &info->queue);
 	mod_timer(&ops->cursor_timer, jiffies + HZ/5);
 }
 
-- 
1.7.12.rc2.18.g61b472e

