From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:46:29 +0000
Subject: [PATCH 12/26] Staging: fbtft: fb_ssd1325: Switch to the gpio descriptor interface
Message-Id: <618a646df1ffad7401b794ab23c2e7b009ae7d6d.1543142441.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the fb_ssd1325.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ssd1325.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1325.c b/drivers/staging/fbtft/fb_ssd1325.c
index f974f7fc4d79..8a3140d41d8b 100644
--- a/drivers/staging/fbtft/fb_ssd1325.c
+++ b/drivers/staging/fbtft/fb_ssd1325.c
@@ -6,7 +6,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -35,7 +35,7 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	gpio_set_value(par->gpio.cs, 0);
+	gpiod_set_value(par->gpio.cs, 0);
 
 	write_reg(par, 0xb3);
 	write_reg(par, 0xf0);
@@ -155,7 +155,7 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 		}
 	}
 
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 
 	/* Write data */
 	ret = par->fbtftops.write(par, par->txbuf.buf,
-- 
2.17.1
