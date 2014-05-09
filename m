From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 May 2014 12:32:03 +0000
Subject: [PATCH 1/5] OMAPDSS: Fix writes to DISPC_POL_FREQ
Message-Id: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

When omapdss writes to DISPC_POL_FREQ register, it always ORs the bits
with the current contents of the register, never clearing the old ones,
causing wrong signal polarity settings.

As we write all the bits in DISPC_POL_FREQ, we don't need to care about
the current contents of the register. So fix the issue by constructing
new register value from scratch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index f18397c33e8f..a22c64e26172 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2945,13 +2945,13 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 		BUG();
 	}
 
-	l = dispc_read_reg(DISPC_POL_FREQ(channel));
-	l |= FLD_VAL(onoff, 17, 17);
-	l |= FLD_VAL(rf, 16, 16);
-	l |= FLD_VAL(de_level, 15, 15);
-	l |= FLD_VAL(ipc, 14, 14);
-	l |= FLD_VAL(hsync_level, 13, 13);
-	l |= FLD_VAL(vsync_level, 12, 12);
+	l = FLD_VAL(onoff, 17, 17) |
+		FLD_VAL(rf, 16, 16) |
+		FLD_VAL(de_level, 15, 15) |
+		FLD_VAL(ipc, 14, 14) |
+		FLD_VAL(hsync_level, 13, 13) |
+		FLD_VAL(vsync_level, 12, 12);
+
 	dispc_write_reg(DISPC_POL_FREQ(channel), l);
 }
 
-- 
1.9.1

