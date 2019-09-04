From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 04 Sep 2019 11:55:23 +0000
Subject: [PATCH -next] fbdev: s3c-fb: use devm_platform_ioremap_resource() to simplify code
Message-Id: <20190904115523.25068-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jingoohan1@gmail.com, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/s3c-fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index ba04d7a..43ac8d7 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1411,8 +1411,7 @@ static int s3c_fb_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(sfb->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sfb->regs = devm_ioremap_resource(dev, res);
+	sfb->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sfb->regs)) {
 		ret = PTR_ERR(sfb->regs);
 		goto err_lcd_clk;
-- 
2.7.4
