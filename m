From: Rongrong Zou <zourongrong@gmail.com>
Date: Sun, 29 May 2016 09:40:50 +0000
Subject: [path v2 2/7] drm/hisilicon/hibmc: Add plane for DE
Message-Id: <1464514855-108050-3-git-send-email-zourongrong@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
In-Reply-To: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zourongrong@huawei.com, airlied@linux.ie, emil.l.velikov@gmail.com, lijianhua@huawei.com, xinliang.liu@linaro.org
Cc: dri-devel@lists.freedesktop.org, guohanjun@huawei.com, majun258@huawei.com, linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Add plane funcs and helper funcs for DE.

Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
Signed-off-by: Jianhua Li <lijianhua@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/Makefile        |   2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 170 ++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c |  41 +++++-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |   3 +
 4 files changed, 214 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
index 533f9ed..faa7e64 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -1,4 +1,4 @@
-hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_power.o
+hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_power.o
 
 obj-$(CONFIG_DRM_HISI_HIBMC)	+=hibmc-drm.o
 #obj-y	+= hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
new file mode 100644
index 0000000..e8e5853
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -0,0 +1,170 @@
+/* Hisilicon Hibmc SoC drm driver
+ *
+ * Based on the bochs drm driver.
+ *
+ * Copyright (c) 2016 Huawei Limited.
+ *
+ * Author:
+ *	Rongrong Zou <zourongrong@huawei>
+ *	Rongrong Zou <zourongrong@gmail.com>
+ *	Jianhua Li <lijianhua@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_plane_helper.h>
+#include <drm/drmP.h>
+
+#include "hibmc_drm_drv.h"
+#include "hibmc_drm_regs.h"
+#include "hibmc_drm_power.h"
+
+/* ---------------------------------------------------------------------- */
+
+static int hibmc_plane_prepare_fb(struct drm_plane *plane,
+		       const struct drm_plane_state *new_state)
+{
+	/* do nothing */
+	return 0;
+}
+
+static void hibmc_plane_cleanup_fb(struct drm_plane *plane,
+				   const struct drm_plane_state *old_state)
+{
+	/* do nothing */
+}
+
+static int hibmc_plane_atomic_check(struct drm_plane *plane,
+				    struct drm_plane_state *state)
+{
+	struct drm_framebuffer *fb = state->fb;
+	struct drm_crtc *crtc = state->crtc;
+	struct drm_crtc_state *crtc_state;
+	u32 src_x = state->src_x >> 16;
+	u32 src_y = state->src_y >> 16;
+	u32 src_w = state->src_w >> 16;
+	u32 src_h = state->src_h >> 16;
+	int crtc_x = state->crtc_x;
+	int crtc_y = state->crtc_y;
+	u32 crtc_w = state->crtc_w;
+	u32 crtc_h = state->crtc_h;
+
+	if (!crtc || !fb)
+		return 0;
+
+	crtc_state = drm_atomic_get_crtc_state(state->state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
+
+	if (src_w != crtc_w || src_h != crtc_h) {
+		DRM_ERROR("Scale not support!!!\n");
+		return -EINVAL;
+	}
+
+	if (src_x + src_w > fb->width ||
+	    src_y + src_h > fb->height)
+		return -EINVAL;
+
+	if (crtc_x < 0 || crtc_y < 0)
+		return -EINVAL;
+
+	if (crtc_x + crtc_w > crtc_state->adjusted_mode.hdisplay ||
+	    crtc_y + crtc_h > crtc_state->adjusted_mode.vdisplay)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void hibmc_plane_atomic_update(struct drm_plane *plane,
+				      struct drm_plane_state *old_state)
+{
+	struct drm_plane_state	*state	= plane->state;
+	u32 reg;
+	unsigned int line_l;
+	struct hibmc_drm_device *hidev +		(struct hibmc_drm_device *)plane->dev->dev_private;
+
+	/* now just support one plane */
+	writel(0, hidev->mmio + HIBMC_CRT_FB_ADDRESS);
+	reg = state->fb->width * (state->fb->bits_per_pixel >> 3);
+	/* now line_pad is 16 */
+	reg = PADDING(16, reg);
+
+	line_l = state->fb->width * state->fb->bits_per_pixel / 8;
+	line_l = PADDING(16, line_l);
+	writel((HIBMC_CRT_FB_WIDTH_WIDTH(reg) & HIBMC_CRT_FB_WIDTH_WIDTH_MASK) |
+	       (HIBMC_CRT_FB_WIDTH_OFFS(line_l) & HIBMC_CRT_FB_WIDTH_OFFS_MASK),
+	       hidev->mmio + HIBMC_CRT_FB_WIDTH);
+
+	/* SET PIXEL FORMAT */
+	reg = readl(hidev->mmio + HIBMC_CRT_DISP_CTL);
+	reg = reg & ~HIBMC_CRT_DISP_CTL_FORMAT_MASK;
+	reg = reg | (HIBMC_CRT_DISP_CTL_FORMAT(state->fb->bits_per_pixel >> 4) &
+		     HIBMC_CRT_DISP_CTL_FORMAT_MASK);
+	writel(reg, hidev->mmio + HIBMC_CRT_DISP_CTL);
+}
+
+static void hibmc_plane_atomic_disable(struct drm_plane *plane,
+				       struct drm_plane_state *old_state)
+{
+}
+
+static const u32 channel_formats1[] = {
+	DRM_FORMAT_RGB565, DRM_FORMAT_BGR565, DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888, DRM_FORMAT_XRGB8888, DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGBA8888, DRM_FORMAT_BGRA8888, DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888
+};
+
+static struct drm_plane_funcs hibmc_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.set_property = drm_atomic_helper_plane_set_property,
+	.destroy = drm_plane_cleanup,
+	.reset = drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+};
+
+static const struct drm_plane_helper_funcs hibmc_plane_helper_funcs = {
+	.prepare_fb = hibmc_plane_prepare_fb,
+	.cleanup_fb = hibmc_plane_cleanup_fb,
+	.atomic_check = hibmc_plane_atomic_check,
+	.atomic_update = hibmc_plane_atomic_update,
+	.atomic_disable = hibmc_plane_atomic_disable,
+};
+
+int hibmc_plane_init(struct hibmc_drm_device *hidev)
+{
+	struct drm_device *dev = hidev->dev;
+	struct drm_plane *plane = &hidev->plane;
+	int ret = 0;
+
+	/*
+	 * plane init
+	 * TODO: Now only support primary plane, overlay planes
+	 * need to do.
+	 */
+	ret = drm_universal_plane_init(dev, plane, 1, &hibmc_plane_funcs,
+				       channel_formats1,
+				       ARRAY_SIZE(channel_formats1),
+				       DRM_PLANE_TYPE_PRIMARY,
+				       NULL);
+	if (ret) {
+		DRM_ERROR("fail to init plane!!!\n");
+		return ret;
+	}
+
+	drm_plane_helper_add(plane, &hibmc_plane_helper_funcs);
+	return 0;
+}
+
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 7eaacd8..794250a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -51,7 +51,8 @@ static void hibmc_disable_vblank(struct drm_device *dev, unsigned int pipe)
 }
 
 static struct drm_driver hibmc_driver = {
-	.driver_features	= DRIVER_GEM | DRIVER_MODESET,
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET |
+						DRIVER_ATOMIC,
 	.fops			= &hibmc_fops,
 	.name			= "hibmc",
 	.desc			= "hibmc drm driver",
@@ -98,6 +99,40 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+static int hibmc_kms_init(struct hibmc_drm_device *hidev)
+{
+	int ret;
+
+	drm_mode_config_init(hidev->dev);
+	hidev->mode_config_initialized = true;
+
+	hidev->dev->mode_config.min_width = 0;
+	hidev->dev->mode_config.min_height = 0;
+	hidev->dev->mode_config.max_width = 1920;
+	hidev->dev->mode_config.max_height = 1440;
+
+	hidev->dev->mode_config.fb_base = hidev->fb_base;
+	hidev->dev->mode_config.preferred_depth = 24;
+	hidev->dev->mode_config.prefer_shadow = 0;
+
+	hidev->dev->mode_config.funcs = (void *)&mode_config_funcs;
+
+	ret = hibmc_plane_init(hidev);
+	if (ret) {
+		DRM_ERROR("fail to init plane!!!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void hibmc_kms_fini(struct hibmc_drm_device *hidev)
+{
+	if (hidev->mode_config_initialized) {
+		drm_mode_config_cleanup(hidev->dev);
+		hidev->mode_config_initialized = false;
+	}
+}
 
 static int hibmc_hw_config(struct hibmc_drm_device *hidev)
 {
@@ -190,6 +225,7 @@ static int hibmc_unload(struct drm_device *dev)
 {
 	struct hibmc_drm_device *hidev = dev->dev_private;
 
+	hibmc_kms_fini(hidev);
 	hibmc_hw_fini(hidev);
 	dev->dev_private = NULL;
 	return 0;
@@ -210,6 +246,9 @@ static int hibmc_load(struct drm_device *dev, unsigned long flags)
 	if (ret)
 		goto err;
 
+	ret = hibmc_kms_init(hidev);
+	if (ret)
+		goto err;
 
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret) {
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index a072ea9..6c7985d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -32,8 +32,11 @@ struct hibmc_drm_device {
 
 	/* drm */
 	struct drm_device  *dev;
+	struct drm_plane plane;
 	bool mode_config_initialized;
 };
 
+int hibmc_plane_init(struct hibmc_drm_device *hidev);
+
 
 #endif
-- 
1.9.1

