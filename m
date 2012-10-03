From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Wed, 03 Oct 2012 12:40:44 +0000
Subject: [PATCH 2/2] drivers/video/exynos/exynos_mipi_dsi.c: fix error return code
Message-Id: <1349268044-32616-2-git-send-email-peter.senna@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Inki Dae <inki.dae@samsung.com>
Cc: kernel-janitors@vger.kernel.org, Donghwa Lee <dh09.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Peter Senna Tschudin <peter.senna@gmail.com>

Convert a nonnegative error return code to a negative one, as returned
elsewhere in the function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>


Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>

---
 drivers/video/exynos/exynos_mipi_dsi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index c4f25de..07d70a3 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -375,6 +375,7 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 	dsim->clock = clk_get(&pdev->dev, "dsim0");
 	if (IS_ERR(dsim->clock)) {
 		dev_err(&pdev->dev, "failed to get dsim clock source\n");
+		ret = -ENODEV;
 		goto err_clock_get;
 	}
 
@@ -383,6 +384,7 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "failed to get io memory region\n");
+		ret = -ENODEV;
 		goto err_platform_get;
 	}
 
@@ -407,6 +409,7 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 	dsim_ddi = exynos_mipi_dsi_bind_lcd_ddi(dsim, dsim_pd->lcd_panel_name);
 	if (!dsim_ddi) {
 		dev_err(&pdev->dev, "mipi_dsim_ddi object not found.\n");
+		ret = -EINVAL;
 		goto err_bind;
 	}
 

