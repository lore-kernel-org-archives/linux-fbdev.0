From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 02 Feb 2017 13:53:09 +0000
Subject: [PATCH v3 0/2] gpio: Add the devm_fwnode_get_index_gpiod_from_child() helper
Message-Id: <1486043591-6278-1-git-send-email-boris.brezillon@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-leds@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>

Hello Linus,

Here is the v3 rebased on your ib-gpiod-flags branch.

Thanks,

Boris

---
Changes since v2:
- Rebase on the ib-gpiod-flags

Changes since v1:
- Rename the devm_get_gpiod_from_child() helper into
  devm_fwnode_get_gpiod_from_child()
- Define as a static inline wrapper around
  devm_fwnode_get_gpiod_from_child()

Boris Brezillon (2):
  gpio: Rename devm_get_gpiod_from_child()
  gpio: Add the devm_fwnode_get_index_gpiod_from_child() helper

 drivers/gpio/devres.c                     | 18 +++++++++-------
 drivers/gpio/gpiolib.c                    |  9 ++++----
 drivers/input/keyboard/gpio_keys.c        |  6 ++++--
 drivers/input/keyboard/gpio_keys_polled.c |  8 +++----
 drivers/leds/leds-gpio.c                  |  5 +++--
 drivers/video/fbdev/amba-clcd-nomadik.c   | 16 +++++++-------
 include/linux/gpio/consumer.h             | 35 ++++++++++++++++++++-----------
 7 files changed, 57 insertions(+), 40 deletions(-)

-- 
2.7.4

