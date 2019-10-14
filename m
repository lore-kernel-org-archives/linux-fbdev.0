From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:14 +0000
Subject: [PATCH v2 13/15] staging: Add mgakms driver
Message-Id: <20191014140416.28517-14-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

The mgakms driver uses DRM's fbconv helpers to provide a DRM driver
for Matrox chipsets. This will allow matroxfb to be refactored into
a first-class DRM driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/staging/Kconfig             |   2 +
 drivers/staging/Makefile            |   1 +
 drivers/staging/mgakms/Kconfig      |  13 +++
 drivers/staging/mgakms/Makefile     |   6 ++
 drivers/staging/mgakms/mga_device.c |  68 +++++++++++++++
 drivers/staging/mgakms/mga_device.h |  30 +++++++
 drivers/staging/mgakms/mga_drv.c    | 129 ++++++++++++++++++++++++++++
 drivers/staging/mgakms/mga_drv.h    |  14 +++
 8 files changed, 263 insertions(+)
 create mode 100644 drivers/staging/mgakms/Kconfig
 create mode 100644 drivers/staging/mgakms/Makefile
 create mode 100644 drivers/staging/mgakms/mga_device.c
 create mode 100644 drivers/staging/mgakms/mga_device.h
 create mode 100644 drivers/staging/mgakms/mga_drv.c
 create mode 100644 drivers/staging/mgakms/mga_drv.h

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 6f1fa4c849a1..fd25596813c5 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -125,4 +125,6 @@ source "drivers/staging/exfat/Kconfig"
 
 source "drivers/staging/qlge/Kconfig"
 
+source "drivers/staging/mgakms/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index a90f9b308c8d..4c98b028ee99 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -53,3 +53,4 @@ obj-$(CONFIG_UWB)		+= uwb/
 obj-$(CONFIG_USB_WUSB)		+= wusbcore/
 obj-$(CONFIG_EXFAT_FS)		+= exfat/
 obj-$(CONFIG_QLGE)		+= qlge/
