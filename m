From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Apr 2020 15:55:50 +0000
Subject: [PATCH 5/8] drm/vmwgfx: make framebuffer support optional
Message-Id: <20200417155553.675905-6-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-fbdev@vger.kernel.org
Cc: marex@denx.de, dsd@laptop.org, Arnd Bergmann <arnd@arndb.de>, Andrzej Hajda <a.hajda@samsung.com>, airlied@linux.ie, masahiroy@kernel.org, Nicolas Pitre <nico@fluxnic.net>, Saeed Mahameed <saeedm@mellanox.com>, thellstrom@vmware.com, haojian.zhuang@gmail.com, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, kieran.bingham+renesas@ideasonboard.com, linux-graphics-maintainer@vmware.com, Laurent.pinchart@ideasonboard.com, jfrederich@gmail.com, robert.jarzmik@free.fr, daniel@zonque.org

CONFIG_FB causes unnecessary Kconfig dependency problems when selected
from another driver. Since it is already optional in vmwgfx at runtime,
turn this into a compile-time dependency so the support can be completely
left out of the driver and enabled only if CONFIG_FB is explicitly
selected in the configuration.

When the FB support is built into the driver, it is turned on by
default, but can still be disabled when loading the module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/vmwgfx/Kconfig      | 17 +++++++-------
 drivers/gpu/drm/vmwgfx/Makefile     |  4 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 35 +++++++++++++++++++----------
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
index 15acdf2a7c0f..b2835636991b 100644
--- a/drivers/gpu/drm/vmwgfx/Kconfig
+++ b/drivers/gpu/drm/vmwgfx/Kconfig
@@ -2,12 +2,7 @@
 config DRM_VMWGFX
 	tristate "DRM driver for VMware Virtual GPU"
 	depends on DRM && PCI && X86 && MMU
-	select FB_DEFERRED_IO
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
 	select DRM_TTM
-	select FB
 	select MAPPING_DIRTY_HELPERS
 	# Only needed for the transitional use of drm_crtc_init - can be removed
 	# again once vmwgfx sets up the primary plane itself.
@@ -20,9 +15,15 @@ config DRM_VMWGFX
 	  The compiled module will be called "vmwgfx.ko".
 
 config DRM_VMWGFX_FBCON
-	depends on DRM_VMWGFX && FB
-	bool "Enable framebuffer console under vmwgfx by default"
+	bool "Enable framebuffer console under vmwgfx"
+	depends on DRM_VMWGFX
+	depends on FB=y || FB=DRM_VMWGFX
+	select FB_DEFERRED_IO
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	   Choose this option if you are shipping a new vmwgfx
-	   userspace driver that supports using the kernel driver.
+	   userspace driver that supports using the kernel driver
+	   and you have framebuffer support enabled.
 
diff --git a/drivers/gpu/drm/vmwgfx/Makefile b/drivers/gpu/drm/vmwgfx/Makefile
index 31f85f09f1fc..905ebabc79fc 100644
--- a/drivers/gpu/drm/vmwgfx/Makefile
+++ b/drivers/gpu/drm/vmwgfx/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 vmwgfx-y := vmwgfx_execbuf.o vmwgfx_gmr.o vmwgfx_kms.o vmwgfx_drv.o \
-	    vmwgfx_fb.o vmwgfx_ioctl.o vmwgfx_resource.o vmwgfx_ttm_buffer.o \
+	    vmwgfx_ioctl.o vmwgfx_resource.o vmwgfx_ttm_buffer.o \
 	    vmwgfx_fifo.o vmwgfx_irq.o vmwgfx_ldu.o vmwgfx_ttm_glue.o \
 	    vmwgfx_overlay.o vmwgfx_marker.o vmwgfx_gmrid_manager.o \
 	    vmwgfx_fence.o vmwgfx_bo.o vmwgfx_scrn.o vmwgfx_context.o \
@@ -11,5 +11,7 @@ vmwgfx-y := vmwgfx_execbuf.o vmwgfx_gmr.o vmwgfx_kms.o vmwgfx_drv.o \
 	    vmwgfx_validation.o vmwgfx_page_dirty.o vmwgfx_streamoutput.o \
 	    ttm_object.o ttm_lock.o
 
+vmwgfx-$(CONFIG_DRM_VMWGFX_FBCON) += vmwgfx_fb.o
+
 vmwgfx-$(CONFIG_TRANSPARENT_HUGEPAGE) += vmwgfx_thp.o
 obj-$(CONFIG_DRM_VMWGFX) := vmwgfx.o
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index c2247a893ed4..a471a659b89d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -258,7 +258,6 @@ static const struct pci_device_id vmw_pci_id_list[] = {
 };
 MODULE_DEVICE_TABLE(pci, vmw_pci_id_list);
 
-static int enable_fbdev = IS_ENABLED(CONFIG_DRM_VMWGFX_FBCON);
 static int vmw_force_iommu;
 static int vmw_restrict_iommu;
 static int vmw_force_coherent;
@@ -269,8 +268,21 @@ static int vmw_probe(struct pci_dev *, const struct pci_device_id *);
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr);
 
