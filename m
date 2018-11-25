From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Sun, 25 Nov 2018 11:56:34 +0000
Subject: [PATCH 26/26] Staging: fbtft: fb_ra8875: Switch to the gpio descriptor interface
Message-Id: <d9b510e30805d4d5aea8544a552a9c1c49d9de41.1543142441.git.nishadkamdar@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

This switches the fb_ra8875.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 5d3b76ca74d8..70b37fc7fb66 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include "fbtft.h"
 
 #define DRVNAME "fb_ra8875"
@@ -39,7 +39,7 @@ static int write_spi(struct fbtft_par *par, void *buf, size_t len)
 
 static int init_display(struct fbtft_par *par)
 {
-	gpio_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 
 	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
 		      "%s()\n", __func__);
-- 
2.17.1
