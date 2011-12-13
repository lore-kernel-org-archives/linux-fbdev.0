From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:01:55 +0000
Subject: [PATCH 00/57] SH Mobile LCDC: rework DSI/HDMI interface and add overlays support
Message-Id: <1323784972-24205-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi everybody,

First of all, sorry for the patch bomb. I usually try to send smaller patch
sets by splitting them into coherent subsets, but getting the code in a proper
shape took time and required several iterations of the whole set.

These patches can be divided in 4 groups.

- Patches 01 to 29 rework the interface between the LCDC and MIPI/DSI and HDMI
  drivers. The MIPI/DSI and HDMI drivers are now FB-agnostic, except for the
  usage of the fb_videomode structure used to pass video mode information to
  the LCDC driver.

- Patches 30 to 38 perform additional cleanup to the LCDC driver made possible
  by the previous patches.

- Patches 39 to 54 rework the MERAM driver to allocate ICBs and MERAM regions
  automatically instead of relying on manually allocated regions specified in
  platform data. They're a first step in the longer term goal of making MERAM
  usable for other purpose than LCDC cache.

- Patches 55 to 57 add overlays support to the LCDC driver. They should be
  considered as a prototype implementation for now. I plan to rework them, but
  early feedback is always appreciated.

I would like to push patches 01 to 54 (after review of course) to v3.4 (or
v3.3 if time and review permits).

