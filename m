From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 22 Oct 2014 08:39:33 +0000
Subject: [PATCH 4/5] OMAPDSS: fix dispc register dump for preload & mflag
Message-Id: <1413967174-28009-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Preload register is dumped twice for video overlays and mflag register
is not dumped for GFX.

Fix the register dump.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index e67976bd0627..0e9a74bb9fc2 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3290,8 +3290,11 @@ static void dispc_dump_regs(struct seq_file *s)
 		DUMPREG(i, DISPC_OVL_FIFO_SIZE_STATUS);
 		DUMPREG(i, DISPC_OVL_ROW_INC);
 		DUMPREG(i, DISPC_OVL_PIXEL_INC);
+
 		if (dss_has_feature(FEAT_PRELOAD))
 			DUMPREG(i, DISPC_OVL_PRELOAD);
+		if (dss_has_feature(FEAT_MFLAG))
+			DUMPREG(i, DISPC_OVL_MFLAG_THRESHOLD);
 
 		if (i = OMAP_DSS_GFX) {
 			DUMPREG(i, DISPC_OVL_WINDOW_SKIP);
@@ -3312,10 +3315,6 @@ static void dispc_dump_regs(struct seq_file *s)
 		}
 		if (dss_has_feature(FEAT_ATTR2))
 			DUMPREG(i, DISPC_OVL_ATTRIBUTES2);
-		if (dss_has_feature(FEAT_PRELOAD))
-			DUMPREG(i, DISPC_OVL_PRELOAD);
-		if (dss_has_feature(FEAT_MFLAG))
-			DUMPREG(i, DISPC_OVL_MFLAG_THRESHOLD);
 	}
 
 #undef DISPC_REG
-- 
2.1.1

