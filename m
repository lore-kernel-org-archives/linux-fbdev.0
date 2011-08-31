From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 31 Aug 2011 13:21:45 +0000
Subject: [PATCH 5/8] OMAP: DSS2: DISPC: Add missing IRQ  definitions
Message-Id: <1314796908-17354-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314796908-17354-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add IRQ definitions for missing OMAP4 IRQs: FRAMEDONEWB, FRAMEDONETV,
WBBUFFEROVERFLOW.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 include/video/omapdss.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index d4c85f2..f8385ae 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -43,6 +43,9 @@
 #define DISPC_IRQ_VSYNC2		(1 << 18)
 #define DISPC_IRQ_ACBIAS_COUNT_STAT2	(1 << 21)
 #define DISPC_IRQ_FRAMEDONE2		(1 << 22)
+#define DISPC_IRQ_FRAMEDONEWB		(1 << 23)
+#define DISPC_IRQ_FRAMEDONETV		(1 << 24)
+#define DISPC_IRQ_WBBUFFEROVERFLOW	(1 << 25)
 
 struct omap_dss_device;
 struct omap_overlay_manager;
-- 
1.7.4.1

