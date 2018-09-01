From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Sat, 01 Sep 2018 14:08:46 +0000
Subject: [PATCH v3 06/13] drm/bochs: use simpler remove_conflicting_pci_framebuffers()
Message-Id: <b5fce8eba7472e5ba8e18c2624938be6c5aa6ebb.1535810304.git.mirq-linux@rere.qmqm.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, linux-tegra@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 7b20318483e4..c61b40c72b62 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -143,22 +143,6 @@ static const struct dev_pm_ops bochs_pm_ops = {
 /* ---------------------------------------------------------------------- */
 /* pci interface                                                          */
 
-static int bochs_kick_out_firmware_fb(struct pci_dev *pdev)
-{
-	struct apertures_struct *ap;
-
-	ap = alloc_apertures(1);
-	if (!ap)
-		return -ENOMEM;
-
-	ap->ranges[0].base = pci_resource_start(pdev, 0);
-	ap->ranges[0].size = pci_resource_len(pdev, 0);
-	drm_fb_helper_remove_conflicting_framebuffers(ap, "bochsdrmfb", false);
-	kfree(ap);
-
-	return 0;
-}
-
 static int bochs_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
@@ -171,7 +155,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 	}
 
-	ret = bochs_kick_out_firmware_fb(pdev);
+	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "bochsdrmfb");
 	if (ret)
 		return ret;
 
-- 
2.18.0
