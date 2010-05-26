From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Date: Wed, 26 May 2010 17:54:37 +0000
Subject: [PATCH] fbdev: fix frame buffer devices menu
Message-Id: <1274896477-6832-1-git-send-email-cascardo@holoscopio.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Baruch Siach <baruch@tkos.co.il>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>

Commit f601441916d1e19291d0b4f044b4a7551e2924d0 has inserted the symbol
HAVE_FB_IMX, which does not depend on FB after the menuconfig FB. This
breaks the menu, presenting most of the drivers outside of it, when
using menuconfig.

Moving the symbol to the start of the file, just like HAVE_FB_ATMEL,
fixes the problem without breaking it for iMX25 configurations (tested
with ARCH=3Darm, no build).

Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 drivers/video/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 1e6fec4..3d94a14 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -8,6 +8,9 @@ menu "Graphics support"
 config HAVE_FB_ATMEL
 	bool
=20
+config HAVE_FB_IMX
+	bool
+
 source "drivers/char/agp/Kconfig"
=20
 source "drivers/gpu/vga/Kconfig"
@@ -400,9 +403,6 @@ config FB_SA1100
 	  If you plan to use the LCD display with your SA-1100 system, say
 	  Y here.
=20
-config HAVE_FB_IMX
-	bool
-
 config FB_IMX
 	tristate "Motorola i.MX LCD support"
 	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
--=20
1.7.1

