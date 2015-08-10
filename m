From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Mon, 10 Aug 2015 14:31:54 +0000
Subject: [PATCH] video: fbdev: atmel_lcdfb: remove useless include
Message-Id: <1439217114-12317-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Definitions from linux/platform_data/atmel.h are not used, remove the
include.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index abadc490fa1f..a5006788647c 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -19,7 +19,6 @@
 #include <linux/backlight.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
-#include <linux/platform_data/atmel.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
-- 
2.1.4