Laurent Pinchart (57):
  fbdev: sh_mobile_lcdc: Reorder code into sections
  fbdev: sh_mobile_lcdc: Mark init-only symbols with __devinit(const)
  fbdev: sh_mobile_lcdc: Move pm runtime enable to probe()
  fbdev: sh_mobile_lcdc: Don't pass struct device around
  fbdev: sh_mobile_lcdc: Create functions to turn the display on/off
  fbdev: sh_mobile_hdmi: Don't access LCDC channel in notifier callback
  sh_mobile_hdmi: Remove platform data lcd_dev field
  fbdev: sh_mobile_lcdc: Add sh_mobile_lcdc_entity definition
  fbdev: sh_mobile_hdmi: Implement sh_mobile_lcdc_entity interface
  fbdev: sh_mipi_dsi: Implement sh_mobile_lcdc_entity interface
  fbdev: sh_mobile_lcdc: Handle HDMI/MIPI transmitter device directly
  arm: mach-shmobile: Add LCDC tx_dev field to platform data
  fbdev: sh_mipi_dsi: Don't hook up into board_cfg display operations
  fbdev: sh_mobile_hdmi: Don't hook up into board_cfg display
    operations
  arm: mach-shmobile: Don't initialize the hdmi_info lcd_chan field
  fbdev: sh_mobile_hdmi: Remove sh_mobile_hdmi_info lcd_chan field
  fbdev: sh_mobile_lcdc: Remove board configuration owner field
  fbdev: sh_mobile_lcdc: Remove board configuration board_data field
  fbdev: sh_mobile_lcdc: Move brightness ops to sh_mobile_lcdc_bl_info
  fbdev: sh_mobile_lcdc: Merge board_cfg and lcd_size_cfg into
    panel_cfg
  sh_mobile_lcdc: Add an lcdc channel pointer to sh_mobile_lcdc_entity
  sh_mobile_hdmi: Use sh_mobile_lcdc_entity::channel to access fb_info
  fbdev: sh_mobile_lcdc: Remove fb_info parameter to display_on
    operation
  fbdev: sh_mobile_lcdc: Return display connection state in display_on
  sh_mobile_lcdc: Add display notify callback to sh_mobile_lcdc_chan
  sh_mobile_hdmi: Use LCDC notification callback
  fbdev: sh_mobile_lcdc: Pass a video mode to the notify callback
  fbdev: sh_mobile_hdmi: Don't set sh_hdmi::mode in the display on
    handler
  fbdev: sh_mobile_hdmi: Don't access LCDC fb_info
  fbdev: sh_mobile_lcdc: Store display mode in a struct fb_videomode
  fbdev: sh_mobile_lcdc: Rename (lcd|num)_cfg (lcd|num)_modes
  fbdev: sh_mobile_lcdc: Reorganize the sh_mobile_lcdc_chan structure
  fbdev: sh_mobile_lcdc: Add sh_mobile_format_info() function
  fbdev: sh_mobile_lcdc: Store the format in struct sh_mobile_lcdc_chan
  fbdev: sh_mobile_lcdc: Split fb init/cleanup from channel
    init/cleanup
  fbdev: sh_mobile_lcdc: Pass physical device pointer to DMA functions
  fbdev: sh_mobile_lcdc: Store configuration in channel structure
  fbdev: sh_mobile_lcdc: Pass channel pointer to
    sh_mobile_wait_for_vsync
  arm: mach-shmobile: Split MERAM resources into regs and meram
  fbdev: sh_mobile_meram: Request memory regions for memory resources
  fbdev: sh_mobile_meram: Add _cfg suffix to struct sh_mobile_meram_icb
  fbdev: sh_mobile_meram: Make variables unsigned where applicable
  fbdev: sh_mobile_meram: Make current_reg field store the current reg
    set
  fbdev: sh_mobile_meram: Add struct sh_mobile_meram_icb
  fbdev: sh_mobile_meram: Don't inline everything
  fbdev: sh_mobile_meram: Divide the code into sections
  fbdev: sh_mobile_meram: Use genalloc to manage MERAM allocation
  fbdev: sh_mobile_meram: Allocate ICBs automatically
  arm: mach-shmobile: Don't set MERAM ICB numbers in platform data
  fbdev: sh_mobile_meram: Remove unused sh_mobile_meram_icb_cfg fields
  fbdev: sh_mobile_lcdc: Don't store copy of platform data
  arm: mach-shmobile: Constify sh_mobile_meram_cfg structures
  fbdev: sh_mobile_meram: Don't perform update in register operation
  fbdev: sh_mobile_meram: Remove unneeded sanity checks
  fbdev: sh_mobile_lcdc: Constify sh_mobile_lcdc_fix structure
  fbdev: sh_mobile_lcdc: Rename fb operation handlers with a common
    prefix
  fbdev: sh_mobile_lcdc: Implement overlays support

 arch/arm/mach-shmobile/board-ag5evm.c       |   24 +-
 arch/arm/mach-shmobile/board-ap4evb.c       |  289 ++--
 arch/arm/mach-shmobile/board-mackerel.c     |  106 +-
 arch/sh/boards/mach-ap325rxa/setup.c        |   22 +-
 arch/sh/boards/mach-ecovec24/setup.c        |   20 +-
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |   10 +-
 arch/sh/boards/mach-kfr2r09/setup.c         |    8 +-
 arch/sh/boards/mach-migor/lcd_qvga.c        |    3 +-
 arch/sh/boards/mach-migor/setup.c           |   16 +-
 arch/sh/boards/mach-se/7724/setup.c         |   12 +-
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |   16 +-
 arch/sh/include/mach-migor/mach/migor.h     |    2 +-
 drivers/video/Kconfig                       |    1 +
 drivers/video/sh_mipi_dsi.c                 |   97 +-
 drivers/video/sh_mobile_hdmi.c              |  297 +---
 drivers/video/sh_mobile_lcdcfb.c            | 2357 +++++++++++++++++++--------
 drivers/video/sh_mobile_lcdcfb.h            |   84 +-
 drivers/video/sh_mobile_meram.c             |  673 ++++----
 include/video/sh_mobile_hdmi.h              |    2 -
 include/video/sh_mobile_lcdc.h              |   42 +-
 include/video/sh_mobile_meram.h             |   40 +-
 21 files changed, 2518 insertions(+), 1603 deletions(-)

-- 
Regards,

Laurent Pinchart

