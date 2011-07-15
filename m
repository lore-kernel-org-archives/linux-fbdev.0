From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 15 Jul 2011 21:52:30 +0000
Subject: [PATCH 0/3] sh_mobile_lcdc cleanup and fixes
Message-Id: <1310766753-30314-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi everybody,

When trying to understand the sh_mobile_lcdc driver, I found it hard to read
statements that include hardcoded register values. I thus wrote a patch that
replace them with macros, making the code more readable.

While doing so, I found two potential issues in the driver. See patches 2 and
3 for detailed explanations and fixes.

Laurent Pinchart (3):
  fbdev: sh_mobile_lcdc: Replace hardcoded register values with macros
  fbdev: sh_mobile_lcdc: Don't acknowlege interrupts unintentionally
  fbdev: sh_mobile_lcdc: Compute clock pattern using divider
    denominator

 drivers/video/sh_mobile_lcdcfb.c |  232 +++++++++++++++++---------------------
 include/video/sh_mobile_lcdc.h   |  135 +++++++++++++++++++---
 2 files changed, 222 insertions(+), 145 deletions(-)

-- 
Best regards,

Laurent Pinchart

