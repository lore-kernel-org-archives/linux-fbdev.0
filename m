From: Roger Quadros <roger.quadros@nokia.com>
Date: Fri, 12 Mar 2010 15:37:53 +0000
Subject: [RFC][PATCH 1/3] OMAP: DSS2: Do regulator stuff in dpi_init_display()
Message-Id: <1268408275-31633-2-git-send-email-roger.quadros@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

We don't want dpi_init() to fail in any case as it will prevent us
from using DSS2 if we don't have DSI in the system. This is because
dpi_init() is done unconditionally by the DSS2 core.

We will only need to do regulator initialization when DPI is actually
present in the system. So we do regulator init stuff in dpi_init_display()

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 drivers/video/omap2/dss/dpi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 960e977..bcedafd 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -299,11 +299,6 @@ int dpi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("init_display\n");
 
-	return 0;
-}
-
-int dpi_init(struct platform_device *pdev)
-{
 	if (cpu_is_omap34xx()) {
 		dpi.vdds_dsi_reg = dss_get_vdds_dsi();
 		if (IS_ERR(dpi.vdds_dsi_reg)) {
@@ -315,6 +310,11 @@ int dpi_init(struct platform_device *pdev)
 	return 0;
 }
 
+int dpi_init(struct platform_device *pdev)
+{
+	return 0;
+}
+
 void dpi_exit(void)
 {
 }
-- 
1.6.0.4

