From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:55:01 +0000
Subject: [PATCH 24/26] Staging: fbtft: fb_tls8204: Switch to the gpio descriptor interface
Message-Id: <413693a296f8f890731369ccd755081466f81df7.1543142441.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the fb_tls8204.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_tls8204.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_tls8204.c b/drivers/staging/fbtft/fb_tls8204.c
index 277b6ed9c725..bec6dd0ffb01 100644
--- a/drivers/staging/fbtft/fb_tls8204.c
+++ b/drivers/staging/fbtft/fb_tls8204.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -94,7 +94,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 		/* The display is 102x68 but the LCD is 84x48.
 		 * Set the write pointer at the start of each row.
 		 */
-		gpio_set_value(par->gpio.dc, 0);
+		gpiod_set_value(par->gpio.dc, 0);
 		write_reg(par, 0x80 | 0);
 		write_reg(par, 0x40 | y);
 
@@ -109,7 +109,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			*buf++ = ch;
 		}
 		/* Write the row */
-		gpio_set_value(par->gpio.dc, 1);
+		gpiod_set_value(par->gpio.dc, 1);
 		ret = par->fbtftops.write(par, par->txbuf.buf, WIDTH);
 		if (ret < 0) {
 			dev_err(par->info->device,
-- 
2.17.1
