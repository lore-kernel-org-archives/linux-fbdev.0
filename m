From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 21 Sep 2020 21:02:33 +0000
Subject: [PATCH] MAINTAINERS: move Milo Kim to credits
Message-Id: <20200921210233.21449-1-krzk@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Milo Kim's email in TI bounces with permanent error (550: Invalid
recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
credits and remove the separate driver entries for:

 - TI LP855x backlight driver,
 - TI LP8727 charger driver,
 - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 CREDITS     |  3 +++
 MAINTAINERS | 23 -----------------------
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/CREDITS b/CREDITS
index 1df63cdf71df..46384b11f258 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1910,6 +1910,9 @@ S: 660 Harvard Ave. #7
 S: Santa Clara, CA 95051
 S: USA
 
+N: Milo Kim
+D: TI LP855x, LP8727 and LP8788 drivers
+
 N: Russell King
 E: rmk@arm.linux.org.uk
 D: Linux/arm integrator, maintainer & hacker
diff --git a/MAINTAINERS b/MAINTAINERS
index 5b9621ca2b31..031adeff29cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17471,29 +17471,6 @@ S:	Maintained
 F:	sound/soc/codecs/isabelle*
 F:	sound/soc/codecs/lm49453*
 
-TI LP855x BACKLIGHT DRIVER
-M:	Milo Kim <milo.kim@ti.com>
-S:	Maintained
-F:	Documentation/driver-api/backlight/lp855x-driver.rst
-F:	drivers/video/backlight/lp855x_bl.c
-F:	include/linux/platform_data/lp855x.h
-
-TI LP8727 CHARGER DRIVER
-M:	Milo Kim <milo.kim@ti.com>
-S:	Maintained
-F:	drivers/power/supply/lp8727_charger.c
-F:	include/linux/platform_data/lp8727.h
-
-TI LP8788 MFD DRIVER
-M:	Milo Kim <milo.kim@ti.com>
-S:	Maintained
-F:	drivers/iio/adc/lp8788_adc.c
-F:	drivers/leds/leds-lp8788.c
-F:	drivers/mfd/lp8788*.c
-F:	drivers/power/supply/lp8788-charger.c
-F:	drivers/regulator/lp8788-*.c
-F:	include/linux/mfd/lp8788*.h
-
 TI NETCP ETHERNET DRIVER
 M:	Wingman Kwok <w-kwok2@ti.com>
 M:	Murali Karicheri <m-karicheri2@ti.com>
-- 
2.17.1
