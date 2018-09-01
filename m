From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Sat, 01 Sep 2018 14:08:46 +0000
Subject: [PATCH v3 05/13] drm/amdgpu: use simpler remove_conflicting_pci_framebuffers()
Message-Id: <fe59ab587ef4ef799b525fcc03d87800c5dc26d9.1535810304.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, Jonathan Hunter <jonathanh@nvidia.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, Maxime Ripard <maxime.ripard@bootlin.com>, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0b19482b36b8..9b6e037719db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -560,28 +560,6 @@ MODULE_DEVICE_TABLE(pci, pciidlist);
 
 static struct drm_driver kms_driver;
 
-static int amdgpu_kick_out_firmware_fb(struct pci_dev *pdev)
-{
-	struct apertures_struct *ap;
-	bool primary = false;
-
-	ap = alloc_apertures(1);
-	if (!ap)
-		return -ENOMEM;
-
-	ap->ranges[0].base = pci_resource_start(pdev, 0);
-	ap->ranges[0].size = pci_resource_len(pdev, 0);
-
-#ifdef CONFIG_X86
-	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
-#endif
-	drm_fb_helper_remove_conflicting_framebuffers(ap, "amdgpudrmfb", primary);
-	kfree(ap);
-
-	return 0;
-}
-
-
 static int amdgpu_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -609,7 +587,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		return ret;
 
 	/* Get rid of things like offb */
-	ret = amdgpu_kick_out_firmware_fb(pdev);
+	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "amdgpudrmfb");
 	if (ret)
 		return ret;
 
-- 
2.18.0
