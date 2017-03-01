From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 01 Mar 2017 23:31:09 +0000
Subject: [PATCH] video: fbdev: pmag-aa-fb: remove incorrect __exit markups
Message-Id: <20170301233109.GA8563@dtor-ws>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Even if bus is not hot-pluggable, devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe() which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/fbdev/pmag-aa-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pmag-aa-fb.c b/drivers/video/fbdev/pmag-aa-fb.c
index ffe2dd482f84..39922f072db4 100644
--- a/drivers/video/fbdev/pmag-aa-fb.c
+++ b/drivers/video/fbdev/pmag-aa-fb.c
@@ -247,7 +247,7 @@ static int pmagaafb_probe(struct device *dev)
 	return err;
 }
 
-static int __exit pmagaafb_remove(struct device *dev)
+static int pmagaafb_remove(struct device *dev)
 {
 	struct tc_dev *tdev = to_tc_dev(dev);
 	struct fb_info *info = dev_get_drvdata(dev);
@@ -280,7 +280,7 @@ static struct tc_driver pmagaafb_driver = {
 		.name	= "pmagaafb",
 		.bus	= &tc_bus_type,
 		.probe	= pmagaafb_probe,
-		.remove	= __exit_p(pmagaafb_remove),
+		.remove	= pmagaafb_remove,
 	},
 };
 
-- 
2.12.0.rc1.440.g5b76565f74-goog


-- 
Dmitry
