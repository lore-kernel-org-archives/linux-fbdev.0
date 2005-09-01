From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/10] fbcon: Stop cursor timer if console is inactive
Date: Fri, 02 Sep 2005 05:52:03 +0800
Message-ID: <43177803.5040509@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAx35-0004nM-CV
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:43 -0700
Received: from wproxy.gmail.com ([64.233.184.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAx35-0003zW-5m
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:43 -0700
Received: by wproxy.gmail.com with SMTP id i3so393130wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Sep 2005 14:56:37 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

    If console is blanked or in KD_GRAPHICS mode, delete cursor timer.  No
    sense flashing the cursor when there's nothing to be seen.

    Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 fbcon.c |   92 ++++++++++++++++++++++++++++++++++------------------------------
 fbcon.h |    3 +-
 2 files changed, 52 insertions(+), 43 deletions(-)


diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -331,6 +331,35 @@ static void cursor_timer_handler(unsigne
 	mod_timer(&ops->cursor_timer, jiffies + HZ/5);
 }
 
+static void fbcon_add_cursor_timer(struct fb_info *info)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+
+	if ((!info->queue.func || info->queue.func == fb_flashcursor) &&
+	    !(ops->flags & FBCON_FLAGS_CURSOR_TIMER)) {
+		if (!info->queue.func)
+			INIT_WORK(&info->queue, fb_flashcursor, info);
+
+		init_timer(&ops->cursor_timer);
+		ops->cursor_timer.function = cursor_timer_handler;
+		ops->cursor_timer.expires = jiffies + HZ / 5;
+		ops->cursor_timer.data = (unsigned long ) info;
+		add_timer(&ops->cursor_timer);
+		ops->flags |= FBCON_FLAGS_CURSOR_TIMER;
+	}
+}
+	
+static void fbcon_del_cursor_timer(struct fb_info *info)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+
+	if (info->queue.func == fb_flashcursor &&
+	    ops->flags & FBCON_FLAGS_CURSOR_TIMER) {
+		del_timer_sync(&ops->cursor_timer);
+		ops->flags &= ~FBCON_FLAGS_CURSOR_TIMER;
+	}
+}
+	
 #ifndef MODULE
 static int __init fb_console_setup(char *this_opt)
 {
@@ -583,9 +612,7 @@ static int con2fb_release_oldinfo(struct
 	}
 
 	if (!err) {
-		if (oldinfo->queue.func == fb_flashcursor)
-			del_timer_sync(&ops->cursor_timer);
-
+		fbcon_del_cursor_timer(oldinfo);
 		kfree(ops->cursor_state.mask);
 		kfree(ops->cursor_data);
 		kfree(oldinfo->fbcon_par);
@@ -596,22 +623,6 @@ static int con2fb_release_oldinfo(struct
 	return err;
 }
 
-static void con2fb_init_newinfo(struct fb_info *info)
-{
-	if (!info->queue.func || info->queue.func == fb_flashcursor) {
-		struct fbcon_ops *ops = info->fbcon_par;
-
-		if (!info->queue.func)
-			INIT_WORK(&info->queue, fb_flashcursor, info);
-
-		init_timer(&ops->cursor_timer);
-		ops->cursor_timer.function = cursor_timer_handler;
-		ops->cursor_timer.expires = jiffies + HZ / 5;
-		ops->cursor_timer.data = (unsigned long ) info;
-		add_timer(&ops->cursor_timer);
-	}
-}
-
 static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
 				int unit, int show_logo)
 {
@@ -695,7 +706,7 @@ static int set_con2fb_map(int unit, int 
  				 logo_shown != FBCON_LOGO_DONTSHOW);
 
  		if (!found)
- 			con2fb_init_newinfo(info);
+ 			fbcon_add_cursor_timer(info);
  		con2fb_map_boot[unit] = newidx;
  		con2fb_init_display(vc, info, unit, show_logo);
 	}
@@ -898,18 +909,7 @@ static const char *fbcon_startup(void)
 	}
 #endif				/* CONFIG_MAC */
 
-	/* Initialize the work queue. If the driver provides its
-	 * own work queue this means it will use something besides 
-	 * default timer to flash the cursor. */
-	if (!info->queue.func) {
-		INIT_WORK(&info->queue, fb_flashcursor, info);
-
-		init_timer(&ops->cursor_timer);
-		ops->cursor_timer.function = cursor_timer_handler;
-		ops->cursor_timer.expires = jiffies + HZ / 5;
-		ops->cursor_timer.data = (unsigned long ) info;
-		add_timer(&ops->cursor_timer);
-	}
+	fbcon_add_cursor_timer(info);
 	return display_desc;
 }
 
@@ -1923,7 +1923,7 @@ static int fbcon_resize(struct vc_data *
 
 static int fbcon_switch(struct vc_data *vc)
 {
-	struct fb_info *info;
+	struct fb_info *info, *old_info = NULL;
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
 	int i, prev_console;
@@ -1956,7 +1956,8 @@ static int fbcon_switch(struct vc_data *
 	}
 
 	prev_console = ((struct fbcon_ops *)info->fbcon_par)->currcon;
-
+	if (prev_console != -1)
+		old_info = registered_fb[con2fb_map[prev_console]];
 	/*
 	 * FIXME: If we have multiple fbdev's loaded, we need to
 	 * update all info->currcon.  Perhaps, we can place this
@@ -1984,10 +1985,12 @@ static int fbcon_switch(struct vc_data *
 	info->var.yoffset = info->var.xoffset = p->yscroll = 0;
 	fb_set_var(info, &var);
 
-	if (prev_console != -1 &&
-	    registered_fb[con2fb_map[prev_console]] != info &&
-	    info->fbops->fb_set_par)
-		info->fbops->fb_set_par(info);
+	if (old_info != NULL && old_info != info) {
+		if (info->fbops->fb_set_par)
+			info->fbops->fb_set_par(info);
+		fbcon_del_cursor_timer(old_info);
+		fbcon_add_cursor_timer(info);
+	}
 
 	set_blitting_type(vc, info, p);
 	((struct fbcon_ops *)info->fbcon_par)->cursor_reset = 1;
@@ -2073,11 +2076,16 @@ static int fbcon_blank(struct vc_data *v
 				fbcon_generic_blank(vc, info, blank);
 		}
 
- 		if (!blank)
- 			update_screen(vc);
- 	}
+		if (!blank)
+			update_screen(vc);
+	}
+
+	if (!blank)
+		fbcon_add_cursor_timer(info);
+	else
+		fbcon_del_cursor_timer(info);
 
- 	return 0;
+	return 0;
 }
 
 static void fbcon_free_font(struct display *p)
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -18,7 +18,8 @@
 
 #include <asm/io.h>
 
-#define FBCON_FLAGS_INIT 1
+#define FBCON_FLAGS_INIT         1
+#define FBCON_FLAGS_CURSOR_TIMER 2
 
    /*
     *    This is the interface between the low-level console driver and the




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
