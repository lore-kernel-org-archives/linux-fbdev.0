From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Fri, 08 Jan 2010 13:22:34 +0000
Subject: [PATCH 00/15] OMAP DSS fixes
Message-Id: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Bunch of small fixes to OMAP DSS for review.

 Tomi


Peter Huewe (1):
  video/omap: add __init/__exit macros to
    drivers/video/omap/lcd_htcherald.c

Tomi Valkeinen (12):
  OMAP: DSS2: DSI: fix VC channels in send_short and send_null
  OMAP: DSS2: DSI: print debug DCS cmd in hex
  OMAP: DSS2: Collect interrupt statistics
  OMAP: DSS2: Fix crash when panel doesn't define enable_te()
  OMAP: DSS2: RFBI: convert to new kfifo API
  OMAP: OMAPFB: fix clk_get for RFBI
  OMAP: OMAPFB: add dummy release function for omapdss
  MAINTAINERS: change omapfb maintainer
  MAINTAINERS: Combine DSS2 and OMAPFB2 into one entry
  OMAP: DSS2: OMAPFB: fix omapfb_free_fbmem()
  OMAP: DSS2: Make check-delay-loops consistent
  OMAP: DSS2: OMAPFB: fix crash when panel driver was not loaded

Vaibhav Hiremath (1):
  OMAP: DSS2: Fix compile warning

Ville Syrjälä (1):
  DSS2: Reject scaling settings when they cannot be supported

 MAINTAINERS                              |   15 +---
 drivers/video/omap/dispc.c               |   18 +---
 drivers/video/omap/lcd_htcherald.c       |    4 +-
 drivers/video/omap/omapfb.h              |    2 +
 drivers/video/omap/omapfb_main.c         |   25 +++++
 drivers/video/omap/rfbi.c                |    4 +-
 drivers/video/omap2/dss/Kconfig          |    7 ++
 drivers/video/omap2/dss/core.c           |   10 ++
 drivers/video/omap2/dss/dispc.c          |   74 +++++++++++++-
 drivers/video/omap2/dss/dsi.c            |  160 +++++++++++++++++++++++++++---
 drivers/video/omap2/dss/dss.c            |    6 +-
 drivers/video/omap2/dss/dss.h            |   14 +++
 drivers/video/omap2/dss/rfbi.c           |   30 +++---
 drivers/video/omap2/omapfb/omapfb-main.c |    6 +
 14 files changed, 309 insertions(+), 66 deletions(-)

