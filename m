From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Thu, 30 Aug 2018 21:00:09 +0000
Subject: [PATCH v2 09/12] drm/virtio: use simpler remove_conflicting_pci_framebuffers()
Message-Id: <4f4a5b7472a7161dc0fc7a1a9be746d18fc8a7b1.1535656077.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
index 7df8d0c9026a..115ed546ca4e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
@@ -28,26 +28,6 @@
 
 #include "virtgpu_drv.h"
 
-static void virtio_pci_kick_out_firmware_fb(struct pci_dev *pci_dev)
-{
-	struct apertures_struct *ap;
-	bool primary;
-
-	ap = alloc_apertures(1);
-	if (!ap)
-		return;
-
-	ap->ranges[0].base = pci_resource_start(pci_dev, 0);
-	ap->ranges[0].size = pci_resource_len(pci_dev, 0);
-
-	primary = pci_dev->resource[PCI_ROM_RESOURCE].flags
-		& IORESOURCE_ROM_SHADOW;
-
-	drm_fb_helper_remove_conflicting_framebuffers(ap, "virtiodrmfb", primary);
-
-	kfree(ap);
-}
-
 int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev)
 {
 	struct drm_device *dev;
@@ -69,7 +49,9 @@ int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev)
 			 pname);
 		dev->pdev = pdev;
 		if (vga)
-			virtio_pci_kick_out_firmware_fb(pdev);
+			drm_fb_helper_remove_conflicting_pci_framebuffers(pdev,
+									  0,
+									  "virtiodrmfb");
 
 		snprintf(unique, sizeof(unique), "pci:%s", pname);
 		ret = drm_dev_set_unique(dev, unique);
-- 
2.18.0
