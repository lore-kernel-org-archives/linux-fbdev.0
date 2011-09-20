From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Sep 2011 19:21:26 +0000
Subject: [PATCH v2 0/4] sh_mobile_meram cleanups and fixes
Message-Id: <1316546490-4639-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

Here's the second version of the sh_mobile_meram and cleanup fixes. Compared
to v1, I've incorporated Damian's comments in the register definitions (first
patch).

Laurent Pinchart (4):
  fbdev: sh_mobile_meram: Replace hardcoded register values with macros
  fbdev: sh_mobile_meram: Validate ICB configuration outside mutex
  fbdev: sh_mobile_meram: Fix MExxCTL register save on runtime PM
    suspend
  fbdev: sh_mobile_meram: Remove unneeded sh_mobile_meram.h

 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 drivers/video/sh_mobile_meram.c  |  125 ++++++++++++++++++++++++++------------
 drivers/video/sh_mobile_meram.h  |   33 ----------
 3 files changed, 87 insertions(+), 73 deletions(-)
 delete mode 100644 drivers/video/sh_mobile_meram.h

-- 
Regards,

Laurent Pinchart

