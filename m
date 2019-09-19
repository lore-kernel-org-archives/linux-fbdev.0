From: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 19 Sep 2019 15:01:06 +0000
Subject: [PATCH] video: pxafb: Use devm_platform_ioremap_resource() in pxafb_probe()
Message-Id: <a1b804b1-43c2-327a-d6d1-df49aebec680@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Mack <daniel@zonque.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, YueHaibing <yuehaibing@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Himanshu Jha <himanshujha199640@gmail.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Sep 2019 16:51:38 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/pxafb.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index f70c9f79622e..237f8f436fdb 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2237,7 +2237,6 @@ static int pxafb_probe(struct platform_device *dev)
 {
 	struct pxafb_info *fbi;
 	struct pxafb_mach_info *inf, *pdata;
-	struct resource *r;
 	int i, irq, ret;

 	dev_dbg(&dev->dev, "pxafb_probe\n");
@@ -2303,14 +2302,7 @@ static int pxafb_probe(struct platform_device *dev)
 		fbi->lcd_supply = NULL;
 	}

-	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (r == NULL) {
-		dev_err(&dev->dev, "no I/O memory resource defined\n");
-		ret = -ENODEV;
-		goto failed;
-	}
-
-	fbi->mmio_base = devm_ioremap_resource(&dev->dev, r);
+	fbi->mmio_base = devm_platform_ioremap_resource(dev, 0);
 	if (IS_ERR(fbi->mmio_base)) {
 		dev_err(&dev->dev, "failed to get I/O memory\n");
 		ret = -EBUSY;
--
2.23.0
