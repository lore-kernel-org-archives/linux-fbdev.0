From: Tony Lindgren <tony@atomide.com>
Date: Wed, 19 Sep 2012 21:05:52 +0000
Subject: [PATCH 07/29] ARM: OMAP1: Move lcd_mipid.h from plat to mach
Message-Id: <20120919210552.28074.21443.stgit@muffinssi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120919205732.28074.43697.stgit@muffinssi>
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is only used by omap1.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-nokia770.c         |    2 +-
 arch/arm/mach-omap1/include/mach/lcd_mipid.h |    0 
 drivers/video/omap/lcd_mipid.c               |    2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/{plat-omap/include/plat/lcd_mipid.h => mach-omap1/include/mach/lcd_mipid.h} (100%)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index bfc2b06..a2699eb 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -27,7 +27,7 @@
 
 #include <mach/mux.h>
 #include <mach/keypad.h>
-#include <plat/lcd_mipid.h>
+#include <mach/lcd_mipid.h>
 #include <plat/mmc.h>
 #include <plat/clock.h>
 
diff --git a/arch/arm/plat-omap/include/plat/lcd_mipid.h b/arch/arm/mach-omap1/include/mach/lcd_mipid.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/lcd_mipid.h
rename to arch/arm/mach-omap1/include/mach/lcd_mipid.h
diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
index e3880c4..2b64d07 100644
--- a/drivers/video/omap/lcd_mipid.c
+++ b/drivers/video/omap/lcd_mipid.c
@@ -25,7 +25,7 @@
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 
-#include <plat/lcd_mipid.h>
+#include <mach/lcd_mipid.h>
 
 #include "omapfb.h"
 

