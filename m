From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Wed, 17 Feb 2010 11:57:19 +0000
Subject: [PATCH 4/4] OMAP: DSS2: OMAPFB: fix cleanup on dssdev enable error
Message-Id: <1266407839-14713-4-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266407839-14713-1-git-send-email-tomi.valkeinen@nokia.com>
 <1266407839-14713-2-git-send-email-tomi.valkeinen@nokia.com>
 <1266407839-14713-3-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1266407839-14713-3-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

If enabling a dss device failed, omapfb didn't exit, leading to crash.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 973bf79..6a383ab 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2176,9 +2176,11 @@ static int omapfb_probe(struct platform_device *pdev)
 		u16 w, h;
 #endif
 		r = def_display->enable(def_display);
-		if (r)
+		if (r) {
 			dev_warn(fbdev->dev, "Failed to enable display '%s'\n",
 					def_display->name);
+			goto cleanup;
+		}
 
 		/* set the update mode */
 		if (def_display->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
-- 
1.6.5

