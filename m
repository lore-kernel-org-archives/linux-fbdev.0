From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 19 Aug 2013 11:20:40 +0000
Subject: [PATCH 6/7] video: xilinxfb: replace devm_request_and_ioremap by devm_ioremap_resource
Message-Id: <1376911241-27720-7-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376911241-27720-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1376911241-27720-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Use devm_ioremap_resource instead of devm_request_and_ioremap.

This was done using the semantic patch
scripts/coccinelle/api/devm_ioremap_resource.cocci

The initialization of drvdata->regs_phys was manually moved lower, to take
advantage of the NULL test on res performed by devm_ioremap_resource.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/xilinxfb.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 6629b29..84c664e 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -259,12 +259,12 @@ static int xilinxfb_assign(struct platform_device *pdev,
 		struct resource *res;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		drvdata->regs_phys = res->start;
-		drvdata->regs = devm_request_and_ioremap(&pdev->dev, res);
-		if (!drvdata->regs) {
-			rc = -EADDRNOTAVAIL;
+		drvdata->regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(drvdata->regs)) {
+			rc = PTR_ERR(drvdata->regs);
 			goto err_region;
 		}
+		drvdata->regs_phys = res->start;
 	}
 
 	/* Allocate the framebuffer memory */

