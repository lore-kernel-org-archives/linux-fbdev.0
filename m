From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Wed, 24 Apr 2013 12:12:02 +0000
Subject: [PATCH 0/6] Davinci fbdev driver and enable it for DMx platform
Message-Id: <1366804808-22720-1-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Lad, Prabhakar <prabhakar.csengg@gmail.com>

This patch series adds an fbdev driver for Texas
Instruments Davinci SoC.The display subsystem consists
of OSD and VENC, with OSD supporting 2 RGb planes and 
2 video planes.
http://focus.ti.com/general/docs/lit/
getliterature.tsp?literatureNumber=sprue37d&fileType=pdf

A good amount of the OSD and VENC enabling code is
present in the kernel, and this patch series adds the 
fbdev interface.

The fbdev driver exports 4 nodes representing each
plane to the user - from fb0 to fb3.


Lad, Prabhakar (6):
  media: davinci: vpbe: fix checkpatch warning for CamelCase
  media: davinci: vpbe: enable vpbe for fbdev addition
  davinci: vpbe: add fbdev driver
  ARM: davinci: dm355: enable fbdev driver
  ARM: davinci: dm365: enable fbdev driver
  ARM: davinci: dm644x: enable fbdev driver

 arch/arm/mach-davinci/dm355.c                 |   24 +-
 arch/arm/mach-davinci/dm365.c                 |   10 +
 arch/arm/mach-davinci/dm644x.c                |   10 +
 drivers/media/platform/davinci/vpbe_display.c |    8 +-
 drivers/media/platform/davinci/vpbe_osd.c     |  820 ++++++++-
 drivers/media/platform/davinci/vpbe_venc.c    |   43 +
 drivers/video/Kconfig                         |   12 +
 drivers/video/Makefile                        |    1 +
 drivers/video/davincifb.c                     | 2523 +++++++++++++++++++++++++
 drivers/video/davincifb.h                     |  194 ++
 include/media/davinci/vpbe_osd.h              |   66 +-
 include/media/davinci/vpbe_venc.h             |   21 +
 12 files changed, 3702 insertions(+), 30 deletions(-)
 create mode 100644 drivers/video/davincifb.c
 create mode 100644 drivers/video/davincifb.h

-- 
1.7.4.1

