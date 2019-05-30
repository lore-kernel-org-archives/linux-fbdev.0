From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 30 May 2019 12:30:19 +0000
Subject: [PATCH v3] video: fbdev: atmel_lcdfb: add COMPILE_TEST support
Message-Id: <69cd6b8b-1fd1-86fa-2070-99d0ce15a868@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190530123016eucas1p2e18747b8ac1d156657232eab52876a61@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Add COMPILE_TEST support to atmel_lcdfb driver for better compile
testing coverage.

While at it fix improper use of UL (to silence build warnings on
x86_64).

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v3: fix build warnings on x86_64

v2: add missing HAVE_CLK && HAS IOMEM dependencies

 drivers/video/fbdev/Kconfig       |    3 ++-
 drivers/video/fbdev/atmel_lcdfb.c |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -855,7 +855,8 @@ config FB_S1D13XXX
 
 config FB_ATMEL
 	tristate "AT91 LCD Controller support"
-	depends on FB && OF && HAVE_FB_ATMEL
+	depends on FB && OF && HAVE_CLK && HAS_IOMEM
+	depends on HAVE_FB_ATMEL || COMPILE_TEST
 	select FB_BACKLIGHT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
Index: b/drivers/video/fbdev/atmel_lcdfb.c
=================================--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -673,7 +673,7 @@ static int atmel_lcdfb_set_par(struct fb
 	lcdc_writel(sinfo, ATMEL_LCDC_MVAL, 0);
 
 	/* Disable all interrupts */
-	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
+	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0U);
 	/* Enable FIFO & DMA errors */
 	lcdc_writel(sinfo, ATMEL_LCDC_IER, ATMEL_LCDC_UFLWI | ATMEL_LCDC_OWRI | ATMEL_LCDC_MERI);
 
@@ -1291,7 +1291,7 @@ static int atmel_lcdfb_suspend(struct pl
 	 * We don't want to handle interrupts while the clock is
 	 * stopped. It may take forever.
 	 */
-	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
+	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0U);
 
 	sinfo->saved_lcdcon = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_CTR);
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);
