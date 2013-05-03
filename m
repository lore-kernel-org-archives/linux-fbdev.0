From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 03 May 2013 23:00:34 +0000
Subject: [PATCH 6/7] radeon: Switch to drm_mtrr_add_wc and add a missing drm_mtrr_del_wc
Message-Id: <134d5e30d48f0355d1558597333aab2a680dfbdd.1367621039.git.luto@amacapital.net>
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
 drivers/gpu/drm/radeon/radeon_object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index d3aface..01d4906 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -321,8 +321,8 @@ void radeon_bo_force_delete(struct radeon_device *rdev)
 int radeon_bo_init(struct radeon_device *rdev)
 {
 	/* Add an MTRR for the VRAM */
-	rdev->mc.vram_mtrr = mtrr_add(rdev->mc.aper_base, rdev->mc.aper_size,
-			MTRR_TYPE_WRCOMB, 1);
+	rdev->mc.vram_mtrr = drm_mtrr_add_wc(rdev->mc.aper_base,
+					     rdev->mc.aper_size);
 	DRM_INFO("Detected VRAM RAM=%lluM, BAR=%lluM\n",
 		rdev->mc.mc_vram_size >> 20,
 		(unsigned long long)rdev->mc.aper_size >> 20);
@@ -334,6 +334,7 @@ int radeon_bo_init(struct radeon_device *rdev)
 void radeon_bo_fini(struct radeon_device *rdev)
 {
 	radeon_ttm_fini(rdev);
+	drm_mtrr_del_wc(rdev->mc.vram_mtrr);
 }
 
 void radeon_bo_list_add_object(struct radeon_bo_list *lobj,
-- 
1.8.1.4

