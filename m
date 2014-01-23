From: David Herrmann <dh.herrmann@gmail.com>
Date: Thu, 23 Jan 2014 14:14:59 +0000
Subject: [PATCH 07/11] drm: mgag200: remove redundant fbdev removal
Message-Id: <1390486503-1504-8-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390486503-1504-1-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1390486503-1504-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Ingo Molnar <mingo@kernel.org>, linux-fbdev@vger.kernel.org, Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>, David Herrmann <dh.herrmann@gmail.com>

We already call remove_conflicting_framebuffers() on PCI BAR0 during
pci-probe, no need to do that again during device loading.

This avoids calling into remove_conflicting_framebuffers() from within DRM
->load() callback, which might deadlock, once we make this call remove
DRM-backed sysfb-devices, too.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/gpu/drm/mgag200/mgag200_main.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_main.c b/drivers/gpu/drm/mgag200/mgag200_main.c
index 26868e5..0ee093c 100644
--- a/drivers/gpu/drm/mgag200/mgag200_main.c
+++ b/drivers/gpu/drm/mgag200/mgag200_main.c
@@ -117,20 +117,11 @@ static int mga_probe_vram(struct mga_device *mdev, void __iomem *mem)
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
-	remove_conflicting_framebuffers(aper, "mgafb", true);
-	kfree(aper);
-
 	if (!devm_request_mem_region(mdev->dev->dev, mdev->mc.vram_base, mdev->mc.vram_window,
 				"mgadrmfb_vram")) {
 		DRM_ERROR("can't reserve VRAM\n");
-- 
1.8.5.3

