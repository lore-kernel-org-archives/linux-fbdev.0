From: Archit Taneja <archit@ti.com>
Date: Wed, 09 May 2012 10:22:47 +0000
Subject: [PATCH v4 0/9] OMAPDSS: APPLY: Treat overlay manager timings as shadow registers
Message-Id: <1336558256-26140-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
In-Reply-To: <1334561027-28569-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

An overlay manager's timings (the manager size, and blanking parameters if an
LCD manager) are DISPC shadow registers, and they should hence follow the
correct programming model.

This set makes the timings an extra_info parameter in manager's private data .
The interface drivers now apply the timings in instead of directly writing to
registers.

This change also prevents the need to use display resolution for overlay
checks, hence making some of the APPLY functions less dependent on the display.
Some DISPC functions that needed display width can also use these privately
stored timings.

Changes since v3:

- Remove direct setting of go bit in dpi_set_timings()
- Take some of the patches in "OMAPDSS: Misc fixes and cleanups" and make them a
  part of this series as they are more related.
- Don't have an initial set of manager timings in private data, only check
  manager and overlay parameters once the manager is enabled.

These patches apply over:

git://gitorious.org/linux-omap-dss2/linux.git dev

Reference tree containing this series:

git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git mgr_timing_and_fixes_2

Tested on OMAP4 SDP and Panda.

Archit Taneja (9):
  OMAPDSS: APPLY: Add manager timings as extra_info in private data
  OMAPDSS: Apply manager timings instead of direct DISPC writes
  OMAPDSS: MANAGER: Create a function to check manager timings
  OMAPDSS: APPLY: Don't check manager settings if it is disabled
  OMAPDSS: APPLY: Remove display dependency from overlay and manager
    checks
  OMAPDSS: DPI/HDMI: Apply manager timings even if panel is disabled
  OMAPDSS: APPLY: Remove an unnecessary omap_dss_device pointer
  OMAPDSS: DISPC: Remove omap_dss_device pointer usage from
    dispc_mgr_pclk_rate()
  OMAPDSS: DISPC: Remove usage of dispc_mgr_get_device()

 drivers/video/omap2/dss/apply.c   |  132 ++++++++++++++++++++++++++++---------
 drivers/video/omap2/dss/dispc.c   |   64 ++++++++----------
 drivers/video/omap2/dss/dpi.c     |    7 +-
 drivers/video/omap2/dss/dsi.c     |    5 +-
 drivers/video/omap2/dss/dss.h     |   16 +++--
 drivers/video/omap2/dss/hdmi.c    |    4 +-
 drivers/video/omap2/dss/manager.c |   19 +++++-
 drivers/video/omap2/dss/overlay.c |   10 +--
 drivers/video/omap2/dss/rfbi.c    |    4 +-
 drivers/video/omap2/dss/sdi.c     |    2 +-
 drivers/video/omap2/dss/venc.c    |    2 +-
 11 files changed, 175 insertions(+), 90 deletions(-)

-- 
1.7.5.4

