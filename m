From: Nicolas Kaiser <nikai@nikai.net>
Date: Mon, 04 Oct 2010 18:38:42 +0000
Subject: [PATCH] video/omap: remove mux.h include
Message-Id: <20101004203842.088b0cb2@absol.kitzblitz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101004174344.21577085@absol.kitzblitz>
	<20101004175429.GW3117@atomide.com>
In-Reply-To: <20101004175429.GW3117@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Including mux.h should no longer be needed for omap2/3/4 SoCs
outside arch/arm/mach-omap2 files.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 drivers/video/omap/lcd_omap3beagle.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
index ca75cc2..d7c6c3e 100644
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -25,8 +25,6 @@
 #include <linux/gpio.h>
 #include <linux/i2c/twl.h>
 
-#include <plat/mux.h>
-#include <plat/mux.h>
 #include <asm/mach-types.h>
 
 #include "omapfb.h"
-- 
1.7.2.2
