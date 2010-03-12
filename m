From: Roger Quadros <roger.quadros@nokia.com>
Date: Fri, 12 Mar 2010 15:37:54 +0000
Subject: [RFC][PATCH 2/3] OMAP: DSS2: Prevent recursive Panel Enable/Disable calls from SDI
Message-Id: <1268408275-31633-3-git-send-email-roger.quadros@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

Panel enable/disable is now done inside display manager,
so don't need to do it again.

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 drivers/video/omap2/dss/sdi.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 12eb404..45aab89 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -115,12 +115,6 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 
 	dssdev->manager->enable(dssdev->manager);
 
-	if (dssdev->driver->enable) {
-		r = dssdev->driver->enable(dssdev);
-		if (r)
-			goto err3;
-	}
-
 	sdi.skip_init = 0;
 
 	return 0;
@@ -137,9 +131,6 @@ EXPORT_SYMBOL(omapdss_sdi_display_enable);
 
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 {
-	if (dssdev->driver->disable)
-		dssdev->driver->disable(dssdev);
-
 	dssdev->manager->disable(dssdev->manager);
 
 	dss_sdi_disable();
-- 
1.6.0.4

