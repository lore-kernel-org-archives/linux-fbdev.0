From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 24 Oct 2012 09:29:05 +0000
Subject: [PATCH 14/20] OMAPDSS: HDMI: make hdmi pclk check more permissive
Message-Id: <1351070951-18616-15-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ricardo Neri <ricardo.neri@ti.com>

The hdmi driver tries to find the given video timings from its static
list of timings, to find the required ID for the mode. The check tries
to find exact match for the pixel clock, among other checks.

with omapfb driver there can be some amount of error in the give pixel
clock, as the pixel clock is converted between Hz and ps, thus the
hdmi's check fails to find the mode.

This patch makes the check more allowing, by rounding the pixel clocks
to nearest MHz.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index dfbc1e7..90cc1b1 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -404,7 +404,8 @@ static bool hdmi_timings_compare(struct omap_video_timings *timing1,
 {
 	int timing1_vsync, timing1_hsync, timing2_vsync, timing2_hsync;
 
-	if ((timing2->pixel_clock = timing1->pixel_clock) &&
+	if ((DIV_ROUND_CLOSEST(timing2->pixel_clock, 1000) =
+			DIV_ROUND_CLOSEST(timing1->pixel_clock, 1000)) &&
 		(timing2->x_res = timing1->x_res) &&
 		(timing2->y_res = timing1->y_res)) {
 
-- 
1.7.9.5

