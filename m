From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 29 Apr 2013 10:22:29 +0000
Subject: [PATCH 02/10] OMAPFB: use module_platform_driver()
Message-Id: <1367230957-32337-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of using platform_driver_probe(), use module_platform_driver()
so that we can support deferred probing.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index f38348e..808f6af 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2422,7 +2422,7 @@ static int omapfb_init_connections(struct omapfb2_device *fbdev,
 	return 0;
 }
 
-static int __init omapfb_probe(struct platform_device *pdev)
+static int omapfb_probe(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = NULL;
 	int r = 0;
@@ -2595,6 +2595,7 @@ static int __exit omapfb_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omapfb_driver = {
+	.probe		= omapfb_probe,
 	.remove         = __exit_p(omapfb_remove),
 	.driver         = {
 		.name   = "omapfb",
@@ -2602,36 +2603,13 @@ static struct platform_driver omapfb_driver = {
 	},
 };
 
-static int __init omapfb_init(void)
-{
-	DBG("omapfb_init\n");
-
-	if (platform_driver_probe(&omapfb_driver, omapfb_probe)) {
-		printk(KERN_ERR "failed to register omapfb driver\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static void __exit omapfb_exit(void)
-{
-	DBG("omapfb_exit\n");
-	platform_driver_unregister(&omapfb_driver);
-}
-
 module_param_named(mode, def_mode, charp, 0);
 module_param_named(vram, def_vram, charp, 0);
 module_param_named(rotate, def_rotate, int, 0);
 module_param_named(vrfb, def_vrfb, bool, 0);
 module_param_named(mirror, def_mirror, bool, 0);
 
-/* late_initcall to let panel/ctrl drivers loaded first.
- * I guess better option would be a more dynamic approach,
- * so that omapfb reacts to new panels when they are loaded */
-late_initcall(omapfb_init);
-/*module_init(omapfb_init);*/
-module_exit(omapfb_exit);
+module_platform_driver(omapfb_driver);
 
 MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
 MODULE_DESCRIPTION("OMAP2/3 Framebuffer");
-- 
1.7.10.4

