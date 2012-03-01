From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 01 Mar 2012 12:26:28 +0000
Subject: [PATCH 0/7] OMAPDSS: HDMI PHY burnout fix for 3.2 stable
Message-Id: <1330604795-29156-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

The main patch in this set is the "PHY burnout fix", which implements a fix for
a hardware bug in the OMAP4 HDMI PHY which may cause physical damage to the
board if the HDMI PHY is already enabled when the HDMI cable is plugged in. The
possible damage breaks HDMI output hardware, otherwise the board is unaffected.

The preceding patches are small cleanups/fixes for HDMI GPIOs so that the fix
can be implemented. And the fix introduced a small bug with hot plug detect,
which is fixed by the patch from Rob. Rob's patch is not yet in upstream, but
has been accepted by fbdev maintainer.

 Tomi

Rob Clark (1):
  OMAPDSS: HDMI: hot plug detect fix

Tomi Valkeinen (6):
  OMAP: 4430SDP/Panda: use gpio_free_array to free HDMI gpios
  OMAP: 4430SDP/Panda: rename HPD GPIO to CT_CP_HPD
  OMAPDSS: remove wrong HDMI HPD muxing
  OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
  OMAP: 4430SDP/Panda: add HDMI HPD gpio
  OMAPDSS: HDMI: PHY burnout fix

 arch/arm/mach-omap2/board-4430sdp.c       |   22 +++++---
 arch/arm/mach-omap2/board-omap4panda.c    |   22 +++++---
 drivers/video/omap2/dss/hdmi.c            |    3 +
 drivers/video/omap2/dss/ti_hdmi.h         |    4 ++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   77 ++++++++++++++++++++++++-----
 include/video/omapdss.h                   |    5 ++
 6 files changed, 105 insertions(+), 28 deletions(-)

-- 
1.7.4.1

