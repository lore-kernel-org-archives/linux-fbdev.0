From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 29 Apr 2014 15:28:58 +0000
Subject: [PATCH 2/3] drm/panel: simple - Disable panel on shutdown
Message-Id: <1398785339-8107-2-git-send-email-thierry.reding@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398785339-8107-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1398785339-8107-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>

From: Thierry Reding <treding@nvidia.com>

When a device is shut down, disable the panel to make sure the display
backlight doesn't stay lit.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 309f29e9234a..a790f4c337cf 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -262,6 +262,13 @@ static int panel_simple_remove(struct device *dev)
 	return 0;
 }
 
+static void panel_simple_shutdown(struct device *dev)
+{
+	struct panel_simple *panel = dev_get_drvdata(dev);
+
+	panel_simple_disable(&panel->base);
+}
+
 static const struct drm_display_mode auo_b101aw03_mode = {
 	.clock = 51450,
 	.hdisplay = 1024,
@@ -412,6 +419,11 @@ static int panel_simple_platform_remove(struct platform_device *pdev)
 	return panel_simple_remove(&pdev->dev);
 }
 
+static void panel_simple_platform_shutdown(struct platform_device *pdev)
+{
+	panel_simple_shutdown(&pdev->dev);
+}
+
 static struct platform_driver panel_simple_platform_driver = {
 	.driver = {
 		.name = "panel-simple",
@@ -420,6 +432,7 @@ static struct platform_driver panel_simple_platform_driver = {
 	},
 	.probe = panel_simple_platform_probe,
 	.remove = panel_simple_platform_remove,
+	.shutdown = panel_simple_platform_shutdown,
 };
 
 struct panel_desc_dsi {
@@ -561,6 +574,11 @@ static int panel_simple_dsi_remove(struct mipi_dsi_device *dsi)
 	return panel_simple_remove(&dsi->dev);
 }
 
+static void panel_simple_dsi_shutdown(struct mipi_dsi_device *dsi)
+{
+	panel_simple_shutdown(&dsi->dev);
+}
+
 static struct mipi_dsi_driver panel_simple_dsi_driver = {
 	.driver = {
 		.name = "panel-simple-dsi",
@@ -569,6 +587,7 @@ static struct mipi_dsi_driver panel_simple_dsi_driver = {
 	},
 	.probe = panel_simple_dsi_probe,
 	.remove = panel_simple_dsi_remove,
+	.shutdown = panel_simple_dsi_shutdown,
 };
 
 static int __init panel_simple_init(void)
-- 
1.9.2

