From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Dec 2013 21:56:49 +0000
Subject: [PATCH 05/11] fbcon: queue work on power efficient wq
Message-Id: <1387317415-22252-5-git-send-email-broonie@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

fbcon uses workqueues and it has no real dependency of scheduling these on the
cpu which scheduled them.

On a idle system, it is observed that and idle cpu wakes up many times just to
service this work. It would be better if we can schedule it on a cpu which the
scheduler believes to be the most appropriate one.

This patch replaces system_wq with system_power_efficient_wq.

Cc: Dave Airlie <airlied@redhat.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit a85f1a41f020bc2c97611060bcfae6f48a1db28d)
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/video/console/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index a92783e480e6..0d8f98c79a6c 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -404,7 +404,7 @@ static void cursor_timer_handler(unsigned long dev_addr)
 	struct fb_info *info = (struct fb_info *) dev_addr;
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	schedule_work(&info->queue);
+	queue_work(system_power_efficient_wq, &info->queue);
 	mod_timer(&ops->cursor_timer, jiffies + HZ/5);
 }
 
-- 
1.8.5.1

