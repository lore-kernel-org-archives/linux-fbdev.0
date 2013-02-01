From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 01 Feb 2013 09:19:36 +0000
Subject: [PATCH v6 0/8] video: mmp display subsystem
Message-Id: <1359710376-8988-1-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

This series added support for display controller in
Marvell "mmp" series processors.
It also contains patches to enable display panel on
TTC_DKB board.

v6: changed abbreviations "ovly" to "overlay", updated
some define to functions, updated buffer alloc functions
and some minorish changes.
v5: rebased to 3.8RC3 and support common clock tree.
v4: added patches to enable display panel on TTC_DKB
board.
v3: registered lcd spi control as a spi master and
panel driver operations moved to standard spi bus
interface.
v2: removed change-id and blank lines.

Thanks,
-Zhou

Guoqing Li (1):
  video: mmp display controller support

Lisa Du (1):
  video: mmp: add tpo hvga panel supported

Zhou Zhu (6):
  video: mmp display subsystem
  video: mmp fb support
  video: mmpdisp: add spi port in display controller
  ARM: mmp: added device for display controller
  ARM: mmp: enable display in ttc_dkb
  ARM: mmp: add display and fb support in pxa910 defconfig

 arch/arm/configs/pxa910_defconfig         |    8 +
 arch/arm/mach-mmp/include/mach/pxa910.h   |    5 +-
 arch/arm/mach-mmp/pxa910.c                |    3 +
 arch/arm/mach-mmp/ttc_dkb.c               |   92 ++
 drivers/video/Kconfig                     |    1 +
 drivers/video/Makefile                    |    1 +
 drivers/video/mmp/Kconfig                 |   11 +
 drivers/video/mmp/Makefile                |    1 +
 drivers/video/mmp/core.c                  |  258 ++++
 drivers/video/mmp/fb/Kconfig              |   13 +
 drivers/video/mmp/fb/Makefile             |    1 +
 drivers/video/mmp/fb/mmpfb.c              |  684 ++++++++++
 drivers/video/mmp/fb/mmpfb.h              |   54 +
 drivers/video/mmp/hw/Kconfig              |   20 +
 drivers/video/mmp/hw/Makefile             |    2 +
 drivers/video/mmp/hw/mmp_ctrl.c           |  591 +++++++++
 drivers/video/mmp/hw/mmp_ctrl.h           | 1974 +++++++++++++++++++++++++++++
 drivers/video/mmp/hw/mmp_spi.c            |  180 +++
 drivers/video/mmp/panel/Kconfig           |    6 +
 drivers/video/mmp/panel/Makefile          |    1 +
 drivers/video/mmp/panel/tpo_tj032md01bw.c |  186 +++
 include/video/mmp_disp.h                  |  352 +++++
 22 files changed, 4443 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/mmp/Kconfig
 create mode 100644 drivers/video/mmp/Makefile
 create mode 100644 drivers/video/mmp/core.c
 create mode 100644 drivers/video/mmp/fb/Kconfig
 create mode 100644 drivers/video/mmp/fb/Makefile
 create mode 100644 drivers/video/mmp/fb/mmpfb.c
 create mode 100644 drivers/video/mmp/fb/mmpfb.h
 create mode 100644 drivers/video/mmp/hw/Kconfig
 create mode 100644 drivers/video/mmp/hw/Makefile
 create mode 100644 drivers/video/mmp/hw/mmp_ctrl.c
 create mode 100644 drivers/video/mmp/hw/mmp_ctrl.h
 create mode 100644 drivers/video/mmp/hw/mmp_spi.c
 create mode 100644 drivers/video/mmp/panel/Kconfig
 create mode 100644 drivers/video/mmp/panel/Makefile
 create mode 100644 drivers/video/mmp/panel/tpo_tj032md01bw.c
 create mode 100644 include/video/mmp_disp.h

-- 
1.7.9.5

