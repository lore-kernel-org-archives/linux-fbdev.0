From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 17 Jan 2012 12:48:56 +0000
Subject: [PATCH 0/6] OMAPDSS: HDMI PHY burnout fix
Message-Id: <1326804542-22285-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, mythripk@ti.com
Cc: archit@ti.com, x0132446@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The main patch in this set is the last one, which implements a fix for the HW
bug on OMAP4 which causes physical damage to the board if the HDMI cable is not
connected but HDMI output is enabled.

The preceding patches are small cleanups/fixes for HDMI GPIOs so that the fix
can be implemented.

Note that I haven't gotten a confirmation that using LDO_ON for the HDMI PHY
power fixes the issue. So whether the fix works or not is unclear.

 Tomi

Tomi Valkeinen (6):
  OMAP: 4430SDP/Panda: use gpio_free_array to free HDMI gpios
  OMAP: 4430SDP/Panda: rename HPD GPIO to CT_CP_HPD
  OMAPDSS: remove wrong HDMI HPD muxing
  OMAP: 4430SDP/Panda: setup HDMI GPIO muxes
  OMAP: 4430SDP/Panda: add HDMI HPD gpio
  OMAPDSS: HDMI: PHY burnout fix

 arch/arm/mach-omap2/board-4430sdp.c       |   18 ++++++--
 arch/arm/mach-omap2/board-omap4panda.c    |   18 ++++++--
 arch/arm/mach-omap2/display.c             |    4 --
 drivers/video/omap2/dss/hdmi.c            |    3 +
 drivers/video/omap2/dss/ti_hdmi.h         |    4 ++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   68 +++++++++++++++++++++++++++--
 include/video/omapdss.h                   |    5 ++
 7 files changed, 104 insertions(+), 16 deletions(-)

-- 
1.7.4.1