+#ifdef CONFIG_DRM_VMWGFX_FBCON
+static int enable_fbdev = 1;
 MODULE_PARM_DESC(enable_fbdev, "Enable vmwgfx fbdev");
 module_param_named(enable_fbdev, enable_fbdev, int, 0600);
+static inline bool vmw_fb_enabled(struct vmw_private *dev_priv)
+{
+	return dev_priv->enable_fb;
+}
+#else
+#define enable_fbdev 0
+static inline bool vmw_fb_enabled(struct vmw_private *dev_priv)
+{
+	return false;
+}
+#endif
 MODULE_PARM_DESC(force_dma_api, "Force using the DMA API for TTM pages");
 module_param_named(force_dma_api, vmw_force_iommu, int, 0600);
 MODULE_PARM_DESC(restrict_iommu, "Try to limit IOMMU usage for TTM pages");
@@ -669,7 +681,6 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 	dev_priv->mmio_start = pci_resource_start(dev->pdev, 2);
 
 	dev_priv->assume_16bpp = !!vmw_assume_16bpp;
-
 	dev_priv->enable_fb = enable_fbdev;
 
 	vmw_write(dev_priv, SVGA_REG_ID, SVGA_ID_2);
@@ -945,7 +956,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 		VMWGFX_DRIVER_PATCHLEVEL);
 	vmw_host_log(host_log);
 
-	if (dev_priv->enable_fb) {
+	if (vmw_fb_enabled(dev_priv)) {
 		vmw_fifo_resource_inc(dev_priv);
 		vmw_svga_enable(dev_priv);
 		vmw_fb_init(dev_priv);
@@ -1001,7 +1012,7 @@ static void vmw_driver_unload(struct drm_device *dev)
 	if (dev_priv->ctx.res_ht_initialized)
 		drm_ht_remove(&dev_priv->ctx.res_ht);
 	vfree(dev_priv->ctx.cmd_bounce);
-	if (dev_priv->enable_fb) {
+	if (vmw_fb_enabled(dev_priv)) {
 		vmw_fb_off(dev_priv);
 		vmw_fb_close(dev_priv);
 		vmw_fifo_resource_dec(dev_priv);
@@ -1149,7 +1160,7 @@ static void vmw_master_drop(struct drm_device *dev,
 	struct vmw_private *dev_priv = vmw_priv(dev);
 
 	vmw_kms_legacy_hotspot_clear(dev_priv);
-	if (!dev_priv->enable_fb)
+	if (vmw_fb_enabled(dev_priv))
 		vmw_svga_disable(dev_priv);
 }
 
@@ -1347,7 +1358,7 @@ static int vmw_pm_freeze(struct device *kdev)
 		DRM_ERROR("Failed to freeze modesetting.\n");
 		return ret;
 	}
-	if (dev_priv->enable_fb)
+	if (vmw_fb_enabled(dev_priv))
 		vmw_fb_off(dev_priv);
 
 	ttm_suspend_lock(&dev_priv->reservation_sem);
@@ -1355,18 +1366,18 @@ static int vmw_pm_freeze(struct device *kdev)
 	vmw_resource_evict_all(dev_priv);
 	vmw_release_device_early(dev_priv);
 	ttm_bo_swapout_all(&dev_priv->bdev);
-	if (dev_priv->enable_fb)
+	if (vmw_fb_enabled(dev_priv))
 		vmw_fifo_resource_dec(dev_priv);
 	if (atomic_read(&dev_priv->num_fifo_resources) != 0) {
 		DRM_ERROR("Can't hibernate while 3D resources are active.\n");
-		if (dev_priv->enable_fb)
+		if (vmw_fb_enabled(dev_priv))
 			vmw_fifo_resource_inc(dev_priv);
 		WARN_ON(vmw_request_device_late(dev_priv));
 		dev_priv->suspend_locked = false;
 		ttm_suspend_unlock(&dev_priv->reservation_sem);
 		if (dev_priv->suspend_state)
 			vmw_kms_resume(dev);
-		if (dev_priv->enable_fb)
+		if (vmw_fb_enabled(dev_priv))
 			vmw_fb_on(dev_priv);
 		return -EBUSY;
 	}
@@ -1388,14 +1399,14 @@ static int vmw_pm_restore(struct device *kdev)
 	vmw_write(dev_priv, SVGA_REG_ID, SVGA_ID_2);
 	(void) vmw_read(dev_priv, SVGA_REG_ID);
 
-	if (dev_priv->enable_fb)
+	if (vmw_fb_enabled(dev_priv))
 		vmw_fifo_resource_inc(dev_priv);
 
 	ret = vmw_request_device(dev_priv);
 	if (ret)
 		return ret;
 
-	if (dev_priv->enable_fb)
+	if (vmw_fb_enabled(dev_priv))
 		__vmw_svga_enable(dev_priv);
 
 	vmw_fence_fifo_up(dev_priv->fman);
@@ -1404,7 +1415,7 @@ static int vmw_pm_restore(struct device *kdev)
 	if (dev_priv->suspend_state)
 		vmw_kms_resume(dev_priv->dev);
 
-	if (dev_priv->enable_fb)
+	if (vmw_fb_enabled(dev_priv))
 		vmw_fb_on(dev_priv);
 
 	return 0;
-- 
2.26.0
