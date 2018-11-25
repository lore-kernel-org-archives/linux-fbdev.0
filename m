From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:40:14 +0000
Subject: [PATCH 06/26] Staging: fbtft: fb_upd161704: Switch to the gpio descriptor interface
Message-Id: <87f73bf1fb0a79eac6eac5af9a376e68d152c990.1543142440.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the fb_upd161704.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_upd161704.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index acc425fdf34e..564a38e34440 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -26,8 +26,8 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs != -1)
-		gpio_set_value(par->gpio.cs, 0);  /* Activate chip */
+	if (!par->gpio.cs)
+		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	/* Initialization sequence from Lib_UTFT */
 
-- 
2.17.1
