From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 06 Jul 2017 12:57:35 +0000
Subject: [PATCH 4/4] drm/<drivers>: Drop fbdev info flags
Message-Id: <20170706125735.28299-5-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706125735.28299-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20170706125735.28299-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>

- FBINFO_CAN_FORCE_OUTPUT has been a lie ever since we nerfed&removed
  the entire panic handling code in our fbdev emulation. We might
  restore kms panic output, but not through the bazillion of legacy
  code layers called fbdev/fbcon, there's just no way to make that
  work safely.

- With the module check change FBINFO_DEFAULT is always 0, so can be
  removed too.

That removes another change to cargo-cult stuff in kms drivers, yay!

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c            | 1 -
 drivers/gpu/drm/armada/armada_fbdev.c             | 1 -
 drivers/gpu/drm/ast/ast_fb.c                      | 1 -
 drivers/gpu/drm/bochs/bochs_fbdev.c               | 1 -
 drivers/gpu/drm/cirrus/cirrus_fbdev.c             | 1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c | 1 -
 drivers/gpu/drm/i915/intel_fbdev.c                | 1 -
 drivers/gpu/drm/mgag200/mgag200_fb.c              | 1 -
 drivers/gpu/drm/msm/msm_fbdev.c                   | 1 -
 drivers/gpu/drm/omapdrm/omap_fbdev.c              | 1 -
 drivers/gpu/drm/qxl/qxl_fb.c                      | 1 -
 drivers/gpu/drm/radeon/radeon_fb.c                | 1 -
 drivers/gpu/drm/udl/udl_fb.c                      | 1 -
 drivers/gpu/drm/virtio/virtgpu_fb.c               | 1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                | 1 -
 15 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index c0d8c6ff6380..1c57fefc364c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -245,7 +245,6 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
 
-	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
 	info->fbops = &amdgpufb_ops;
 
 	tmp = amdgpu_bo_gpu_offset(abo) - adev->mc.vram_start;
diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index 602dfead8eef..5b479b0ed06c 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -81,7 +81,6 @@ static int armada_fb_create(struct drm_fb_helper *fbh,
 
 	strlcpy(info->fix.id, "armada-drmfb", sizeof(info->fix.id));
 	info->par = fbh;
-	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
 	info->fbops = &armada_fb_ops;
 	info->fix.smem_start = obj->phys_addr;
 	info->fix.smem_len = obj->obj.size;
diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
index 4ad4acd0ccab..53ca6d099234 100644
--- a/drivers/gpu/drm/ast/ast_fb.c
+++ b/drivers/gpu/drm/ast/ast_fb.c
@@ -231,7 +231,6 @@ static int astfb_create(struct drm_fb_helper *helper,
 
 	strcpy(info->fix.id, "astdrmfb");
 
-	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
 	info->fbops = &astfb_ops;
 
 	info->apertures->ranges[0].base = pci_resource_start(dev->pdev, 0);
diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index 49d5a2b7d630..14eb8d0d5a00 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -118,7 +118,6 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 
 	strcpy(info->fix.id, "bochsdrmfb");
 
-	info->flags = FBINFO_DEFAULT;
 	info->fbops = &bochsfb_ops;
 
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index 7fa58eeadc9d..c69586163d92 100644
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
@@ -215,7 +215,6 @@ static int cirrusfb_create(struct drm_fb_helper *helper,
 
 	strcpy(info->fix.id, "cirrusdrmfb");
 
-	info->flags = FBINFO_DEFAULT;
 	info->fbops = &cirrusfb_ops;
 
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
index f5ac80daeef2..9740eed9231a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
@@ -131,7 +131,6 @@ static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
 
 	strcpy(info->fix.id, "hibmcdrmfb");
 
-	info->flags = FBINFO_DEFAULT;
 	info->fbops = &hibmc_drm_fb_ops;
 
 	drm_fb_helper_fill_fix(info, hi_fbdev->fb->fb.pitches[0],
diff --git a/drivers/gpu/drm/i915/intel_fbdev.c b/drivers/gpu/drm/i915/intel_fbdev.c
index 5536591d3da0..b953365a3eec 100644
--- a/drivers/gpu/drm/i915/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/intel_fbdev.c
@@ -232,7 +232,6 @@ static int intelfb_create(struct drm_fb_helper *helper,
 
 	strcpy(info->fix.id, "inteldrmfb");
 
-	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
 	info->fbops = &intelfb_ops;
 
 	/* setup aperture base/size for vesafb takeover */
diff --git a/drivers/gpu/drm/mgag200/mgag200_fb.c b/drivers/gpu/drm/mgag200/mgag200_fb.c
index 5d3b1fac906f..e94d78a32fe0 100644
--- a/drivers/gpu/drm/mgag200/mgag200_fb.c
+++ b/drivers/gpu/drm/mgag200/mgag200_fb.c
@@ -210,7 +210,6 @@ static int mgag200fb_create(struct drm_fb_helper *helper,
 
 	strcpy(info->fix.id, "mgadrmfb");
 
-	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
 	info->fbops = &mgag200fb_ops;
 
 	/* setup aperture base/size for vesafb takeover */
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index 5ecf4ff9a059..9c00fedfc741 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -143,7 +143,6 @@ static int msm_fbdev_create(struct drm_fb_helper *helper,
 	helper->fb = fb;
 
 	fbi->par = helper;
-	fbi->flags = FBINFO_DEFAULT;
 	fbi->fbops = &msm_fb_ops;
 
 	strcpy(fbi->fix.id, "msm");
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index daf81a0a2899..9273118040b7 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -184,7 +184,6 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 	helper->fb = fb;
 
 	fbi->par = helper;
-	fbi->flags = FBINFO_DEFAULT;
 	fbi->fbops = &omap_fb_ops;
 
 	strcpy(fbi->fix.id, MODULE_NAME);
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index 69e7359b562a..844c4a31ca13 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -275,7 +275,6 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
 
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
 
-	info->flags = FBINFO_DEFAULT;
 	info->fbops = &qxlfb_ops;
 
 	/*
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 356ad90a5238..e141fcd5e8e1 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -264,7 +264,6 @@ static int radeonfb_create(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
 
-	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
 	info->fbops = &radeonfb_ops;
 
 	tmp = radeon_bo_gpu_offset(rbo) - rdev->mc.vram_start;
diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
index 4a6500362564..a5c54dc60def 100644
--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -393,7 +393,6 @@ static int udlfb_create(struct drm_fb_helper *helper,
 	info->fix.smem_len = size;
 	info->fix.smem_start = (unsigned long)ufbdev->ufb.obj->vmapping;
 
-	info->flags = FBINFO_DEFAULT | FBINFO_CAN_FORCE_OUTPUT;
 	info->fbops = &udlfb_ops;
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
 	drm_fb_helper_fill_var(info, &ufbdev->helper, sizes->fb_width, sizes->fb_height);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index 33df067b11c1..046e28b69d99 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -273,7 +273,6 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	vfbdev->helper.fb = fb;
 
 	strcpy(info->fix.id, "virtiodrmfb");
-	info->flags = FBINFO_DEFAULT;
 	info->fbops = &virtio_gpufb_ops;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
index 6f4cb4678cbc..d23a18aae476 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -779,7 +779,6 @@ int vmw_fb_init(struct vmw_private *vmw_priv)
 	info->screen_base = (char __iomem *)par->vmalloc;
 	info->screen_size = fb_size;
 
-	info->flags = FBINFO_DEFAULT;
 	info->fbops = &vmw_fb_ops;
 
 	/* 24 depth per default */
-- 
2.13.2

