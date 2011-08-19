From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 19 Aug 2011 08:44:51 +0000
Subject: [PULL] SH mobile LCDC cleanups and fixes
Message-Id: <201108191044.52130.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian,

Here are the latest SH mobile LCDC and MERAM cleanups and fixes based on top
of v3.1-rc2. All the patches have been posted to the list. I've incorporated
acked-by and tested-by lines when available, but most of the patches received
no comment.

The following changes since commit 93ee7a9340d64f20295aacc3fb6a22b759323280:

  Linux 3.1-rc2 (2011-08-14 15:09:08 -0700)

are available in the git repository at:
  git://linuxtv.org/pinchartl/fbdev.git sh-mobile-lcdc

Damian Hobson-Garcia (5):
      fbdev: sh_mobile_meram: Enable runtime PM
      fbdev: sh_mobile_meram: Enable/disable MERAM along with LCDC
      fbdev: sh_mobile_meram: Move private data from .h to .c
      fbdev: sh_mobile_meram: Backup/restore device registers on shutdown/resume
      fbdev: sh_mobile_meram: Assign meram to the SH7372_A4LC power domain

Laurent Pinchart (11):
      fbdev: sh_mobile_lcdc: Turn dot clock on before resuming from runtime PM
      fbdev: sh_mobile_lcdc: Replace hardcoded register values with macros
      fbdev: sh_mobile_lcdc: Don't acknowlege interrupts unintentionally
      fbdev: sh_mobile_lcdc: Compute clock pattern using divider denominator
      fbdev: sh_mobile_lcdc: Split LCDC start code from sh_mobile_lcdc_start
      fbdev: sh_mobile_lcdc: Store the frame buffer base address when panning
      fbdev: sh_mobile_lcdc: Restart LCDC in runtime PM resume handler
      fbdev: sh_mobile_meram: Replace hardcoded register values with macros
      fbdev: sh_mobile_meram: Validate ICB configuration outside mutex
      fbdev: sh_mobile_meram: Fix MExxCTL register save on runtime PM suspend
      fbdev: sh_mobile_meram: Remove unneeded sh_mobile_meram.h

 arch/arm/mach-shmobile/board-mackerel.c |    1 +
 drivers/video/sh_mobile_lcdcfb.c        |  592 ++++++++++++++-----------------
 drivers/video/sh_mobile_lcdcfb.h        |   12 +-
 drivers/video/sh_mobile_meram.c         |  202 +++++++++--
 drivers/video/sh_mobile_meram.h         |   41 ---
 include/video/sh_mobile_lcdc.h          |  135 ++++++-
 6 files changed, 556 insertions(+), 427 deletions(-)
 delete mode 100644 drivers/video/sh_mobile_meram.h

-- 
Regards,

Laurent Pinchart
