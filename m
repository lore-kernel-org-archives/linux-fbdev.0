From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Mon, 16 Dec 2013 15:57:39 +0000
Subject: [PATCH 1/2] video/fb: Propagate error code from failing to unregister conflicting fb
Message-Id: <1387209460-9042-1-git-send-email-chris@chris-wilson.co.uk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org

If we fail to remove a conflicting fb driver, we need to abort the
loading of the second driver to avoid likely kernel panics.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbmem.c | 31 +++++++++++++++++++++----------
 include/linux/fb.h    |  4 ++--
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 010d19105ebc..e296967a3abb 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1577,10 +1577,10 @@ static bool fb_do_apertures_overlap(struct apertures_struct *gena,
 static int do_unregister_framebuffer(struct fb_info *fb_info);
 
 #define VGA_FB_PHYS 0xA0000
-static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
-				     const char *name, bool primary)
+static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
+					      const char *name, bool primary)
 {
-	int i;
+	int i, ret;
 
 	/* check all firmware fbs and kick off if the base addr overlaps */
 	for (i = 0 ; i < FB_MAX; i++) {
@@ -1599,22 +1599,29 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			printk(KERN_INFO "fb: conflicting fb hw usage "
 			       "%s vs %s - removing generic driver\n",
 			       name, registered_fb[i]->fix.id);
-			do_unregister_framebuffer(registered_fb[i]);
+			ret = do_unregister_framebuffer(registered_fb[i]);
+			if (ret)
+				return ret;
 		}
 	}
+
+	return 0;
 }
 
 static int do_register_framebuffer(struct fb_info *fb_info)
 {
-	int i;
+	int i, ret;
 	struct fb_event event;
 	struct fb_videomode mode;
 
 	if (fb_check_foreignness(fb_info))
 		return -ENOSYS;
 
-	do_remove_conflicting_framebuffers(fb_info->apertures, fb_info->fix.id,
-					 fb_is_primary_device(fb_info));
+	ret = do_remove_conflicting_framebuffers(fb_info->apertures,
+						 fb_info->fix.id,
+						 fb_is_primary_device(fb_info));
+	if (ret)
+		return ret;
 
 	if (num_registered_fb = FB_MAX)
 		return -ENXIO;
@@ -1739,12 +1746,16 @@ int unlink_framebuffer(struct fb_info *fb_info)
 }
 EXPORT_SYMBOL(unlink_framebuffer);
 
-void remove_conflicting_framebuffers(struct apertures_struct *a,
-				     const char *name, bool primary)
+int remove_conflicting_framebuffers(struct apertures_struct *a,
+				    const char *name, bool primary)
 {
+	int ret;
+
 	mutex_lock(&registration_lock);
-	do_remove_conflicting_framebuffers(a, name, primary);
+	ret = do_remove_conflicting_framebuffers(a, name, primary);
 	mutex_unlock(&registration_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL(remove_conflicting_framebuffers);
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 70c4836e4a9f..fe6ac956550e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -613,8 +613,8 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 extern int register_framebuffer(struct fb_info *fb_info);
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int unlink_framebuffer(struct fb_info *fb_info);
-extern void remove_conflicting_framebuffers(struct apertures_struct *a,
-				const char *name, bool primary);
+extern int remove_conflicting_framebuffers(struct apertures_struct *a,
+					   const char *name, bool primary);
 extern int fb_prepare_logo(struct fb_info *fb_info, int rotate);
 extern int fb_show_logo(struct fb_info *fb_info, int rotate);
 extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
-- 
1.8.5.1

