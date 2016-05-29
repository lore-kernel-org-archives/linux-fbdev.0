From: Rongrong Zou <zourongrong@gmail.com>
Date: Sun, 29 May 2016 09:40:53 +0000
Subject: [path v2 5/7] drm/hisilicon/hibmc: Add connector for VDAC
Message-Id: <1464514855-108050-6-git-send-email-zourongrong@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
In-Reply-To: <1464514855-108050-1-git-send-email-zourongrong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zourongrong@huawei.com, airlied@linux.ie, emil.l.velikov@gmail.com, lijianhua@huawei.com, xinliang.liu@linaro.org
Cc: dri-devel@lists.freedesktop.org, guohanjun@huawei.com, majun258@huawei.com, linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Add connector funcs and helper funcs for VDAC.

Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
Signed-off-by: Jianhua Li <lijianhua@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 21 ++++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  3 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 89 ++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 962072f..70d79d2 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -135,6 +135,14 @@ static int hibmc_kms_init(struct hibmc_drm_device *hidev)
 		return ret;
 	}
 
+	ret = hibmc_connector_init(hidev);
+	if (ret) {
+		DRM_ERROR("failed to init connector\n");
+		return ret;
+	}
+
+	drm_mode_connector_attach_encoder(&hidev->connector,
+					  &hidev->encoder);
 	return 0;
 }
 
@@ -278,6 +286,12 @@ err:
 	return ret;
 }
 
+static void hibmc_connector_unplug_all(struct drm_device *dev)
+{
+	mutex_lock(&dev->mode_config.mutex);
+	drm_connector_unregister_all(dev);
+	mutex_unlock(&dev->mode_config.mutex);
+}
 
 static int hibmc_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
@@ -304,8 +318,14 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_unload;
 
+	ret = drm_connector_register_all(dev);
+	if (ret)
+		goto err_unregister;
+
 	return 0;
 
+err_unregister:
+	drm_dev_unregister(dev);
 err_unload:
 	hibmc_unload(dev);
 err_disable:
@@ -320,6 +340,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	hibmc_connector_unplug_all(dev);
 	drm_dev_unregister(dev);
 	hibmc_unload(dev);
 	drm_dev_unref(dev);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index d0c5982..eb5a892 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -35,12 +35,13 @@ struct hibmc_drm_device {
 	struct drm_plane plane;
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
+	struct drm_connector connector;
 	bool mode_config_initialized;
 };
 
 int hibmc_plane_init(struct hibmc_drm_device *hidev);
 int hibmc_crtc_init(struct hibmc_drm_device *hidev);
 int hibmc_encoder_init(struct hibmc_drm_device *hidev);
-
+int hibmc_connector_init(struct hibmc_drm_device *hidev);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index cb9a130..b39ec65 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -24,6 +24,13 @@
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
 
+static int defx = 800;
+static int defy = 600;
+
+module_param(defx, int, 0444);
+module_param(defy, int, 0444);
+MODULE_PARM_DESC(defx, "default x resolution");
+MODULE_PARM_DESC(defy, "default y resolution");
 
 static void hibmc_encoder_disable(struct drm_encoder *encoder)
 {
@@ -83,3 +90,85 @@ int hibmc_encoder_init(struct hibmc_drm_device *hidev)
 	return 0;
 }
 
+static int hibmc_connector_get_modes(struct drm_connector *connector)
+{
+	int count;
+
+	count = drm_add_modes_noedid(connector, 800, 600);
+	drm_set_preferred_mode(connector, defx, defy);
+	return count;
+}
+
+static int hibmc_connector_mode_valid(struct drm_connector *connector,
+				      struct drm_display_mode *mode)
+{
+	struct hibmc_drm_device *hiprivate +	 container_of(connector, struct hibmc_drm_device, connector);
+	unsigned long size = mode->hdisplay * mode->vdisplay * 4;
+
+	/*
+	* Make sure we can fit two framebuffers into video memory.
+	* This allows up to 1600x1200 with 16 MB (default size).
+	* If you want more try this:
+	* 'qemu -vga std -global VGA.vgamem_mb2 $otherargs'
+	*/
+	if (size * 2 > hiprivate->fb_size)
+		return MODE_BAD;
+
+	return MODE_OK;
+}
+
+static struct drm_encoder *
+hibmc_connector_best_encoder(struct drm_connector *connector)
+{
+	int enc_id = connector->encoder_ids[0];
+
+	/* pick the encoder ids */
+	if (enc_id)
+		return drm_encoder_find(connector->dev, enc_id);
+
+	return NULL;
+}
+
+static enum drm_connector_status hibmc_connector_detect(struct drm_connector
+						 *connector, bool force)
+{
+	return connector_status_connected;
+}
+
+static const struct drm_connector_helper_funcs
+	hibmc_connector_connector_helper_funcs = {
+	.get_modes = hibmc_connector_get_modes,
+	.mode_valid = hibmc_connector_mode_valid,
+	.best_encoder = hibmc_connector_best_encoder,
+};
+
+static const struct drm_connector_funcs hibmc_connector_connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.detect = hibmc_connector_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+int hibmc_connector_init(struct hibmc_drm_device *hidev)
+{
+	struct drm_device *dev = hidev->dev;
+	struct drm_connector *connector = &hidev->connector;
+	int ret;
+
+	ret = drm_connector_init(dev, connector,
+				 &hibmc_connector_connector_funcs,
+				 DRM_MODE_CONNECTOR_VIRTUAL);
+	if (ret) {
+		DRM_ERROR("failed to init connector\n");
+		return ret;
+	}
+	drm_connector_helper_add(connector,
+				 &hibmc_connector_connector_helper_funcs);
+
+	return 0;
+}
+
-- 
1.9.1

