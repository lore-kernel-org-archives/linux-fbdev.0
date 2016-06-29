From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 29 Jun 2016 08:19:12 +0000
Subject: [RFC PATCH kernel] Revert "fbcon: use the cursor blink interval provided by vt"
Message-Id: <1467188352-5580-1-git-send-email-aik@ozlabs.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


This is rather a bugreport than actual revert but nevertheless.

Since 27a4c827c34a I started noticing weird traces and quite often
I could not boot my test machine which is POWER8 box with AST video
or ATI video (video adapter type does not matter much although
is happens lot more often with the OpenPOWER machine which got AST).
The system console is IPMI, not the actual video adapter.

I bisected it to this:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id'a4c827c34ac4256a190cc9d24607f953c1c459

For some reason which I do not understand, in cursor_timer_handler(),
ops->cur_blink_jiffies is zero. Why can this happen? What is a proper
fix? Thanks.


---
 drivers/video/console/fbcon.c | 12 ++++++------
 drivers/video/console/fbcon.h |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index afd3301..7e5b425 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -402,7 +402,7 @@ static void cursor_timer_handler(unsigned long dev_addr)
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	queue_work(system_power_efficient_wq, &info->queue);
-	mod_timer(&ops->cursor_timer, jiffies + ops->cur_blink_jiffies);
+	mod_timer(&ops->cursor_timer, jiffies + HZ/5);
 }
 
 static void fbcon_add_cursor_timer(struct fb_info *info)
@@ -417,7 +417,7 @@ static void fbcon_add_cursor_timer(struct fb_info *info)
 
 		init_timer(&ops->cursor_timer);
 		ops->cursor_timer.function = cursor_timer_handler;
-		ops->cursor_timer.expires = jiffies + ops->cur_blink_jiffies;
+		ops->cursor_timer.expires = jiffies + HZ / 5;
 		ops->cursor_timer.data = (unsigned long ) info;
 		add_timer(&ops->cursor_timer);
 		ops->flags |= FBCON_FLAGS_CURSOR_TIMER;
@@ -709,7 +709,7 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
 	}
 
 	if (!err) {
-		ops->cur_blink_jiffies = HZ / 5;
+//		ops->cur_blink_jiffies = HZ / 5;
 		info->fbcon_par = ops;
 
 		if (vc)
@@ -957,7 +957,7 @@ static const char *fbcon_startup(void)
 	ops->currcon = -1;
 	ops->graphics = 1;
 	ops->cur_rotate = -1;
-	ops->cur_blink_jiffies = HZ / 5;
+//	ops->cur_blink_jiffies = HZ / 5;
 	info->fbcon_par = ops;
 	p->con_rotate = initial_rotation;
 	set_blitting_type(vc, info);
@@ -1095,7 +1095,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 		con_copy_unimap(vc, svc);
 
 	ops = info->fbcon_par;
-	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
+//	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
 	p->con_rotate = initial_rotation;
 	set_blitting_type(vc, info);
 
@@ -1309,7 +1309,7 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 	int y;
  	int c = scr_readw((u16 *) vc->vc_pos);
 
-	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
+//	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
 
 	if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
 		return;
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index 7aaa4ea..6bd2e0c 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -70,7 +70,6 @@ struct fbcon_ops {
 	struct fb_cursor cursor_state;
 	struct display *p;
         int    currcon;	                /* Current VC. */
-	int    cur_blink_jiffies;
 	int    cursor_flash;
 	int    cursor_reset;
 	int    blank_state;
-- 
2.5.0.rc3

