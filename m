From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 25 Feb 2017 19:25:11 +0000
Subject: [PATCH] video: fbdev: pmagb-b-fb: remove incorrect __exit markups
Message-Id: <20170225192511.GA12591@dtor-ws>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Even if bus is not hot-pluggable, the devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe() which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/fbdev/pmagb-b-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pmagb-b-fb.c b/drivers/video/fbdev/pmagb-b-fb.c
index 0822b6f8dddc..2ae88b4e86b0 100644
--- a/drivers/video/fbdev/pmagb-b-fb.c
+++ b/drivers/video/fbdev/pmagb-b-fb.c
@@ -353,7 +353,7 @@ static int pmagbbfb_probe(struct device *dev)
 	return err;
 }
 
-static int __exit pmagbbfb_remove(struct device *dev)
+static int pmagbbfb_remove(struct device *dev)
 {
 	struct tc_dev *tdev = to_tc_dev(dev);
 	struct fb_info *info = dev_get_drvdata(dev);
@@ -388,7 +388,7 @@ static struct tc_driver pmagbbfb_driver = {
 		.name	= "pmagbbfb",
 		.bus	= &tc_bus_type,
 		.probe	= pmagbbfb_probe,
-		.remove	= __exit_p(pmagbbfb_remove),
+		.remove	= pmagbbfb_remove,
 	},
 };
 
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
