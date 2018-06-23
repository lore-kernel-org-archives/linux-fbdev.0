From: Daniel Mack <daniel@zonque.org>
Date: Sat, 23 Jun 2018 19:11:25 +0000
Subject: [PATCH 2/2] video: fbdev: pxa3xx_gcu: add devicetree bindings
Message-Id: <20180623191125.22965-2-daniel@zonque.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180623191125.22965-1-daniel@zonque.org>
In-Reply-To: <20180623191125.22965-1-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh+dt@kernel.org, airlied@linux.ie, mark.rutland@arm.com, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>

Add a device tree match table for this hardware graphics acceleration
driver so it can be used by pxa3xx boards booted with a devicetree.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 0955622a1227..3d987f4c06ad 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -44,6 +44,7 @@
 #include <linux/clk.h>
 #include <linux/fs.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include "pxa3xx-gcu.h"
 
@@ -703,11 +704,20 @@ static int pxa3xx_gcu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id pxa3xx_gcu_of_match[] = {
+	{ .compatible = "marvell,pxa3xx-gcu", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pxa3xx_gcu_of_match);
+#endif
+
 static struct platform_driver pxa3xx_gcu_driver = {
 	.probe	  = pxa3xx_gcu_probe,
 	.remove	 = pxa3xx_gcu_remove,
 	.driver	 = {
 		.name   = DRV_NAME,
+		.of_match_table = of_match_ptr(pxa3xx_gcu_of_match),
 	},
 };
 
-- 
2.17.1

