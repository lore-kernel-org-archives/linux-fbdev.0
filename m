From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 29 Apr 2014 15:28:57 +0000
Subject: [PATCH 1/3] drm/dsi: Support device shutdown
Message-Id: <1398785339-8107-1-git-send-email-thierry.reding@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>

From: Thierry Reding <treding@nvidia.com>

Hook up the MIPI DSI bus's .shutdown() function to allow drivers to
implement code that should be run when a device is shut down.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 10 ++++++++++
 include/drm/drm_mipi_dsi.h     |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 09821f46d768..e633df2f68d8 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -282,6 +282,14 @@ static int mipi_dsi_drv_remove(struct device *dev)
 	return drv->remove(dsi);
 }
 
+static void mipi_dsi_drv_shutdown(struct device *dev)
+{
+	struct mipi_dsi_driver *drv = to_mipi_dsi_driver(dev->driver);
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
+
+	drv->shutdown(dsi);
+}
+
 /**
  * mipi_dsi_driver_register - register a driver for DSI devices
  * @drv: DSI driver structure
@@ -293,6 +301,8 @@ int mipi_dsi_driver_register(struct mipi_dsi_driver *drv)
 		drv->driver.probe = mipi_dsi_drv_probe;
 	if (drv->remove)
 		drv->driver.remove = mipi_dsi_drv_remove;
+	if (drv->shutdown)
+		drv->driver.shutdown = mipi_dsi_drv_shutdown;
 
 	return driver_register(&drv->driver);
 }
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 7209df15a3cd..944f33f8ba38 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -135,11 +135,13 @@ ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, unsigned int channel,
  * @driver: device driver model driver
  * @probe: callback for device binding
  * @remove: callback for device unbinding
+ * @shutdown: called at shutdown time to quiesce the device
  */
 struct mipi_dsi_driver {
 	struct device_driver driver;
 	int(*probe)(struct mipi_dsi_device *dsi);
 	int(*remove)(struct mipi_dsi_device *dsi);
+	void (*shutdown)(struct mipi_dsi_device *dsi);
 };
 
 #define to_mipi_dsi_driver(d) container_of(d, struct mipi_dsi_driver, driver)
-- 
1.9.2

