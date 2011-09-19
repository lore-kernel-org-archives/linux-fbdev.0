From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:38 +0000
Subject: [WIP/RFC 00/31] sh_mobile_lcdc: Media controller prototype
Message-Id: <1316392089-27598-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi everybody,

I've tried to clean up the sh_mobile_lcdcfb driver and the associated HDMI and
MIPI transmitters drivers.

Both transmitter drivers hook up into the LCDC driver by hijacking the display
on/off operations pointers transparently, and accessing the LCDC fb_info
structure directly. Beside not being clean and very reusable, that approach is
prone to race conditions. In other words, I don't really like it.

With my V4L background, I've tried to implement a proof of concept of "fbdev
entities", currently limited to the sh_mobile_lcdcfb driver (hence the struct
sh_mobile_lcdc_entity instead of struct fb_entity). Here's the result, with an
implementation of the media controller API as the icing on the cake.

The idea behind those patches it to isolate the SH mobile HDMI and MIPI
transmitters drivers from the LCDC driver. To achieve this, the transmitters
create a struct sh_mobile_lcdc_entity instance and fill it with pointers to
abstract operations. The LCDC driver gets hold of a pointer to the associated
sh_mobile_lcdc_entity through platform data (this currently relies on probe
order and probably needs to be cleaned up), and calls those abstract operations
to control the display. It also fills the entity structure with a pointer to
itself (this should be replaced by an abstract fb_host/fb_master/fb_something)
to provide the transmitter drivers with a notification callback.

The last 6 patches implement the media controller API on top of that. The result
is the ability for userspace applications to discover the internal device
topology. Two (rather unimpressive :-)) topology examples generated
automatically can be found at http://www.ideasonboard.org/media/lcdc0.ps and
http://www.ideasonboard.org/media/lcdc1.ps. With more complex hardware (or with
support for more complex hardware features such as multiple overlays in the
sh_mobile_lcdcfb driver), the MC API will allow discovering overlays and other
hardware blocks, which is the first step required to control them.

Comments will be very warmly welcomed (provided that you don't start a flame
war :-)).

Laurent Pinchart (31):
  fbdev: sh_mobile_lcdc: Reorder code into sections
  fbdev: sh_mobile_lcdc: Mark init-only symbols with __devinit(const)
  fbdev: sh_mobile_lcdc: Move pm runtime enable to probe()
  fbdev: sh_mobile_lcdc: Don't pass struct device around
  fbdev: sh_mobile_lcdc: Create functions to turn the display on/off
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
  media: Initialize media controller core with subsys_initcall
  fbdev: Add media controller support
  fbdev: sh_mobile_lcdc: Make LCDC entity inherit from media_entity
  fbdev: sh_mipi_dsi: Add media controller support
  fbdev: sh_mobile_hdmi: Add media controller support
  fbdev: sh_mobile_lcdc: Add media controller support

 arch/arm/mach-shmobile/board-ag5evm.c       |   20 +-
 arch/arm/mach-shmobile/board-ap4evb.c       |  278 +++++-----
 arch/arm/mach-shmobile/board-mackerel.c     |   78 ++--
 arch/sh/boards/mach-ap325rxa/setup.c        |   18 +-
 arch/sh/boards/mach-ecovec24/setup.c        |   12 +-
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |   10 +-
 arch/sh/boards/mach-kfr2r09/setup.c         |    4 +-
 arch/sh/boards/mach-migor/lcd_qvga.c        |    3 +-
 arch/sh/boards/mach-migor/setup.c           |    8 +-
 arch/sh/boards/mach-se/7724/setup.c         |    4 +-
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |   16 +-
 arch/sh/include/mach-migor/mach/migor.h     |    2 +-
 drivers/media/media-devnode.c               |    4 +-
 drivers/video/Kconfig                       |    1 +
 drivers/video/fbmem.c                       |   21 +
 drivers/video/fbsysfs.c                     |   11 +
 drivers/video/sh_mipi_dsi.c                 |   72 ++--
 drivers/video/sh_mobile_hdmi.c              |  226 ++------
 drivers/video/sh_mobile_lcdcfb.c            |  744 ++++++++++++++++++---------
 drivers/video/sh_mobile_lcdcfb.h            |   41 ++-
 include/linux/fb.h                          |    8 +
 include/video/sh_mobile_hdmi.h              |    2 -
 include/video/sh_mobile_lcdc.h              |   29 +-
 23 files changed, 900 insertions(+), 712 deletions(-)

-- 
Regards,

Laurent Pinchart

