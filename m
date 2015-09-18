From: Luis de Bethencourt <luis@debethencourt.com>
Date: Fri, 18 Sep 2015 18:46:09 +0000
Subject: [PATCH] video: fbdev: mb862xx: Fix module autoload for OF platform driver
Message-Id: <20150918184609.GA32729@goodgumbo.baconseed.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Wolfram Sang <wsa@the-dreams.de>, linux-fbdev@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hello,

This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index 9b8bebd..f9ec5c0 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -831,6 +831,7 @@ static struct of_device_id of_platform_mb862xx_tbl[] = {
 	{ .compatible = "fujitsu,coral", },
 	{ /* end */ }
 };
+MODULE_DEVICE_TABLE(of, of_platform_mb862xx_tbl);
 
 static struct platform_driver of_platform_mb862xxfb_driver = {
 	.driver = {
-- 
2.4.6