+obj-$(CONFIG_DRM_MGAKMS)	+= mgakms/
diff --git a/drivers/staging/mgakms/Kconfig b/drivers/staging/mgakms/Kconfig
new file mode 100644
index 000000000000..de23e76317bd
--- /dev/null
+++ b/drivers/staging/mgakms/Kconfig
@@ -0,0 +1,13 @@
+config DRM_MGAKMS
+	tristate "Matrox g200/g400"
+	depends on DRM && PCI
+	select DRM_FBCONV_HELPER
+	select DRM_GEM_SHMEM_HELPER
+	select DRM_KMS_HELPER
+	help
+	  Choose this option if you have a Matrox Millennium,
+	  Matrox Millennium II, Matrox Mystique, Matrox Mystique 220,
+	  Matrox Productiva G100, Matrox Mystique G200,
+	  Matrox Millennium G200, Matrox Marvel G200 video, Matrox G400,
+	  G450 or G550 card. If M is selected, the module will be called mga.
+	  AGP support is required for this driver to work.
diff --git a/drivers/staging/mgakms/Makefile b/drivers/staging/mgakms/Makefile
new file mode 100644
index 000000000000..65695f04eb7f
--- /dev/null
+++ b/drivers/staging/mgakms/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+mgakms-y	:= mga_device.o \
+		   mga_drv.o
+
+obj-$(CONFIG_DRM_MGAKMS)	+= mgakms.o
diff --git a/drivers/staging/mgakms/mga_device.c b/drivers/staging/mgakms/mga_device.c
new file mode 100644
index 000000000000..34b3bb1ed8a5
--- /dev/null
+++ b/drivers/staging/mgakms/mga_device.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/fb.h>
+#include <linux/pci.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_modeset_helper.h>
+
+#include "mga_device.h"
+
+/*
+ * struct mga_device
+ */
+
+int mga_device_init(struct mga_device *mdev, struct drm_driver *drv,
+		    struct fb_info *fb_info)
+{
+	static const uint32_t formats[] = {
+		DRM_FORMAT_XRGB8888,
+		DRM_FORMAT_RGB565
+	};
+	static unsigned int max_width = 2048;
+	static unsigned int max_height = 2048;
+	static unsigned int preferred_depth = 32;
+
+	int ret;
+
+	ret = drm_dev_init(&mdev->dev, drv, fb_info->device);
+	if (ret)
+		return ret;
+	mdev->dev.dev_private = mdev;
+	mdev->dev.pdev = container_of(fb_info->device, struct pci_dev, dev);
+	mdev->fb_info = fb_info;
+
+	ret = drm_fbconv_modeset_init(&mdev->modeset, &mdev->dev, fb_info,
+				      max_width, max_height, preferred_depth);
+	if (ret)
+		goto err_drm_dev_fini;
+
+	ret = drm_fbconv_modeset_setup_pipe(&mdev->modeset, NULL, formats,
+					    ARRAY_SIZE(formats), NULL, NULL);
+	if (ret)
+		goto err_drm_fbconv_modeset_cleanup;
+
+	ret = drm_fbdev_generic_setup(&mdev->dev, 0);
+	if (ret)
+		goto err_drm_fbconv_modeset_cleanup;
+
+	return 0;
+
+err_drm_fbconv_modeset_cleanup:
+	/* cleans up all mode-setting structures */
+	drm_fbconv_modeset_cleanup(&mdev->modeset);
+err_drm_dev_fini:
+	drm_dev_fini(&mdev->dev);
+	return ret;
+}
+
+void mga_device_cleanup(struct mga_device *mdev)
+{
+	struct drm_device *dev = &mdev->dev;
+
+	drm_fbconv_modeset_cleanup(&mdev->modeset);
+
+	drm_dev_fini(dev);
+	dev->dev_private = NULL;
+}
diff --git a/drivers/staging/mgakms/mga_device.h b/drivers/staging/mgakms/mga_device.h
new file mode 100644
index 000000000000..442effbf37bc
--- /dev/null
+++ b/drivers/staging/mgakms/mga_device.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef MGA_DEVICE_H
+#define MGA_DEVICE_H
+
+#include <linux/kernel.h>
+
+#include <drm/drm_device.h>
+#include <drm/drm_fbconv_helper.h>
+
+struct drm_driver;
+struct fb_info;
+
+struct mga_device {
+	struct drm_device dev;
+	struct fb_info *fb_info;
+
+	struct drm_fbconv_modeset modeset;
+};
+
+static inline struct mga_device *mga_device_of_dev(struct drm_device *dev)
+{
+	return container_of(dev, struct mga_device, dev);
+}
+
+int mga_device_init(struct mga_device *mdev, struct drm_driver *drv,
+		    struct fb_info *fb_info);
+void mga_device_cleanup(struct mga_device *mdev);
+
+#endif
diff --git a/drivers/staging/mgakms/mga_drv.c b/drivers/staging/mgakms/mga_drv.c
new file mode 100644
index 000000000000..75e26d3046f3
--- /dev/null
+++ b/drivers/staging/mgakms/mga_drv.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/fb.h>
+#include <linux/pci.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_fbconv_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_ioctl.h>
+
+#include "mga_device.h"
+#include "mga_drv.h"
+
+#define DRIVER_AUTHOR		"Thomas Zimmermann <tzimmermann@suse.de>"
+#define DRIVER_NAME		"mgakms"
+#define DRIVER_DESCRIPTION	"DRM driver for Matrox graphics chipsets"
+#define DRIVER_LICENSE		"GPL"
+#define DRIVER_DATE		"20190301"
+#define DRIVER_MAJOR		0
+#define DRIVER_MINOR		0
+#define DRIVER_PATCHLEVEL	1
+
+/*
+ * DRM driver
+ */
+
+DEFINE_DRM_GEM_SHMEM_FOPS(mga_file_operations);
+
+static struct drm_driver mga_driver = {
+	.major = DRIVER_MAJOR,
+	.minor = DRIVER_MINOR,
+	.patchlevel = DRIVER_PATCHLEVEL,
+	.name = DRIVER_NAME,
+	.desc = DRIVER_DESCRIPTION,
+	.date = DRIVER_DATE,
+	.driver_features = DRIVER_ATOMIC |
+			   DRIVER_GEM |
+			   DRIVER_MODESET,
+	.fops = &mga_file_operations,
+	DRM_GEM_SHMEM_DRIVER_OPS,
+};
+
+static void mga_remove_conflicting_framebuffers(struct pci_dev *pdev)
+{
+	struct apertures_struct *ap;
+	bool primary = false;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return;
+
+	ap->ranges[0].base = pci_resource_start(pdev, 1);
+	ap->ranges[0].size = pci_resource_len(pdev, 1);
+
+#ifdef CONFIG_X86
+	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
+		IORESOURCE_ROM_SHADOW;
+#endif
+	drm_fb_helper_remove_conflicting_framebuffers(ap, DRIVER_NAME,
+						      primary);
+	kfree(ap);
+}
+
+static struct mga_device *mga_create_device(struct fb_info *fb_info)
+{
+	struct mga_device *mdev;
+	int ret;
+
+	mdev = devm_kzalloc(fb_info->device, sizeof(*mdev), GFP_KERNEL);
+	if (!mdev)
+		return ERR_PTR(-ENOMEM);
+	ret = mga_device_init(mdev, &mga_driver, fb_info);
+	if (ret)
+		goto err_devm_kfree;
+	return mdev;
+
+err_devm_kfree:
+	devm_kfree(fb_info->device, mdev);
+	return ERR_PTR(ret);
+}
+
+static void mga_destroy_device(struct mga_device *mdev)
+{
+	struct device *dev = mdev->fb_info->device;
+
+	mga_device_cleanup(mdev);
+	devm_kfree(dev, mdev);
+}
+
+struct mga_device *mga_register_framebuffer(struct fb_info *fb_info,
+					    struct pci_dev *pdev)
+{
+	int ret;
+	struct mga_device *mdev;
+
+	mga_remove_conflicting_framebuffers(pdev);
+
+	ret = drm_fbconv_fill_fb_info(fb_info);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mdev = mga_create_device(fb_info);
+	if (IS_ERR(mdev)) {
+		ret = PTR_ERR(mdev);
+		goto err_drm_fbconv_cleanup_fb_info;
+	}
+
+	ret = drm_dev_register(&mdev->dev, 0);
+	if (ret)
+		goto err_mga_destroy_device;
+
+	return mdev;
+
+err_mga_destroy_device:
+	mga_destroy_device(mdev);
+err_drm_fbconv_cleanup_fb_info:
+	drm_fbconv_cleanup_fb_info(fb_info);
+	return ERR_PTR(ret);
+}
+
+void mga_unregister_framebuffer(struct mga_device *mdev)
+{
+	struct fb_info *fb_info = mdev->fb_info;
+
+	mga_destroy_device(mdev);
+	drm_fbconv_cleanup_fb_info(fb_info);
+}
diff --git a/drivers/staging/mgakms/mga_drv.h b/drivers/staging/mgakms/mga_drv.h
new file mode 100644
index 000000000000..d214719516c0
--- /dev/null
+++ b/drivers/staging/mgakms/mga_drv.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef MGA_DRV_H
+#define MGA_DRV_H
+
+struct fb_info;
+struct mga_device;
+struct pci_dev;
+
+struct mga_device *mga_register_framebuffer(struct fb_info *fb_info,
+					    struct pci_dev *pdev);
+void mga_unregister_framebuffer(struct mga_device *mdev);
+
+#endif
-- 
2.23.0
