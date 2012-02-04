From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:41:08 +0000
Subject: [PATCH 09/13] FB: sa1100: remove assabet specific initialization
Message-Id: <E1Rtc7I-0000at-EL@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Remove the assabet specific initialization for PAL output mode -
we call the lcd_power function before we enable the LCD controller,
which will disable the LCD panel to prevent it receiving incorrect
timings.  Therefore, this setup here is redundant.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/sa1100fb.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index c9f1e7c..f6e27f4 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -182,7 +182,6 @@
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <mach/assabet.h>
 #include <mach/shannon.h>
 
 /*
@@ -190,8 +189,6 @@
  */
 #define DEBUG_VAR 1
 
-#undef ASSABET_PAL_VIDEO
-
 #include "sa1100fb.h"
 
 static const struct sa1100fb_rgb rgb_4 = {
@@ -1229,11 +1226,6 @@ static int __devinit sa1100fb_probe(struct platform_device *pdev)
 		goto failed;
 	}
 
-#ifdef ASSABET_PAL_VIDEO
-	if (machine_is_assabet())
-		ASSABET_BCR_clear(ASSABET_BCR_LCD_ON);
-#endif
-
 	/*
 	 * This makes sure that our colour bitfield
 	 * descriptors are correctly initialised.
-- 
1.7.4.4

