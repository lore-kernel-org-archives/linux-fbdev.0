From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 20 Jul 2011 11:24:23 +0000
Subject: [PATCH v2 0/6] sh_mobile_lcdc cleanup and fixes
Message-Id: <1311161069-11918-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi everybody,

Here's a second version of my sh_mobile_lcdc cleanup and fixes patch set.
Compared to v1, it adds three new patches that clean the driver's runtime PM
resume handling, and fix a panning issue on resume.

The first three patches have not been modified.

Laurent Pinchart (6):
  fbdev: sh_mobile_lcdc: Replace hardcoded register values with macros
  fbdev: sh_mobile_lcdc: Don't acknowlege interrupts unintentionally
  fbdev: sh_mobile_lcdc: Compute clock pattern using divider
    denominator
  fbdev: sh_mobile_lcdc: Split LCDC start code from
    sh_mobile_lcdc_start
  fbdev: sh_mobile_lcdc: Store the frame buffer base address when
    panning
  fbdev: sh_mobile_lcdc: Restart LCDC in runtime PM resume handler

 drivers/video/sh_mobile_lcdcfb.c |  582 +++++++++++++++++---------------------
 drivers/video/sh_mobile_lcdcfb.h |   12 +-
 include/video/sh_mobile_lcdc.h   |  135 ++++++++--
 3 files changed, 383 insertions(+), 346 deletions(-)

-- 
Regards,

Laurent Pinchart

