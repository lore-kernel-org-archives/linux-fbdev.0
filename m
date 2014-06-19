From: Michael Welling <mwelling@ieee.org>
Date: Thu, 19 Jun 2014 01:52:12 +0000
Subject: [PATCH] drivers:video:fbdev atmel_lcdfb.c power GPIO registration bug
Message-Id: <1403142732-31706-1-git-send-email-mwelling@ieee.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>

A list that was intended for storing power control GPIOs was never
initialized correctly or filled. Without these lines of added code
the kernel hangs when trying to access an uninitialized list when a
power control GPIO is registered with the device tree.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/video/fbdev/atmel_lcdfb.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index e683b6e..d36e830 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1057,6 +1057,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 		goto put_display_node;
 	}
 
+	INIT_LIST_HEAD(&pdata->pwr_gpios);
 	ret = -ENOMEM;
 	for (i = 0; i < of_gpio_named_count(display_np, "atmel,power-control-gpio"); i++) {
 		gpio = of_get_named_gpio_flags(display_np, "atmel,power-control-gpio",
@@ -1082,6 +1083,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 			dev_err(dev, "set direction output gpio %d failed\n", gpio);
 			goto put_display_node;
 		}
+		list_add(&og->list, &pdata->pwr_gpios);
 	}
 
 	if (is_gpio_power)
-- 
1.7.9.5

