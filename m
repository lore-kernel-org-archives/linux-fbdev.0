From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 03 Jun 2016 11:03:24 +0000
Subject: [PATCH v3 22/27] platform_data: omapdss: Remove unused members from omap_dss_board_info
Message-Id: <20160603110329.9953-23-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160603110329.9953-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160603110329.9953-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org

The num_devices, **devices and *default_device is leftover from the past.
They can be removed as they are no used.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/linux/platform_data/omapdss.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/platform_data/omapdss.h b/include/linux/platform_data/omapdss.h
index dbb875abc44a..679177929045 100644
--- a/include/linux/platform_data/omapdss.h
+++ b/include/linux/platform_data/omapdss.h
@@ -25,13 +25,8 @@ enum omapdss_version {
 	OMAPDSS_VER_DRA7xx,
 };
 
-struct omap_dss_device;
-
 /* Board specific data */
 struct omap_dss_board_info {
-	int num_devices;
-	struct omap_dss_device **devices;
-	struct omap_dss_device *default_device;
 	const char *default_display_name;
 	int (*dsi_enable_pads)(int dsi_id, unsigned int lane_mask);
 	void (*dsi_disable_pads)(int dsi_id, unsigned int lane_mask);
-- 
2.8.3

