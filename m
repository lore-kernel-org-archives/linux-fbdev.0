From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Fri, 17 Oct 2014 12:19:15 +0000
Subject: [PATCH] drivers: video: fbdev: atmel_lcdfb.c: remove unnecessary header
Message-Id: <1413548355-499-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404440796-11090-1-git-send-email-mwelling@ieee.org>
In-Reply-To: <1404440796-11090-1-git-send-email-mwelling@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Remove unnecessary mach/cpu.h header to be able to converge to a multiplatform
kernel.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 1d8bdb92939b..ea45a30fd4d2 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -26,7 +26,6 @@
 #include <video/of_display_timing.h>
 #include <video/videomode.h>
 
-#include <mach/cpu.h>
 #include <asm/gpio.h>
 
 #include <video/atmel_lcdc.h>
-- 
1.9.1

