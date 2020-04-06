From: Tang Bin <tangbin@cmss.chinamobile.com>
Date: Mon, 06 Apr 2020 05:34:50 +0000
Subject: [PATCH] video: fbdev: don't print error message on platform_get_irq() failure
Message-Id: <20200406053450.8380-1-tangbin@cmss.chinamobile.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tang Bin <tangbin@cmss.chinamobile.com>

The platform_get_irq() can print error message,so remove the redundant
dev_err() here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index d567f5d56..1e2521925 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1114,7 +1114,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 
 	sinfo->irq_base = platform_get_irq(pdev, 0);
 	if (sinfo->irq_base < 0) {
-		dev_err(dev, "unable to get irq\n");
 		ret = sinfo->irq_base;
 		goto stop_clk;
 	}
-- 
2.20.1.windows.1
