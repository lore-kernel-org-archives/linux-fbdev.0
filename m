From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 12/17] fbdev: fix the fb_find_nearest_mode() function
Date: Tue, 18 Oct 2005 17:20:59 +0800
Message-ID: <4354BE7B.9080807@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyJ9-0000e1-L2
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:39 -0700
Received: from zproxy.gmail.com ([64.233.162.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyJ5-0002dd-FQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:39 -0700
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
Cc: linux-fbdev-devel@lists.sf.net, Michal Januszewski <spock@gentoo.org>

From: Michal Januszewski <spock@gentoo.org>

Currently the fb_find_nearest_mode() function finds a mode with
screen resolution closest to that described by the 'var' argument
and with some arbitrary refresh rate (eg. in the following sequence
of refresh rates: 70 60 53 85 75, 53 is selected).

This patch fixes the function so that it looks for the closest mode as
far as both resolution and refresh rate are concerned. The function's
first argument is changed to fb_videomode so that the refresh rate can
be specified by the caller, as fb_var_screeninfo doesn't have any fields
that could directly hold this data.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 drivers/video/console/fbcon.c |    3 ++-
 drivers/video/modedb.c        |   24 +++++++++++++-----------
 include/linux/fb.h            |    2 +-
 3 files changed, 16 insertions(+), 13 deletions(-)


diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2715,7 +2715,8 @@ static void fbcon_new_modelist(struct fb
 			continue;
 		vc = vc_cons[i].d;
 		display_to_var(&var, &fb_display[i]);
-		mode = fb_find_nearest_mode(&var, &info->modelist);
+		mode = fb_find_nearest_mode(fb_display[i].mode,
+					    &info->modelist);
 		fb_videomode_to_var(&var, mode);
 
 		if (vc)
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -676,6 +676,8 @@ void fb_var_to_videomode(struct fb_video
 	mode->sync = var->sync;
 	mode->vmode = var->vmode & FB_VMODE_MASK;
 	mode->flag = FB_MODE_IS_FROM_VAR;
+	mode->refresh = 0;
+
 	if (!var->pixclock)
 		return;
 
@@ -785,39 +787,39 @@ struct fb_videomode *fb_find_best_mode(s
 }
 
 /**
- * fb_find_nearest_mode - find mode closest video mode
+ * fb_find_nearest_mode - find closest videomode
  *
- * @var: pointer to struct fb_var_screeninfo
+ * @mode: pointer to struct fb_videomode
  * @head: pointer to modelist
  *
  * Finds best matching videomode, smaller or greater in dimension.
  * If more than 1 videomode is found, will return the videomode with
- * the closest refresh rate
+ * the closest refresh rate.
  */
-struct fb_videomode *fb_find_nearest_mode(struct fb_var_screeninfo *var,
+struct fb_videomode *fb_find_nearest_mode(struct fb_videomode *mode,
 					  struct list_head *head)
 {
 	struct list_head *pos;
 	struct fb_modelist *modelist;
-	struct fb_videomode *mode, *best = NULL;
+	struct fb_videomode *cmode, *best = NULL;
 	u32 diff = -1, diff_refresh = -1;
 
 	list_for_each(pos, head) {
 		u32 d;
 
 		modelist = list_entry(pos, struct fb_modelist, list);
-		mode = &modelist->mode;
+		cmode = &modelist->mode;
 
-		d = abs(mode->xres - var->xres) +
-			abs(mode->yres - var->yres);
+		d = abs(cmode->xres - mode->xres) +
+			abs(cmode->yres - mode->yres);
 		if (diff > d) {
 			diff = d;
-			best = mode;
+			best = cmode;
 		} else if (diff == d) {
-			d = abs(mode->refresh - best->refresh);
+			d = abs(cmode->refresh - mode->refresh);
 			if (diff_refresh > d) {
 				diff_refresh = d;
-				best = mode;
+				best = cmode;
 			}
 		}
 	}
diff --git a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -897,7 +897,7 @@ extern struct fb_videomode *fb_match_mod
 					  struct list_head *head);
 extern struct fb_videomode *fb_find_best_mode(struct fb_var_screeninfo *var,
 					      struct list_head *head);
-extern struct fb_videomode *fb_find_nearest_mode(struct fb_var_screeninfo *var,
+extern struct fb_videomode *fb_find_nearest_mode(struct fb_videomode *mode,
 						 struct list_head *head);
 extern void fb_destroy_modelist(struct list_head *head);
 extern void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
