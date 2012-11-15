From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Nov 2012 15:58:34 +0000
Subject: [PATCH 26/32] OMAPDSS: DPI: use dispc's check_timings
Message-Id: <1352995120-3288-27-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

dpi.c uses dss_mgr_check_timings() to verify video timings, but that
function is in the compat layer. Change dpi.c to use the dispc's check
instead.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index c109fa6..b32202f 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -315,7 +315,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 	unsigned long pck;
 	struct dispc_clock_info dispc_cinfo;
 
-	if (dss_mgr_check_timings(mgr, timings))
+	if (mgr && !dispc_mgr_timings_ok(mgr->id, timings))
 		return -EINVAL;
 
 	if (timings->pixel_clock = 0)
-- 
1.7.10.4

