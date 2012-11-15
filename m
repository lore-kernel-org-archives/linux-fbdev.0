From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Nov 2012 15:58:11 +0000
Subject: [PATCH 03/32] OMAPDSS: don't WARN if there's no DSI device
Message-Id: <1352995120-3288-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

dsi_get_dsidev_from_id() gives a WARN if DSI support is not compiled in.
This warning is not right, as it's valid to call
dsi_get_dsidev_from_id() to see if there is DSI support or not.

Remove the WARN().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8adf8be..09d0651 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -382,8 +382,6 @@ static inline void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev)
 }
 static inline struct platform_device *dsi_get_dsidev_from_id(int module)
 {
-	WARN("%s: DSI not compiled in, returning platform device as NULL\n",
-			__func__);
 	return NULL;
 }
 #endif
-- 
1.7.10.4

