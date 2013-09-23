From: Johan Hovold <jhovold@gmail.com>
Date: Mon, 23 Sep 2013 14:27:30 +0000
Subject: [PATCH 5/7] usb: gadget: pxa25x_udc: fix deferred probe from __init
Message-Id: <1379946452-25649-6-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130923134028.GF21013@sirena.org.uk>
 <1379946452-25649-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1379946452-25649-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pcmcia-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Move probe out of __init section and don't use platform_driver_probe
which cannot be used with deferred probing.

Since commit e9354576 ("gpiolib: Defer failed gpio requests by default")
this driver might return -EPROBE_DEFER if a gpio_request fails.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/usb/gadget/pxa25x_udc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index cc92074..0ac6064 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -2054,7 +2054,7 @@ static struct pxa25x_udc memory = {
 /*
  *	probe - binds to the platform device
  */
-static int __init pxa25x_udc_probe(struct platform_device *pdev)
+static int pxa25x_udc_probe(struct platform_device *pdev)
 {
 	struct pxa25x_udc *dev = &memory;
 	int retval, irq;
@@ -2203,7 +2203,7 @@ static void pxa25x_udc_shutdown(struct platform_device *_dev)
 	pullup_off();
 }
 
-static int __exit pxa25x_udc_remove(struct platform_device *pdev)
+static int pxa25x_udc_remove(struct platform_device *pdev)
 {
 	struct pxa25x_udc *dev = platform_get_drvdata(pdev);
 
@@ -2294,7 +2294,8 @@ static int pxa25x_udc_resume(struct platform_device *dev)
 
 static struct platform_driver udc_driver = {
 	.shutdown	= pxa25x_udc_shutdown,
-	.remove		= __exit_p(pxa25x_udc_remove),
+	.probe		= pxa25x_udc_probe,
+	.remove		= pxa25x_udc_remove,
 	.suspend	= pxa25x_udc_suspend,
 	.resume		= pxa25x_udc_resume,
 	.driver		= {
@@ -2303,7 +2304,7 @@ static struct platform_driver udc_driver = {
 	},
 };
 
-module_platform_driver_probe(udc_driver, pxa25x_udc_probe);
+module_platform_driver(udc_driver);
 
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_AUTHOR("Frank Becker, Robert Schwebel, David Brownell");
-- 
1.8.3.2

