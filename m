From: mathieu.poirier@linaro.org
Date: Tue, 15 May 2012 21:02:56 +0000
Subject: [PATCH 0/5] drivers/video: randconfig patches for kernel 3.4.patch
Message-Id: <1337115781-27979-1-git-send-email-mathieu.poirier@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, mathieu.poirier@linaro.org

From: Arnd Bergmann <arnd@arndb.de>

These patches fix miscellaneous problems when working
with make randconfig.  They were discovered on kernel
3.1-rc4 and have been reformatted for 3.4.

Arnd Bergmann (5):
  drivers/video: use correct __devexit_p annotation
  video/ili9320: do not mark exported functions __devexit
  video/console: automatically select a font
  drivers/savagefb: use mdelay instead of udelay
  drivers/tosa: driver needs I2C and SPI to compile

 drivers/video/backlight/Kconfig        |    2 +-
 drivers/video/backlight/ili9320.c      |    2 +-
 drivers/video/broadsheetfb.c           |    2 +-
 drivers/video/console/Kconfig          |   14 ++++++++++++++
 drivers/video/mbx/mbxfb.c              |    2 +-
 drivers/video/savage/savagefb_driver.c |   10 +++++-----
 6 files changed, 23 insertions(+), 9 deletions(-)

-- 
1.7.5.4

