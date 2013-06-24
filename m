From: David Herrmann <dh.herrmann@gmail.com>
Date: Mon, 24 Jun 2013 22:27:29 +0000
Subject: [RFC 6/6] drm: nouveau: kick out firmware drivers during probe
Message-Id: <1372112849-670-7-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372112849-670-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1372112849-670-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@gmail.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Olof Johansson <olof@lixom.net>, David Herrmann <dh.herrmann@gmail.com>

Use the new DRM infrastructure to kick out firmware drivers before probing
the real driver.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 383f4e6..418867f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -233,13 +233,11 @@ nouveau_accel_init(struct nouveau_drm *drm)
 	nouveau_bo_move_init(drm);
 }
 
-static int nouveau_drm_probe(struct pci_dev *pdev,
-			     const struct pci_device_id *pent)
+static int nouveau_kick_out_firmware(struct drm_device *dev)
 {
-	struct nouveau_device *device;
 	struct apertures_struct *aper;
 	bool boot = false;
-	int ret;
+	struct pci_dev *pdev = dev->pdev;
 
 	/* remove conflicting drivers (vesafb, efifb etc) */
 	aper = alloc_apertures(3);
@@ -265,8 +263,18 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 #ifdef CONFIG_X86
 	boot = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
 #endif
-	remove_conflicting_framebuffers(aper, "nouveaufb", boot);
-	kfree(aper);
+
+	drm_kick_out_firmware(aper, boot);
+	dev->apertures = aper;
+	dev->apert_boot = boot;
+	return 0;
+}
+
+static int nouveau_drm_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *pent)
+{
+	struct nouveau_device *device;
+	int ret;
 
 	ret = nouveau_device_create(pdev, nouveau_name(pdev), pci_name(pdev),
 				    nouveau_config, nouveau_debug, &device);
@@ -294,9 +302,13 @@ nouveau_drm_load(struct drm_device *dev, unsigned long flags)
 	struct nouveau_drm *drm;
 	int ret;
 
-	ret = nouveau_cli_create(pdev, "DRM", sizeof(*drm), (void**)&drm);
+	ret = nouveau_kick_out_firmware(dev);
 	if (ret)
 		return ret;
+
+	ret = nouveau_cli_create(pdev, "DRM", sizeof(*drm), (void**)&drm);
+	if (ret)
+		goto fail_apert;
 	lockdep_set_class(&drm->client.mutex, &drm_client_lock_class_key);
 
 	dev->dev_private = drm;
@@ -392,6 +404,9 @@ fail_ttm:
 	nouveau_vga_fini(drm);
 fail_device:
 	nouveau_cli_destroy(&drm->client);
+fail_apert:
+	kfree(dev->apertures);
+	dev->apertures = NULL;
 	return ret;
 }
 
-- 
1.8.3.1

