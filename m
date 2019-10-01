From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 01 Oct 2019 12:58:30 +0000
Subject: [PATCH v4 0/7] backlight: gpio: simplify the driver
Message-Id: <20191001125837.4472-1-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While working on my other series related to gpio-backlight[1] I noticed
that we could simplify the driver if we made the only user of platform
data use GPIO lookups and device properties. This series tries to do
that.

The first patch adds all necessary data structures to ecovec24. Patch
2/7 unifies much of the code for both pdata and non-pdata cases. Patches
3-4/7 remove unused platform data fields. Last three patches contain
additional improvements for the GPIO backlight driver while we're already
modifying it.

I don't have access to this HW but hopefully this works. Only compile
tested.

[1] https://lkml.org/lkml/2019/6/25/900

v1 -> v2:
- rebased on top of v5.3-rc1 and adjusted to the recent changes from Andy
- added additional two patches with minor improvements

v2 -> v3:
- in patch 7/7: used initializers to set values for pdata and dev local vars

v3 -> v4:
- rebased on top of v5.4-rc1
- removed changes that are no longer relevant after commit ec665b756e6f
  ("backlight: gpio-backlight: Correct initial power state handling")
- added patch 7/7

Bartosz Golaszewski (7):
  backlight: gpio: remove unneeded include
  sh: ecovec24: add additional properties to the backlight device
  backlight: gpio: simplify the platform data handling
  sh: ecovec24: don't set unused fields in platform data
  backlight: gpio: remove unused fields from platform data
  backlight: gpio: use a helper variable for &pdev->dev
  backlight: gpio: pull gpio_backlight_initial_power_state() into probe

 arch/sh/boards/mach-ecovec24/setup.c         |  33 ++++--
 drivers/video/backlight/gpio_backlight.c     | 107 +++++--------------
 include/linux/platform_data/gpio_backlight.h |   3 -
 3 files changed, 52 insertions(+), 91 deletions(-)

-- 
2.23.0
