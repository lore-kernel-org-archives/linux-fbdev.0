From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:49:07 +0000
Subject: [PATCH 16/26] Staging: fbtft: fb_uc1701: Switch to the gpio descriptor interface
Message-Id: <9aa3e142296156dd54a199774b3e35fe7762712b.1543142441.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

This switches the fb_uc1701.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_uc1701.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_uc1701.c b/drivers/staging/fbtft/fb_uc1701.c
index 0a3531d6eb39..e4ccc73868a7 100644
--- a/drivers/staging/fbtft/fb_uc1701.c
+++ b/drivers/staging/fbtft/fb_uc1701.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -136,9 +136,9 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 		write_reg(par, LCD_PAGE_ADDRESS | (u8)y);
 		write_reg(par, 0x00);
 		write_reg(par, LCD_COL_ADDRESS);
-		gpio_set_value(par->gpio.dc, 1);
+		gpiod_set_value(par->gpio.dc, 1);
 		ret = par->fbtftops.write(par, par->txbuf.buf, WIDTH);
-		gpio_set_value(par->gpio.dc, 0);
+		gpiod_set_value(par->gpio.dc, 0);
 	}
 
 	if (ret < 0)
-- 
2.17.1
