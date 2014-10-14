From: Felipe Balbi <balbi@ti.com>
Date: Tue, 14 Oct 2014 18:28:53 +0000
Subject: [PATCH 1/3] video: fbdev: omap2: omapfb: remove __exit annotation
Message-Id: <1413311335-25083-1-git-send-email-balbi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

if we leave __exit annotation, driver can't be unbound
through sysfs.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index ec2d132..9cbf1ce 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -2619,7 +2619,7 @@ err0:
 	return r;
 }
 
-static int __exit omapfb_remove(struct platform_device *pdev)
+static int omapfb_remove(struct platform_device *pdev)
 {
 	struct omapfb2_device *fbdev = platform_get_drvdata(pdev);
 
@@ -2636,7 +2636,7 @@ static int __exit omapfb_remove(struct platform_device *pdev)
 
 static struct platform_driver omapfb_driver = {
 	.probe		= omapfb_probe,
-	.remove         = __exit_p(omapfb_remove),
+	.remove         = omapfb_remove,
 	.driver         = {
 		.name   = "omapfb",
 		.owner  = THIS_MODULE,
-- 
2.1.0.GIT

