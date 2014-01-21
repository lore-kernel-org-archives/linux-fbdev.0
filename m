From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 11:59:21 +0000
Subject: [PATCH 0/2] fbdev: shmobile-lcdcfb: Fix sparse warnings
Message-Id: <1390305563-27229-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

The subject says it all, these two patches fix sparse warnings.

Laurent Pinchart (2):
  fbdev: shmobile-lcdcfb: Use NULL instead of 0 as NULL pointer
  fbdev: shmobile-lcdcfb: Fix sparse address space cast warning

 drivers/video/sh_mobile_lcdcfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Regards,

Laurent Pinchart

