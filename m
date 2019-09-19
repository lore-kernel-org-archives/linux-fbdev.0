From: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 19 Sep 2019 14:33:25 +0000
Subject: [PATCH] video: ocfb: Use devm_platform_ioremap_resource() in ocfb_probe()
Message-Id: <61b75aa6-ff92-e0ed-53f2-50a95d93d1f6@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Himanshu Jha <himanshujha199640@gmail.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Sep 2019 16:26:56 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/ocfb.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/ocfb.c b/drivers/video/fbdev/ocfb.c
index a970edc2a6f8..be308b4dc91d 100644
--- a/drivers/video/fbdev/ocfb.c
+++ b/drivers/video/fbdev/ocfb.c
@@ -297,7 +297,6 @@ static int ocfb_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct ocfb_dev *fbdev;
-	struct resource *res;
 	int fbsize;

 	fbdev = devm_kzalloc(&pdev->dev, sizeof(*fbdev), GFP_KERNEL);
@@ -319,13 +318,7 @@ static int ocfb_probe(struct platform_device *pdev)
 	ocfb_init_var(fbdev);
 	ocfb_init_fix(fbdev);

-	/* Request I/O resource */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "I/O resource request failed\n");
-		return -ENXIO;
-	}
-	fbdev->regs = devm_ioremap_resource(&pdev->dev, res);
+	fbdev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fbdev->regs))
 		return PTR_ERR(fbdev->regs);

--
2.23.0
