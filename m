From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/5] Video Mode Handling - Linked list of video modes
Date: Mon, 9 Aug 2004 09:44:52 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408090944.52495.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BtzI8-0001VP-EB
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:36 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BtzI7-0003tA-Ld
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:36 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9E56077683B
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Aug 2004 00:56:10 +0000 (UTC)
Content-Disposition: inline
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

Hi,

The patch adds support for a mode database in a linked list form.

Included in the patch are exportable functions that will:

a. convert struct fb_videomode to struct fb_var_screeninfo and vice versa
b. search the mode list for matching or best-fit modes
c. add/delete entries to the database
d. convert a mode array to a mode list
e. destroy the entire list
d. compare 2 modes

The diff is against 2.6.8-rc3-mm1 but should apply cleanly to 2.6.8-rc3-mm2
as well.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/modedb.c |  256 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h     |   23 ++++
 2 files changed, 279 insertions(+)

diff -uprN linux-2.6.8-rc3-mm1-orig/drivers/video/modedb.c linux-2.6.8-rc3-mm1/drivers/video/modedb.c
--- linux-2.6.8-rc3-mm1-orig/drivers/video/modedb.c	2004-08-08 21:04:23.215931464 +0800
+++ linux-2.6.8-rc3-mm1/drivers/video/modedb.c	2004-08-08 21:15:28.785749472 +0800
@@ -570,5 +570,261 @@ done:
     return 0;
 }
 
