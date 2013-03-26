From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Mar 2013 13:33:47 +0000
Subject: [PATCH 17/26] OMAPDSS: generic-dpi-panel platform_data changes
Message-Id: <1364304836-18134-18-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The forthcoming omap_dss_device to platform_device conversion requires a
few new fields to the generic-dpi-panel platform data. Add the platform
data fields here so that we can make the board file changes
independently of the panel driver changes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omap-panel-generic-dpi.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/video/omap-panel-generic-dpi.h b/include/video/omap-panel-generic-dpi.h
index 127e3f2..4ef4419 100644
--- a/include/video/omap-panel-generic-dpi.h
+++ b/include/video/omap-panel-generic-dpi.h
@@ -29,9 +29,12 @@ struct omap_dss_device;
  * @platform_disable: platform specific panel disable function
  */
 struct panel_generic_dpi_data {
+	const char *display_name;
+	const char *source;
 	const char *name;
 	int (*platform_enable)(struct omap_dss_device *dssdev);
 	void (*platform_disable)(struct omap_dss_device *dssdev);
+	int data_lines;
 };
 
 #endif /* __OMAP_PANEL_GENERIC_DPI_H */
-- 
1.7.10.4

