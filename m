From: Vladimir Zapolskiy <vz@mleia.com>
Date: Wed, 21 Dec 2016 03:27:14 +0000
Subject: [PATCH 1/4] video: ARM CLCD: sort included headers out alphabetically
Message-Id: <20161221032717.13154-2-vz@mleia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
In-Reply-To: <20161221032717.13154-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

To simplify the task of looking through the list of included headers sort
them out alphabetically, some of the truly redundant headers are removed
from the list.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/video/fbdev/amba-clcd.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index ec2671d..a806fb8 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -10,27 +10,22 @@
  *
  *  ARM PrimeCell PL110 Color LCD Controller
  */
-#include <linux/dma-mapping.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/slab.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/clcd.h>
+#include <linux/backlight.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/mm.h>
+#include <linux/dma-mapping.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
-#include <linux/amba/bus.h>
-#include <linux/amba/clcd.h>
-#include <linux/bitops.h>
-#include <linux/clk.h>
-#include <linux/hardirq.h>
-#include <linux/of.h>
+#include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_graph.h>
-#include <linux/backlight.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <video/display_timing.h>
 #include <video/of_display_timing.h>
 #include <video/videomode.h>
-- 
2.10.2

