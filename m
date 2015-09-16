From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Wed, 16 Sep 2015 09:12:34 +0000
Subject: [RESEND PATCH] OMAPDSS: panel-sony-acx565akm: Export OF module alias information
Message-Id: <1442394754-14058-1-git-send-email-javier@osg.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

Drivers needs to export the OF id table and this be built into
the module or udev won't have the necessary information to autoload
the driver module when the device is registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
index 90cbc4c3406c..c581231c74a5 100644
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
2.4.3

