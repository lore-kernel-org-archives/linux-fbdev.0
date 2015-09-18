From: Luis de Bethencourt <luis@debethencourt.com>
Date: Fri, 18 Sep 2015 18:44:57 +0000
Subject: [PATCH] omapdss: acx565akm: Fix module autoload for OF platform driver
Message-Id: <20150918184457.GA32636@goodgumbo.baconseed.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

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

 drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
index 90cbc4c..c581231 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
@@ -898,6 +898,7 @@ static const struct of_device_id acx565akm_of_match[] = {
 	{ .compatible = "omapdss,sony,acx565akm", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, acx565akm_of_match);
 
 static struct spi_driver acx565akm_driver = {
 	.driver = {
-- 
2.4.6

