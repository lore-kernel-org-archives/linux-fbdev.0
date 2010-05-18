From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 18 May 2010 12:34:55 +0000
Subject: [PATCH 04/23] OMAP: DSS2: Remove redundant enable/disable calls from SDI
Message-Id: <1274186114-26951-5-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Roger Quadros <roger.quadros@nokia.com>

Panel enable/disable is now done via the panel driver, so we should not
call the panel driver again

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/sdi.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 12eb404..3de3c1e 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -115,17 +115,9 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 
 	dssdev->manager->enable(dssdev->manager);
 
-	if (dssdev->driver->enable) {
-		r = dssdev->driver->enable(dssdev);
-		if (r)
-			goto err3;
-	}
-
 	sdi.skip_init = 0;
 
 	return 0;
-err3:
-	dssdev->manager->disable(dssdev->manager);
 err2:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 err1:
@@ -137,9 +129,6 @@ EXPORT_SYMBOL(omapdss_sdi_display_enable);
 
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 {
-	if (dssdev->driver->disable)
-		dssdev->driver->disable(dssdev);
-
 	dssdev->manager->disable(dssdev->manager);
 
 	dss_sdi_disable();
-- 
1.7.0.4

