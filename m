From: mathieu.poirier@linaro.org
Date: Tue, 15 May 2012 21:02:59 +0000
Subject: [PATCH 3/5] video/console: automatically select a font
Message-Id: <1337115781-27979-4-git-send-email-mathieu.poirier@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1337115781-27979-1-git-send-email-mathieu.poirier@linaro.org>
In-Reply-To: <1337115781-27979-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, mathieu.poirier@linaro.org

From: Arnd Bergmann <arnd@arndb.de>

The frame buffer console needs at least one font to be built into
the kernel, so add the necessary Kconfig magic to guarantee that
one of the available font is always on. If a user accidentally
disables all fonts manually, the 8x16 font will be selected
anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/video/console/Kconfig |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index c2d11fe..e2c96d0 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -224,5 +224,19 @@ config FONT_10x18
 	  big letters. It fits between the sun 12x22 and the normal 8x16 font.
 	  If other fonts are too big or too small for you, say Y, otherwise say N.
 
+config FONT_AUTOSELECT
+	def_bool y
+	depends on FRAMEBUFFER_CONSOLE || SGI_NEWPORT_CONSOLE || STI_CONSOLE || USB_SISUSBVGA_CON
+	depends on !FONT_8x8
+	depends on !FONT_6x11
+	depends on !FONT_7x14
+	depends on !FONT_PEARL_8x8
+	depends on !FONT_ACORN_8x8
+	depends on !FONT_MINI_4x6
+	depends on !FONT_SUN8x16
+	depends on !FONT_SUN12x22
+	depends on !FONT_10x18
+	select FONT_8x16
+
 endmenu
 
-- 
1.7.5.4

