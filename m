From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 21 May 2019 10:47:02 +0000
Subject: [PATCH v2] video: fbdev: imxfb: add COMPILE_TEST support
Message-Id: <33fc4837-599d-0d5c-c530-58b283c4c095@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190521104703eucas1p2c1b6163a4ff9bb4d6caed325a4d0ee23@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org

Add COMPILE_TEST support to imxfb driver for better compile
testing coverage.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2: add missing HAVE_CLK && HAS IOMEM dependencies (noted by Uwe)

drivers/video/fbdev/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -331,7 +331,8 @@ config FB_SA1100
 
 config FB_IMX
 	tristate "Freescale i.MX1/21/25/27 LCD support"
-	depends on FB && ARCH_MXC
+	depends on FB && HAVE_CLK && HAS_IOMEM
+	depends on ARCH_MXC || COMPILE_TEST
 	select LCD_CLASS_DEVICE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
