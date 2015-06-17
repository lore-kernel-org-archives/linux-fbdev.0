From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Jun 2015 12:54:27 +0000
Subject: [PATCH 03/11] OMAPDSS: DISPC: fix check_horiz_timing_omap3 args
Message-Id: <1434545675-477-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

After calculating the required decimation for scaling, the dispc driver
checks once more if the resulting configuration is valid by calling
check_horiz_timing_omap3().

Earlier calls to this function have correctly used in_width and
in_height as parameters, but the last call uses width and height. This
causes the driver to possibly reject scaling that would work.

This patch fixes the parameters.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index db60aa98f661..cc61513afdb4 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2338,8 +2338,8 @@ again:
 		}
 	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
 
-	if (check_horiz_timing_omap3(pclk, lclk, mgr_timings, pos_x, width,
-				height, out_width, out_height, *five_taps)) {
+	if (check_horiz_timing_omap3(pclk, lclk, mgr_timings, pos_x, in_width,
+				in_height, out_width, out_height, *five_taps)) {
 			DSSERR("horizontal timing too tight\n");
 			return -EINVAL;
 	}
-- 
2.1.4

