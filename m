From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Date: Thu, 28 Jun 2012 09:52:05 +0000
Subject: [PATCH 0/4] Add LCD3 channel support
Message-Id: <cover.1340874806.git.cmahapatra@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

Hi everyone!
This following patch series enables LCD3 support which consists of two patches.

The 1st patch
 * adds enum mgr_reg_fields to describe various register fields manipulated for
   LCD support
 * replaces if-else checks for LCD implementation with simpler interface with
   the help of data from struct mgr_desc

The 2nd Patch
 * adds LCD3 channel support
 * updates DISPC registers for LCD3 support

The 3rd patch
 * enables LCD3 manager DSS feature
 * adds enables clock support for LCD3
 * adds IRQs specific to LCD3 manager

The 4th patch
 * enables dispc functions to provide dump functionality for clocks and IRQs
   specific to LCD3

This patch was based on mainline kernel v3.5rc4.

All your comments and suggestions are welcome.

Regards,
Chandrabhanu

Chandrabhanu Mahapatra (4):
  OMAPDSS: Cleanup implementation of LCD channels
  OMAPDSS: Add support for LCD3 channel
  OMAPDSS: Add LCD3 overlay manager and Clock and IRQ support
  OMAPDSS: Add dump and debug support for LCD3

 drivers/video/omap2/dss/dispc.c        |  351 ++++++++++++++++++--------------
 drivers/video/omap2/dss/dispc.h        |   28 +++
 drivers/video/omap2/dss/dsi.c          |    6 +-
 drivers/video/omap2/dss/dss.c          |   12 +-
 drivers/video/omap2/dss/dss.h          |    6 +
 drivers/video/omap2/dss/dss_features.h |    5 +-
 drivers/video/omap2/dss/manager.c      |   16 +-
 drivers/video/omap2/dss/overlay.c      |   14 +-
 include/video/omapdss.h                |    6 +
 9 files changed, 268 insertions(+), 176 deletions(-)

