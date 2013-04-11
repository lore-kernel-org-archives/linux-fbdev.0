From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 11 Apr 2013 14:57:41 +0000
Subject: [PATCH 0/8] ARM: at91: atmel_lcdc: add DT support
Message-Id: <20130411145741.GB25242@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: inux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

HI,

	The following patch series add the DT support of the Atmel LCDC
	controler and update the 9263 and 9g45 Atmel Reference board

	At the same time some cleanup is done on the drivers implementation as
	we was using the internal data struct as platform data

The following changes since commit d920129d817acc5f7ebfadeb7ecbce70ab161f6c:

  ARM: at91/avr32/atmel_lcdfb: add platform device-id table (2013-04-11 21:00:56 +0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git j/for-3.10_atmel_lcd_dt

for you to fetch changes up to 6354e161060c2d90f0935d14d037e2f126b8c6e5:

  ARM: at91: sam9263ek: add dt lcd support (2013-04-11 21:18:21 +0800)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (8):
      video: atmel_lcdfb: fix platform data struct
      video: atmel_lcdfb: introduce atmel_lcdfb_power_control
      video: atmel_lcdfb: pass the pdata as params
      video: atmel_lcdfb: add device tree suport
      ARM: at91: sam9g45: add lcd support
      ARM: at91: sam9263: add fb dt support
      ARM: at91: at9sam9m10g45ek: add dt lcd support
      ARM: at91: sam9263ek: add dt lcd support

 Documentation/devicetree/bindings/video/atmel,lcdc.txt |   75 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi                     |   39 ++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263ek.dts                    |   30 +++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                     |   47 +++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts                 |   29 +++++++++++++++
 arch/arm/mach-at91/at91sam9261_devices.c               |    6 +--
 arch/arm/mach-at91/at91sam9263_devices.c               |    6 +--
 arch/arm/mach-at91/at91sam9g45_devices.c               |    6 +--
 arch/arm/mach-at91/at91sam9rl_devices.c                |    6 +--
 arch/arm/mach-at91/board-sam9261ek.c                   |   10 ++---
 arch/arm/mach-at91/board-sam9263ek.c                   |    6 +--
 arch/arm/mach-at91/board-sam9m10g45ek.c                |    4 +-
 arch/arm/mach-at91/board-sam9rlek.c                    |    6 +--
 arch/arm/mach-at91/board.h                             |    4 +-
 arch/avr32/boards/atngw100/evklcd10x.c                 |    8 ++--
 arch/avr32/boards/atngw100/mrmt.c                      |    4 +-
 arch/avr32/boards/atstk1000/atstk1000.h                |    2 +-
 arch/avr32/boards/atstk1000/setup.c                    |    2 +-
 arch/avr32/boards/favr-32/setup.c                      |    2 +-
 arch/avr32/boards/hammerhead/setup.c                   |    2 +-
 arch/avr32/boards/merisc/display.c                     |    2 +-
 arch/avr32/boards/mimc200/setup.c                      |    4 +-
 arch/avr32/mach-at32ap/at32ap700x.c                    |    8 ++--
 arch/avr32/mach-at32ap/include/mach/board.h            |    4 +-
 drivers/video/Kconfig                                  |    2 +
 drivers/video/atmel_lcdfb.c                            |  342 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 include/video/atmel_lcdc.h                             |   26 ++-----------
 27 files changed, 547 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/atmel,lcdc.txt

Best Regards,
J.
