From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 01 Jun 2016 08:35:42 +0000
Subject: [PATCH v2 20/27] video: omapdss: Remove unused members from struct omap_dss_board_info
Message-Id: <20160601083549.10549-21-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org

The num_devices, **devices and *default_device is leftover from the past.
They can be removed as they are no used.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/video/omapdss.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 0c7ae93ebd76..a43859a0a398 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -320,9 +320,6 @@ enum omapdss_version {
 
 /* Board specific data */
 struct omap_dss_board_info {
-	int num_devices;
-	struct omap_dss_device **devices;
-	struct omap_dss_device *default_device;
 	const char *default_display_name;
 	int (*dsi_enable_pads)(int dsi_id, unsigned lane_mask);
 	void (*dsi_disable_pads)(int dsi_id, unsigned lane_mask);
-- 
2.8.3

