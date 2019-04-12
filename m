From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 12 Apr 2019 10:59:53 +0000
Subject: [PATCH] video: fbdev: imxfb: add COMPILE_TEST support
Message-Id: <57884bfc-efc3-371c-f99c-7fd2ed02f5fc@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190412105954eucas1p1072c6d28d5c48499df3bc1b35bbe2ed8@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org

Add COMPILE_TEST support to imxfb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig	2019-04-12 12:35:07.322174869 +0200
+++ b/drivers/video/fbdev/Kconfig	2019-04-12 12:35:07.306174869 +0200
@@ -334,7 +334,7 @@ config FB_SA1100
 
 config FB_IMX
 	tristate "Freescale i.MX1/21/25/27 LCD support"
-	depends on FB && ARCH_MXC
+	depends on FB && (ARCH_MXC || COMPILE_TEST)
 	select BACKLIGHT_LCD_SUPPORT
 	select LCD_CLASS_DEVICE
 	select FB_CFB_FILLRECT
