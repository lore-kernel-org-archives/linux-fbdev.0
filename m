From: Olliver Schinagl <o.schinagl@ultimaker.com>
Date: Tue, 08 Sep 2015 19:19:50 +0000
Subject: [PATCH 1/2] fbdev: ssd1307fb: alphabetize headers
Message-Id: <1441739991-4676-2-git-send-email-o.schinagl@ultimaker.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441739991-4676-1-git-send-email-o.schinagl@ultimaker.com>
In-Reply-To: <1441739991-4676-1-git-send-email-o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp-PRwTpj6vllL6m1q2wEL4bg@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Prabhakar Lad <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Olliver Schinagl <oliver@schinagl.nl>

This patch sorts the headers on ssd1307fb driver.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/video/fbdev/ssd1307fb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 3e153c0..339615c 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -6,16 +6,16 @@
  * Licensed under the GPLv2 or later.
  */
 
-#include <linux/module.h>
 #include <linux/backlight.h>
-#include <linux/kernel.h>
-#include <linux/i2c.h>
+#include <linux/delay.h>
 #include <linux/fb.h>
-#include <linux/uaccess.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pwm.h>
-#include <linux/delay.h>
+#include <linux/uaccess.h>
 
 #define SSD1307FB_DATA			0x40
 #define SSD1307FB_COMMAND		0x80
-- 
2.1.4