+/**
+ * fb_var_to_videomode - convert fb_var_screeninfo to fb_videomode
+ * @mode: pointer to struct fb_videomode
+ * @var: pointer to struct fb_var_screeninfo
+ */
+void fb_var_to_videomode(struct fb_videomode *mode,
+			 struct fb_var_screeninfo *var)
+{
+	u32 pixclock, hfreq, htotal, vtotal;
+
+	(char *) mode->name = NULL;
+	mode->xres = var->xres;
+	mode->yres = var->yres;
+	mode->pixclock = var->pixclock;
+	mode->hsync_len = var->hsync_len;
+	mode->vsync_len = var->vsync_len;
+	mode->left_margin = var->left_margin;
+	mode->right_margin = var->right_margin;
+	mode->upper_margin = var->upper_margin;
+	mode->lower_margin = var->lower_margin;
+	mode->sync = var->sync;
+	mode->vmode = var->vmode & FB_VMODE_MASK;
+	mode->flag = FB_MODE_IS_FROM_VAR;
+	if (!var->pixclock)
+		return;
+
+	pixclock = PICOS2KHZ(var->pixclock) * 1000;
+	   
+	htotal = var->xres + var->right_margin + var->hsync_len + 
+		var->left_margin;
+	vtotal = var->yres + var->lower_margin + var->vsync_len + 
+		var->upper_margin;
+
+	if (var->vmode & FB_VMODE_INTERLACED)
+		vtotal /= 2;
+	if (var->vmode & FB_VMODE_DOUBLE)
+		vtotal *= 2;
+
+	hfreq = pixclock/htotal;
+	mode->refresh = hfreq/vtotal;
+}
+
+/**
+ * fb_videomode_to_var - convert fb_videomode to fb_var_screeninfo
+ * @var: pointer to struct fb_var_screeninfo
+ * @mode: pointer to struct fb_videomode
+ */
+void fb_videomode_to_var(struct fb_var_screeninfo *var,
+			       struct fb_videomode *mode)
+{
+	var->xres = mode->xres;
+	var->yres = mode->yres;
+	var->pixclock = mode->pixclock;
+	var->left_margin = mode->left_margin;
+	var->hsync_len = mode->hsync_len;
+	var->vsync_len = mode->vsync_len;
+	var->right_margin = mode->right_margin;
+	var->upper_margin = mode->upper_margin;
+	var->lower_margin = mode->lower_margin;
+	var->sync = mode->sync;
+	var->vmode = mode->vmode & FB_VMODE_MASK;
+}
+
+/**
+ * fb_mode_is_equal - compare 2 videomodes
+ * @mode1: first videomode
+ * @mode2: second videomode
+ *
+ * RETURNS:
+ * 1 if equal, 0 if not
+ */
+int fb_mode_is_equal(struct fb_videomode *mode1,
+		     struct fb_videomode *mode2)
+{
+	return (mode1->xres         == mode2->xres &&
+		mode1->yres         == mode2->yres &&
+		mode1->pixclock     == mode2->pixclock &&
+		mode1->hsync_len    == mode2->hsync_len &&
+		mode1->vsync_len    == mode2->vsync_len &&
+		mode1->left_margin  == mode2->left_margin &&
+		mode1->right_margin == mode2->right_margin &&
+		mode1->upper_margin == mode2->upper_margin &&
+		mode1->lower_margin == mode2->lower_margin &&
+		mode1->sync         == mode2->sync &&
+		mode1->vmode        == mode2->vmode);
+}
+
+/**
+ * fb_find_best_mode - find best matching videomode
+ * @var: pointer to struct fb_var_screeninfo
+ * @head: pointer to struct list_head of modelist
+ *
+ * RETURNS:
+ * struct fb_videomode, NULL if none found
+ *
+ * IMPORTANT:
+ * This function assumes that all modelist entries in
+ * info->monspecs.modelist are valid. 
+ *
+ * NOTES:
+ * Finds best matching videomode which has an equal or greater dimension than
+ * var->xres and var->yres.  If more than 1 videomode is found, will return
+ * the videomode with the highest refresh rate
+ */
+struct fb_videomode *fb_find_best_mode(struct fb_var_screeninfo *var,
+				       struct list_head *head)
+{
+	struct list_head *pos;
+	struct fb_modelist *modelist;
+	struct fb_videomode *mode, *best = NULL;
+	u32 diff = -1;
+
+	list_for_each(pos, head) {
+		modelist = list_entry(pos, struct fb_modelist, list);
+		mode = &modelist->mode;
+		u32 d;
+
+		if (mode->xres >= var->xres && mode->yres >= var->yres) {
+			d = (mode->xres - var->xres) +
+				(mode->yres - var->yres);
+			if (diff > d) {
+				diff = d;
+				best = mode;
+			} else if (diff == d && mode->refresh > best->refresh)
+			    best = mode;
+		}	    
+	}
+	return best;
+}
+
+/**
+ * fb_match_mode - find a videomode which exactly matches the timings in var
+ * @var: pointer to struct fb_var_screeninfo
+ * @head: pointer to struct list_head of modelist
+ *
+ * RETURNS:
+ * struct fb_videomode, NULL if none found
+ */
+struct fb_videomode *fb_match_mode(struct fb_var_screeninfo *var,
+				   struct list_head *head)
+{
+	struct list_head *pos;
+	struct fb_modelist *modelist;
+	struct fb_videomode *m, mode;
+
+	fb_var_to_videomode(&mode, var);
+	list_for_each(pos, head) {
+		modelist = list_entry(pos, struct fb_modelist, list);
+		m = &modelist->mode;
+		if (fb_mode_is_equal(m, &mode))
+			return m;
+	}
+	return NULL;
+}				       
+
+/**
+ * fb_add_videomode: adds videomode entry to modelist
+ * @mode: videomode to add
+ * @head: struct list_head of modelist
+ *
+ * NOTES:
+ * Will only add unmatched mode entries
+ */
+int fb_add_videomode(struct fb_videomode *mode, struct list_head *head)
+{
+	struct list_head *pos;
+	struct fb_modelist *modelist;
+	struct fb_videomode *m;
+	int found = 0;
+
+	list_for_each(pos, head) {
+		modelist = list_entry(pos, struct fb_modelist, list);
+		m = &modelist->mode;
+		if (fb_mode_is_equal(m, mode)) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		modelist = kmalloc(sizeof(struct fb_modelist),
+						  GFP_KERNEL);
+		
+		if (!modelist)
+			return -ENOMEM;
+		modelist->mode = *mode;
+		list_add(&modelist->list, head);
+	}
+	return 0;
+}				       
+
+/**
+ * fb_delete_videomode: removed videomode entry from modelist
+ * @mode: videomode to remove
+ * @head: struct list_head of modelist
+ *
+ * NOTES:
+ * Will remove all matching mode entries
+ */
+void fb_delete_videomode(struct fb_videomode *mode, struct list_head *head)
+{
+	struct list_head *pos, *n;
+	struct fb_modelist *modelist;
+	struct fb_videomode *m;
+
+	list_for_each_safe(pos, n, head) {
+		modelist = list_entry(pos, struct fb_modelist, list);
+		m = &modelist->mode;
+		if (fb_mode_is_equal(m, mode)) {
+			list_del(pos);
+			kfree(pos);
+		}
+	}
+}
+
+/**
+ * fb_destroy_modelist: destroy modelist
+ * @head: struct list_head of modelist
+ */
+void fb_destroy_modelist(struct list_head *head)
+{
+	struct list_head *pos, *n;
+	
+	list_for_each_safe(pos, n, head) {
+		list_del(pos);
+		kfree(pos);
+	}
+}
+
+/**
+ * fb_videomode_to_modelist: convert mode array to mode list
+ * @modedb: array of struct fb_videomode
+ * @num: number of entries in array
+ * @head: struct list_head of modelist
+ */
+void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,
+			      struct list_head *head)
+{
+	int i;
+
+	INIT_LIST_HEAD(head);
+	
+	for (i = 0; i < num; i++) {
+		if (fb_add_videomode(&modedb[i], head))
+			return;
+	}
+}
+
+EXPORT_SYMBOL(fb_videomode_to_var);
+EXPORT_SYMBOL(fb_var_to_videomode);
+EXPORT_SYMBOL(fb_mode_is_equal);
+EXPORT_SYMBOL(fb_add_videomode);
+EXPORT_SYMBOL(fb_delete_videomode);
+EXPORT_SYMBOL(fb_destroy_modelist);
+EXPORT_SYMBOL(fb_match_mode);
+EXPORT_SYMBOL(fb_find_best_mode);
+EXPORT_SYMBOL(fb_videomode_to_modelist);
 EXPORT_SYMBOL(vesa_modes);
 EXPORT_SYMBOL(fb_find_mode);
