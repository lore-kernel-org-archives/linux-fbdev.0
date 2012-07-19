From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 19 Jul 2012 00:39:13 +0000
Subject: [PATCH 0/9] SH Mobile LCDC and MERAM patches
Message-Id: <1342658362-19491-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

Here are 9 patches for the SH Mobile LCDC and MERAM drivers. Patches 1/9 to
4/9 and 9/9 have previously been posted as part of the "SH Mobile LCDC
MERAM-based frame buffer backing store" RFC series. Patch 5/9 has also been
posted as part of the same series, albeit included in patch 9/9.

As most of those patches have already been posted for review (patches 6/9 to
8/9 that haven't been posted already are small fixes), I plan to send a pull
request soon, to get the patches in v3.6 if possible.

Laurent Pinchart (9):
  sh_mobile_meram: Rename operations to cache_[alloc|free|update]
  sh_mobile_meram: Use direct function calls for the public API
  sh_mobile_meram: Add direct MERAM allocation API
  fbdev: sh_mobile_lcdc: Destroy mutex at remove time
  fbdev: sh_mobile_lcdc: Fix line pitch computation
  fbdev: sh_mobile_lcdc: Use channel configuration to initialize fb
    device
  fbdev: sh_mobile_lcdc: Support horizontal panning
  fbdev: sh_mobile_lcdc: Fix overlay registers update during pan
    operation
  fbdev: sh_mobile_lcdc: Fix pan offset computation in YUV mode

 drivers/video/sh_mobile_lcdcfb.c |  209 +++++++++++++++++----------------
 drivers/video/sh_mobile_lcdcfb.h |    5 +-
 drivers/video/sh_mobile_meram.c  |  235 +++++++++++++++++++++-----------------
 include/video/sh_mobile_meram.h  |   71 ++++++++----
 4 files changed, 293 insertions(+), 227 deletions(-)

-- 
Regards,

Laurent Pinchart

