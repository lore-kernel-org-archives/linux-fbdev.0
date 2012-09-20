From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 20 Sep 2012 16:33:18 +0000
Subject: [PATCHv5 0/2] Add support for the OLED in the CFA10036
Message-Id: <1348158800-23039-1-git-send-email-maxime.ripard@free-electrons.com>
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

Considering that the driver has been around since almost two months now, and
I have not received any comments on the framebuffer part, I'd very much like it
to be included in 3.7 if possible.

Thanks,
Maxime

Changes from v4:
  * Fix kernel crash when writing more data than the internal buffer space by
    adding boundary check for the fb_write function

Changes from v3:
  * Changed the dt property name to remove the leading oled- and changed the
    reset-gpio property to reset-gpios

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

Maxime Ripard (2):
  video: Add support for the Solomon SSD1307 OLED Controller
  ARM: dts: mxs: add oled support for the cfa-10036

 .../devicetree/bindings/video/ssd1307fb.txt        |   24 ++
 arch/arm/boot/dts/imx28-cfa10036.dts               |   20 +
 drivers/video/Kconfig                              |   13 +
 drivers/video/Makefile                             |    1 +
 drivers/video/ssd1307fb.c                          |  407 ++++++++++++++++++++
 5 files changed, 465 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ssd1307fb.txt
 create mode 100644 drivers/video/ssd1307fb.c

-- 
1.7.9.5

