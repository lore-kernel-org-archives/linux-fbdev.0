From: Timur Tabi <timur@freescale.com>
Date: Mon, 14 Nov 2011 22:01:28 +0000
Subject: [PATCH] fb: split out framebuffer initialization from allocation
Message-Id: <1321308088-6327-1-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Introduce functions framebuffer_init() and framebuffer_cleanup() to allow
the initialization of a user-allocated fb_info object.

framebuffer_alloc() allows for appending a private data structure when it
allocates the fb_info object.  However, a driver that registers multiple
framebuffers for one device may also need another private data structure
for the device itself.  framebuffer_init() allows such drivers to store
the fb_info objects in the device-specific private data structure,
thereby simplifying memory allocation.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fbsysfs.c |   45 +++++++++++++++++++++++++++++++++++++++------
 include/linux/fb.h      |    2 ++
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 67afa9c..77d1c83 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -24,6 +24,29 @@
 #define FB_SYSFS_FLAG_ATTR 1
 
 /**
+ * framebuffer_init - initialize a frame buffer info object
+ *
+ * @info: pointer to the fb_info object
+ * @dev: pointer to the device for this fb, this can be NULL
+ *
+ * Initializes a frame buffer info object.  The object should be zeroed-out
+ * before calling this function, because only some fields are initialized.
+ *
+ * Use this function for fb_info objects that are not allocated via
+ * framebuffer_alloc(). The object must be cleaned up with
+ * framebuffer_cleanup() before its memory is deallocated.
+ */
+void framebuffer_init(struct fb_info *info, struct device *dev)
+{
+	info->device = dev;
+
+#ifdef CONFIG_FB_BACKLIGHT
+	mutex_init(&info->bl_curve_mutex);
+#endif
+}
+EXPORT_SYMBOL(framebuffer_init);
+
+/**
  * framebuffer_alloc - creates a new frame buffer info structure
  *
  * @size: size of driver private data, can be zero
@@ -35,6 +58,7 @@
  *
  * Returns the new structure, or NULL if an error occurred.
  *
+ * The object must be deallocated with framebuffer_release().
  */
 struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 {
@@ -57,11 +81,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 	if (size)
 		info->par = p + fb_info_size;
 
-	info->device = dev;
-
-#ifdef CONFIG_FB_BACKLIGHT
-	mutex_init(&info->bl_curve_mutex);
-#endif
+	framebuffer_init(info, dev);
 
 	return info;
 #undef PADDING
@@ -70,6 +90,19 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 EXPORT_SYMBOL(framebuffer_alloc);
 
 /**
+ * framebuffer_cleanup - cleans up a frame buffer info object
+ *
+ * @info: frame buffer info object
+ *
+ * Cleans up an fb_info object that was initialized with framebuffer_init().
+ */
+void framebuffer_cleanup(struct fb_info *info)
+{
+	kfree(info->apertures);
+}
+EXPORT_SYMBOL(framebuffer_cleanup);
+
+/**
  * framebuffer_release - marks the structure available for freeing
  *
  * @info: frame buffer info structure
@@ -80,7 +113,7 @@ EXPORT_SYMBOL(framebuffer_alloc);
  */
 void framebuffer_release(struct fb_info *info)
 {
-	kfree(info->apertures);
+	framebuffer_cleanup(info);
 	kfree(info);
 }
 EXPORT_SYMBOL(framebuffer_release);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 1d6836c..c2347fb 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1068,6 +1068,8 @@ static inline bool fb_be_math(struct fb_info *info)
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
+extern void framebuffer_init(struct fb_info *info, struct device *dev);
+extern void framebuffer_cleanup(struct fb_info *info);
 extern int fb_init_device(struct fb_info *fb_info);
 extern void fb_cleanup_device(struct fb_info *head);
 extern void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max);
-- 
1.7.3.4


