From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 15 Mar 2018 22:41:58 +0000
Subject: [RFC 0/4] gpio-backlight: remove platform data support
Message-Id: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linus Walleij <linus.walleij@linaro.org>

Hi,

This series attempts to remove platform data support from gpio_blackllist
driver and switch it over to generic device properties/GPIO tables.
The only user of platform data was SuperH Ecovec24 board; please take a
look at patch #2 that tries to only register backlight when the board is
using LDC and not DVI.

Please note that I do not have the hardware (do we even care about
ecovec24? I'd like to rip out platform data support from tsc2007 as
well, but ecovec24 is using custom pendown handler and GPIOs have
to be switched off from interrupt mode to GPIO and back in that
pendown handler, which is all quite messy. If we do not care about
this board I'd much rather removed that custom pendown).

Thanks!

Dmitry Torokhov (4):
  backlight: gpio_backlight: use generic device properties
  sh: ecovec24: conditionally register backlight device
  sh: ecovec24: convert backlight to use device properties
  backlight: gpio_backlight: remove platform data support

 arch/sh/boards/mach-ecovec24/setup.c         | 47 ++++++----
 drivers/video/backlight/gpio_backlight.c     | 93 +++-----------------
 include/linux/platform_data/gpio_backlight.h | 20 -----
 3 files changed, 46 insertions(+), 114 deletions(-)
 delete mode 100644 include/linux/platform_data/gpio_backlight.h

-- 
Dmitry

