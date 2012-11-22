From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Nov 2012 14:39:51 +0000
Subject: [GIT PULL FOR v3.8] SH Mobile LCDC patches
Message-Id: <2641878.cGkiV3BMeH@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

Thank you for taking care of pull requests for the v3.8 merge window. Here's 
one already :-)

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:
  git://linuxtv.org/pinchartl/fbdev.git lcdc-next

Hideki EIRAKU (1):
      fbdev: sh_mobile_lcdc: use dma_mmap_coherent

Laurent Pinchart (19):
      fbdev: sh_mobile_lcdc: Get display dimensions from the channel structure
      fbdev: sh_mobile_lcdc: Rename mode argument to modes
      fbdev: sh_mobile_lcdc: Remove priv argument from channel and overlay 
init
      ARM: mach-shmobile: ag5evm: Add LCDC tx_dev field to platform data
      fbdev: sh_mipi_dsi: Add channel field to platform data
      ARM: mach-shmobile: Initiliaze the new sh_mipi_dsi_info channel field
      fbdev: sh_mipi_dsi: Use the sh_mipi_dsi_info channel field
      fbdev: sh_mipi_dsi: Use the LCDC entity default mode
      fbdev: sh_mipi_dsi: Remove last reference to LCDC platform data
      ARM: mach-shmobile: Remove the unused sh_mipi_dsi_info lcd_chan field
      fbdev: sh_mipi_dsi: Remove the unused sh_mipi_dsi_info lcd_chan field
      fbdev: sh_mobile_lcdc: Store the backlight brightness internally
      ARM: mach-shmobile: mackerel: Removed unused get_brightness callback
      sh: ap325rxa: Remove unused get_brightness LCDC callback
      sh: ecovec24: Remove unused get_brightness LCDC callback
      fbdev: sh_mobile_lcdc: Remove unused get_brightness pdata callback
      ARM: mach-shmobile: ag5evm: Use the backlight API for brightness control
      sh: kfr2r09: Use the backlight API for brightness control
      fbdev: sh_mobile_lcdc: Make sh_mobile_lcdc_sys_bus_ops static

 arch/arm/mach-shmobile/board-ag5evm.c       |  198 ++++++++++++++------------
 arch/arm/mach-shmobile/board-ap4evb.c       |    4 +-
 arch/arm/mach-shmobile/board-mackerel.c     |    6 -
 arch/sh/boards/mach-ap325rxa/setup.c        |    6 -
 arch/sh/boards/mach-ecovec24/setup.c        |    6 -
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |   16 +--
 arch/sh/boards/mach-kfr2r09/setup.c         |    7 +-
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |    6 +-
 drivers/video/sh_mipi_dsi.c                 |   69 ++++------
 drivers/video/sh_mobile_lcdcfb.c            |   74 +++++++----
 drivers/video/sh_mobile_lcdcfb.h            |    1 +
 include/video/sh_mipi_dsi.h                 |    4 +-
 include/video/sh_mobile_lcdc.h              |    1 -
 13 files changed, 192 insertions(+), 206 deletions(-)

-- 
Regards,

Laurent Pinchart

