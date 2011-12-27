From: Archit Taneja <archit@ti.com>
Date: Tue, 27 Dec 2011 12:49:09 +0000
Subject: [RFC PATCH 26/29] OMAPDSS: DISPLAY: Add a manager apply to sysfs store attributes for writeback
Message-Id: <1324989432-3625-27-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Writeback driver ops don't apply the writeback attribute changes, they just set
the writeback info parameters. Add manager apply calls in sysfs store ops for
timings, rotation and mirroring when its the writeback panel.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/display.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 03d7fb0..71ef0d7 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -144,6 +144,12 @@ static ssize_t display_timings_store(struct device *dev,
 
 	dssdev->driver->set_timings(dssdev, &t);
 
+	if (dssdev->wbdev && dssdev->manager) {
+		r = dssdev->manager->apply(dssdev->manager);
+		if (r)
+			return r;
+	}
+
 	return size;
 }
 
@@ -175,6 +181,12 @@ static ssize_t display_rotate_store(struct device *dev,
 	if (r)
 		return r;
 
+	if (dssdev->wbdev && dssdev->manager) {
+		r = dssdev->manager->apply(dssdev->manager);
+		if (r)
+			return r;
+	}
+
 	return size;
 }
 
@@ -207,6 +219,12 @@ static ssize_t display_mirror_store(struct device *dev,
 	if (r)
 		return r;
 
+	if (dssdev->wbdev && dssdev->manager) {
+		r = dssdev->manager->apply(dssdev->manager);
+		if (r)
+			return r;
+	}
+
 	return size;
 }
 
-- 
1.7.4.1

