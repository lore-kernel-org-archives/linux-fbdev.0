From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 23 Aug 2012 08:42:27 +0000
Subject: [PATCHv3 0/4]
Message-Id: <1345711351-16367-1-git-send-email-maxime.ripard@free-electrons.com>
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

Changes from v2:
  * Add the pin name as comment to the pwm4 pinctrl declaration
  * Change slightly the documentation of the dt bindings for the gpios to remove
    the mxs-specific cell.

Changes from v1:
  * Did some factorisation of the ssd1307fb_write* functions.
  * Filled the smem_start field of the fb_fix_screeninfo structure
  * Fixed the broken pwm declaration
  * Change the names of oled-reset-gpios and reset-active-low properties in the
    device tree to oled-reset-gpio and oled-reset-active-low for consistency

Maxime Ripard (4):
  video: Add support for the Solomon SSD1307 OLED Controller
  ARM: dts: mxs: Add alternative I2C muxing options for imx28
  ARM: dts: mxs: Add pwm4 muxing options for imx28
  ARM: dts: mxs: add oled support for the cfa-10036

 .../devicetree/bindings/video/ssd1307fb.txt        |   24 ++
 arch/arm/boot/dts/imx28-cfa10036.dts               |   20 +
 arch/arm/boot/dts/imx28.dtsi                       |   21 ++
 drivers/video/Kconfig                              |   13 +
 drivers/video/Makefile                             |    1 +
 drivers/video/ssd1307fb.c                          |  386 ++++++++++++++++++++
 6 files changed, 465 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ssd1307fb.txt
 create mode 100644 drivers/video/ssd1307fb.c

-- 
1.7.9.5

