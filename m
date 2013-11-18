From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 18 Nov 2013 12:50:03 +0000
Subject: [PATCH 0/6] OMAPDSS: suspend/resume improvements
Message-Id: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

DISPC's suspend/resume works ok on mainline, but there was recently a bug with
TI's kernel containing support for newer SoCs. The bug was that not all DISPC
registers were restored correctly on resume.

While this bug is not in the mainline, I realized that the current
suspend/resume support in DISPC is rather silly, and can be done much more
efficiently.

This series improves the suspend/resume, making introducing similar bugs as
seen in TI kernel not possible, and cleans up the code quite a bit.

There's also a patch to use runtime PM's autosuspend with DSS devices, which
should reduce the on/off cycles when e.g. starting omapdss.

 Tomi

Tomi Valkeinen (6):
  OMAPDSS: APPLY: set infos to dirty on enable
  OMAPDSS: DISPC: Remove context restore
  OMAPDSS: DSS remove ctx stuff
  OMAPDSS: remove dss_get_ctx_loss_count
  OMAPDSS: add debug print for runtime suspend/resume
  OMAPDSS: use runtime PM's autosuspend

 arch/arm/mach-omap2/display.c   |   1 -
 drivers/video/omap2/dss/apply.c |  22 ++++
 drivers/video/omap2/dss/dispc.c | 262 ++--------------------------------------
 drivers/video/omap2/dss/dsi.c   |   9 +-
 drivers/video/omap2/dss/dss.c   | 103 ++++++----------
 drivers/video/omap2/dss/dss.h   |   4 +-
 drivers/video/omap2/dss/hdmi4.c |   9 +-
 drivers/video/omap2/dss/rfbi.c  |   9 +-
 drivers/video/omap2/dss/venc.c  |   9 +-
 include/video/omapdss.h         |   1 -
 10 files changed, 101 insertions(+), 328 deletions(-)

-- 
1.8.3.2

