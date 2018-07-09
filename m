From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 09 Jul 2018 22:04:36 +0000
Subject: [PATCH] omapfb: Mark expected switch fall-throughs
Message-Id: <20180709220436.GA10751@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c   | 2 ++
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index fb605ae..8d63d1b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -1905,6 +1905,7 @@ static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,
 		if (color_mode = OMAP_DSS_COLOR_YUV2 ||
 			color_mode = OMAP_DSS_COLOR_UYVY)
 			width = width >> 1;
+		/* fall through */
 	case OMAP_DSS_ROT_90:
 	case OMAP_DSS_ROT_270:
 		*offset1 = 0;
@@ -1927,6 +1928,7 @@ static void calc_vrfb_rotation_offset(u8 rotation, bool mirror,
 		if (color_mode = OMAP_DSS_COLOR_YUV2 ||
 			color_mode = OMAP_DSS_COLOR_UYVY)
 			width = width >> 1;
+		/* fall through */
 	case OMAP_DSS_ROT_90 + 4:
 	case OMAP_DSS_ROT_270 + 4:
 		*offset1 = 0;
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index e08e566..6b5a0db 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -893,6 +893,7 @@ int omapfb_setup_overlay(struct fb_info *fbi, struct omap_overlay *ovl,
 				/ (var->bits_per_pixel >> 2);
 			break;
 		}
+		/* fall through */
 	default:
 		screen_width = fix->line_length / (var->bits_per_pixel >> 3);
 		break;
-- 
2.7.4

