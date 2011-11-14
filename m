From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 14 Nov 2011 15:01:42 +0000
Subject: [PATCH 0/3] OMAPDSS: fixes for rc
Message-Id: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

A few fixes for the next -rc.

One for the old omapfb, and two for the omapdss fixing issues related to HDMI.

 Tomi

Tomi Valkeinen (3):
  OMAPDSS: HDMI: fix returned HDMI pixel clock
  OMAPFB: fix compilation warnings due to missing include
  OMAPDSS: DISPC: skip scaling calculations when not scaling

 drivers/video/omap/dispc.c      |    2 +-
 drivers/video/omap2/dss/dispc.c |   11 +++++------
 drivers/video/omap2/dss/hdmi.c  |    2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

-- 
1.7.4.1

