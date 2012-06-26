From: Archit Taneja <archit@ti.com>
Date: Tue, 26 Jun 2012 09:48:43 +0000
Subject: [PATCH 06/17] OMAPDSS: DISPLAY: Ignore newly added omap_video_timings fields for display timings sys
Message-Id: <1340703414-1915-8-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The display sysfs file for viewing/storing display timings is something which
will be deprecated. The new omap_video_timings fields (hsync_level, vsync_level
and others) are not configurable or viewable via this sysfs file.

This prevents the need to make the input more configurable to take the new
fields and at the same time work without these fields for backward
compatibility.

In display_timings_store, the omap_video_timings struct used to set the timings
is initialized to the existing panel timings so that the new fields are taken in
correctly. The other fields are taken from the user as before.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 37d6504..1d8198e 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -116,7 +116,7 @@ static ssize_t display_timings_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct omap_video_timings t;
+	struct omap_video_timings t = dssdev->panel.timings;
 	int r, found;
 
 	if (!dssdev->driver->set_timings || !dssdev->driver->check_timings)
-- 
1.7.9.5

