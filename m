From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 04 Mar 2013 21:03:20 +0000
Subject: [PATCH 2/2] omapfb: fix broken build on Amstrad E3/Delta
Message-Id: <1362431000-15141-2-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362431000-15141-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1362431000-15141-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Fix the following build regression in 3.9-rc1 by including
<machine/hardware.h>:

drivers/video/omap/lcd_ams_delta.c: In function 'ams_delta_lcd_set_power':
drivers/video/omap/lcd_ams_delta.c:48:4: error: implicit declaration of function 'omap_writeb' [-Werror=implicit-function-declaration]
drivers/video/omap/lcd_ams_delta.c:49:6: error: 'OMAP_PWL_ENABLE' undeclared (first use in this function)
drivers/video/omap/lcd_ams_delta.c:49:6: note: each undeclared identifier is reported only once for each function it appears in
drivers/video/omap/lcd_ams_delta.c:50:19: error: 'OMAP_PWL_CLK_ENABLE' undeclared (first use in this function)
drivers/video/omap/lcd_ams_delta.c: In function 'ams_delta_lcd_set_contrast':
drivers/video/omap/lcd_ams_delta.c:66:22: error: 'OMAP_PWL_ENABLE' undeclared (first use in this function)

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/video/omap/lcd_ams_delta.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/omap/lcd_ams_delta.c b/drivers/video/omap/lcd_ams_delta.c
index ed4cad8..4a5f2cd 100644
--- a/drivers/video/omap/lcd_ams_delta.c
+++ b/drivers/video/omap/lcd_ams_delta.c
@@ -27,6 +27,7 @@
 #include <linux/lcd.h>
 #include <linux/gpio.h>
 
+#include <mach/hardware.h>
 #include <mach/board-ams-delta.h>
 
 #include "omapfb.h"
-- 
1.7.10.4

