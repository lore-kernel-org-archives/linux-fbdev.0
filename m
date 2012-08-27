From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Date: Mon, 27 Aug 2012 08:55:11 +0000
Subject: [PATCH] OMAPDSS: Correct DISPC_IRQ bit definitions for LCD3
Message-Id: <1346057599-5691-1-git-send-email-cmahapatra@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: mark.tyler@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The DISPC_IRQ bit definitions pertaining to channel LCD3 as DISPC_IRQ_VSYNC3,
DISPC_IRQ_SYNC_LOST3, DISPC_IRQ_ACBIAS_COUNT_STAT3 AND DISPC_IRQ_FRAMEDONE3
which were incorrectly set in previous LCD3 patches have been corrected here.

Reported-by: Mark Tyler <mark.tyler@ti.com>
Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 include/video/omapdss.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b868123..9c7cca3 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -48,10 +48,10 @@
 #define DISPC_IRQ_FRAMEDONEWB		(1 << 23)
 #define DISPC_IRQ_FRAMEDONETV		(1 << 24)
 #define DISPC_IRQ_WBBUFFEROVERFLOW	(1 << 25)
-#define DISPC_IRQ_FRAMEDONE3		(1 << 26)
-#define DISPC_IRQ_VSYNC3		(1 << 27)
-#define DISPC_IRQ_ACBIAS_COUNT_STAT3	(1 << 28)
-#define DISPC_IRQ_SYNC_LOST3		(1 << 29)
+#define DISPC_IRQ_SYNC_LOST3		(1 << 27)
+#define DISPC_IRQ_VSYNC3		(1 << 28)
+#define DISPC_IRQ_ACBIAS_COUNT_STAT3	(1 << 29)
+#define DISPC_IRQ_FRAMEDONE3		(1 << 30)
 
 struct omap_dss_device;
 struct omap_overlay_manager;
-- 
1.7.10

