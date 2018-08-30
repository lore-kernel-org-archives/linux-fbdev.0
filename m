From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Thu, 30 Aug 2018 21:00:06 +0000
Subject: [PATCH v2 03/12] fbdev: add remove_conflicting_pci_framebuffers()
Message-Id: <cab03a68df539b2f4be93a61323d3f3129c5325b.1535656077.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org

Almost all PCI drivers using remove_conflicting_framebuffers() wrap it
with the same code.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
[for v1]
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

---
v2: add kerneldoc for DRM helper
---
 drivers/video/fbdev/core/fbmem.c | 22 ++++++++++++++++++++++
 include/drm/drm_fb_helper.h      | 24 ++++++++++++++++++++++++
 include/linux/fb.h               |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0df148eb4699..927e016487e9 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -34,6 +34,7 @@
 #include <linux/fb.h>
 #include <linux/fbcon.h>
 #include <linux/mem_encrypt.h>
+#include <linux/pci.h>
 
 #include <asm/fb.h>
 
@@ -1802,6 +1803,27 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 }
 EXPORT_SYMBOL(remove_conflicting_framebuffers);
 
+int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const char *name)
+{
+	struct apertures_struct *ap;
+	bool primary = false;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return -ENOMEM;
+
+	ap->ranges[0].base = pci_resource_start(pdev, res_id);
+	ap->ranges[0].size = pci_resource_len(pdev, res_id);
+#ifdef CONFIG_X86
+	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
+					IORESOURCE_ROM_SHADOW;
+#endif
+	remove_conflicting_framebuffers(ap, name, primary);
+	kfree(ap);
+	return 0;
+}
+EXPORT_SYMBOL(remove_conflicting_pci_framebuffers);
+
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 1c1e53abb25d..6e1fc52d1b1b 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -587,4 +587,28 @@ drm_fb_helper_remove_conflicting_framebuffers(struct apertures_struct *a,
 #endif
 }
 
+/**
+ * drm_fb_helper_remove_conflicting_framebuffers - remove firmware framebuffers for PCI devices
+ * @pdev: PCI device being driven
+ * @resource_id: index of PCI BAR configuring framebuffer memory
+ * @name: requesting driver name
+ *
+ * This function removes framebuffer devices (eg. initialized by firmware)
+ * using memory range configured for @pdev's BAR @resource_id.
+ *
+ * The function assumes that PCI device with shadowed ROM is drives a primary
+ * display and so kicks out vga16fb.
+ */
+static inline int
+drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
+						  int resource_id,
+						  const char *name)
+{
+#if IS_REACHABLE(CONFIG_FB)
+	return remove_conflicting_pci_framebuffers(pdev, resource_id, name);
+#else
+	return 0;
+#endif
+}
+
 #endif
diff --git a/include/linux/fb.h b/include/linux/fb.h
index aa74a228bb92..abeffd55b66a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -632,6 +632,8 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 extern int register_framebuffer(struct fb_info *fb_info);
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int unlink_framebuffer(struct fb_info *fb_info);
+extern int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id,
+					       const char *name);
 extern int remove_conflicting_framebuffers(struct apertures_struct *a,
 					   const char *name, bool primary);
 extern int fb_prepare_logo(struct fb_info *fb_info, int rotate);
-- 
2.18.0
