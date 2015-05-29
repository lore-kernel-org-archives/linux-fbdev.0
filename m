From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 29 May 2015 00:30:32 +0000
Subject: [PATCH v4 0/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <1432859434-17821-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Tomi,

Upon integration onto your tree of the series, "[PATCH v3 00/17] framebuffer:
simple conversions to arch_phys_wc_add()" the 0 day build bot found a
compilation issue on the gbefb driver. I had test compiled drivers with
allyesconfig and allmodconfig but failed to test compile against MIPS. This
driver is enabled *only for MIPS*.  For the life me I could not get a MIPS
cross compiler even on debian, so what I did to test this was incorporate into
my private tree a temporary patch [0] which enables this driver to compile on
x86 and go test compile with that as a temporary patch. The compilation was
failing since I used the info struct instead of the actual private data
structure. This fixes that and moves its assignment early.  Sorry about that.

The rest of the series does not require changes for integration after these
two patch replacements. Let me know if you'd like me to respin the entire
series though, but I didn't since I figured its pointless as the patches remain
intact. For your convenience however I've rebased all these 17 patches onto
your latest tree on the for-next branch, you can pull the changes with the
details provided below. This v4 iteration only carries the two patches which
required updates. The details of the full pull request go below this.

[0] http://drvbp1.linux-foundation.org/~mcgrof/patches/tmp/enable-gbefb-x86.patch

Luis R. Rodriguez (2):
  video: fbdev: gbefb: add missing mtrr_del() calls
  video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()

 drivers/video/fbdev/gbefb.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

The following changes since commit 36520841a443d5ee966f9632c417fcc8a25e07e3:

  video/console: use swap() in newport_bmove() (2015-05-27 12:54:49 +0300)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-framebuffer.git simple-arch_phys-20150528

for you to fetch changes up to 29b0c802f84943cac3658927452a2da4c976c632:

  video: fbdev: geode gxfb: use ioremap_wc() for framebuffer (2015-05-28 17:16:43 -0700)

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
 drivers/video/fbdev/gbefb.c                  | 21 +++++++-------
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
 27 files changed, 106 insertions(+), 405 deletions(-)
