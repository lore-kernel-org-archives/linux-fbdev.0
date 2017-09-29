From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Fri, 29 Sep 2017 10:51:07 +0000
Subject: [PATCH 3/8] video: sa1100fb: use devm_ioremap_resource()
Message-Id: <E1dxsst-0006j1-2Y@rmk-PC.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170929105004.GY20805@n2100.armlinux.org.uk>
In-Reply-To: <20170929105004.GY20805@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use devm_ioremap_resource() to map the LCD controller memory region,
and remove the unnecessary cleanup for this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/video/fbdev/sa1100fb.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 1562d7607dd2..ab83970dbfd9 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1217,29 +1217,28 @@ static int sa1100fb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0 || !res)
+	if (irq < 0)
 		return -EINVAL;
 
-	if (!request_mem_region(res->start, resource_size(res), "LCD"))
-		return -EBUSY;
-
 	fbi = sa1100fb_init_fbinfo(&pdev->dev);
 	ret = -ENOMEM;
 	if (!fbi)
 		goto failed;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	fbi->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(fbi->base)) {
+		ret = PTR_ERR(fbi->base);
+		goto failed;
+	}
+
 	fbi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(fbi->clk)) {
 		ret = PTR_ERR(fbi->clk);
 		goto failed;
 	}
 
-	fbi->base = ioremap(res->start, resource_size(res));
-	if (!fbi->base)
-		goto failed;
-
 	/* Initialize video memory */
 	ret = sa1100fb_map_video_memory(fbi);
 	if (ret)
@@ -1286,9 +1285,6 @@ static int sa1100fb_probe(struct platform_device *pdev)
  err_free_irq:
 	free_irq(irq, fbi);
  failed:
-	if (fbi)
-		iounmap(fbi->base);
-	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
 
-- 
2.7.4

