From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Jul 2017 13:57:55 +0000
Subject: [PATCH RESEND] fbdev: omapfb: remove unused variable
Message-Id: <20170726135816.2216688-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org

Removing the default display name left a harmless warning:

fbdev/omap2/omapfb/dss/core.c: In function 'omap_dss_probe':
fbdev/omap2/omapfb/dss/core.c:196:30: error: unused variable 'pdata' [-Werror=unused-variable]

This removes the now-unused variable as well.

Fixes: 278cba7eaf54 ("drm: omapdrm: Remove unused default display name support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Originally submitted on June 9, no reply other than the Reviewed-by tag.
The patch is still needed
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index eecf695c16f4..09e5bb013d28 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -193,7 +193,6 @@ static struct notifier_block omap_dss_pm_notif_block = {
 
 static int __init omap_dss_probe(struct platform_device *pdev)
 {
-	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	int r;
 
 	core.pdev = pdev;
-- 
2.9.0

