From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Wed, 21 Nov 2012 19:48:52 +0000
Subject: [PATCH 2/2] OMAP: DSS: panel-n8x0: register the DSS driver after SPI probe
Message-Id: <1353527332-5216-2-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353527332-5216-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1353527332-5216-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Register the DSS driver after SPI probe. This simplifies the
initialization. This is similar to what is being done e.g.
in panel-acx565akm.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/video/omap2/displays/panel-n8x0.c |   39 +++++++----------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index 3fc5ad0..6cafdd4 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -702,18 +702,25 @@ static struct omap_dss_driver n8x0_panel_driver = {
 
 static int mipid_spi_probe(struct spi_device *spi)
 {
+	int r;
+
 	dev_dbg(&spi->dev, "mipid_spi_probe\n");
 
 	spi->mode = SPI_MODE_0;
 
 	s_drv_data.spidev = spi;
 
-	return 0;
+	r = omap_dss_register_driver(&n8x0_panel_driver);
+	if (r)
+		pr_err("n8x0_panel: dss driver registration failed\n");
+
+	return r;
 }
 
 static int mipid_spi_remove(struct spi_device *spi)
 {
 	dev_dbg(&spi->dev, "mipid_spi_remove\n");
+	omap_dss_unregister_driver(&n8x0_panel_driver);
 	return 0;
 }
 
@@ -725,34 +732,6 @@ static struct spi_driver mipid_spi_driver = {
 	.probe	= mipid_spi_probe,
 	.remove	= __devexit_p(mipid_spi_remove),
 };
+module_spi_driver(mipid_spi_driver);
 
-static int __init n8x0_panel_drv_init(void)
-{
-	int r;
-
-	r = spi_register_driver(&mipid_spi_driver);
-	if (r) {
-		pr_err("n8x0_panel: spi driver registration failed\n");
-		return r;
-	}
-
-	r = omap_dss_register_driver(&n8x0_panel_driver);
-	if (r) {
-		pr_err("n8x0_panel: dss driver registration failed\n");
-		spi_unregister_driver(&mipid_spi_driver);
-		return r;
-	}
-
-	return 0;
-}
-
-static void __exit n8x0_panel_drv_exit(void)
-{
-	spi_unregister_driver(&mipid_spi_driver);
-
-	omap_dss_unregister_driver(&n8x0_panel_driver);
-}
-
-module_init(n8x0_panel_drv_init);
-module_exit(n8x0_panel_drv_exit);
 MODULE_LICENSE("GPL");
-- 
1.7.10.4

