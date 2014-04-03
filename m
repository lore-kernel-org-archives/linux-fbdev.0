From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 03 Apr 2014 00:09:48 +0000
Subject: [PATCH] video: pxa3xx-gcu: use devm_ioremap_resource()
Message-Id: <001c01cf4ed1$07117630$15346290$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use devm_ioremap_resource() because devm_request_and_ioremap() is
obsoleted by devm_ioremap_resource().

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Cc: Daniel Mack <zonque@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 417f9a2..dd8bc18 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -612,7 +612,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 	/* handle IO resources */
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->mmio_base = devm_request_and_ioremap(dev, r);
+	priv->mmio_base = devm_ioremap_resource(dev, r);
 	if (IS_ERR(priv->mmio_base)) {
 		dev_err(dev, "failed to map I/O memory\n");
 		return PTR_ERR(priv->mmio_base);
-- 
1.7.10.4


