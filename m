From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 29 May 2015 22:07:15 +0000
Subject: [PATCH v5 0/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <1432937236-9327-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Tomi,

this v5 series goes with the patch 3/17 titled "video: fbdev: gbefb:
use arch_phys_wc_add() and devm_ioremap_wc()" with a change from
dma_free_coherent() to dma_free_writecombine() for the area now allocated
with dma_alloc_writecombine(). The remaining patches remain the same.

As for the pull request all I did was reset my tree to yours, and
then reset it to the same old commit 36520841a443d5ee966f9632c417fcc8a25e07e3,
then applied the new series. The only delta from the v4 seires is the
patch 3/17. The new branch changes from simple-arch_phys-20150528 to
simple-arch_phys-20150529. Pull request below for your convenience.

Luis R. Rodriguez (1):
  video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()

 drivers/video/fbdev/gbefb.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

The following changes since commit 36520841a443d5ee966f9632c417fcc8a25e07e3:

  video/console: use swap() in newport_bmove() (2015-05-27 12:54:49 +0300)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-framebuffer.git simple-arch_phys-20150529

for you to fetch changes up to d8328b5f2175f1ae2f9dc4db6140af67c9196989:

  video: fbdev: geode gxfb: use ioremap_wc() for framebuffer (2015-05-29 14:57:49 -0700)

----------------------------------------------------------------
Luis R. Rodriguez (17):
      video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: gbefb: add missing mtrr_del() calls
      video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
      video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: neofb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
      video: fbdev: atmel_lcdfb: use ioremap_wc() for framebuffer
      video: fbdev: geode gxfb: use ioremap_wc() for framebuffer

 drivers/video/fbdev/atmel_lcdfb.c            |  3 +-
 drivers/video/fbdev/aty/aty128fb.c           | 36 ++++--------------------
 drivers/video/fbdev/aty/radeon_base.c        | 29 ++++----------------
 drivers/video/fbdev/aty/radeonfb.h           |  2 +-
 drivers/video/fbdev/gbefb.c                  | 25 ++++++++---------
 drivers/video/fbdev/geode/gxfb_core.c        |  3 +-
 drivers/video/fbdev/i810/i810.h              |  3 +-
 drivers/video/fbdev/i810/i810_main.c         | 11 +++++---
 drivers/video/fbdev/i810/i810_main.h         | 26 ------------------
 drivers/video/fbdev/intelfb/intelfb.h        |  4 +--
 drivers/video/fbdev/intelfb/intelfbdrv.c     | 38 +++-----------------------
 drivers/video/fbdev/matrox/matroxfb_base.c   | 36 +++++++++---------------
 drivers/video/fbdev/matrox/matroxfb_base.h   | 27 +-----------------
 drivers/video/fbdev/neofb.c                  | 26 +++++-------------
 drivers/video/fbdev/nvidia/nv_type.h         |  7 +----
 drivers/video/fbdev/nvidia/nvidia.c          | 37 ++++---------------------
 drivers/video/fbdev/pm2fb.c                  | 31 ++++-----------------
 drivers/video/fbdev/pm3fb.c                  | 30 ++++----------------
 drivers/video/fbdev/riva/fbdev.c             | 39 +++++---------------------
 drivers/video/fbdev/riva/rivafb.h            |  4 +--
 drivers/video/fbdev/savage/savagefb.h        |  4 +--
 drivers/video/fbdev/savage/savagefb_driver.c | 17 ++----------
 drivers/video/fbdev/sis/sis.h                |  2 +-
 drivers/video/fbdev/sis/sis_main.c           | 27 ++++--------------
 drivers/video/fbdev/tdfxfb.c                 | 41 ++++------------------------
 include/video/neomagic.h                     |  5 +---
 include/video/tdfx.h                         |  2 +-
 27 files changed, 108 insertions(+), 407 deletions(-)
