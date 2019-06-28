From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 28 Jun 2019 10:02:49 +0000
Subject: [PATCH RFT 0/4] backlight: gpio: simplify the driver
Message-Id: <20190628100253.8385-1-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While working on my other series related to gpio-backlight[1] I noticed
that we could simplify the driver if we made the only user of platform
data use GPIO lookups and device properties. This series tries to do
that.

The first patch sets up all the required structures in the board file,
the second modifies the backlight driver, the third and fourth remove
the leftovers.

This series depends on the three first patches from [1].

I don't have access to this HW but hopefully this works. Only compile
tested.

[1] https://lkml.org/lkml/2019/6/25/900

Bartosz Golaszewski (4):
  sh: ecovec24: add additional properties to the backlight device
  backlight: gpio: simplify the platform data handling
  sh: ecovec24: don't set unused fields in platform data
  backlight: gpio: remove unused fields from platform data

 arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++++++----
 drivers/video/backlight/gpio_backlight.c     | 46 ++++++--------------
 include/linux/platform_data/gpio_backlight.h |  3 --
 3 files changed, 38 insertions(+), 44 deletions(-)

-- 
2.21.0
