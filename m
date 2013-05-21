From: Laurent Navet <laurent.navet@gmail.com>
Date: Tue, 21 May 2013 12:33:49 +0000
Subject: [PATCH V2] drivers: video: mxsfb: clean use of devm_ioremap_resource()
Message-Id: <1369139629-20638-1-git-send-email-laurent.navet@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <19650694.136921368693687337.JavaMail.weblogic@epml12>
In-Reply-To: <19650694.136921368693687337.JavaMail.weblogic@epml12>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de, jg1.han@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>

Check of 'res' and calls to dev_err are already done in devm_ioremap_resource,
so no need to do them twice.

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/video/mxsfb.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 21223d4..6a1b338 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -883,12 +883,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (of_id)
 		pdev->id_entry = of_id->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Cannot get memory IO resource\n");
-		return -ENODEV;
-	}
-
 	fb_info = framebuffer_alloc(sizeof(struct mxsfb_info), &pdev->dev);
 	if (!fb_info) {
 		dev_err(&pdev->dev, "Failed to allocate fbdev\n");
@@ -897,9 +891,9 @@ static int mxsfb_probe(struct platform_device *pdev)
 
 	host = to_imxfb_host(fb_info);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(host->base)) {
-		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = PTR_ERR(host->base);
 		goto fb_release;
 	}
-- 
1.7.10.4

