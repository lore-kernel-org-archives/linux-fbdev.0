From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Sep 2012 10:35:21 +0000
Subject: [PATCH 0/6] OMAPDSS: remove cpu_is_* calls
Message-Id: <1348828527-13309-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <a0393947@ti.com>, Chandrabhanu Mahapatra <cmahapatra@ti.com>, =?UTF-8?q?Rapha=C3=ABl=20Ass=C3=A9nat?= <raph@8d.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This series adds an omapdss_version enum that is passed via platform data to
omapdss driver. This version identifier is then used instead of cpu_is_*()
calls.

After these, omapdss no longer contains any plat/ or mach/ includes. omapfb,
vrfb and vram still do, though.

 Tomi

Tomi Valkeinen (6):
  OMAPDSS: add omapdss_version
  OMAPDSS: use omapdss_version in dss_features.c
  OMAPDSS: DISPC: use omapdss_version
  OMAPDSS: DSS: use omapdss_version
  OMAPDSS: HDMI: use omapdss_version
  OMAPDSS: remove <plat/cpu.h> includes

 arch/arm/mach-omap2/display.c          |   38 +++++++++++++++++++
 drivers/video/omap2/dss/core.c         |    2 +-
 drivers/video/omap2/dss/dispc.c        |   41 +++++++++++++-------
 drivers/video/omap2/dss/dss.c          |   39 +++++++++++++------
 drivers/video/omap2/dss/dss_features.c |   64 ++++++++++++++++++++++----------
 drivers/video/omap2/dss/dss_features.h |    5 ++-
 drivers/video/omap2/dss/hdmi.c         |    3 +-
 include/video/omapdss.h                |   14 +++++++
 8 files changed, 157 insertions(+), 49 deletions(-)

-- 
1.7.9.5

