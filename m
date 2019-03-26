From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:35 +0000
Subject: [PATCH 02/11] drm/fbdevdrm: Add fbdevdrm device
Message-Id: <20190326091744.11542-3-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

There's an fbdevdrm device for each supported fbdev device. The fbdevdrm
driver listens for fb events, and creates and destroys fbdevdrm devices
accordingly.

Only hardware-specific fbdev drivers are supported. Generic drivers, such
as vga16fb or vesafb are not handled. DRM-based fbdev drivers are also not
supported. This prevents the situation where a DRM drivers enables
framebuffer emulation and fbdevdrm creates a second DRM device for the
same hardware.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/fbdevdrm/Makefile          |   3 +-
 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c |  79 ++++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h |  44 ++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c    | 173 ++++++++++++++++++++-
 4 files changed, 296 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h

diff --git a/drivers/gpu/drm/fbdevdrm/Makefile b/drivers/gpu/drm/fbdevdrm/Makefile
index 65e6b43cf682..750940d38509 100644
--- a/drivers/gpu/drm/fbdevdrm/Makefile
+++ b/drivers/gpu/drm/fbdevdrm/Makefile
@@ -1,4 +1,5 @@
 ccflags-y = -Iinclude/drm
-fbdevdrm-y := fbdevdrm_drv.o
+fbdevdrm-y := fbdevdrm_device.o \
+	      fbdevdrm_drv.o
 
 obj-$(CONFIG_DRM_FBDEVDRM) += fbdevdrm.o
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
new file mode 100644
index 000000000000..0abf41cf05bb
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * One purpose of this driver is to allow for easy conversion of framebuffer
+ * drivers to DRM. As a special exception to the GNU GPL, you are allowed to
+ * relicense this file under the terms of a license of your choice if you're
+ * porting a framebuffer driver. In order to do so, update the SPDX license
+ * identifier to the new license and remove this exception.
+ *
+ * If you add code to this file, please ensure that it's compatible with the
+ * stated exception.
+ */
+
+#include "fbdevdrm_device.h"
+#include <drm/drm_drv.h>
+#include <drm/drm_modeset_helper.h>
+#include <drm/drm_print.h>
+#include <linux/fb.h>
+#include <linux/pci.h>
+
+/*
+ * struct fbdrmdev_device
+ */
+
+int fbdevdrm_device_init(struct fbdevdrm_device *fdev, struct drm_driver *drv,
+			 struct fb_info *fb_info)
+{
+	int ret;
+
+	ret = drm_dev_init(&fdev->dev, drv, fb_info->device);
+	if (ret)
+		return ret;
+	fdev->dev.dev_private = fdev;
+	fdev->dev.pdev = container_of(fb_info->device, struct pci_dev, dev);
+	fdev->fb_info = fb_info;
+
+	INIT_LIST_HEAD(&fdev->device_list);
+
+	return 0;
+}
+
+void fbdevdrm_device_cleanup(struct fbdevdrm_device *fdev)
+{
+	struct drm_device *dev = &fdev->dev;
+
+	if (!list_empty(&fdev->device_list)) {
+		DRM_ERROR("fbdevdrm: cleaned up device is still enqueued "
+			  "in device list\n");
+	}
+
+	drm_dev_fini(dev);
+	dev->dev_private = NULL;
+}
+
+struct fbdevdrm_device* fbdevdrm_device_create(struct drm_driver *drv,
+					       struct fb_info *fb_info)
+{
+	struct fbdevdrm_device *fdev;
+	int ret;
+
+	fdev = devm_kzalloc(fb_info->dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return ERR_PTR(-ENOMEM);
+	ret = fbdevdrm_device_init(fdev, drv, fb_info);
+	if (ret < 0)
+		goto err_devm_kfree;
+	return fdev;
+
+err_devm_kfree:
+	devm_kfree(fb_info->dev, fdev);
+	return ERR_PTR(ret);
+}
+
+void fbdevdrm_device_destroy(struct fbdevdrm_device *fdev)
+{
+	struct device *dev = fdev->fb_info->dev;
+
+	fbdevdrm_device_cleanup(fdev);
+	devm_kfree(dev, fdev);
+}
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
new file mode 100644
index 000000000000..85878f60bba4
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * One purpose of this driver is to allow for easy conversion of framebuffer
+ * drivers to DRM. As a special exception to the GNU GPL, you are allowed to
+ * relicense this file under the terms of a license of your choice if you're
+ * porting a framebuffer driver. In order to do so, update the SPDX license
+ * identifier to the new license and remove this exception.
+ *
+ * If you add code to this file, please ensure that it's compatible with the
+ * stated exception.
+ */
+
+#ifndef FBDEVDRM_DEVICE_H
+#define FBDEVDRM_DEVICE_H
+
+#include <drm/drm_device.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+
+struct drm_driver;
+struct fb_info;
+
+struct fbdevdrm_device {
+	struct drm_device dev;
+	struct fb_info *fb_info;
+
+	struct list_head device_list; /* entry in global device list */
+};
+
+static inline struct fbdevdrm_device* fbdevdrm_device_of_device_list(
+	struct list_head *device_list)
+{
+	return list_entry(device_list, struct fbdevdrm_device, device_list);
+}
+
+int fbdevdrm_device_init(struct fbdevdrm_device *fdev, struct drm_driver *drv,
+			 struct fb_info *fb_info);
+void fbdevdrm_device_cleanup(struct fbdevdrm_device *fdev);
+
+struct fbdevdrm_device* fbdevdrm_device_create(struct drm_driver *drv,
+					       struct fb_info *fb_info);
+void fbdevdrm_device_destroy(struct fbdevdrm_device *fdev);
+
+#endif
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
index dcb263b0c386..5be902094dc6 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
@@ -10,8 +10,13 @@
  * stated exception.
  */
 
+#include <drm/drm_drv.h>
+#include <drm/drm_print.h>
+#include <linux/console.h> /* for console_{un/lock}() */
 #include <linux/fb.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include "fbdevdrm_device.h"
 
 /* DRM porting note: Here are some general information about the driver,
  * licensing and maintenance contact. If you're porting an fbdev driver
@@ -29,18 +34,156 @@
 #define DRIVER_MINOR		0
 #define DRIVER_PATCHLEVEL	1
 
+/*
+ * DRM driver
+ */
+
+static struct drm_driver fbdevdrm_drv = {
+	/* data fields */
+	.major = DRIVER_MAJOR,
+	.minor = DRIVER_MINOR,
+	.patchlevel = DRIVER_PATCHLEVEL,
+	.name = DRIVER_NAME,
+	.desc = DRIVER_DESCRIPTION,
+	.date = DRIVER_DATE
+};
+
+/* Device list */
+
+static DEFINE_MUTEX(device_list_mutex);
+static LIST_HEAD(device_list);
+
+static void device_list_add(struct fbdevdrm_device *fdev)
+{
+	mutex_lock(&device_list_mutex);
+	list_add(&fdev->device_list, &device_list);
+	mutex_unlock(&device_list_mutex);
+}
+
+static struct fbdevdrm_device* device_list_del(struct fbdevdrm_device *fdev)
+{
+	mutex_lock(&device_list_mutex);
+	list_del(&fdev->device_list);
+	mutex_unlock(&device_list_mutex);
+
+	return fdev;
+}
+
+static struct fbdevdrm_device* device_list_find_by_fb_info(
+	const struct fb_info *fb_info)
+{
+	struct list_head *pos;
+	struct fbdevdrm_device *fdev = NULL;
+
+	mutex_lock(&device_list_mutex);
+	list_for_each(pos, &device_list) {
+		struct fbdevdrm_device *pos_fdev +			fbdevdrm_device_of_device_list(pos);
+		if (pos_fdev->fb_info = fb_info) {
+			fdev = pos_fdev;
+			goto out;
+		}
+	}
+out:
+	mutex_unlock(&device_list_mutex);
+	return fdev;
+}
+
 /* Module entry points */
 
+static bool is_generic_driver(const struct fb_info *fb_info)
+{
+	/* DRM porting note: We don't want to bind to vga16fb, vesafb, or any
+	 * other generic fbdev driver. Usually, these drivers have limited
+	 * capabilitis. We only continue if the fix structure indicates a
+	 * hardware-specific drivers . This test will also sort out drivers
+	 * registered via DRM's fbdev emulation. If you're porting an fbdev
+	 * driver to DRM, you can remove this test. The module's PCI device
+	 * ids will contain this information.
+	 */
+	return !fb_info->fix.accel &&
+	       !!strcmp(fb_info->fix.id, "S3 Virge/DX");
+}
+
+static int on_fb_registered(struct fb_info *fb_info, void *data)
+{
+	struct fbdevdrm_device *fdev;
+	int ret;
+
+	if (is_generic_driver(fb_info)) {
+		DRM_ERROR("fbdevdrm: not binding to %s\n", fb_info->fix.id);
+		return 0;
+	}
+
+	fdev = fbdevdrm_device_create(&fbdevdrm_drv, fb_info);
+	if (IS_ERR(fdev))
+		return PTR_ERR(fdev);
+	device_list_add(fdev);
+
+	ret = drm_dev_register(&fdev->dev, 0);
+	if (ret)
+		goto err_device_list_del;
+
+	return 0;
+
+err_device_list_del:
+	device_list_del(fdev);
+	fbdevdrm_device_destroy(fdev);
+	return ret;
+}
+
+static int on_fb_unregistered(struct fb_info *fb_info, void *data)
+{
+	struct fbdevdrm_device *fdev;
+
+	fdev = device_list_find_by_fb_info(fb_info);
+	if (!fdev)
+		return 0;
+
+	device_list_del(fdev);
+	fbdevdrm_device_destroy(fdev);
+
+	return 0;
+}
+
 static int fb_client_notifier_call(struct notifier_block *nb,
 				   unsigned long action, void *data)
 {
+	static const char* const event_name[] = {
+#define EVENT_NAME(_ev) \
+	[_ev] = #_ev
+		EVENT_NAME(FB_EVENT_MODE_CHANGE),
+		EVENT_NAME(FB_EVENT_SUSPEND),
+		EVENT_NAME(FB_EVENT_RESUME),
+		EVENT_NAME(FB_EVENT_MODE_DELETE),
+		EVENT_NAME(FB_EVENT_FB_REGISTERED),
+		EVENT_NAME(FB_EVENT_FB_UNREGISTERED),
+		EVENT_NAME(FB_EVENT_GET_CONSOLE_MAP),
+		EVENT_NAME(FB_EVENT_SET_CONSOLE_MAP),
+		EVENT_NAME(FB_EVENT_BLANK),
+		EVENT_NAME(FB_EVENT_NEW_MODELIST),
+		EVENT_NAME(FB_EVENT_MODE_CHANGE_ALL),
+		EVENT_NAME(FB_EVENT_CONBLANK),
+		EVENT_NAME(FB_EVENT_GET_REQ),
+		EVENT_NAME(FB_EVENT_FB_UNBIND),
+		EVENT_NAME(FB_EVENT_REMAP_ALL_CONSOLE),
+		EVENT_NAME(FB_EARLY_EVENT_BLANK),
+		EVENT_NAME(FB_R_EARLY_EVENT_BLANK)
+#undef EVENT_NAME
+	};
+
 	static int (* const on_event[])(struct fb_info*, void*) = {
+		[FB_EVENT_FB_REGISTERED]   = on_fb_registered,
+		[FB_EVENT_FB_UNREGISTERED] = on_fb_unregistered
 	};
 
 	const struct fb_event *event = data;
 
-	if ((action >= ARRAY_SIZE(on_event)) || !on_event[action])
+	if ((action >= ARRAY_SIZE(on_event)) || !on_event[action]) {
+		DRM_ERROR("fbdevdrm: unhandled event %s\n",
+				event_name[action]);
 		return 0; /* event not handled by us */
+	}
 	return on_event[action](event->info, event->data);
 }
 
@@ -50,13 +193,39 @@ static struct notifier_block fb_client = {
 
 static int __init fbdevdrm_init(void)
 {
-	int ret;
+	int ret, i;
 
 	ret = fb_register_client(&fb_client);
 	if (ret < 0)
 		return ret;
 
+	/* There might already be registered FB devices. We go
+	 * through them manually to create a corresponding DRM
+	 * device. For the event notifier, all the locking is
+	 * performed by the fbdev framework. Here, we have to
+	 * do it by ourselves. */
+
+	console_lock();
+
+	for_each_registered_fb(i) {
+		struct fb_info *fb_info = registered_fb[i];
+		if (!lock_fb_info(fb_info)) {
+			ret = -ENODEV;
+			goto err_console_unlock;
+		}
+		ret = on_fb_registered(fb_info, NULL);
+		unlock_fb_info(fb_info);
+		if (ret < 0)
+			goto err_console_unlock;
+	}
+
+	console_unlock();
+
 	return 0;
+
+err_console_unlock:
+	console_unlock();
+	return ret;
 }
 
 static void __exit fbdevdrm_exit(void)
-- 
2.21.0
