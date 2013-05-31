From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Fri, 31 May 2013 19:42:09 +0000
Subject: [PULL] FBDEV: some small fixes for 3.10-rc4
Message-Id: <20130531194209.GS19468@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Linus,

	This contain some small fixes for Atmel LCDC, ps3fb and OMAPDSS

please pull
The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/plagnioj/linux-fbdev.git tags/fbdev-for-3.10-rc4

for you to fetch changes up to 56c21b53ab071feb3ce93375a563ead745fa7105:

  atmel_lcdfb: blank the backlight on remove (2013-06-01 03:18:55 +0800)

----------------------------------------------------------------
fbdev: fixes for 3.10-rc4

This contains some small fixes

Atmel LCDC: fix blank the backlight on remove
ps3fb: fix compile warning
OMAPDSS: Fix crash with DT boot

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (1):
      Merge branch 'fbdev-3.10-fixes' of git://gitorious.org/linux-omap-dss2/linux into linux-fbdev/for-3.10-fixes

Richard Genoud (2):
      trivial: atmel_lcdfb: add missing error message
      atmel_lcdfb: blank the backlight on remove

Tomi Valkeinen (2):
      fbdev/ps3fb: fix compile warning
      OMAPDSS: Fix crash with DT boot

 drivers/gpu/drm/omapdrm/omap_drv.c       |    3 +++
 drivers/media/platform/omap/omap_vout.c  |    3 +++
 drivers/video/atmel_lcdfb.c              |   15 ++++++++++++---
 drivers/video/omap2/dss/core.c           |   20 +++++++++++++++++++-
 drivers/video/omap2/omapfb/omapfb-main.c |    3 +++
 drivers/video/ps3fb.c                    |    2 +-
 include/video/omapdss.h                  |    1 +
 7 files changed, 42 insertions(+), 5 deletions(-)

Brest Regards,
J.
