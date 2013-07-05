From: Alison Wang <b18965@freescale.com>
Date: Fri, 05 Jul 2013 07:51:38 +0000
Subject: [PATCH 0/4] ARM: vf610: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <1373010702-9244-1-git-send-email-b18965@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This series contain DCU framebuffer driver for Freescale Vybrid VF610 platform.

The Display Controller Unit (DCU) module is a system master that
fetches graphics stored in internal or external memory and displays
them on a TFT LCD panel. A wide range of panel sizes is supported
and the timing of the interface signals is highly configurable.
Graphics are read directly from memory and then blended in real-time,
which allows for dynamic content creation with minimal CPU intervention.

The features:

(1) Full RGB888 output to TFT LCD panel.
(2) For the current LCD panel, WQVGA "480x272" is supported.
(3) Blending of each pixel using up to 4 source layers dependent on size of panel.
(4) Each graphic layer can be placed with one pixel resolution in either axis.
(5) Each graphic layer support RGB565 and RGB888 direct colors without alpha channel
and BGRA8888 direct colors with an alpha channel.
(6) Each graphic layer support alpha blending with 8-bit resolution.

----------------------------------------------------------------
Alison Wang (4):
      ARM: dts: vf610: Add DCU and TCON nodes
      ARM: dts: vf610-twr: Enable DCU and TCON devices
      ARM: clk: vf610: Add DCU and TCON clock support
      fb: Add DCU framebuffer driver for Vybrid VF610 platform

 arch/arm/boot/dts/vf610-twr.dts         |   10 +
 arch/arm/boot/dts/vf610.dtsi            |   18 ++
 arch/arm/mach-imx/clk-vf610.c           |    5 +
 drivers/video/Kconfig                   |    9 +
 drivers/video/Makefile                  |    1 +
 drivers/video/fsl-dcu-fb.c              | 1091 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/vf610-clock.h |    3 +-
 7 files changed, 1136 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/fsl-dcu-fb.c


