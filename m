From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 18:55:30 +0000
Subject: [PATCH] omapfb/dss: Delete an error message for a failed memory allocation in three functions
Message-Id: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 19:46:09 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c    | 4 +---
 drivers/video/fbdev/omap2/omapfb/dss/dss.c      | 4 +---
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 7a75dfda9845..10164a3bae4a 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -3982,10 +3982,8 @@ static int dispc_init_features(struct platform_device *pdev)
 	struct dispc_features *dst;
 
 	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
-	if (!dst) {
-		dev_err(&pdev->dev, "Failed to allocate DISPC Features\n");
+	if (!dst)
 		return -ENOMEM;
-	}
 
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index 48c6500c24e1..a5de13777e2b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -893,10 +893,8 @@ static int dss_init_features(struct platform_device *pdev)
 	struct dss_features *dst;
 
 	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
-	if (!dst) {
-		dev_err(&pdev->dev, "Failed to allocate local DSS Features\n");
+	if (!dst)
 		return -ENOMEM;
-	}
 
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
index 9a13c35fd6d8..d25eea10c665 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
@@ -195,10 +195,8 @@ static int hdmi_phy_init_features(struct platform_device *pdev)
 	const struct hdmi_phy_features *src;
 
 	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
-	if (!dst) {
-		dev_err(&pdev->dev, "Failed to allocate HDMI PHY Features\n");
+	if (!dst)
 		return -ENOMEM;
-	}
 
 	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP4430_ES1:
-- 
2.15.0

