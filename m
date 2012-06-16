From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 16 Jun 2012 14:07:14 +0000
Subject: [PULL for v3.6] SH Mobile LCDC fixes and planes support
Message-Id: <3246665.HJN7RE5zfe@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

Could you please pull the following LCDC patches ?

The following changes since commit b67989515defba7412acff01162e5bb1f0f5923a:

  video: s3c-fb: fix possible division by zero in s3c_fb_calc_pixclk 
(2012-06-13 17:34:16 +0000)

are available in the git repository at:
  git://linuxtv.org/pinchartl/fbdev.git planes

Guennadi Liakhovetski (1):
      fbdev: sh_mipi_dsi: fix a section mismatch

Laurent Pinchart (4):
      fbdev: sh_mobile_lcdc: Don't confuse line size with pitch
      fbdev: sh_mobile_lcdc: Constify sh_mobile_lcdc_fix structure
      fbdev: sh_mobile_lcdc: Rename fb operation handlers with a common prefix
      fbdev: sh_mobile_lcdc: Implement overlays support

 .../sysfs-devices-platform-sh_mobile_lcdc_fb       |   44 +
 drivers/video/sh_mipi_dsi.c                        |    7 +-
 drivers/video/sh_mobile_lcdcfb.c                   |  987 +++++++++++++++++--
 drivers/video/sh_mobile_lcdcfb.h                   |    1 +
 include/video/sh_mobile_lcdc.h                     |    7 +
 5 files changed, 944 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-
sh_mobile_lcdc_fb

-- 
Regards,

Laurent Pinchart

