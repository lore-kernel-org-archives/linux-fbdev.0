From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:54:09 +0000
Subject: [PATCH 23/26] Staging: fbtft: fb_ssd1305: Switch to the gpio descriptor interface
Message-Id: <1abc12c3f5290b1eca9b8d737dda0ebe146e340b.1543142441.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

This switches the fb_ssd1305.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1305.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1305.c b/drivers/staging/fbtft/fb_ssd1305.c
index 3515888d94c9..020fe48fed0b 100644
--- a/drivers/staging/fbtft/fb_ssd1305.c
+++ b/drivers/staging/fbtft/fb_ssd1305.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -168,7 +168,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 
 	/* Write data */
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 	ret = par->fbtftops.write(par, par->txbuf.buf,
 				  par->info->var.xres * par->info->var.yres /
 				  8);
-- 
2.17.1
