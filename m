From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 03 May 2013 23:00:32 +0000
Subject: [PATCH 4/7] drm: Use drm_mtrr_add_wc for the AGP aperture
Message-Id: <d39eb3baa01479e37638b25135d7f95c3e096858.1367621039.git.luto@amacapital.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1367621038.git.luto@amacapital.net>
In-Reply-To: <cover.1367621038.git.luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/gpu/drm/drm_pci.c  |  8 ++++----
 drivers/gpu/drm/drm_stub.c | 10 ++--------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index bd719e9..3628683 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -278,10 +278,10 @@ int drm_pci_agp_init(struct drm_device *dev)
 		}
 		if (drm_core_has_MTRR(dev)) {
 			if (dev->agp)
-				dev->agp->agp_mtrr -					mtrr_add(dev->agp->agp_info.aper_base,
-						 dev->agp->agp_info.aper_size *
-						 1024 * 1024, MTRR_TYPE_WRCOMB, 1);
+				dev->agp->agp_mtrr = drm_mtrr_add_wc(
+					dev->agp->agp_info.aper_base,
+					dev->agp->agp_info.aper_size *
+					1024 * 1024);
 		}
 	}
 	return 0;
diff --git a/drivers/gpu/drm/drm_stub.c b/drivers/gpu/drm/drm_stub.c
index 7d30802..96e21bd 100644
--- a/drivers/gpu/drm/drm_stub.c
+++ b/drivers/gpu/drm/drm_stub.c
@@ -451,14 +451,8 @@ void drm_put_dev(struct drm_device *dev)
 
 	drm_lastclose(dev);
 
-	if (drm_core_has_MTRR(dev) && drm_core_has_AGP(dev) &&
-	    dev->agp && dev->agp->agp_mtrr >= 0) {
-		int retval;
-		retval = mtrr_del(dev->agp->agp_mtrr,
-				  dev->agp->agp_info.aper_base,
-				  dev->agp->agp_info.aper_size * 1024 * 1024);
-		DRM_DEBUG("mtrr_del=%d\n", retval);
-	}
+	if (drm_core_has_MTRR(dev) && drm_core_has_AGP(dev) && dev->agp)
+		drm_mtrr_del_wc(dev->agp->agp_mtrr);
 
 	if (dev->driver->unload)
 		dev->driver->unload(dev);
-- 
1.8.1.4

