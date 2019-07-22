From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jul 2019 13:44:14 +0000
Subject: [PATCH v2 0/9] ARM: davinci: da850-evm: remove more legacy GPIO calls
Message-Id: <20190722134423.26555-1-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is another small step on the path to liberating davinci from legacy
GPIO API calls and shrinking the davinci GPIO driver by not having to
support the base GPIO number anymore.

This time we're removing the legacy calls used indirectly by the LCDC
fbdev driver.

First two patches enable the GPIO backlight driver in
davinci_all_defconfig.

Patch 3/12 models the backlight GPIO as an actual GPIO backlight device.

Patches 4-6 extend the fbdev driver with regulator support and convert
the da850-evm board file to using it.

Last three patches are improvements to the da8xx fbdev driver since
we're already touching it in this series.

v1 -> v2:
- dopped the gpio-backlight patches from this series as since v5.3-rc1 we
  can probe the module with neither the OF node nor platform data
- collected review and ack tags
- rebased on top of v5.3-rc1

Bartosz Golaszewski (9):
  ARM: davinci: refresh davinci_all_defconfig
  ARM: davinci_all_defconfig: enable GPIO backlight
  ARM: davinci: da850-evm: model the backlight GPIO as an actual device
  fbdev: da8xx: add support for a regulator
  ARM: davinci: da850-evm: switch to using a fixed regulator for lcdc
  fbdev: da8xx: remove panel_power_ctrl() callback from platform data
  fbdev: da8xx-fb: use devm_platform_ioremap_resource()
  fbdev: da8xx-fb: drop a redundant if
  fbdev: da8xx: use resource management for dma

 arch/arm/configs/davinci_all_defconfig  |  27 ++----
 arch/arm/mach-davinci/board-da850-evm.c |  90 +++++++++++++-----
 drivers/video/fbdev/da8xx-fb.c          | 118 +++++++++++++-----------
 include/video/da8xx-fb.h                |   1 -
 4 files changed, 141 insertions(+), 95 deletions(-)

-- 
2.21.0
