From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 25 Feb 2017 19:24:46 +0000
Subject: [PATCH] video: fbdev: pmag-ba-fb: remove incorrect __exit markups
Message-Id: <20170225192446.GA12502@dtor-ws>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Even if bus is not hot-pluggable, the devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe() which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/fbdev/pmag-ba-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pmag-ba-fb.c b/drivers/video/fbdev/pmag-ba-fb.c
index 5872bc4af3ce..f49317f137ec 100644
--- a/drivers/video/fbdev/pmag-ba-fb.c
+++ b/drivers/video/fbdev/pmag-ba-fb.c
@@ -235,7 +235,7 @@ static int pmagbafb_probe(struct device *dev)
 	return err;
 }
 
-static int __exit pmagbafb_remove(struct device *dev)
+static int pmagbafb_remove(struct device *dev)
 {
 	struct tc_dev *tdev = to_tc_dev(dev);
 	struct fb_info *info = dev_get_drvdata(dev);
@@ -270,7 +270,7 @@ static struct tc_driver pmagbafb_driver = {
 		.name	= "pmagbafb",
 		.bus	= &tc_bus_type,
 		.probe	= pmagbafb_probe,
-		.remove	= __exit_p(pmagbafb_remove),
+		.remove	= pmagbafb_remove,
 	},
 };
 
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
