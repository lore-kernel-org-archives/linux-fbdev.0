From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Thu, 30 Aug 2018 21:00:08 +0000
Subject: [PATCH v2 07/12] drm/mgag200: use simpler remove_conflicting_pci_framebuffers()
Message-Id: <66888ed290bb80f8c529af2583611a383e2430f3.1535656077.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535656077.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org

Remove duplicated call, while at it.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/mgag200/mgag200_drv.c  | 21 +--------------------
 drivers/gpu/drm/mgag200/mgag200_main.c |  9 ---------
 2 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 74cdde2ee474..ac6af4bd9df6 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -42,29 +42,10 @@ static const struct pci_device_id pciidlist[] = {
 
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
-static void mgag200_kick_out_firmware_fb(struct pci_dev *pdev)
-{
-	struct apertures_struct *ap;
-	bool primary = false;
-
-	ap = alloc_apertures(1);
-	if (!ap)
-		return;
-
-	ap->ranges[0].base = pci_resource_start(pdev, 0);
-	ap->ranges[0].size = pci_resource_len(pdev, 0);
-
-#ifdef CONFIG_X86
-	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
-#endif
-	drm_fb_helper_remove_conflicting_framebuffers(ap, "mgag200drmfb", primary);
-	kfree(ap);
-}
-
 
 static int mga_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	mgag200_kick_out_firmware_fb(pdev);
+	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "mgag200drmfb");
 
 	return drm_get_pci_dev(pdev, ent, &driver);
 }
diff --git a/drivers/gpu/drm/mgag200/mgag200_main.c b/drivers/gpu/drm/mgag200/mgag200_main.c
index 780f983b0294..79d54103d470 100644
--- a/drivers/gpu/drm/mgag200/mgag200_main.c
+++ b/drivers/gpu/drm/mgag200/mgag200_main.c
@@ -124,20 +124,11 @@ static int mga_probe_vram(struct mga_device *mdev, void __iomem *mem)
 static int mga_vram_init(struct mga_device *mdev)
 {
 	void __iomem *mem;
-	struct apertures_struct *aper = alloc_apertures(1);
-	if (!aper)
-		return -ENOMEM;
 
 	/* BAR 0 is VRAM */
 	mdev->mc.vram_base = pci_resource_start(mdev->dev->pdev, 0);
 	mdev->mc.vram_window = pci_resource_len(mdev->dev->pdev, 0);
 
-	aper->ranges[0].base = mdev->mc.vram_base;
-	aper->ranges[0].size = mdev->mc.vram_window;
-
-	drm_fb_helper_remove_conflicting_framebuffers(aper, "mgafb", true);
-	kfree(aper);
-
 	if (!devm_request_mem_region(mdev->dev->dev, mdev->mc.vram_base, mdev->mc.vram_window,
 				"mgadrmfb_vram")) {
 		DRM_ERROR("can't reserve VRAM\n");
-- 
2.18.0
