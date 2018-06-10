From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 10 Jun 2018 14:24:13 +0000
Subject: [PATCH] omapfb: encoder-tpd12s015: fix error return code
Message-Id: <1528640655-18948-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

Return an error code on failure.

Problem found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c |   12 +++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
index 80dc473..2b58bfc 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
@@ -240,22 +240,28 @@ static int tpd_probe(struct platform_device *pdev)
 
 	gpio = devm_gpiod_get_index_optional(&pdev->dev, NULL, 0,
 		GPIOD_OUT_LOW);
-	if (IS_ERR(gpio))
+	if (IS_ERR(gpio)) {
+		r = PTR_ERR(gpio);
 		goto err_gpio;
+	}
 
 	ddata->ct_cp_hpd_gpio = gpio;
 
 	gpio = devm_gpiod_get_index_optional(&pdev->dev, NULL, 1,
 		GPIOD_OUT_LOW);
-	if (IS_ERR(gpio))
+	if (IS_ERR(gpio)) {
+		r = PTR_ERR(gpio);
 		goto err_gpio;
+	}
 
 	ddata->ls_oe_gpio = gpio;
 
 	gpio = devm_gpiod_get_index(&pdev->dev, NULL, 2,
 		GPIOD_IN);
-	if (IS_ERR(gpio))
+	if (IS_ERR(gpio)) {
+		r = PTR_ERR(gpio);
 		goto err_gpio;
+	}
 
 	ddata->hpd_gpio = gpio;
 

