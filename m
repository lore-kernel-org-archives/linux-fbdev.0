From: Felipe Balbi <balbi@ti.com>
Date: Tue, 14 Oct 2014 18:28:54 +0000
Subject: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing MODULE_ALIAS()
Message-Id: <1413311335-25083-2-git-send-email-balbi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
In-Reply-To: <1413311335-25083-1-git-send-email-balbi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

without MODULE_ALIAS(), omapfb won't get loaded
automatically.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index 9cbf1ce..b4b9244 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -2651,6 +2651,7 @@ module_param_named(mirror, def_mirror, bool, 0);
 
 module_platform_driver(omapfb_driver);
 
+MODULE_ALIAS("platform:omapfb");
 MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
 MODULE_DESCRIPTION("OMAP2/3 Framebuffer");
 MODULE_LICENSE("GPL v2");
-- 
2.1.0.GIT

