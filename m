From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 May 2015 16:32:39 +0000
Subject: [PATCH 23/27] backlight: Allow compile test of GPIO consumers if !GPIOLIB
Message-Id: <1430843563-18615-23-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
appropriate.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/backlight/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 2d9923a60076e380..0505b796d743250e 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -36,14 +36,16 @@ config LCD_CORGI
 
 config LCD_L4F00242T03
 	tristate "Epson L4F00242T03 LCD"
-	depends on SPI_MASTER && GPIOLIB
+	depends on SPI_MASTER
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  SPI driver for Epson L4F00242T03. This provides basic support
 	  for init and powering the LCD up/down through a sysfs interface.
 
 config LCD_LMS283GF05
 	tristate "Samsung LMS283GF05 LCD"
-	depends on SPI_MASTER && GPIOLIB
+	depends on SPI_MASTER
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  SPI driver for Samsung LMS283GF05. This provides basic support
 	  for powering the LCD up/down through a sysfs interface.
@@ -434,7 +436,7 @@ config BACKLIGHT_AS3711
 
 config BACKLIGHT_GPIO
 	tristate "Generic GPIO based Backlight Driver"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  If you have a LCD backlight adjustable by GPIO, say Y to enable
 	  this driver.
-- 
1.9.1

