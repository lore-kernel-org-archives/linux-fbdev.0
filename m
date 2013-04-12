From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 12 Apr 2013 08:00:01 +0000
Subject: [PATCH RESEND 0/2] Add support for the Solomon SSD1306 OLED Controller
Message-Id: <1365753603-4438-1-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

This patchset adds the needed bits to the ssd1307fb driver to support the
very similar Solomon SSD1306 controller.

Since the SSD1307 has been replaced by the SSD1306 in the latest CFA-10036
production samples, we also need to change the device tree accordingly.

Thanks,
Maxime

Maxime Ripard (2):
  video: ssd1307fb: Add support for SSD1306 OLED controller
  ARM: dts: cfa10036: Change the OLED display to SSD1306

 .../devicetree/bindings/video/ssd1307fb.txt        |   10 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |   14 +-
 arch/arm/boot/dts/imx28-cfa10049.dts               |    4 +-
 drivers/video/ssd1307fb.c                          |  267 ++++++++++++++------
 4 files changed, 210 insertions(+), 85 deletions(-)

-- 
1.7.10.4

