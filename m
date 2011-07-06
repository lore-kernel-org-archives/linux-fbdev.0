From: Andy Doan <andy.doan@linaro.org>
Date: Wed, 06 Jul 2011 17:08:29 +0000
Subject: [PATCH] OMAPFB: make debug message more useful
Message-Id: <1309972109-23778-1-git-send-email-andy.doan@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Doan <andy.doan@linaro.org>

Make the debug message useful by printing the name of the device
that no associated driver could be found for.

Signed-off-by: Andy Doan <andy.doan@linaro.org>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 602b71a..e5a64b3 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2373,7 +2373,8 @@ static int omapfb_probe(struct platform_device *pdev)
 		omap_dss_get_device(dssdev);
 
 		if (!dssdev->driver) {
-			dev_err(&pdev->dev, "no driver for display\n");
+			dev_err(&pdev->dev, "no driver for display: %s\n",
+				dssdev->name);
 			r = -ENODEV;
 		}
 
-- 
1.7.4.1

