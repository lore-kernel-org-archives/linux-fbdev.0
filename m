From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Mar 2012 17:43:48 +0000
Subject: [RFC/PATCH 0/6] SH Mobile LCDC MERAM-based frame buffer backing store
Message-Id: <1331833434-11934-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi everybody,

This patch set implements support for storing the frame buffer contents in the
on-chip SRAM (MERAM). This will allow keeping the display on while putting
system memory in a low-power mode (assuming the CPU is idle). The main use case
is to reduce power consumption on mobile platforms when the user doesn't
interact with the device and lets it lock itself automatically after a short
timeout.

This is a first implementation and improvements are possible (such as copying
the frame buffer content using DMA, possibly through the VEU to handle format
conversion). I've tested it on a Mackerel board.

Laurent Pinchart (6):
  sh_mobile_meram: Rename operations to cache_[alloc|free|update]
  sh_mobile_meram: Use direct function calls for the public API
  sh_mobile_meram: Add direct MERAM allocation API
  fbdev: sh_mobile_lcdc: Fix pan offset computation in YUV mode
  fbdev: sh_mobile_lcdc: Destroy mutex at remove time
  fbdev: sh_mobile_lcdc: Added MERAM-backed frame buffer support

 drivers/video/sh_mobile_lcdcfb.c |  254 +++++++++++++++++++++++++++----------
 drivers/video/sh_mobile_lcdcfb.h |   10 ++-
 drivers/video/sh_mobile_meram.c  |  227 +++++++++++++++++++---------------
 include/video/sh_mobile_lcdc.h   |    1 +
 include/video/sh_mobile_meram.h  |   71 ++++++++---
 5 files changed, 370 insertions(+), 193 deletions(-)

-- 
Regards,

Laurent Pinchart

