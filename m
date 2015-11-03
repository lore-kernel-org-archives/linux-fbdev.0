From: Rongrong Zou <rongrongchau@outlook.com>
Date: Tue, 03 Nov 2015 13:54:55 +0000
Subject: [PATCH 0/3] Hisilicon graphic driver
Message-Id: <BLU437-SMTP248CA33D65A31EAE12675CC32B0@phx.gbl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Rongrong Zou <rongrongchau@163.com>

Hi1710 chip have a graphic modue with 2d acceleration, this driver support
the graphic module.

Rongrong Zou (3):
  Hisilicon graphic driver: add fbdev support to hisilicon hi1710
    graphic chip
  Hisilicon graphic driver: add hardware cursor support to hisilicon
    hi1710 graphi chip
  Hisilicon graphic driver: add 2d acceleration to hisilicon hi1710
    graphic chip

 MAINTAINERS                                 |    7 +
 drivers/video/fbdev/Kconfig                 |   14 +
 drivers/video/fbdev/Makefile                |    2 +-
 drivers/video/fbdev/hisilicon/Makefile      |    6 +
 drivers/video/fbdev/hisilicon/hisi_accel.c  |  382 ++++++++
 drivers/video/fbdev/hisilicon/hisi_accel.h  |   62 ++
 drivers/video/fbdev/hisilicon/hisi_chip.c   |  131 +++
 drivers/video/fbdev/hisilicon/hisi_chip.h   |   62 ++
 drivers/video/fbdev/hisilicon/hisi_cursor.c |  121 +++
 drivers/video/fbdev/hisilicon/hisi_cursor.h |   11 +
 drivers/video/fbdev/hisilicon/hisi_drv.c    | 1326 +++++++++++++++++++++++++++
 drivers/video/fbdev/hisilicon/hisi_drv.h    |  181 ++++
 drivers/video/fbdev/hisilicon/hisi_help.h   |   64 ++
 drivers/video/fbdev/hisilicon/hisi_hw.c     |  314 +++++++
 drivers/video/fbdev/hisilicon/hisi_hw.h     |   95 ++
 drivers/video/fbdev/hisilicon/hisi_mode.c   |  286 ++++++
 drivers/video/fbdev/hisilicon/hisi_mode.h   |   39 +
 drivers/video/fbdev/hisilicon/hisi_power.c  |  106 +++
 drivers/video/fbdev/hisilicon/hisi_power.h  |   18 +
 drivers/video/fbdev/hisilicon/hisi_reg.h    |  418 +++++++++
 20 files changed, 3644 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/fbdev/hisilicon/Makefile
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_accel.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_accel.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_chip.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_chip.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_cursor.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_cursor.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_drv.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_drv.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_help.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_hw.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_hw.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_mode.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_mode.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_power.c
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_power.h
 create mode 100644 drivers/video/fbdev/hisilicon/hisi_reg.h

-- 
1.9.1

