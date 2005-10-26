From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/4] fbdev: Add helper to get an appropriate initial mode
Date: Wed, 26 Oct 2005 19:55:36 +0800
Message-ID: <435F6EB8.7050501@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUk2X-0001r4-Dn
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 05:05:57 -0700
Received: from zproxy.gmail.com ([64.233.162.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EUk2W-00084U-R0
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Oct 2005 05:05:57 -0700
Received: by zproxy.gmail.com with SMTP id 14so104212nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Oct 2005 05:05:55 -0700 (PDT)
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

Add new helper, fb_find_best_display(), which will search the modelist for
the best mode for the attached display.  This requires an EDID block that
is converted to struct fb_monspecs and a private modelist. The search will
be done in this manner:

- if 1st detailed timing is preferred, use that
- else if dimensions of the display are known, use that to estimate xres and
- else if modelist has detailed timings, use the first detailed timing
- else, use the very first entry from the modelist

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 drivers/video/modedb.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h     |    2 +
 2 files changed, 62 insertions(+)


diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index aadef04..1789a52 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -944,6 +944,66 @@ void fb_videomode_to_modelist(struct fb_
 	}
 }
 
+struct fb_videomode *fb_find_best_display(struct fb_monspecs *specs,
+					  struct list_head *head)
+{
+	struct list_head *pos;
+	struct fb_modelist *modelist;
+	struct fb_videomode *m, *m1 = NULL, *md = NULL, *best = NULL;
+	int first = 0;
+
+	if (!head->prev || !head->next || list_empty(head))
+		goto finished;
+
+	/* get the first detailed mode and the very first mode */
+	list_for_each(pos, head) {
+		modelist = list_entry(pos, struct fb_modelist, list);
+		m = &modelist->mode;
+
+		if (!first) {
+			m1 = m;
+			first = 1;
+		}
+
+		if (m->flag & FB_MODE_IS_FIRST) {
+ 			md = m;
+			break;
+		}
+	}
+
+	/* first detailed timing is preferred */
+	if (specs->misc & FB_MISC_1ST_DETAIL) {
+		best = md;
+		goto finished;
+	}
+
+	/* find best mode based on display width and height */
+	if (specs->max_x && specs->max_y) {
+		struct fb_var_screeninfo var;
+
+		memset(&var, 0, sizeof(struct fb_var_screeninfo));
+		var.xres = (specs->max_x * 7200)/254;
+		var.yres = (specs->max_y * 7200)/254;
+		m = fb_find_best_mode(&var, head);
+		if (m) {
+			best = m;
+			goto finished;
+		}
+	}
+
+	/* use first detailed mode */
+	if (md) {
+		best = md;
+		goto finished;
+	}
+
+	/* last resort, use the very first mode */
+	best = m1;
+finished:
+	return best;
+}
+EXPORT_SYMBOL(fb_find_best_display);
+
 EXPORT_SYMBOL(fb_videomode_to_var);
 EXPORT_SYMBOL(fb_var_to_videomode);
 EXPORT_SYMBOL(fb_mode_is_equal);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 68a7879..e7ff98e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -902,6 +902,8 @@ extern struct fb_videomode *fb_find_near
 extern void fb_destroy_modelist(struct list_head *head);
 extern void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,
 				     struct list_head *head);
+extern struct fb_videomode *fb_find_best_display(struct fb_monspecs *specs,
+						 struct list_head *head);
 
 /* drivers/video/fbcmap.c */
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
