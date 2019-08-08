From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 08 Aug 2019 21:22:10 +0000
Subject: [PATCH 01/22] ARM: omap1: innovator: pass lcd control address as pdata
Message-Id: <20190808212234.2213262-2-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190808212234.2213262-1-arnd@arndb.de>
In-Reply-To: <20190808212234.2213262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

To avoid using the mach/omap1510.h header file, pass the correct
address as platform data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-innovator.c  | 3 +++
 drivers/video/fbdev/omap/lcd_inn1510.c | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index cbe093f969d5..2425f1bacb33 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -194,6 +194,9 @@ static struct platform_device innovator1510_smc91x_device = {
 static struct platform_device innovator1510_lcd_device = {
 	.name		= "lcd_inn1510",
 	.id		= -1,
+	.dev	= {
+		.platform_data = (void __force *)OMAP1510_FPGA_LCD_PANEL_CONTROL,
+	}
 };
 
 static struct platform_device innovator1510_spi_device = {
diff --git a/drivers/video/fbdev/omap/lcd_inn1510.c b/drivers/video/fbdev/omap/lcd_inn1510.c
index 776e7f8d656e..37ed0c14aa5a 100644
--- a/drivers/video/fbdev/omap/lcd_inn1510.c
+++ b/drivers/video/fbdev/omap/lcd_inn1510.c
@@ -14,15 +14,17 @@
 
 #include "omapfb.h"
 
+static void __iomem *omap1510_fpga_lcd_panel_control;
+
 static int innovator1510_panel_enable(struct lcd_panel *panel)
 {
-	__raw_writeb(0x7, OMAP1510_FPGA_LCD_PANEL_CONTROL);
+	__raw_writeb(0x7, omap1510_fpga_lcd_panel_control);
 	return 0;
 }
 
 static void innovator1510_panel_disable(struct lcd_panel *panel)
 {
-	__raw_writeb(0x0, OMAP1510_FPGA_LCD_PANEL_CONTROL);
+	__raw_writeb(0x0, omap1510_fpga_lcd_panel_control);
 }
 
 static struct lcd_panel innovator1510_panel = {
@@ -48,6 +50,7 @@ static struct lcd_panel innovator1510_panel = {
 
 static int innovator1510_panel_probe(struct platform_device *pdev)
 {
+	omap1510_fpga_lcd_panel_control = (void __iomem *)pdev->dev.platform_data;
 	omapfb_register_panel(&innovator1510_panel);
 	return 0;
 }
-- 
2.20.0
