From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 04 Feb 2016 14:04:09 +0000
Subject: [PATCH 00/11] CLCD Nomadik+Versatile support
Message-Id: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is the result of some tiresome work to adopt the CLCD
driver to use device tree properly for Nomadik, Integrator,
Versatile and RealView.

The Nomadik support basically just adds some vendor data stuff
similar to what we have done for other drivers, but also add
as per-vendor .board_init() and .panel_init() hook.

These hooks are then used to handle panels on these boards.
Versatile is the most elaborate and took the most time, as it
is doing autodetection of the panel at runtime, and thus we
encode all possible panels in the DT and select the detected
panel at .panel_init() time.

The patches have been tested quite extensively on my Nomadik
NHK8815 and the ARM Integrator, Versatile, and RealView
reference designs, as well as on the more forgiving QEMU
emulation of Versatile.

Eventually I would like to have patches 1 thru 8 (those with
patches to CLCD or the DT bindings) applied through the FBDEV
subsystem, while I will take the SoC specifics (patches 9 thru 11,
and some non-included Nomadik patches) separately as it affects
multiple ARM SoC files.

Linus Walleij (11):
  video: ARM CLCD: backlight support for OF
  video: ARM CLCD: support DT signal inversion flags
  video: ARM CLCD: support pads connected in reverse order
  video: ARM CLCD: support Nomadik variant
  video: ARM CLCD: add special board and panel hooks for Nomadik
  Documentation/DT: add blurb for IB2 syscon to Versatile
  Documentation/DT: add Versatile display bindings
  video: ARM CLCD: add special panel hook for Versatiles
  ARM: PB11MPCore: define a standard VGA panel
  ARM: PB1176: define a standard VGA panel
  ARM: versatile: move CLCD configuration to device tree

 Documentation/devicetree/bindings/arm/arm-boards   |   8 +
 .../bindings/display/panel/epson,l2f50113t00.txt   |   7 +
 .../bindings/display/panel/sanyo,alr252rgt.txt     |   7 +
 .../bindings/display/panel/sanyo,tm38qv67a02a.txt  |   7 +
 .../bindings/display/panel/sharp,lq084v1dg21.txt   |   7 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/arm-realview-pb1176.dts          |  40 ++
 arch/arm/boot/dts/arm-realview-pb11mp.dts          |  19 +-
 arch/arm/boot/dts/versatile-ab-ib2.dts             |  20 +
 arch/arm/boot/dts/versatile-ab.dts                 | 203 ++++++++++-
 arch/arm/mach-versatile/versatile_dt.c             | 162 --------
 drivers/video/fbdev/Kconfig                        |   6 +-
 drivers/video/fbdev/Makefile                       |   1 +
 drivers/video/fbdev/amba-clcd-nomadik.c            | 263 +++++++++++++
 drivers/video/fbdev/amba-clcd-nomadik.h            |  24 ++
 drivers/video/fbdev/amba-clcd-versatile.c          | 406 +++++++++++++++++++++
 drivers/video/fbdev/amba-clcd-versatile.h          |  17 +
 drivers/video/fbdev/amba-clcd.c                    | 205 ++++++++++-
 include/linux/amba/clcd.h                          |  76 +++-
 20 files changed, 1279 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/epson,l2f50113t00.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sanyo,alr252rgt.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sanyo,tm38qv67a02a.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq084v1dg21.txt
 create mode 100644 arch/arm/boot/dts/versatile-ab-ib2.dts
 create mode 100644 drivers/video/fbdev/amba-clcd-nomadik.c
 create mode 100644 drivers/video/fbdev/amba-clcd-nomadik.h
 create mode 100644 drivers/video/fbdev/amba-clcd-versatile.h

-- 
2.4.3

