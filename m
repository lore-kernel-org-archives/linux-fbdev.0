From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Jun 2015 10:16:22 +0000
Subject: [PATCH 0/7] OMAPDSS: use components (fix probing problems)
Message-Id: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

I noticed that on some platforms omapdss did not probe successfully. Some
resource was not available yet, but omapdss did not manage to handle deferred
probing. The reason was the use of platform_driver_probe() in combination with
how the omapdss module handles the drivers.

To fix this properly, the component system felt fine for the job, and it seems
to work nicely.

 Tomi

Tomi Valkeinen (7):
  OMAPDSS: move 'dss_initialized' to dss driver
  OMAPDSS: refactor dss probe function
  OMAPDSS: fix dss_init_ports error handling
  OMAPDSS: remove uses of __init/__exit
  OMAPDSS: reorder uninit calls
  OMAPDSS: componentize omapdss
  OMAPDSS: simplify submodule reg/unreg code

 drivers/video/fbdev/omap2/dss/core.c  |  80 ++++--------
 drivers/video/fbdev/omap2/dss/dispc.c |  42 +++++--
 drivers/video/fbdev/omap2/dss/dpi.c   |  36 ++++--
 drivers/video/fbdev/omap2/dss/dsi.c   |  27 +++-
 drivers/video/fbdev/omap2/dss/dss.c   | 223 +++++++++++++++++++++++-----------
 drivers/video/fbdev/omap2/dss/dss.h   |  32 ++---
 drivers/video/fbdev/omap2/dss/hdmi4.c |  28 ++++-
 drivers/video/fbdev/omap2/dss/hdmi5.c |  28 ++++-
 drivers/video/fbdev/omap2/dss/rfbi.c  |  32 ++++-
 drivers/video/fbdev/omap2/dss/sdi.c   |  35 ++++--
 drivers/video/fbdev/omap2/dss/venc.c  |  31 +++--
 11 files changed, 396 insertions(+), 198 deletions(-)

-- 
2.1.4

