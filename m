From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 27 May 2015 12:42:27 +0000
Subject: [PATCH] fbcon: Fix incorrect fbcon_del_cursor_timer calls.
Message-Id: <201505272142.JGF00513.VJHOOLMOFSQFtF@I-love.SAKURA.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From f4976c5f9638633eb31a1c6dbe78861abf5c79c1 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 27 May 2015 21:36:38 +0900
Subject: [PATCH] fbcon: Fix incorrect fbcon_del_cursor_timer calls.

Commit 27a4c827c34a ("fbcon: use the cursor blink interval provided by vt")
by error changed to unconditionally call fbcon_del_cursor_timer() at
fbcon_cursor(). As a result, SysRq from keyboard started to hit

  WARN_ON(in_irq() && !tbase_get_irqsafe(timer->base));

at del_timer_sync(), making the system unusable due to message flooding.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/video/console/fbcon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 05b1d1a..658c34b 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1310,8 +1310,9 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 		return;
 
 	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
-	fbcon_del_cursor_timer(info);
-	if (!(vc->vc_cursor_type & 0x10))
+	if (vc->vc_cursor_type & 0x10)
+		fbcon_del_cursor_timer(info);
+	else
 		fbcon_add_cursor_timer(info);
 
 	ops->cursor_flash = (mode = CM_ERASE) ? 0 : 1;
-- 
1.8.3.1
