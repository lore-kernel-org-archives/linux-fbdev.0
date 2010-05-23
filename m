From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sun, 23 May 2010 20:10:01 +0000
Subject: [PATCH 015/199] Video omap lcd_omap3beagle.c: duplicated include
Message-Id: <1274645401-27734-4-git-send-email-andrea.gelmini@gelma.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274645401-27734-1-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1274645401-27734-1-git-send-email-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrea.gelmini@gelma.net
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Koen Kooi <koen@openembedded.org>, David Brownell <dbrownell@users.sourceforge.net>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

drivers/video/omap/lcd_omap3beagle.c: plat/mux.h is included more than once.

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 drivers/video/omap/lcd_omap3beagle.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
index ca75cc2..ac715f9 100644
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -26,7 +26,6 @@
 #include <linux/i2c/twl.h>
 
 #include <plat/mux.h>
-#include <plat/mux.h>
 #include <asm/mach-types.h>
 
 #include "omapfb.h"
-- 
1.7.1.251.gf80a2

