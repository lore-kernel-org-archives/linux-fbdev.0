From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 08 Apr 2014 04:53:10 +0000
Subject: [PATCH V2] video: pxa3xx-gcu: use devm_ioremap_resource()
Message-Id: <008201cf52e6$7314ea60$593ebf20$%han@samsung.com>
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
Changes since v1:
- remove unnecessary error message, because devm_ioremap_resource()
  already prints one in all failure cases.

 drivers/video/fbdev/pxa3xx-gcu.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 417f9a2..4df3657 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -612,11 +612,9 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 	/* handle IO resources */
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->mmio_base = devm_request_and_ioremap(dev, r);
-	if (IS_ERR(priv->mmio_base)) {
-		dev_err(dev, "failed to map I/O memory\n");
+	priv->mmio_base = devm_ioremap_resource(dev, r);
+	if (IS_ERR(priv->mmio_base))
 		return PTR_ERR(priv->mmio_base);
-	}
 
 	/* enable the clock */
 	priv->clk = devm_clk_get(dev, NULL);
-- 
1.7.10.4


