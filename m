From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 16 Oct 2014 09:39:44 +0000
Subject: [PATCH 2/5] OMAPFB: remove wrong __exit and __exit_p()
Message-Id: <1413452387-25452-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1413452387-25452-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb device can be unbound, so using __exit_p() for the driver's
remove callback is wrong.

Remove __exit_p() and __exit from the driver's remove.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index ec2d132c782d..9cbf1ced51c2 100644
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
2.1.1

