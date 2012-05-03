From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 03 May 2012 13:57:55 +0000
Subject: [PATCH 19/25] OMAPFB: add __init & __exit
Message-Id: <1336053481-25433-20-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Change omapfb to use platform_driver_probe and add __init & __exit.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index b00db40..a0967dc 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2307,7 +2307,7 @@ static int omapfb_init_display(struct omapfb2_device *fbdev,
 	return 0;
 }
 
-static int omapfb_probe(struct platform_device *pdev)
+static int __init omapfb_probe(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = NULL;
 	int r = 0;
@@ -2448,7 +2448,7 @@ err0:
 	return r;
 }
 
-static int omapfb_remove(struct platform_device *pdev)
+static int __exit omapfb_remove(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = platform_get_drvdata(pdev);
 
@@ -2462,8 +2462,7 @@ static int omapfb_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omapfb_driver = {
-	.probe          = omapfb_probe,
-	.remove         = omapfb_remove,
+	.remove         = __exit_p(omapfb_remove),
 	.driver         = {
 		.name   = "omapfb",
 		.owner  = THIS_MODULE,
@@ -2474,7 +2473,7 @@ static int __init omapfb_init(void)
 {
 	DBG("omapfb_init\n");
 
-	if (platform_driver_register(&omapfb_driver)) {
+	if (platform_driver_probe(&omapfb_driver, omapfb_probe)) {
 		printk(KERN_ERR "failed to register omapfb driver\n");
 		return -ENODEV;
 	}
-- 
1.7.9.5

