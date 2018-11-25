From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:49:45 +0000
Subject: [PATCH 17/26] Staging: fbtft: fb_ssd1306: Switch to the gpio descriptor interface
Message-Id: <e1eff99fabe75d10908fe03cc646edb3ad0f6c45.1543142441.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the fb_ssd1306.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1306.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1306.c b/drivers/staging/fbtft/fb_ssd1306.c
index 50172ddd94ae..d7c5e2e0eee9 100644
--- a/drivers/staging/fbtft/fb_ssd1306.c
+++ b/drivers/staging/fbtft/fb_ssd1306.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -190,7 +190,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 
 	/* Write data */
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 	ret = par->fbtftops.write(par, par->txbuf.buf, xres * yres / 8);
 	if (ret < 0)
 		dev_err(par->info->device, "write failed and returned: %d\n",
-- 
2.17.1
