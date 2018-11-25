From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:37:31 +0000
Subject: [PATCH 03/26] Staging: fbtft: fbtft-io: Switch to the gpio descriptor interface
Message-Id: <7f743e900391226084fc4f29a2a73e0231b6fe55.1543142440.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the fbtft-io to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fbtft-io.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
index b5051d3d46a6..38cdad6203ea 100644
--- a/drivers/staging/fbtft/fbtft-io.c
+++ b/drivers/staging/fbtft/fbtft-io.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/export.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include "fbtft.h"
 
@@ -142,30 +142,30 @@ int fbtft_write_gpio8_wr(struct fbtft_par *par, void *buf, size_t len)
 		data = *(u8 *)buf;
 
 		/* Start writing by pulling down /WR */
-		gpio_set_value(par->gpio.wr, 0);
+		gpiod_set_value(par->gpio.wr, 0);
 
 		/* Set data */
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		if (data = prev_data) {
-			gpio_set_value(par->gpio.wr, 0); /* used as delay */
+			gpiod_set_value(par->gpio.wr, 0); /* used as delay */
 		} else {
 			for (i = 0; i < 8; i++) {
 				if ((data & 1) != (prev_data & 1))
-					gpio_set_value(par->gpio.db[i],
-						       data & 1);
+					gpiod_set_value(par->gpio.db[i],
+							data & 1);
 				data >>= 1;
 				prev_data >>= 1;
 			}
 		}
 #else
 		for (i = 0; i < 8; i++) {
-			gpio_set_value(par->gpio.db[i], data & 1);
+			gpiod_set_value(par->gpio.db[i], data & 1);
 			data >>= 1;
 		}
 #endif
 
 		/* Pullup /WR */
-		gpio_set_value(par->gpio.wr, 1);
+		gpiod_set_value(par->gpio.wr, 1);
 
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		prev_data = *(u8 *)buf;
@@ -192,30 +192,30 @@ int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len)
 		data = *(u16 *)buf;
 
 		/* Start writing by pulling down /WR */
-		gpio_set_value(par->gpio.wr, 0);
+		gpiod_set_value(par->gpio.wr, 0);
 
 		/* Set data */
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		if (data = prev_data) {
-			gpio_set_value(par->gpio.wr, 0); /* used as delay */
+			gpiod_set_value(par->gpio.wr, 0); /* used as delay */
 		} else {
 			for (i = 0; i < 16; i++) {
 				if ((data & 1) != (prev_data & 1))
-					gpio_set_value(par->gpio.db[i],
-						       data & 1);
+					gpiod_set_value(par->gpio.db[i],
+							data & 1);
 				data >>= 1;
 				prev_data >>= 1;
 			}
 		}
 #else
 		for (i = 0; i < 16; i++) {
-			gpio_set_value(par->gpio.db[i], data & 1);
+			gpiod_set_value(par->gpio.db[i], data & 1);
 			data >>= 1;
 		}
 #endif
 
 		/* Pullup /WR */
-		gpio_set_value(par->gpio.wr, 1);
+		gpiod_set_value(par->gpio.wr, 1);
 
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		prev_data = *(u16 *)buf;
-- 
2.17.1
