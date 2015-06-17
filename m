From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Jun 2015 12:54:26 +0000
Subject: [PATCH 02/11] OMAPDSS: DISPC: fix predecimation for YUV modes
Message-Id: <1434545675-477-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DISPC needs even input buffer width for YUV modes. The DISPC driver
doesn't check this at the moment (although omapdrm does), but worse,
when DISPC driver does x predecimation the result may be uneven. This
causes sometimes sync losts, underflows, or just visual errors.

This patch makes DISPC driver return an error if the user gives uneven
input width for a YUV buffer. It also makes the input width even in case
of predecimation.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index a074d8b70591..db60aa98f661 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2542,6 +2542,21 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 	if (paddr = 0 && rotation_type != OMAP_DSS_ROT_TILER)
 		return -EINVAL;
 
+	switch (color_mode) {
+	case OMAP_DSS_COLOR_YUV2:
+	case OMAP_DSS_COLOR_UYVY:
+	case OMAP_DSS_COLOR_NV12:
+		if (in_width & 1) {
+			DSSERR("input width %d is not even for YUV format\n",
+				in_width);
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		break;
+	}
+
 	out_width = out_width = 0 ? width : out_width;
 	out_height = out_height = 0 ? height : out_height;
 
@@ -2572,6 +2587,27 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 	in_width = in_width / x_predecim;
 	in_height = in_height / y_predecim;
 
+	if (x_predecim > 1 || y_predecim > 1)
+		DSSDBG("predecimation %d x %x, new input size %d x %d\n",
+			x_predecim, y_predecim, in_width, in_height);
+
+	switch (color_mode) {
+	case OMAP_DSS_COLOR_YUV2:
+	case OMAP_DSS_COLOR_UYVY:
+	case OMAP_DSS_COLOR_NV12:
+		if (in_width & 1) {
+			DSSDBG("predecimated input width is not even for YUV format\n");
+			DSSDBG("adjusting input width %d -> %d\n",
+				in_width, in_width & ~1);
+
+			in_width &= ~1;
+		}
+		break;
+
+	default:
+		break;
+	}
+
 	if (color_mode = OMAP_DSS_COLOR_YUV2 ||
 			color_mode = OMAP_DSS_COLOR_UYVY ||
 			color_mode = OMAP_DSS_COLOR_NV12)
-- 
2.1.4

