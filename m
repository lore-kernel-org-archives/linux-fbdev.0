From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 25 Aug 2015 11:33:59 +0000
Subject: [PATCH 0/3] backlight: led-backlight driver
Message-Id: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>

This series aims to add a led-backlight driver, similar to pwm-backlight, but
using a LED class device underneath.

LED framework has no support for DT or getting a LED class driver from another
kernel driver, so I added minimal functionality to led-class.c to get
led-backlight working.

 Tomi

Tomi Valkeinen (3):
  leds: Add of_led_get() and led_put()
  backlight: add led-backlight driver
  devicetree: Add led-backlight binding

 .../bindings/video/backlight/led-backlight.txt     |  30 +++
 drivers/leds/led-class.c                           |  75 +++++++
 drivers/video/backlight/Kconfig                    |   7 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/led_bl.c                   | 226 +++++++++++++++++++++
 include/linux/leds.h                               |   4 +
 6 files changed, 343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/led-backlight.txt
 create mode 100644 drivers/video/backlight/led_bl.c

-- 
2.1.4

