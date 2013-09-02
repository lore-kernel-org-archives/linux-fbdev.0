From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 02 Sep 2013 01:33:22 +0000
Subject: [PATCH] video: xilinxfb: use devm_ioremap_resource() instead of devm_request_and_ioremap()
Message-Id: <005401cea77c$6925eec0$3b71cc40$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use devm_ioremap_resource() because devm_request_and_ioremap() is
obsoleted by devm_ioremap_resource().

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/xilinxfb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 6629b29..ed90051 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -260,9 +260,9 @@ static int xilinxfb_assign(struct platform_device *pdev,
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		drvdata->regs_phys = res->start;
-		drvdata->regs = devm_request_and_ioremap(&pdev->dev, res);
-		if (!drvdata->regs) {
-			rc = -EADDRNOTAVAIL;
+		drvdata->regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(drvdata->regs)) {
+			rc = PTR_ERR(drvdata->regs);
 			goto err_region;
 		}
 	}
-- 
1.7.10.4


