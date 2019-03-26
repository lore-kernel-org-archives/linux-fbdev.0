From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:34 +0000
Subject: [PATCH 01/11] drm/fbdevdrm: Add driver skeleton
Message-Id: <20190326091744.11542-2-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

The fbdevdrm driver runs DRM on top of fbdev framebuffer drivers. It allows
for using legacy drivers with modern userspace and gives a template for
converting fbdev drivers to DRM.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/Kconfig                 |  2 +
 drivers/gpu/drm/Makefile                |  1 +
 drivers/gpu/drm/fbdevdrm/Kconfig        | 13 +++++
 drivers/gpu/drm/fbdevdrm/Makefile       |  4 ++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c | 72 +++++++++++++++++++++++++
 5 files changed, 92 insertions(+)
 create mode 100644 drivers/gpu/drm/fbdevdrm/Kconfig
 create mode 100644 drivers/gpu/drm/fbdevdrm/Makefile
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 5e1bc630b885..c7fb1d382b2c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -337,6 +337,8 @@ source "drivers/gpu/drm/xen/Kconfig"
 
 source "drivers/gpu/drm/vboxvideo/Kconfig"
 
+source "drivers/gpu/drm/fbdevdrm/Kconfig"
+
 # Keep legacy drivers last
 
 menuconfig DRM_LEGACY
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e630eccb951c..ecfa0c0b7330 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -111,3 +111,4 @@ obj-$(CONFIG_DRM_PL111) += pl111/
 obj-$(CONFIG_DRM_TVE200) += tve200/
 obj-$(CONFIG_DRM_XEN) += xen/
 obj-$(CONFIG_DRM_VBOXVIDEO) += vboxvideo/
+obj-$(CONFIG_DRM_FBDEVDRM) += fbdevdrm/
diff --git a/drivers/gpu/drm/fbdevdrm/Kconfig b/drivers/gpu/drm/fbdevdrm/Kconfig
new file mode 100644
index 000000000000..ce071d0f4116
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/Kconfig
@@ -0,0 +1,13 @@
+config DRM_FBDEVDRM
+	tristate "DRM over FBDEV"
+	depends on DRM && PCI && AGP
+	select FB_NOTIFY
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select DRM_KMS_HELPER
+	select DRM_KMS_FB_HELPER
+	select DRM_TTM
+	help
+	  Choose this option to use fbdev video drivers within DRM.
+	  If M is selected the module will be called fbdevdrm.
diff --git a/drivers/gpu/drm/fbdevdrm/Makefile b/drivers/gpu/drm/fbdevdrm/Makefile
new file mode 100644
index 000000000000..65e6b43cf682
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/Makefile
@@ -0,0 +1,4 @@
+ccflags-y = -Iinclude/drm
+fbdevdrm-y := fbdevdrm_drv.o
+
+obj-$(CONFIG_DRM_FBDEVDRM) += fbdevdrm.o
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
new file mode 100644
index 000000000000..dcb263b0c386
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
@@ -0,0 +1,72 @@
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
+#include <linux/fb.h>
+#include <linux/module.h>
+
+/* DRM porting note: Here are some general information about the driver,
+ * licensing and maintenance contact. If you're porting an fbdev driver
+ * to DRM, update them with the appropriate values. For the license, you
+ * should either pick the license of the ported fbdev driver or
+ * GPL-2.0-or-later. Don't forget to remove the license exception statement
+ * from the file headers.
+ */
+#define DRIVER_AUTHOR		"Thomas Zimmermann <tzimmermann@suse.de>"
+#define DRIVER_NAME		"fbdevdrm"
+#define DRIVER_DESCRIPTION	"DRM over FBDEV"
+#define DRIVER_LICENSE		"GPL and additional rights"
+#define DRIVER_DATE		"20190301"
+#define DRIVER_MAJOR		0
+#define DRIVER_MINOR		0
+#define DRIVER_PATCHLEVEL	1
+
+/* Module entry points */
+
+static int fb_client_notifier_call(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	static int (* const on_event[])(struct fb_info*, void*) = {
+	};
+
+	const struct fb_event *event = data;
+
+	if ((action >= ARRAY_SIZE(on_event)) || !on_event[action])
+		return 0; /* event not handled by us */
+	return on_event[action](event->info, event->data);
+}
+
+static struct notifier_block fb_client = {
+	.notifier_call = fb_client_notifier_call
+};
+
+static int __init fbdevdrm_init(void)
+{
+	int ret;
+
+	ret = fb_register_client(&fb_client);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void __exit fbdevdrm_exit(void)
+{
+	fb_unregister_client(&fb_client);
+}
+
+module_init(fbdevdrm_init);
+module_exit(fbdevdrm_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_LICENSE(DRIVER_LICENSE);
-- 
2.21.0
