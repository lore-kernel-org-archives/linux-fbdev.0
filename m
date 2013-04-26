From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 26 Apr 2013 20:02:14 +0000
Subject: [PATCH 0/9] s3c24xx LCD controller driver cleanup
Message-Id: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch series moves the s3c2410fb driver header files from 
arch/arm/mach-s3c24xx to the driver specific directories. It 
also includes couple cleanups to the driver itself and a patch 
actually enabling the display during initialization, so it works
with FRAMEBUFFER_CONSOLE disabled.

Patches 6...9 have no dependencies on rest of the series.

The whole series is also available at:
git://github.com/snawrocki/linux.git cleanup/s3c2410fb

It has been tested on the Micro2440 board.

Sylwester Nawrocki (9):
  s3c2410fb: Move platform data declarations to
    include/linux/platform_data
  s3c2410fb: Make most of register definitions local
  ARM: S3C24XX: Remove include/mach/regs-lcd.h header file
  s3c2410fb: Register single platform driver
  s3c2410fb: Use dev_pm_ops
  s3c2410fb: Enable display by default
  s3c2410fb: Use devm_ioremap_resource()
  s3c2410fb: Remove redundant platform_set_drvdata()
  s3c2410fb: Use module parameter instead of a sysfs entry

 arch/arm/mach-s3c24xx/dma-s3c2410.c             |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2412.c             |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2440.c             |    1 -
 arch/arm/mach-s3c24xx/dma-s3c2443.c             |    1 -
 arch/arm/mach-s3c24xx/include/mach/fb.h         |    1 -
 arch/arm/mach-s3c24xx/include/mach/regs-lcd.h   |  162 ----------------------
 arch/arm/mach-s3c24xx/mach-anubis.c             |    1 -
 arch/arm/mach-s3c24xx/mach-at2440evb.c          |    3 +-
 arch/arm/mach-s3c24xx/mach-bast.c               |    3 +-
 arch/arm/mach-s3c24xx/mach-gta02.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-h1940.c              |    3 +-
 arch/arm/mach-s3c24xx/mach-jive.c               |    3 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c           |    3 +-
 arch/arm/mach-s3c24xx/mach-n30.c                |    3 +-
 arch/arm/mach-s3c24xx/mach-osiris.c             |    1 -
 arch/arm/mach-s3c24xx/mach-qt2410.c             |    3 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c             |    3 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c           |    3 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c           |    1 -
 arch/arm/mach-s3c24xx/mach-smdk2440.c           |    3 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c           |    3 +-
 arch/arm/mach-s3c24xx/mach-vstms.c              |    4 +-
 arch/arm/plat-samsung/devs.c                    |    2 +-
 arch/arm/plat-samsung/include/plat/fb-s3c2410.h |   72 ----------
 drivers/video/s3c2410fb.c                       |  165 ++++++-----------------
 drivers/video/s3c2410fb.h                       |  114 +++++++++++++++-
 include/linux/platform_data/fb-s3c2410.h        |  106 +++++++++++++++
 27 files changed, 272 insertions(+), 396 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/fb.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-lcd.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/fb-s3c2410.h
 create mode 100644 include/linux/platform_data/fb-s3c2410.h

-- 
1.7.4.1

