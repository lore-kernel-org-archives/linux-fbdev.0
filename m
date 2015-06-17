From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Jun 2015 12:54:24 +0000
Subject: [PATCH 00/11] OMAPDSS: scaling & misc fixes
Message-Id: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

Here are some mostly scaling related fixes for omapdss, forward ported from
TI's kernel (i.e. they've seen quite a bit of testing there).

 Tomi

Tomi Valkeinen (11):
  OMAPDSS: DISPC: work-around for errata i631
  OMAPDSS: DISPC: fix predecimation for YUV modes
  OMAPDSS: DISPC: fix check_horiz_timing_omap3 args
  OMAPDSS: DISPC: add check for scaling limits
  OMAPDSS: DISPC: fix row_inc for OMAP3
  OMAPDSS: DISPC: fix 64 bit issue in 5-tap
  OMAPDSS: DISPC: check if scaling setup failed
  OMAPDSS: DISPC: do only y decimation on OMAP3
  OMAPDSS: DISPC: scaler debug print
  OMAPDSS: HDMI4: fix error handling
  OMAPDSS: HDMI: wait for framedone when stopping video

 drivers/video/fbdev/omap2/dss/dispc.c   | 114 +++++++++++++++++++++++++++-----
 drivers/video/fbdev/omap2/dss/hdmi4.c   |   2 +-
 drivers/video/fbdev/omap2/dss/hdmi_wp.c |  16 +++++
 3 files changed, 116 insertions(+), 16 deletions(-)

-- 
2.1.4

