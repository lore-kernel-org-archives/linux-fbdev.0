From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:41:50 +0000
Subject: [PATCH 08/26] Staging: fbtft: fb_uc1611: Switch to the gpio descriptor interface
Message-Id: <d82350e345de07d6dee448a3199cfa0f0b568171.1543142441.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the fb_uc1611.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_uc1611.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_uc1611.c b/drivers/staging/fbtft/fb_uc1611.c
index dfaf8bc70f73..65681d0fe200 100644
--- a/drivers/staging/fbtft/fb_uc1611.c
+++ b/drivers/staging/fbtft/fb_uc1611.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -251,7 +251,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 			}
 			break;
 		}
-		gpio_set_value(par->gpio.dc, 1);
+		gpiod_set_value(par->gpio.dc, 1);
 
 		/* Write data */
 		ret = par->fbtftops.write(par, par->txbuf.buf, len / 2);
-- 
2.17.1
