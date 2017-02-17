From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Feb 2017 14:41:42 +0000
Subject: [PATCH] fbdev: ssd1307fb: include linux/gpio/consumer.h
Message-Id: <20170217144226.2250882-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, LABBE Corentin <clabbe.montjoie@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Changing this driver to the gpiod API requires the use of the
new-style header, depending on the configuration:

drivers/video/fbdev/ssd1307fb.c: In function 'ssd1307fb_probe':
drivers/video/fbdev/ssd1307fb.c:569:15: error: implicit declaration of function 'devm_gpiod_get_optional';did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
drivers/video/fbdev/ssd1307fb.c:570:11: error: 'GPIOD_OUT_LOW' undeclared (first use in this function)

Fixes: 72db33355c14 ("fbdev: ssd1307fb: Start to use gpiod API for reset gpio")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/ssd1307fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 5c87ae4bac6a..bd017b57c47f 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -9,6 +9,7 @@
 #include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.9.0

