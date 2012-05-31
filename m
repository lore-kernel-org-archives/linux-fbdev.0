From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 31 May 2012 16:33:58 +0000
Subject: [PATCH 0/2] SH Mobile MERAM fix
Message-Id: <1338482040-29827-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

These two patches add MERAM operations wrappers. As the MERAM is used by a new
DRM driver I'm working on for the same hardware, I don't want the operations
to be accessed directly. This is a first step in getting rid of the MERAM
platform device pointer in the LCDC platform data.

Laurent Pinchart (2):
  fbdev: sh_mobile_meram: Add MERAM operations wrappers
  fbdev: sh_mobile_lcdc: Use MERAM operations wrappers

 drivers/video/sh_mobile_lcdcfb.c |   18 +++++++-----------
 drivers/video/sh_mobile_meram.c  |   24 ++++++++++++------------
 include/video/sh_mobile_meram.h  |   28 ++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 23 deletions(-)

-- 
Regards,

Laurent Pinchart