diff -uprN linux-2.6.8-rc3-mm1-orig/include/linux/fb.h linux-2.6.8-rc3-mm1/include/linux/fb.h
--- linux-2.6.8-rc3-mm1-orig/include/linux/fb.h	2004-08-08 21:04:50.447791592 +0800
+++ linux-2.6.8-rc3-mm1/include/linux/fb.h	2004-08-08 21:14:42.524782208 +0800
@@ -2,6 +2,7 @@
 #define _LINUX_FB_H
 
 #include <asm/types.h>
+#include <linux/list.h>
 
 /* Definitions of frame buffers						*/
 
@@ -711,6 +712,7 @@ extern void framebuffer_release(struct f
 #define FB_MODE_IS_VESA		4
 #define FB_MODE_IS_CALCULATED	8
 #define FB_MODE_IS_FIRST	16
+#define FB_MODE_IS_FROM_VAR     32
 
 extern int fbmon_valid_timings(u_int pixclock, u_int htotal, u_int vtotal,
 			       const struct fb_info *fb_info);
@@ -729,6 +731,22 @@ extern void fb_destroy_modedb(struct fb_
 /* drivers/video/modedb.c */
 #define VESA_MODEDB_SIZE 34
 extern const struct fb_videomode vesa_modes[];
+extern void fb_var_to_videomode(struct fb_videomode *mode,
+				struct fb_var_screeninfo *var);
+extern void fb_videomode_to_var(struct fb_var_screeninfo *var,
+				struct fb_videomode *mode);
+extern int fb_mode_is_equal(struct fb_videomode *mode1,
+			    struct fb_videomode *mode2);
+extern int fb_add_videomode(struct fb_videomode *mode, struct list_head *head);
+extern void fb_delete_videomode(struct fb_videomode *mode,
+				struct list_head *head);
+extern struct fb_videomode *fb_match_mode(struct fb_var_screeninfo *var,
+					  struct list_head *head);
+extern struct fb_videomode *fb_find_best_mode(struct fb_var_screeninfo *var,
+					      struct list_head *head);
+extern void fb_destroy_modelist(struct list_head *head);
+extern void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,
+				     struct list_head *head);
 
 /* drivers/video/fbcmap.c */
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);
@@ -757,6 +775,11 @@ struct fb_videomode {
 	u32 flag;
 };
 
+struct fb_modelist {
+	struct list_head list;
+	struct fb_videomode mode;
+};
+
 extern int fb_find_mode(struct fb_var_screeninfo *var,
 			struct fb_info *info, const char *mode_option,
 			const struct fb_videomode *db,




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
