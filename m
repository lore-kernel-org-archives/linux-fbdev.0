From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 31 Oct 2012 09:12:52 +0000
Subject: [PATCHv6 0/2] Add support for the OLED in the CFA10036
Message-Id: <1351674774-2891-1-git-send-email-maxime.ripard@free-electrons.com>
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

Considering that the driver has been around since almost three months now, and
I have not received any comments on the framebuffer part, I'd very much like it
to be included in 3.8 if possible.

Thanks,
Maxime

Changes from v5:
  * Fixed bogus reset code

Maxime Ripard (2):
  video: Add support for the Solomon SSD1307 OLED Controller
  ARM: dts: mxs: add oled support for the cfa-10036

 .../devicetree/bindings/video/ssd1307fb.txt        |   24 ++
 arch/arm/boot/dts/imx28-cfa10036.dts               |   19 +
 drivers/video/Kconfig                              |   13 +
 drivers/video/Makefile                             |    1 +
 drivers/video/ssd1307fb.c                          |  407 ++++++++++++++++++++
 5 files changed, 464 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ssd1307fb.txt
 create mode 100644 drivers/video/ssd1307fb.c

-- 
1.7.9.5

