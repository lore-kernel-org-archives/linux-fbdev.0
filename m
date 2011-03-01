From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 01 Mar 2011 12:05:52 +0000
Subject: [RFC/PATCH 0/6] JZ4740: Add SLCD support
Message-Id: <cover.1298980528.git.mcuelenaere@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch series adds SLCD support to the Jz4740 framebuffer driver and adds a
LCD panel driver for the Truly G240400RTSW using the newly-exported SLCD data
transmission functions.

I'm not sure about the way I've handled this (jz4740_fb_slcd_*), so I marked
the relevant patches as RFC. This could be done by emulating SPI, but as this
seemed too much work for little benefit I picked the lazy way out.

Maurus Cuelenaere (6):
  FBDEV: JZ4740: Refactor GPIO pin operations
  FBDEV: JZ4740: Initialize jzfb->fb earlier
  FBDEV: JZ4740: Initialize framebuffer properly
  FBDEV: JZ4740: Add Smart LCD controller support
  FBDEV: JZ4740: Get rid of enumeration value not handled in switch
    warnings
  backlight: Add Truly G240400RTSW LCD panel driver

 arch/mips/include/asm/mach-jz4740/jz4740_fb.h |   61 +++-
 drivers/video/backlight/Kconfig               |    7 +
 drivers/video/backlight/Makefile              |    1 +
 drivers/video/backlight/truly_g240400rtsw.c   |  464 ++++++++++++++++++++++
 drivers/video/jz4740_fb.c                     |  524 +++++++++++++++++++++----
 include/video/truly_g240400rtsw.h             |   35 ++
 6 files changed, 990 insertions(+), 102 deletions(-)
 create mode 100644 drivers/video/backlight/truly_g240400rtsw.c
 create mode 100644 include/video/truly_g240400rtsw.h

-- 
1.7.4

