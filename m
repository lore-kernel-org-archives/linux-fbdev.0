From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:28:05 +0000
Subject: [WIP/RFC 27/31] fbdev: Add media controller support
Message-Id: <1316392089-27598-28-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Initialize and register a single-pad media entity when media controller
support is available.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/fbmem.c   |   21 +++++++++++++++++++++
 drivers/video/fbsysfs.c |   11 +++++++++++
 include/linux/fb.h      |    8 ++++++++
 3 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 5aac00e..26154fb 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -35,6 +35,7 @@
 
 #include <asm/fb.h>
 
+#include <media/media-device.h>
 
     /*
      *  Frame buffer device initialization and setup routines
@@ -1572,6 +1573,7 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	int i;
 	struct fb_event event;
 	struct fb_videomode mode;
+	int ret;
 
 	if (fb_check_foreignness(fb_info))
 		return -ENOSYS;
@@ -1625,6 +1627,21 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	fb_add_videomode(&mode, &fb_info->modelist);
 	registered_fb[i] = fb_info;
 
+#if defined(CONFIG_MEDIA_CONTROLLER)
+	if (fb_info->mdev) {
+		fb_info->entity.type = MEDIA_ENT_T_DEVNODE_FB;
+		fb_info->entity.name = fb_info->name;
+		fb_info->entity.fb.major = FB_MAJOR;
+		fb_info->entity.fb.minor = i;
+		ret = media_device_register_entity(fb_info->mdev,
+						   &fb_info->entity);
+		if (ret < 0)
+			printk(KERN_WARNING
+			       "%s: media_device_register_entity failed\n",
+			       __func__);
+	}
+#endif
+
 	event.info = fb_info;
 	if (!lock_fb_info(fb_info))
 		return -ENODEV;
@@ -1651,6 +1668,10 @@ static int do_unregister_framebuffer(struct fb_info *fb_info)
 	if (ret)
 		return -EINVAL;
 
+#if defined(CONFIG_MEDIA_CONTROLLER)
+	if (fb_info->mdev)
+		media_device_unregister_entity(&fb_info->entity);
+#endif
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 04251ce..5d1ce86 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -63,6 +63,14 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 	mutex_init(&info->bl_curve_mutex);
 #endif
 
+#ifdef CONFIG_MEDIA_CONTROLLER
+	info->pad.flags = MEDIA_PAD_FL_SOURCE;
+	if (media_entity_init(&info->entity, 1, &info->pad, 0) < 0) {
+		kfree(info);
+		return NULL;
+	}
+#endif
+
 	return info;
 #undef PADDING
 #undef BYTES_PER_LONG
@@ -80,6 +88,9 @@ EXPORT_SYMBOL(framebuffer_alloc);
  */
 void framebuffer_release(struct fb_info *info)
 {
+#ifdef CONFIG_MEDIA_CONTROLLER
+	media_entity_cleanup(&info->entity);
+#endif
 	kfree(info->apertures);
 	kfree(info);
 }
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 98b23e3..24b7368 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -423,9 +423,11 @@ struct fb_cursor {
 #include <linux/list.h>
 #include <linux/backlight.h>
 #include <linux/slab.h>
+#include <media/media-entity.h>
 #include <asm/io.h>
 
 struct vm_area_struct;
+struct media_device;
 struct fb_info;
 struct device;
 struct file;
@@ -879,6 +881,12 @@ struct fb_info {
 #endif
 
 	struct fb_ops *fbops;
+#ifdef CONFIG_MEDIA_CONTROLLER
+	char name[32];			/* Device name */
+	struct media_pad pad;		/* Output pad */
+	struct media_device *mdev;	/* Optional media device */
+	struct media_entity entity;	/* Media entity */
+#endif
 	struct device *device;		/* This is the parent */
 	struct device *dev;		/* This is this fb device */
 	int class_flag;                    /* private sysfs flags */
-- 
1.7.3.4

