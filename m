From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2019 16:34:22 +0000
Subject: [PATCH 00/12] ARM: davinci: da850-evm: remove more legacy GPIO calls
Message-Id: <20190625163434.13620-1-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is another small step on the path to liberating davinci from legacy
GPIO API calls and shrinking the davinci GPIO driver by not having to
support the base GPIO number anymore.

This time we're removing the legacy calls used indirectly by the LCDC
fbdev driver.

The first three patches modify the GPIO backlight driver. The first
of them adds the necessary functionality, the other two are just
tweaks and cleanups.

Next two patches enable the GPIO backlight driver in
davinci_all_defconfig.

Patch 6/12 models the backlight GPIO as an actual GPIO backlight device.

Patches 7-9 extend the fbdev driver with regulator support and convert
the da850-evm board file to using it.

Last three patches are improvements to the da8xx fbdev driver since
we're already touching it in this series.

Bartosz Golaszewski (12):
  backlight: gpio: allow to probe non-pdata devices from board files
  backlight: gpio: use a helper variable for &pdev->dev
  backlight: gpio: pull the non-pdata device probing code into probe()
  ARM: davinci: refresh davinci_all_defconfig
  ARM: davinci_all_defconfig: enable GPIO backlight
  ARM: davinci: da850-evm: model the backlight GPIO as an actual device
  fbdev: da8xx: add support for a regulator
  ARM: davinci: da850-evm: switch to using a fixed regulator for lcdc
  fbdev: da8xx: remove panel_power_ctrl() callback from platform data
  fbdev: da8xx-fb: use devm_platform_ioremap_resource()
  fbdev: da8xx-fb: drop a redundant if
  fbdev: da8xx: use resource management for dma

 arch/arm/configs/davinci_all_defconfig   |  28 +++---
 arch/arm/mach-davinci/board-da850-evm.c  |  90 ++++++++++++-----
 drivers/video/backlight/gpio_backlight.c |  67 +++++--------
 drivers/video/fbdev/da8xx-fb.c           | 118 +++++++++++++----------
 include/video/da8xx-fb.h                 |   1 -
 5 files changed, 165 insertions(+), 139 deletions(-)

-- 
2.21.0
