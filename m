From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 12:45:59 +0000
Subject: [RFC 11/14] bootsplash: Redraw fully on console_unblank
Message-Id: <20171025124602.28292-12-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

After exiting a KD_GRAPHICS program and falling back to the text
console, a previously enabled splash needs to be fully redrawn.

Without this patch, the following fails:

1. Switch to a text console
2. Enable splash
3. Start X (or any other KD_GRAPHICS program)
4. Exit X
5. Splash is not seen, apart from animations

Signed-off-by: Max Staudt <mstaudt@suse.de>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/tty/vt/vt.c                   |  2 ++
 drivers/video/fbdev/core/bootsplash.c | 15 +++++++++------
 include/linux/bootsplash.h            |  4 ++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 2ebaba16f785..416735ab6dc1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -102,6 +102,7 @@
 #include <linux/uaccess.h>
 #include <linux/kdb.h>
 #include <linux/ctype.h>
+#include <linux/bootsplash.h>
 
 #define MAX_NR_CON_DRIVER 16
 
@@ -3903,6 +3904,7 @@ void do_unblank_screen(int leaving_gfx)
 	}
 
 	console_blanked = 0;
+	bootsplash_mark_dirty();
 	if (vc->vc_sw->con_blank(vc, 0, leaving_gfx) || vt_force_oops_output(vc))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(vc);
diff --git a/drivers/video/fbdev/core/bootsplash.c b/drivers/video/fbdev/core/bootsplash.c
index e44376d89750..df2757d6e422 100644
--- a/drivers/video/fbdev/core/bootsplash.c
+++ b/drivers/video/fbdev/core/bootsplash.c
@@ -186,6 +186,13 @@ bool bootsplash_would_render_now(void)
 		&& bootsplash_is_enabled();
 }
 
+void bootsplash_mark_dirty(void)
+{
+	mutex_lock(&splash_global.data_lock);
+	splash_global.splash_fb = NULL;
+	mutex_unlock(&splash_global.data_lock);
+}
+
 bool bootsplash_is_enabled(void)
 {
 	unsigned long flags;
@@ -242,9 +249,7 @@ void bootsplash_enable(void)
 
 	if (!was_enabled) {
 		/* Force a full redraw when the splash is re-activated */
-		mutex_lock(&splash_global.data_lock);
-		splash_global.splash_fb = NULL;
-		mutex_unlock(&splash_global.data_lock);
+		bootsplash_mark_dirty();
 
 		queue_work(splash_global.wq, &splash_work_redraw_vc);
 	}
@@ -329,9 +334,7 @@ static int splash_resume(struct device *device)
 	/* Force full redraw on resume since we've probably lost the
 	 * framebuffer's contents meanwhile
 	 */
-	mutex_lock(&splash_global.data_lock);
-	splash_global.splash_fb = NULL;
-	mutex_unlock(&splash_global.data_lock);
+	bootsplash_mark_dirty();
 
 	if (bootsplash_would_render_now())
 		queue_work(splash_global.wq, &splash_work_redraw_vc);
diff --git a/include/linux/bootsplash.h b/include/linux/bootsplash.h
index 101e70818363..a7f36043e6f6 100644
--- a/include/linux/bootsplash.h
+++ b/include/linux/bootsplash.h
@@ -21,6 +21,8 @@ extern void bootsplash_render_full(struct fb_info *info);
 
 extern bool bootsplash_would_render_now(void);
 
+extern void bootsplash_mark_dirty(void);
+
 extern bool bootsplash_is_enabled(void);
 extern void bootsplash_disable(void);
 extern void bootsplash_enable(void);
@@ -33,6 +35,8 @@ extern void bootsplash_init(void);
 
 #define bootsplash_would_render_now() (false)
 
+#define bootsplash_mark_dirty()
+
 #define bootsplash_is_enabled() (false)
 #define bootsplash_disable()
 #define bootsplash_enable()
-- 
2.12.3

