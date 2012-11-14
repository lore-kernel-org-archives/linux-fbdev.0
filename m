From: Archit Taneja <archit@ti.com>
Date: Wed, 14 Nov 2012 08:32:14 +0000
Subject: [PATCH 0/2] OMAPDSS: DISPC: Update manager size limits for OMAP5
Message-Id: <1352881216-7490-1-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Manager width and height can go up to 4K on OMAP5. Make manager width and height
register field offsets and maximum limits as dispc_features. Create a new
dispc_feature struct for OMAP5 which highlights this difference.

Archit Taneja (2):
  OMAPDSS: Add overlay manager width and height limits as a dispc
    feature
  OMAPDSS: Add a dispc_features struct for OMAP5

 drivers/video/omap2/dss/dispc.c        |   47 +++++++++++++++++++++++++++++---
 drivers/video/omap2/dss/dss_features.c |    8 ------
 drivers/video/omap2/dss/dss_features.h |    2 --
 3 files changed, 43 insertions(+), 14 deletions(-)

-- 
1.7.9.5

