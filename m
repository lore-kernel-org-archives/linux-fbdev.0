From: Laurent Navet <laurent.navet@gmail.com>
Date: Tue, 14 May 2013 09:25:08 +0000
Subject: [PATCH] drivers: video: mxsfb: clean use of devm_ioremap_resource()
Message-Id: <1368523508-30967-1-git-send-email-laurent.navet@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>

Check of 'res' and calls to dev_err are already done in devm_ioremap_resource,
so no need to do them twice.

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/video/mxsfb.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 21223d4..0f3d0fc 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -884,9 +884,10 @@ static int mxsfb_probe(struct platform_device *pdev)
 		pdev->id_entry = of_id->data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Cannot get memory IO resource\n");
-		return -ENODEV;
+	host->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(host->base)) {
+		ret = PTR_ERR(host->base);
+		goto fb_release;
 	}
 
 	fb_info = framebuffer_alloc(sizeof(struct mxsfb_info), &pdev->dev);
@@ -897,13 +898,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 
 	host = to_imxfb_host(fb_info);
 
-	host->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(host->base)) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = PTR_ERR(host->base);
-		goto fb_release;
-	}
-
 	host->pdev = pdev;
 	platform_set_drvdata(pdev, host);
 
-- 
1.7.10.4

