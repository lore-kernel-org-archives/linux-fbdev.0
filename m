From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 12 May 2011 11:40:07 +0000
Subject: [PATCHv2 2/8] OMAPFB: fix wrong clock aliases and device name
Message-Id: <1305200413-23697-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1305200413-23697-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The clock aliases and the dss platform device name have changed, and
omapfb fails to initialize. Update the names to correct ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/dispc.c       |    4 ++--
 drivers/video/omap/omapfb_main.c |    2 +-
 drivers/video/omap/rfbi.c        |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 5294834..0ccd7ad 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -922,14 +922,14 @@ static int get_dss_clocks(void)
 		return PTR_ERR(dispc.dss_ick);
 	}
 
-	dispc.dss1_fck = clk_get(&dispc.fbdev->dssdev->dev, "dss1_fck");
+	dispc.dss1_fck = clk_get(&dispc.fbdev->dssdev->dev, "fck");
 	if (IS_ERR(dispc.dss1_fck)) {
 		dev_err(dispc.fbdev->dev, "can't get dss1_fck\n");
 		clk_put(dispc.dss_ick);
 		return PTR_ERR(dispc.dss1_fck);
 	}
 
-	dispc.dss_54m_fck = clk_get(&dispc.fbdev->dssdev->dev, "tv_fck");
+	dispc.dss_54m_fck = clk_get(&dispc.fbdev->dssdev->dev, "tv_clk");
 	if (IS_ERR(dispc.dss_54m_fck)) {
 		dev_err(dispc.fbdev->dev, "can't get tv_fck\n");
 		clk_put(dispc.dss_ick);
diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index e264efd..b3ddd74 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -90,7 +90,7 @@ static void omapdss_release(struct device *dev)
 
 /* dummy device for clocks */
 static struct platform_device omapdss_device = {
-	.name		= "omapdss",
+	.name		= "omapdss_dss",
 	.id		= -1,
 	.dev            = {
 		.release = omapdss_release,
diff --git a/drivers/video/omap/rfbi.c b/drivers/video/omap/rfbi.c
index eada9f1..0c6981f 100644
--- a/drivers/video/omap/rfbi.c
+++ b/drivers/video/omap/rfbi.c
@@ -90,7 +90,7 @@ static int rfbi_get_clocks(void)
 		return PTR_ERR(rfbi.dss_ick);
 	}
 
-	rfbi.dss1_fck = clk_get(&rfbi.fbdev->dssdev->dev, "dss1_fck");
+	rfbi.dss1_fck = clk_get(&rfbi.fbdev->dssdev->dev, "fck");
 	if (IS_ERR(rfbi.dss1_fck)) {
 		dev_err(rfbi.fbdev->dev, "can't get dss1_fck\n");
 		clk_put(rfbi.dss_ick);
-- 
1.7.4.1

