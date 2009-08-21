From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: [PATCH v2] fb: do not ignore fb_set_par errors
Date: Fri, 21 Aug 2009 17:49:39 +0000
Message-ID: <1250876979-29889-1-git-send-email-FlorianSchandinat@gmx.de>
References: <20090820153100.eec12070.akpm@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932502AbZHURr7@vger.kernel.org>
In-Reply-To: <20090820153100.eec12070.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

fb: do not ignore fb_set_par errors

At the moment about half of the framebuffer drivers can return an error
code in fb_set_par. Until now it would be silently ignored by fbmem.c
and fbcon.c. This patch fixes fbmem.c to return the error code and
restore var on error. But it is not clear in which video mode the device
is when fb_set_par fails. It would be good and reasonable if it were in
the old state but there is no guarantee that this is true for all
existing drivers. Additionally print a message if a failing fb_set_par
is detected in fbmem.c or fbcon.c.
Although most errors should be caught by the previous fb_check_var some
errors can't as they are dynamic (memory allocations, ...) and can only
be detected while performing the operations which is forbidden in
fb_check_var.
This patch shouldn't have a negative impact on normal operation as all
drivers return 0 on success. The impact in case of error depends heavily
on the driver and caller but it's expected to be better than before.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
v2: print warning/error messages if fb_set_par fails
---
 drivers/video/console/fbcon.c |   48 +++++++++++++++++++++++++++++++---------
 drivers/video/fbmem.c         |   15 +++++++++++-
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 3a44695..4bee7c2 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -725,7 +725,7 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 				  int oldidx, int found)
 {
 	struct fbcon_ops *ops = oldinfo->fbcon_par;
-	int err = 0;
+	int err = 0, ret;
 
 	if (oldinfo->fbops->fb_release &&
 	    oldinfo->fbops->fb_release(oldinfo, 0)) {
@@ -752,8 +752,14 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 		  newinfo in an undefined state. Thus, a call to
 		  fb_set_par() may be needed for the newinfo.
 		*/
-		if (newinfo->fbops->fb_set_par)
-			newinfo->fbops->fb_set_par(newinfo);
+		if (newinfo->fbops->fb_set_par) {
+			ret = newinfo->fbops->fb_set_par(newinfo);
+
+			if (ret)
+				printk(KERN_ERR "con2fb_release_oldinfo: "
+					"detected unhandled fb_set_par error, "
+					"error code %d\n", ret);
+		}
 	}
 
 	return err;
@@ -763,11 +769,18 @@ static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
 				int unit, int show_logo)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
+	int ret;
 
 	ops->currcon = fg_console;
 
-	if (info->fbops->fb_set_par && !(ops->flags & FBCON_FLAGS_INIT))
-		info->fbops->fb_set_par(info);
+	if (info->fbops->fb_set_par && !(ops->flags & FBCON_FLAGS_INIT)) {
+		ret = info->fbops->fb_set_par(info);
+
+		if (ret)
+			printk(KERN_ERR "con2fb_init_display: detected "
+				"unhandled fb_set_par error, "
+				"error code %d\n", ret);
+	}
 
 	ops->flags |= FBCON_FLAGS_INIT;
 	ops->graphics = 0;
@@ -1006,7 +1019,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	struct vc_data *svc = *default_mode;
 	struct display *t, *p = &fb_display[vc->vc_num];
 	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
-	int cap;
+	int cap, ret;
 
 	if (info_idx == -1 || info == NULL)
 	    return;
@@ -1092,8 +1105,15 @@ static void fbcon_init(struct vc_data *vc, int init)
 	 */
 	if (CON_IS_VISIBLE(vc) && vc->vc_mode == KD_TEXT) {
 		if (info->fbops->fb_set_par &&
-		    !(ops->flags & FBCON_FLAGS_INIT))
-			info->fbops->fb_set_par(info);
+		    !(ops->flags & FBCON_FLAGS_INIT)) {
+			ret = info->fbops->fb_set_par(info);
+
+			if (ret)
+				printk(KERN_ERR "fbcon_init: detected "
+					"unhandled fb_set_par error, "
+					"error code %d\n", ret);
+		}
+
 		ops->flags |= FBCON_FLAGS_INIT;
 	}
 
@@ -2119,7 +2139,7 @@ static int fbcon_switch(struct vc_data *vc)
 	struct fbcon_ops *ops;
 	struct display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
-	int i, prev_console, charcnt = 256;
+	int i, ret, prev_console, charcnt = 256;
 
 	info = registered_fb[con2fb_map[vc->vc_num]];
 	ops = info->fbcon_par;
@@ -2174,8 +2194,14 @@ static int fbcon_switch(struct vc_data *vc)
 
 	if (old_info != NULL && (old_info != info ||
 				 info->flags & FBINFO_MISC_ALWAYS_SETPAR)) {
-		if (info->fbops->fb_set_par)
-			info->fbops->fb_set_par(info);
+		if (info->fbops->fb_set_par) {
+			ret = info->fbops->fb_set_par(info);
+
+			if (ret)
+				printk(KERN_ERR "fbcon_switch: detected "
+					"unhandled fb_set_par error, "
+					"error code %d\n", ret);
+		}
 
 		if (old_info != info)
 			fbcon_del_cursor_timer(old_info);
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index a85c818..008f95a 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -954,6 +954,7 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 			goto done;
 
 		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
+			struct fb_var_screeninfo old_var;
 			struct fb_videomode mode;
 
 			if (info->fbops->fb_get_caps) {
@@ -963,10 +964,20 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 					goto done;
 			}
 
+			old_var = info->var;
 			info->var = *var;
 
-			if (info->fbops->fb_set_par)
-				info->fbops->fb_set_par(info);
+			if (info->fbops->fb_set_par) {
+				ret = info->fbops->fb_set_par(info);
+
+				if (ret) {
+					info->var = old_var;
+					printk(KERN_WARNING "detected "
+						"fb_set_par error, "
+						"error code: %d\n", ret);
+					goto done;
+				}
+			}
 
 			fb_pan_display(info, &info->var);
 			fb_set_cmap(&info->cmap, info);
-- 
1.6.3.2
