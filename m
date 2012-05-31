From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 31 May 2012 17:21:03 +0000
Subject: [PATCH 0/3] sh_mobile_lcdcfb overlays support
Message-Id: <1338484866-12237-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

These three patches implement overlays support for the sh_mobile_lcdcfb driver.

Compared to the previous version (posted as part of a larger patch set), the
sysfs entries are documented in Documentation/ABI and the DMA coherent memory
allocated for the planes is now freed at cleanup time.

Laurent Pinchart (3):
  fbdev: sh_mobile_lcdc: Constify sh_mobile_lcdc_fix structure
  fbdev: sh_mobile_lcdc: Rename fb operation handlers with a common
    prefix
  fbdev: sh_mobile_lcdc: Implement overlays support

 .../sysfs-devices-platform-sh_mobile_lcdc_fb       |   59 ++
 drivers/video/sh_mobile_lcdcfb.c                   | 1011 ++++++++++++++++++--
 include/video/sh_mobile_lcdc.h                     |    7 +
 3 files changed, 981 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-sh_mobile_lcdc_fb

-- 
Regards,

Laurent Pinchart

