From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 04 Mar 2013 08:52:40 +0000
Subject: [PATCH 1/1] video: exynos_mipi_dsi: Convert to devm_ioremap_resource()
Message-Id: <1362386440-17078-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Donghwa Lee <dh09.lee@samsung.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/exynos/exynos_mipi_dsi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index fac7df6..87cd13b 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -32,6 +32,7 @@
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/err.h>
 
 #include <video/exynos_mipi_dsim.h>
 
@@ -384,10 +385,9 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	dsim->reg_base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!dsim->reg_base) {
-		dev_err(&pdev->dev, "failed to remap io region\n");
-		ret = -ENOMEM;
+	dsim->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dsim->reg_base)) {
+		ret = PTR_ERR(dsim->reg_base);
 		goto error;
 	}
 
-- 
1.7.4.1

