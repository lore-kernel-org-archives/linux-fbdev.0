From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 04 Sep 2019 11:57:54 +0000
Subject: [PATCH -next] fbdev/sa1100fb: use devm_platform_ioremap_resource() to simplify code
Message-Id: <20190904115754.21612-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, maarten.lankhorst@linux.intel.com, daniel.vetter@ffwll.ch, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com, yuehaibing@huawei.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/sa1100fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index ae2bcfe..4428cef 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1156,7 +1156,6 @@ static struct sa1100fb_info *sa1100fb_init_fbinfo(struct device *dev)
 static int sa1100fb_probe(struct platform_device *pdev)
 {
 	struct sa1100fb_info *fbi;
-	struct resource *res;
 	int ret, irq;
 
 	if (!dev_get_platdata(&pdev->dev)) {
@@ -1172,8 +1171,7 @@ static int sa1100fb_probe(struct platform_device *pdev)
 	if (!fbi)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fbi->base = devm_ioremap_resource(&pdev->dev, res);
+	fbi->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fbi->base))
 		return PTR_ERR(fbi->base);
 
-- 
2.7.4
