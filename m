From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 04 Mar 2013 21:03:19 +0000
Subject: [PATCH 1/2] omapfb: fix broken build on OMAP1
Message-Id: <1362431000-15141-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Fix the following build regression in 3.9-rc1 by including
<mach/hardware.h>:

drivers/video/omap/omapfb_main.c: In function 'set_fb_var':
drivers/video/omap/omapfb_main.c:505:3: error: implicit declaration of function 'cpu_is_omap15xx' [-Werror=implicit-function-declaration]

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/video/omap/omapfb_main.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index e31f5b3..d40612c 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -32,6 +32,8 @@
 
 #include <linux/omap-dma.h>
 
+#include <mach/hardware.h>
+
 #include "omapfb.h"
 #include "lcdc.h"
 
-- 
1.7.10.4

