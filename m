From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jun 2014 10:03:46 +0000
Subject: [PATCH 01/15] OMAPDSS: DISPC: fix debugfs reg dump
Message-Id: <1403604240-16738-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

DISPC reg dump prints a few registers twice. Remove the extra prints.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 7aa33b0f4a1f..d1f0dbb486b8 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3257,13 +3257,10 @@ static void dispc_dump_regs(struct seq_file *s)
 		if (i = OMAP_DSS_CHANNEL_DIGIT)
 			continue;
 
-		DUMPREG(i, DISPC_DEFAULT_COLOR);
-		DUMPREG(i, DISPC_TRANS_COLOR);
 		DUMPREG(i, DISPC_TIMING_H);
 		DUMPREG(i, DISPC_TIMING_V);
 		DUMPREG(i, DISPC_POL_FREQ);
 		DUMPREG(i, DISPC_DIVISORo);
-		DUMPREG(i, DISPC_SIZE_MGR);
 
 		DUMPREG(i, DISPC_DATA_CYCLE1);
 		DUMPREG(i, DISPC_DATA_CYCLE2);
-- 
1.9.1

