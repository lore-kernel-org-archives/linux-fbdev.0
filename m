From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Jun 2015 12:54:31 +0000
Subject: [PATCH 07/11] OMAPDSS: DISPC: check if scaling setup failed
Message-Id: <1434545675-477-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The DISPC's scaling code seems to presume that decimation always
succeeds, and so we always do find a suitable downscaling setup.
However, this is not the case, and the algorithm can fail.

When that happens, the code just proceeds with wrong results, causing
issues later.

Add the necessary checks to bail out if the scaling algorithm failed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 2db1c986e989..0bdb587cb48c 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2279,6 +2279,11 @@ static int dispc_ovl_calc_scaling_24xx(unsigned long pclk, unsigned long lclk,
 		}
 	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
 
+	if (error) {
+		DSSERR("failed to find scaling settings\n");
+		return -EINVAL;
+	}
+
 	if (in_width > maxsinglelinewidth) {
 		DSSERR("Cannot scale max input width exceeded");
 		return -EINVAL;
@@ -2356,6 +2361,11 @@ again:
 		}
 	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
 
+	if (error) {
+		DSSERR("failed to find scaling settings\n");
+		return -EINVAL;
+	}
+
 	if (check_horiz_timing_omap3(pclk, lclk, mgr_timings, pos_x, in_width,
 				in_height, out_width, out_height, *five_taps)) {
 			DSSERR("horizontal timing too tight\n");
-- 
2.1.4

