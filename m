From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Thu, 31 Jan 2013 10:37:37 +0000
Subject: [PATCH 1/3] video: exynos_mipi_dsi: Convert to devm_ioremap_resource()
Message-Id: <1359627939-2685-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: thierry.reding@avionic-design.de, gregkh@linuxfoundation.org, sachin.kamat@linaro.org, Donghwa Lee <dh09.lee@samsung.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Donghwa Lee <dh09.lee@samsung.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/exynos/exynos_mipi_dsi.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index fac7df6..a29715f 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -32,6 +32,7 @@
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/err.h>
 
 #include <video/exynos_mipi_dsim.h>
 
@@ -384,10 +385,10 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	dsim->reg_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!dsim->reg_base) {
+	dsim->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dsim->reg_base)) {
 		dev_err(&pdev->dev, "failed to remap io region\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(dsim->reg_base);
 		goto error;
 	}
 
-- 
1.7.4.1

