From: Johan Hovold <jhovold@gmail.com>
Date: Mon, 23 Sep 2013 14:27:28 +0000
Subject: [PATCH 3/7] mtd: atmel_nand: fix deferred probe from __init
Message-Id: <1379946452-25649-4-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130923134028.GF21013@sirena.org.uk>
 <1379946452-25649-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1379946452-25649-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pcmcia-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Josh Wu <josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Move probe out of __init section and don't use platform_driver_probe
which cannot be used with deferred probing.

Since commit e9354576 ("gpiolib: Defer failed gpio requests by default")
this driver might return -EPROBE_DEFER if a gpio_request fails.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Wu <josh.wu@atmel.com>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/mtd/nand/atmel_nand.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index 060feea..bd1ce7d 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1139,7 +1139,7 @@ static int pmecc_choose_ecc(struct atmel_nand_host *host,
 	return 0;
 }
 
-static int __init atmel_pmecc_nand_init_params(struct platform_device *pdev,
+static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
 					 struct atmel_nand_host *host)
 {
 	struct mtd_info *mtd = &host->mtd;
@@ -1548,7 +1548,7 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 }
 #endif
 
-static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
+static int atmel_hw_nand_init_params(struct platform_device *pdev,
 					 struct atmel_nand_host *host)
 {
 	struct mtd_info *mtd = &host->mtd;
@@ -1987,7 +1987,7 @@ static struct platform_driver atmel_nand_nfc_driver;
 /*
  * Probe for the NAND device.
  */
-static int __init atmel_nand_probe(struct platform_device *pdev)
+static int atmel_nand_probe(struct platform_device *pdev)
 {
 	struct atmel_nand_host *host;
 	struct mtd_info *mtd;
@@ -2184,7 +2184,7 @@ err_nand_ioremap:
 /*
  * Remove a NAND device.
  */
-static int __exit atmel_nand_remove(struct platform_device *pdev)
+static int atmel_nand_remove(struct platform_device *pdev)
 {
 	struct atmel_nand_host *host = platform_get_drvdata(pdev);
 	struct mtd_info *mtd = &host->mtd;
@@ -2270,7 +2270,8 @@ static struct platform_driver atmel_nand_nfc_driver = {
 };
 
 static struct platform_driver atmel_nand_driver = {
-	.remove		= __exit_p(atmel_nand_remove),
+	.probe		= atmel_nand_probe,
+	.remove		= atmel_nand_remove,
 	.driver		= {
 		.name	= "atmel_nand",
 		.owner	= THIS_MODULE,
@@ -2278,7 +2279,7 @@ static struct platform_driver atmel_nand_driver = {
 	},
 };
 
-module_platform_driver_probe(atmel_nand_driver, atmel_nand_probe);
+module_platform_driver(atmel_nand_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Rick Bronson");
-- 
1.8.3.2

