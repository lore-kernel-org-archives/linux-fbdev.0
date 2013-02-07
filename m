From: Johan Hovold <jhovold@gmail.com>
Date: Thu, 07 Feb 2013 15:31:55 +0000
Subject: [PATCH v2 0/3] ARM: at91/avr32/atmel_lcdfb: remove cpu_is macros
Message-Id: <1360251118-12715-1-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130205201145.GE30595@game.jcrosoft.org>
In-Reply-To: <20130205201145.GE30595@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Here's a v2 replacing the last two patches in the series (the first three are
unchanged since the first post). If preferred, I can repost the whole series
when these patches have been acked.

v2:
 - use clkdev to handle the lcdc bus clock
 - use -lcdfb suffix for device ids (e.g. "at91sam9g45-lcdfb")

Thanks,
Johan

Johan Hovold (3):
  ARM: at91/avr32/atmel_lcdfb: add bus-clock entry
  atmel_lcdfb: move lcdcon2 register access to compute_hozval
  ARM: at91/avr32/atmel_lcdfb: add platform device-id table

 arch/arm/mach-at91/at91sam9261.c         |   2 +
 arch/arm/mach-at91/at91sam9261_devices.c |   6 +-
 arch/arm/mach-at91/at91sam9263.c         |   1 +
 arch/arm/mach-at91/at91sam9263_devices.c |   2 +-
 arch/arm/mach-at91/at91sam9g45.c         |   2 +
 arch/arm/mach-at91/at91sam9g45_devices.c |   6 +-
 arch/arm/mach-at91/at91sam9rl.c          |   1 +
 arch/arm/mach-at91/at91sam9rl_devices.c  |   2 +-
 arch/avr32/mach-at32ap/at32ap700x.c      |   6 +-
 drivers/video/atmel_lcdfb.c              | 120 +++++++++++++++++++++++--------
 include/video/atmel_lcdc.h               |   4 +-
 11 files changed, 117 insertions(+), 35 deletions(-)

-- 
1.8.1.1

