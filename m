From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Jun 2015 12:54:28 +0000
Subject: [PATCH 04/11] OMAPDSS: DISPC: add check for scaling limits
Message-Id: <1434545675-477-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

On OMAP3/AM43xx some scaling factors cause underflows/synclosts. After
studying this, I found that sometimes the driver uses three-tap scaling
with downscaling factor smaller than x0.5. This causes issues, as x0.5
is the limit for three-tap scaling.

The driver has FEAT_PARAM_DOWNSCALE parameter, but that seems to be for
five-tap scaling, which allows scaling down to x0.25.

This patch adds checks for both horizontal and vertical scaling. For
horizontal the HW always uses 5 taps, so the limit is x0.25.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index cc61513afdb4..ddce8fcfc5c1 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2326,6 +2326,21 @@ again:
 		error = (error || in_width > maxsinglelinewidth * 2 ||
 			(in_width > maxsinglelinewidth && *five_taps) ||
 			!*core_clk || *core_clk > dispc_core_clk_rate());
+
+		if (!error) {
+			/* verify that we're inside the limits of scaler */
+			if (in_width / 4 > out_width)
+					error = 1;
+
+			if (*five_taps) {
+				if (in_height / 4 > out_height)
+					error = 1;
+			} else {
+				if (in_height / 2 > out_height)
+					error = 1;
+			}
+		}
+
 		if (error) {
 			if (*decim_x = *decim_y) {
 				*decim_x = min_factor;
-- 
2.1.4

