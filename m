From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:33 +0000
Subject: [PATCH 05/23] OMAPDSS: tpd12s015: CT_CP_HPD as optional gpio
Message-Id: <1449676791-26304-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Manisha Agrawal <manisha.agrawal@ti.com>

tpd12s015 HW has LS_OE, CT_CP_HPD and HPD gpios. Out of these gpios,
driver only handled LS_OE as optional. The CT_CP_HPD gpio should also
be treated as optional gpio as it is just a power saving feature. Some
boards hardwire this gpio to be always enable. In this patch, all access
to CT_CP_HPD gpio is made optional.

Signed-off-by: Manisha Agrawal <manisha.agrawal@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
index 93f95eaeadad..45a0b8e8d320 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
@@ -46,9 +46,11 @@ static int tpd_connect(struct omap_dss_device *dssdev,
 	dst->src = dssdev;
 	dssdev->dst = dst;
 
-	gpiod_set_value_cansleep(ddata->ct_cp_hpd_gpio, 1);
-	/* DC-DC converter needs at max 300us to get to 90% of 5V */
-	udelay(300);
+	if (ddata->ct_cp_hpd_gpio) {
+		gpiod_set_value_cansleep(ddata->ct_cp_hpd_gpio, 1);
+		/* DC-DC converter needs at max 300us to get to 90% of 5V */
+		udelay(300);
+	}
 
 	return 0;
 }
@@ -64,7 +66,8 @@ static void tpd_disconnect(struct omap_dss_device *dssdev,
 	if (dst != dssdev->dst)
 		return;
 
-	gpiod_set_value_cansleep(ddata->ct_cp_hpd_gpio, 0);
+	if (ddata->ct_cp_hpd_gpio)
+		gpiod_set_value_cansleep(ddata->ct_cp_hpd_gpio, 0);
 
 	dst->src = NULL;
 	dssdev->dst = NULL;
@@ -240,7 +243,7 @@ static int tpd_probe(struct platform_device *pdev)
 	}
 
 
-	gpio = devm_gpiod_get_index(&pdev->dev, NULL, 0,
+	gpio = devm_gpiod_get_index_optional(&pdev->dev, NULL, 0,
 		GPIOD_OUT_LOW);
 	if (IS_ERR(gpio))
 		goto err_gpio;
-- 
2.5.0

