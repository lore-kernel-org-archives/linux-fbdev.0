From: mathieu.poirier@linaro.org
Date: Tue, 15 May 2012 21:03:01 +0000
Subject: [PATCH 5/5] drivers/tosa: driver needs I2C and SPI to compile
Message-Id: <1337115781-27979-6-git-send-email-mathieu.poirier@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1337115781-27979-1-git-send-email-mathieu.poirier@linaro.org>
In-Reply-To: <1337115781-27979-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, mathieu.poirier@linaro.org

From: Arnd Bergmann <arnd@arndb.de>

This driver requires both SPI and I2C to build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/video/backlight/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index af16884..d7487d2 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -88,7 +88,7 @@ config LCD_PLATFORM
 
 config LCD_TOSA
 	tristate "Sharp SL-6000 LCD Driver"
-	depends on SPI && MACH_TOSA
+	depends on I2C && SPI && MACH_TOSA
 	help
 	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
 	  for its LCD.
-- 
1.7.5.4

