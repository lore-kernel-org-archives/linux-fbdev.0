From: Archit Taneja <archit@ti.com>
Date: Fri, 17 Aug 2012 10:51:36 +0000
Subject: [PATCH 3/3] OMAPDSS: Remove unnecessary acb/acbi pin fields from omap_dss_device
Message-Id: <1345200551-28712-4-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <343817088-29645-1-git-send-email-archit@ti.com>
 <1345200551-28712-1-git-send-email-archit@ti.com>
In-Reply-To: <1345200551-28712-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Passive matrix support was removed recently. The acb and acbi pin declarations
in omap_dss_device struct weren't removed by accident. Remove these fields
from omap_dss_device.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 include/video/omapdss.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b868123..bc686f4 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -558,10 +558,6 @@ struct omap_dss_device {
 	struct {
 		struct omap_video_timings timings;
 
-		int acbi;	/* ac-bias pin transitions per interrupt */
-		/* Unit: line clocks */
-		int acb;	/* ac-bias pin frequency */
-
 		enum omap_dss_dsi_pixel_format dsi_pix_fmt;
 		enum omap_dss_dsi_mode dsi_mode;
 		struct omap_dss_dsi_videomode_timings dsi_vm_timings;
-- 
1.7.9.5

