From: Andrei Epure <epure.andrei@gmail.com>
Date: Wed, 27 Mar 2013 20:28:01 +0000
Subject: [PATCH] video: exynos: Convert to devm_ioremap_resource()
Message-Id: <1364416081-24113-1-git-send-email-epure.andrei@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: inki.dae@samsung.com, dh09.lee@samsung.com, kyungmin.park@samsung.com, FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrei Epure <epure.andrei@gmail.com>

The new devm_ioremap_resource() provides its own error messages.
Patch found using coccinelle.

Signed-off-by: Andrei Epure <epure.andrei@gmail.com>
---
 drivers/video/exynos/exynos_mipi_dsi.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index fac7df6..dd5e5e9 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -384,10 +384,9 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 
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
1.7.9.5

