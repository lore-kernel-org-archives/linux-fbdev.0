From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 06 Jun 2011 03:39:00 +0000
Subject: [GIT PULL] fbdev fixes for 3.0-rc2
Message-Id: <20110606033900.GF26101@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/fbdev-3.x.git fbdev-fixes-for-linus

Which contains:

Andy Lutomirski (3):
      efifb: Enable write-combining
      efifb: Fix mismatched request/release_mem_region
      efifb: Disallow manual bind and unbind

Bruno PrÃƒÆ’Ã‚Â©mont (1):
      video: Fix use-after-free by vga16fb on rmmod

Joe Perches (1):
      video: Convert vmalloc/memset to vzalloc

Julia Lawall (2):
      drivers/video/imxfb.c: add missing clk_put
      drivers/video/pxa168fb.c: add missing clk_put

Paul Mundt (1):
      fbdev: sh_mobile_lcdcfb: Fix up fallout from MERAM changes.

Steven Miao (1):
      fbdev: bf537-lq035: add missing blacklight properties type

Tormod Volden (1):
      savagefb: Use panel CVT mode as default

 drivers/video/arcfb.c                  |    5 +--
 drivers/video/bf537-lq035.c            |    1 +
 drivers/video/broadsheetfb.c           |    4 +--
 drivers/video/efifb.c                  |   34 ++++++++++++++++++++-----------
 drivers/video/hecubafb.c               |    5 +--
 drivers/video/imxfb.c                  |    4 +-
 drivers/video/metronomefb.c            |    4 +--
 drivers/video/modedb.c                 |    1 +
 drivers/video/pxa168fb.c               |   17 +++++++++------
 drivers/video/savage/savagefb_driver.c |   16 +++++++++++++++
 drivers/video/sh_mobile_lcdcfb.c       |    4 +-
 drivers/video/vga16fb.c                |    2 +
 drivers/video/xen-fbfront.c            |    3 +-
 13 files changed, 63 insertions(+), 37 deletions(-)
