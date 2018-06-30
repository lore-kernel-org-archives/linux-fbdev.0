From: Yisheng Xie <ysxie@foxmail.com>
Date: Sat, 30 Jun 2018 07:29:49 +0000
Subject: [PATCH v2 fbdev-for-next 1/2] fbcon: introduce for_each_registered_fb() helper
Message-Id: <1530343789-4237-1-git-send-email-ysxie@foxmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, keescook@chromium.org, j.w.r.degoede@gmail.com, david@lechnology.com
Cc: andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Yisheng Xie <ysxie@foxmail.com>

Following pattern is often used:

 for (i = 0; i < FB_MAX; i++) {
        if (registered_fb[i]) {
                ...
        }
 }

Therefore, as Andy's suggestion, for_each_registered_fb() helper can
be introduced to make the code easier to read and write by reducing
indentation level. It also saves few lines of code in each occurrence.

This patch convert all part here at the same time.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yisheng Xie <ysxie@foxmail.com>
---
v2:
 - rebase it to fbdev-for-next branch and add one more loop to replace - per Hans
 - Macro should be protected against nested conditionals. - per Andy
 drivers/video/fbdev/core/fbcon.c | 31 +++++++++++--------------------
 drivers/video/fbdev/core/fbmem.c |  4 +---
 include/linux/fb.h               |  4 ++++
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5fb156b..e30d3a1 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2234,8 +2234,8 @@ static int fbcon_switch(struct vc_data *vc)
 	 *
 	 * info->currcon = vc->vc_num;
 	 */
-	for (i = 0; i < FB_MAX; i++) {
-		if (registered_fb[i] != NULL && registered_fb[i]->fbcon_par) {
+	for_each_registered_fb(i) {
+		if (registered_fb[i]->fbcon_par) {
 			struct fbcon_ops *o = registered_fb[i]->fbcon_par;
 
 			o->currcon = vc->vc_num;
@@ -3124,11 +3124,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
 	if (idx = info_idx) {
 		info_idx = -1;
 
-		for (i = 0; i < FB_MAX; i++) {
-			if (registered_fb[i] != NULL) {
-				info_idx = i;
-				break;
-			}
+		for_each_registered_fb(i) {
+			info_idx = i;
+			break;
 		}
 	}
 
@@ -3609,10 +3607,8 @@ static int fbcon_output_notifier(struct notifier_block *nb,
 	deferred_takeover = false;
 	logo_shown = FBCON_LOGO_DONTSHOW;
 
-	for (i = 0; i < FB_MAX; i++) {
-		if (registered_fb[i])
-			fbcon_fb_registered(registered_fb[i]);
-	}
+	for_each_registered_fb(i)
+		fbcon_fb_registered(registered_fb[i]);
 
 	return NOTIFY_OK;
 }
@@ -3638,11 +3634,9 @@ static void fbcon_start(void)
 
 		console_lock();
 
-		for (i = 0; i < FB_MAX; i++) {
-			if (registered_fb[i] != NULL) {
-				info_idx = i;
-				break;
-			}
+		for_each_registered_fb(i) {
+			info_idx = i;
+			break;
 		}
 
 		do_fbcon_takeover(0);
@@ -3669,15 +3663,12 @@ static void fbcon_exit(void)
 	kfree((void *)softback_buf);
 	softback_buf = 0UL;
 
-	for (i = 0; i < FB_MAX; i++) {
+	for_each_registered_fb(i) {
 		int pending = 0;
 
 		mapped = 0;
 		info = registered_fb[i];
 
-		if (info = NULL)
-			continue;
-
 		if (info->queue.func)
 			pending = cancel_work_sync(&info->queue);
 		DPRINTK("fbcon: %s pending work\n", (pending ? "canceled" :
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 609438d..645c6ac 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1593,10 +1593,8 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
 	int i, ret;
 
 	/* check all firmware fbs and kick off if the base addr overlaps */
-	for (i = 0 ; i < FB_MAX; i++) {
+	for_each_registered_fb(i) {
 		struct apertures_struct *gen_aper;
-		if (!registered_fb[i])
-			continue;
 
 		if (!(registered_fb[i]->flags & FBINFO_MISC_FIRMWARE))
 			continue;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index aa74a22..fd31e6f 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -650,6 +650,10 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 extern int num_registered_fb;
 extern struct class *fb_class;
 
+#define for_each_registered_fb(i)		\
+	for (i = 0; i < FB_MAX; i++)		\
+		if (!registered_fb[i]) {} else
+
 extern int lock_fb_info(struct fb_info *info);
 
 static inline void unlock_fb_info(struct fb_info *info)
-- 
1.9.1

