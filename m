From: Andrzej Hajda <a.hajda@samsung.com>
Date: Mon, 15 Feb 2016 14:35:24 +0000
Subject: [PATCH 6/7] fbdev: exynos: fix IS_ERR_VALUE usage
Message-Id: <1455546925-22119-7-git-send-email-a.hajda@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Donghwa Lee <dh09.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org

IS_ERR_VALUE macro should be used only with unsigned long type.
For signed types comparison 'ret < 0' should be used.

The patch follows conclusion from discussion on LKML [1][2].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2120927
[2]: http://permalink.gmane.org/gmane.linux.kernel/2150581

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/video/fbdev/exynos/exynos_mipi_dsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/exynos/exynos_mipi_dsi.c b/drivers/video/fbdev/exynos/exynos_mipi_dsi.c
index b527fe4..951b592 100644
--- a/drivers/video/fbdev/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/fbdev/exynos/exynos_mipi_dsi.c
@@ -402,12 +402,12 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	dsim->irq = platform_get_irq(pdev, 0);
-	if (IS_ERR_VALUE(dsim->irq)) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request dsim irq resource\n");
-		ret = -EINVAL;
 		goto error;
 	}
+	dsim->irq = ret;
 
 	init_completion(&dsim_wr_comp);
 	init_completion(&dsim_rd_comp);
-- 
1.9.1

