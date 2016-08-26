From: Paul Burton <paul.burton@imgtec.com>
Date: Fri, 26 Aug 2016 14:17:32 +0000
Subject: [PATCH v2 00/19] MIPS: SEAD3 device tree conversion
Message-Id: <20160826141751.13121-1-paul.burton@imgtec.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>, Ondrej Zary <linux@rainbow-software.org>, linux-fbdev@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-leds@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, "Maciej W. Rozycki" <macro@linux-mips.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, Ez

Although the SEAD3 board has already made some minimal use of device
tree, until now most peripherals have been left probed by platform code.

This series converts all SEAD3 peripherals to instead be probed from
device tree. The amount of platform code is significantly reduced
leaving SEAD3 primed & ready for a wider task of genericising the
kernel.

Applies atop v4.8-rc3.

Paul Burton (19):
  MIPS: SEAD3: Split obj-y entries across lines
  MIPS: SEAD3: Probe interrupt controllers using DT
  MIPS: SEAD3: Probe UARTs using DT
  MIPS: SEAD3: Use generic ns16550a earlycon support
  MIPS: SEAD3: Probe ethernet controller using DT
  MIPS: SEAD3: Probe EHCI controller using DT
  usb: host: ehci-sead3: Remove SEAD-3 EHCI code
  SEAD3: Probe parallel flash via DT
  MIPS: SEAD3: Use register-bit-led driver via DT for LEDs
  leds: Remove SEAD3 driver
  MIPS: SEAD3: Reset via generic syscon-reboot driver & DT
  MIPS: SEAD3: Use generic restart-poweroff driver
  MIPS: SEAD3: Parse memsize in DT shim
  MIPS: SEAD3: Drop use of cobalt fbdev driver
  fbdev: cobalt_lcdfb: Drop SEAD3 support
  dt-bindings: img-ascii-lcd: Document a binding for simple ASCII LCDs
  auxdisplay: img-ascii-lcd: driver for simple ASCII LCD displays
  MIPS: SEAD3: Use img-ascii-lcd driver
  MIPS: SEAD3: Remove custom read_persistent_clock

 .../bindings/auxdisplay/img-ascii-lcd.txt          |  17 +
 MAINTAINERS                                        |   6 +
 arch/mips/Kconfig                                  |   1 -
 arch/mips/boot/dts/mti/sead3.dts                   | 237 +++++++++++
 arch/mips/configs/sead3_defconfig                  |   8 +
 arch/mips/include/asm/mach-sead3/sead3-dtshim.h    |  29 ++
 arch/mips/include/asm/mips-boards/sead3int.h       |  32 --
 arch/mips/mti-sead3/Makefile                       |  10 +-
 arch/mips/mti-sead3/sead3-console.c                |  46 ---
 arch/mips/mti-sead3/sead3-display.c                |  77 ----
 arch/mips/mti-sead3/sead3-dtshim.c                 | 292 ++++++++++++++
 arch/mips/mti-sead3/sead3-init.c                   |  52 ---
 arch/mips/mti-sead3/sead3-int.c                    |  27 +-
 arch/mips/mti-sead3/sead3-lcd.c                    |  43 --
 arch/mips/mti-sead3/sead3-platform.c               | 223 -----------
 arch/mips/mti-sead3/sead3-reset.c                  |  40 --
 arch/mips/mti-sead3/sead3-setup.c                  |  77 +---
 arch/mips/mti-sead3/sead3-time.c                   |   8 -
 drivers/auxdisplay/Kconfig                         |   9 +
 drivers/auxdisplay/Makefile                        |   1 +
 drivers/auxdisplay/img-ascii-lcd.c                 | 443 +++++++++++++++++++++
 drivers/leds/Kconfig                               |  10 -
 drivers/leds/Makefile                              |   1 -
 drivers/leds/leds-sead3.c                          |  78 ----
 drivers/usb/host/ehci-hcd.c                        |   5 -
 drivers/usb/host/ehci-sead3.c                      | 185 ---------
 drivers/video/fbdev/Kconfig                        |   2 +-
 drivers/video/fbdev/cobalt_lcdfb.c                 |  42 --
 28 files changed, 1056 insertions(+), 945 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt
 create mode 100644 arch/mips/include/asm/mach-sead3/sead3-dtshim.h
 delete mode 100644 arch/mips/include/asm/mips-boards/sead3int.h
 delete mode 100644 arch/mips/mti-sead3/sead3-console.c
 delete mode 100644 arch/mips/mti-sead3/sead3-display.c
 create mode 100644 arch/mips/mti-sead3/sead3-dtshim.c
 delete mode 100644 arch/mips/mti-sead3/sead3-lcd.c
 delete mode 100644 arch/mips/mti-sead3/sead3-platform.c
 delete mode 100644 arch/mips/mti-sead3/sead3-reset.c
 create mode 100644 drivers/auxdisplay/img-ascii-lcd.c
 delete mode 100644 drivers/leds/leds-sead3.c
 delete mode 100644 drivers/usb/host/ehci-sead3.c

-- 
2.9.3

