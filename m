From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 12 Apr 2019 11:29:11 +0000
Subject: [PATCH] video: fbdev: atmel_lcdfb: add COMPILE_TEST support
Message-Id: <fd1ff7c2-f020-8252-c312-df57137ae79e@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190412112917eucas1p14e01f99bc74e37b061b08d6341e21d50@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add COMPILE_TEST support to atmel_lcdfb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig	2019-04-12 13:12:24.000000000 +0200
+++ b/drivers/video/fbdev/Kconfig	2019-04-12 13:15:03.986235226 +0200
@@ -859,7 +859,7 @@ config FB_S1D13XXX
 
 config FB_ATMEL
 	tristate "AT91 LCD Controller support"
-	depends on FB && OF && HAVE_FB_ATMEL
+	depends on FB && OF && (HAVE_FB_ATMEL || COMPILE_TEST)
 	select FB_BACKLIGHT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
