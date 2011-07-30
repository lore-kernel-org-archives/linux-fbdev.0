From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 30 Jul 2011 20:26:51 +0000
Subject: [PATCH 0/4] sh_mobile_meram cleanups and fixes
Message-Id: <1312057615-29123-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi everybody,

This patch series follows the sh_mobile_lcdc patches I've posted to the list.
As with the previous series, I've started with a readability patch that made
me find a bug. Patches 1/4, 2/4 and 4/4 are cleanups, and patch 3/4 fix the
bug. Please see individual patch descriptions for details.

Laurent Pinchart (4):
  fbdev: sh_mobile_meram: Replace hardcoded register values with macros
  fbdev: sh_mobile_meram: Validate ICB configuration outside mutex
  fbdev: sh_mobile_meram: Fix MExxCTL register save on runtime PM
    suspend
  fbdev: sh_mobile_meram: Remove unneeded sh_mobile_meram.h

 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 drivers/video/sh_mobile_meram.c  |  122 ++++++++++++++++++++++++++------------
 drivers/video/sh_mobile_meram.h  |   33 ----------
 3 files changed, 84 insertions(+), 73 deletions(-)
 delete mode 100644 drivers/video/sh_mobile_meram.h

-- 
Regards,

Laurent Pinchart

