From: Alison Wang <b18965@freescale.com>
Date: Thu, 15 Aug 2013 08:01:49 +0000
Subject: [PATCH v3 0/5] ARM: vf610: Add DCU framebuffer driver for Vybrid VF610 platform
Message-Id: <1376553714-25922-1-git-send-email-b18965@freescale.com>
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
(2) For the current LCD panel, WQVGA "480x272" is tested.
(3) Blending of each pixel using up to 4 source layers dependent on size of panel.
(4) Each graphic layer can be placed with one pixel resolution in either axis.
(5) Each graphic layer support RGB565 and RGB888 direct colors without alpha channel
and BGRA8888 direct colors with an alpha channel.
(6) Each graphic layer support alpha blending with 8-bit resolution.

Changes in v3:
- Correct DCU_MODE_BLEND_ITER macro definition.
- Remove hardcode panel description in the driver. Use the videomode helpers to get the relevant data from devicetree.
- Correct the wrong indentation.
- Use dev_* for printing messages in drivers.
- Change calc_div_ratio() to fsl_dcu_calc_div(), and rewrite this function.
- Use devm_request_irq() instead of request_irq().
- Drop useless code.
- Increase the layers number to the maximum 6.
- Use dma_alloc_writecombine() instead of dma_alloc_coherent().
- Use runtime PM.

Changes in v2:
- Add a document for DCU framebuffer driver under Documentation/devicetree/bindings/fb/.

----------------------------------------------------------------
Alison Wang (5):
      ARM: dts: vf610: Add DCU and TCON nodes
      ARM: dts: vf610-twr: Enable DCU and TCON devices
      ARM: clk: vf610: Add DCU and TCON clock support
      fb: Add DCU framebuffer driver for Vybrid VF610 platform
      Documentation: DT: Add DCU framebuffer driver

 Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt |   67 +++++
 arch/arm/boot/dts/vf610-twr.dts                     |   32 +++
 arch/arm/boot/dts/vf610.dtsi                        |   19 +-
 arch/arm/mach-imx/clk-vf610.c                       |    5 +
 drivers/video/Kconfig                               |   10 +
 drivers/video/Makefile                              |    1 +
 drivers/video/fsl-dcu-fb.c                          | 1095 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/vf610-clock.h             |    3 +-
 8 files changed, 1230 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fb/fsl-dcu-fb.txt
 create mode 100644 drivers/video/fsl-dcu-fb.c


