From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Thu, 25 Mar 2010 17:22:46 +0000
Subject: [PATCH 16/16] Video omap lcd_omap3beagle.c: duplicated include
Message-Id: <1269537767-7553-16-git-send-email-andrea.gelmini@gelma.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1269537767-7553-1-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1269537767-7553-1-git-send-email-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-doc@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>, Koen Kooi <koen@openembedded.org>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

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
1.7.0.3.296.g9776a

