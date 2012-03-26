From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Mon, 26 Mar 2012 08:58:38 +0000
Subject: [PATCH v3 0/2] Add lcd driver for panels with gpio controlled panel reset
Message-Id: <1332751600-11371-1-git-send-email-thomas.abraham@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Changes since v2:
- Reworked as per comments[1] from Mark Brown.
  - removed the setting of regulator voltage.

[1] http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg08743.html

Changes since v1:
- Fixed gpio leak, added MODULE_DEVICE_TABLE and dev_pm_ops.
- Changed device tree bindings.

This patchset adds support for passive panels that use a nRESET line which is
controlled by a GPIO of the host system and which do not use a serial comamnd
interface (i2c or spi) or memory-mapped-io interface. Platforms that do not
require any additional control apart from the nRESET line can use this driver
for lcd power control.

The first patch adds driver for passive raster-type lcd's with gpio controlled
panel reset. It includes support for both dt and non-dt platforms. The second
patch adds support for using this driver on Origen board.

Thomas Abraham (2):
  backlight: lcd: add driver for raster-type lcd's with gpio controlled panel reset
  ARM: Exynos: Use lcd power control driver for lcd panel

 .../devicetree/bindings/lcd/lcd-pwrctrl.txt        |   36 +++
 arch/arm/mach-exynos/mach-origen.c                 |   29 +--
 drivers/video/backlight/Kconfig                    |    7 +
 drivers/video/backlight/Makefile                   |    1 +
 drivers/video/backlight/lcd_pwrctrl.c              |  226 ++++++++++++++++++++
 include/video/lcd_pwrctrl.h                        |   24 ++
 6 files changed, 300 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lcd/lcd-pwrctrl.txt
 create mode 100644 drivers/video/backlight/lcd_pwrctrl.c
 create mode 100644 include/video/lcd_pwrctrl.h

