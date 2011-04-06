From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
Date: Wed, 06 Apr 2011 14:29:04 +0000
Subject: [PATCH] video: imx-fb: just depend on IMX_HAVE_PLATFORM_IMX_FB
Message-Id: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

All machines having a imx-fb device now select IMX_HAVE_PLATFORM_IMX_FB,
so HAVE_FB_IMX can go away and there is no need anymore to explicitly
depend on ARCH_MX1 or ARCH_MX2.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

should this go via Sascha's or Paul's tree?

Best regards
Uwe

 arch/arm/plat-mxc/devices/Kconfig |    1 -
 drivers/video/Kconfig             |    5 +----
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/=
Kconfig
index b9ab1d5..e4dcf49 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -24,7 +24,6 @@ config IMX_HAVE_PLATFORM_IMXDI_RTC
=20
 config IMX_HAVE_PLATFORM_IMX_FB
 	bool
-	select HAVE_FB_IMX
=20
 config IMX_HAVE_PLATFORM_IMX_I2C
 	bool
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e6a8d8c..62f337a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -8,9 +8,6 @@ menu "Graphics support"
 config HAVE_FB_ATMEL
 	bool
=20
-config HAVE_FB_IMX
-	bool
-
 config SH_MIPI_DSI
 	tristate
 	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
@@ -359,7 +356,7 @@ config FB_SA1100
=20
 config FB_IMX
 	tristate "Freescale i.MX LCD support"
-	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
+	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
--=20
1.7.2.3

