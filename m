From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 04 Sep 2019 11:54:06 +0000
Subject: [PATCH -next] fbdev: omapfb: use devm_platform_ioremap_resource() to simplify code
Message-Id: <20190904115406.23880-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tglx@linutronix.de, alexios.zavras@intel.com, gregkh@linuxfoundation.org, allison@lohutok.net, yuehaibing@huawei.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/omap2/omapfb/vrfb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/vrfb.c b/drivers/video/fbdev/omap2/omapfb/vrfb.c
index 819e0bc..ee0dd4c 100644
--- a/drivers/video/fbdev/omap2/omapfb/vrfb.c
+++ b/drivers/video/fbdev/omap2/omapfb/vrfb.c
@@ -339,9 +339,7 @@ static int __init vrfb_probe(struct platform_device *pdev)
 	int i;
 
 	/* first resource is the register res, the rest are vrfb contexts */
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	vrfb_base = devm_ioremap_resource(&pdev->dev, mem);
+	vrfb_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vrfb_base))
 		return PTR_ERR(vrfb_base);
 
-- 
2.7.4
