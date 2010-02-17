From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Wed, 17 Feb 2010 11:57:18 +0000
Subject: [PATCH 3/4] OMAP: DSS2: OMAPFB: fix dssdev cleanup on error
Message-Id: <1266407839-14713-3-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266407839-14713-1-git-send-email-tomi.valkeinen@nokia.com>
 <1266407839-14713-2-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1266407839-14713-2-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

If there was a dss device without a driver and thus omapfb probe failed,
ref counts could be left to dss devices.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index d17caef..973bf79 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2111,18 +2111,23 @@ static int omapfb_probe(struct platform_device *pdev)
 	fbdev->dev = &pdev->dev;
 	platform_set_drvdata(pdev, fbdev);
 
+	r = 0;
 	fbdev->num_displays = 0;
 	dssdev = NULL;
 	for_each_dss_dev(dssdev) {
 		omap_dss_get_device(dssdev);
+
 		if (!dssdev->driver) {
 			dev_err(&pdev->dev, "no driver for display\n");
-			r = -EINVAL;
-			goto cleanup;
+			r = -ENODEV;
 		}
+
 		fbdev->displays[fbdev->num_displays++] = dssdev;
 	}
 
+	if (r)
+		goto cleanup;
+
 	if (fbdev->num_displays = 0) {
 		dev_err(&pdev->dev, "no displays\n");
 		r = -EINVAL;
-- 
1.6.5

