From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 13 May 2013 23:58:45 +0000
Subject: [PATCH v3 6/9] radeon: Switch to arch_phys_wc_add and add a missing ..._del
Message-Id: <bf7788cfd4695d05f2b414735744105906650e42.1368485053.git.luto@amacapital.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1368485053.git.luto@amacapital.net>
In-Reply-To: <cover.1368485053.git.luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Jerome Glisse <j.glisse@gmail.com>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@gmail.com>, Andy Lutomirski <luto@amacapital.net>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/gpu/drm/radeon/radeon_object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index d3aface..15cd34b 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -321,8 +321,8 @@ void radeon_bo_force_delete(struct radeon_device *rdev)
 int radeon_bo_init(struct radeon_device *rdev)
 {
 	/* Add an MTRR for the VRAM */
-	rdev->mc.vram_mtrr = mtrr_add(rdev->mc.aper_base, rdev->mc.aper_size,
-			MTRR_TYPE_WRCOMB, 1);
+	rdev->mc.vram_mtrr = arch_phys_wc_add(rdev->mc.aper_base,
+					      rdev->mc.aper_size);
 	DRM_INFO("Detected VRAM RAM=%lluM, BAR=%lluM\n",
 		rdev->mc.mc_vram_size >> 20,
 		(unsigned long long)rdev->mc.aper_size >> 20);
@@ -334,6 +334,7 @@ int radeon_bo_init(struct radeon_device *rdev)
 void radeon_bo_fini(struct radeon_device *rdev)
 {
 	radeon_ttm_fini(rdev);
+	arch_phys_wc_del(rdev->mc.vram_mtrr);
 }
 
 void radeon_bo_list_add_object(struct radeon_bo_list *lobj,
-- 
1.8.1.4

