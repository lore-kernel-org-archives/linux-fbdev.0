From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:16:21 +0000
Subject: [PATCH v3 00/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This series addresses simple changes to framebuffer drivers to use
arch_phys_wc_add() and ioremap_wc() as well as fixing gbefb to add
missing mtrr_del() calls. These changes are pretty straight forward.

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
 drivers/video/fbdev/gbefb.c                  | 18 ++++++------
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
 27 files changed, 104 insertions(+), 404 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

