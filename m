From: Alexander Shiyan <shc_work@mail.ru>
Date: Thu, 20 Mar 2014 16:24:33 +0000
Subject: [PATCH 0/3] video: clps711x: New CLPS711X FB driver
Message-Id: <1395332675-23135-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This series adds a new framebuffer driver for Cirrus Logic CLPS711X
CPUs. Since all code rewritten from scratch, patch is designed as a
replacement of the old (not updated for a long time) for a new one.
The second part of the patch affects changes for the ARM CLPS711X
core subsystem, so ACK from the ARM maintainers would be useful.
Patch originally designed for apply to the video subsystem, but I
have no prejudice it and if it will be applied to the arm-soc branch,
this will also be good.

Alexander Shiyan (3):
  video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
  video: clps711x: Switch CLPS711X boards to use new FB driver
  video: clps711x: Add bindings documentation for CLPS711X framebuffer

 .../bindings/video/cirrus,clps711x-fb.txt          |  48 +++
 arch/arm/mach-clps711x/board-autcpu12.c            |   2 +-
 arch/arm/mach-clps711x/board-edb7211.c             |   2 +-
 arch/arm/mach-clps711x/board-p720t.c               |   2 +-
 arch/arm/mach-clps711x/devices.c                   |  17 +
 arch/arm/mach-clps711x/devices.h                   |   1 +
 drivers/video/fbdev/Kconfig                        |  18 +-
 drivers/video/fbdev/Makefile                       |   2 +-
 drivers/video/fbdev/clps711x-fb.c                  | 456 +++++++++++++++++++++
 drivers/video/fbdev/clps711xfb.c                   | 315 --------------
 10 files changed, 537 insertions(+), 326 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/cirrus,clps711x-fb.txt
 create mode 100644 drivers/video/fbdev/clps711x-fb.c
 delete mode 100644 drivers/video/fbdev/clps711xfb.c

-- 
1.8.3.2

