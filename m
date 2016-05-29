From: Rongrong Zou <zourongrong@gmail.com>
Date: Sun, 29 May 2016 09:40:52 +0000
Subject: [path v2 4/7] drm/hisilicon/hibmc: Add encoder for VDAC
Message-Id: <1464514855-108050-5-git-send-email-zourongrong@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
In-Reply-To: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zourongrong@huawei.com, airlied@linux.ie, emil.l.velikov@gmail.com, lijianhua@huawei.com, xinliang.liu@linaro.org
Cc: dri-devel@lists.freedesktop.org, guohanjun@huawei.com, majun258@huawei.com, linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Add encoder funcs and helpers for VDAC.

Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
Signed-off-by: Jianhua Li <lijianhua@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/Makefile         |  2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  |  6 ++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 85 ++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
index faa7e64..4e7797a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
+++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
@@ -1,4 +1,4 @@
-hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_power.o
+hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_power.o
 
 obj-$(CONFIG_DRM_HISI_HIBMC)	+=hibmc-drm.o
 #obj-y	+= hibmc-drm.o
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index f7837cc..962072f 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -129,6 +129,12 @@ static int hibmc_kms_init(struct hibmc_drm_device *hidev)
 		return ret;
 	}
 
+	ret = hibmc_encoder_init(hidev);
+	if (ret) {
+		DRM_ERROR("failed to init encoder\n");
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index e64ec8d..d0c5982 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -34,11 +34,13 @@ struct hibmc_drm_device {
 	struct drm_device  *dev;
 	struct drm_plane plane;
 	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	bool mode_config_initialized;
 };
 
 int hibmc_plane_init(struct hibmc_drm_device *hidev);
 int hibmc_crtc_init(struct hibmc_drm_device *hidev);
+int hibmc_encoder_init(struct hibmc_drm_device *hidev);
 
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
new file mode 100644
index 0000000..cb9a130
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -0,0 +1,85 @@
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
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drmP.h>
+
+#include "hibmc_drm_drv.h"
+#include "hibmc_drm_regs.h"
+
+
+static void hibmc_encoder_disable(struct drm_encoder *encoder)
+{
+}
+
+static void hibmc_encoder_enable(struct drm_encoder *encoder)
+{
+}
+
+static void hibmc_encoder_mode_set(struct drm_encoder *encoder,
+				   struct drm_display_mode *mode,
+				   struct drm_display_mode *adj_mode)
+{
+	u32 reg;
+	struct drm_device *dev = encoder->dev;
+	struct hibmc_drm_device *hidev = dev->dev_private;
+
+	/* just open DISPLAY_CONTROL_HISILE register bit 3:0*/
+	reg = readl(hidev->mmio + DISPLAY_CONTROL_HISILE);
+	reg |= 0xf;
+	writel(reg, hidev->mmio + DISPLAY_CONTROL_HISILE);
+}
+
+static int hibmc_encoder_atomic_check(struct drm_encoder *encoder,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_connector_state *conn_state)
+{
+	return 0;
+}
+
+static const struct drm_encoder_helper_funcs hibmc_encoder_helper_funcs = {
+	.mode_set = hibmc_encoder_mode_set,
+	.disable = hibmc_encoder_disable,
+	.enable = hibmc_encoder_enable,
+	.atomic_check = hibmc_encoder_atomic_check,
+};
+
+static const struct drm_encoder_funcs hibmc_encoder_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+int hibmc_encoder_init(struct hibmc_drm_device *hidev)
+{
+	struct drm_device *dev = hidev->dev;
+	struct drm_encoder *encoder = &hidev->encoder;
+	int ret;
+
+	encoder->possible_crtcs = 0x1;
+	ret = drm_encoder_init(dev, encoder, &hibmc_encoder_encoder_funcs,
+			       DRM_MODE_ENCODER_DAC, NULL);
+	if (ret) {
+		DRM_ERROR("failed to init encoder\n");
+		return ret;
+	}
+
+	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
+	return 0;
+}
+
-- 
1.9.1

