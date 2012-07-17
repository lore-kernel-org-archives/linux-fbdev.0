From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 17 Jul 2012 15:59:43 +0000
Subject: [PATCH 0/4] Add support for the OLED in the CFA10036
Message-Id: <1342540787-14930-1-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi everyone,

This patchset adds support for the solomon SSD1307 OLED controller present
in the CFA-10036 board.

It first adds the framebuffer driver for this controller, and then the
needed bits to enable it in the cfa10036 dts.

Thanks,
Maxime

Maxime Ripard (4):
  video: Add support for the Solomon SSD1307 OLED Controller
  ARM: dts: mxs: Add alternative I2C muxing options for imx28
  ARM: dts: mxs: Add pwm4 muxing options for imx28
  ARM: dts: mxs: add oled support for the cfa-10036

 .../devicetree/bindings/video/ssd1307fb.txt        |   24 ++
 arch/arm/boot/dts/imx28-cfa10036.dts               |   20 +
 arch/arm/boot/dts/imx28.dtsi                       |   17 +
 drivers/video/Kconfig                              |   14 +
 drivers/video/Makefile                             |    1 +
 drivers/video/ssd1307fb.c                          |  414 ++++++++++++++++++++
 6 files changed, 490 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ssd1307fb.txt
 create mode 100644 drivers/video/ssd1307fb.c

-- 
1.7.9.5

