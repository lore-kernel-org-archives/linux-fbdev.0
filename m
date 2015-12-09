From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:45 +0000
Subject: [PATCH 17/23] OMAPDSS: fix rgb-to-yuv color conv coefs
Message-Id: <1449676791-26304-18-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The color conversion coefficients for RGB to YUV conversion (used with
writeback) don't result in the correct result. This patch sets the
correct coefficients.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 837b1f508d79..c50bb0124d87 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -713,10 +713,12 @@ static void dispc_setup_color_conv_coef(void)
 	int i;
 	int num_ovl = dss_feat_get_num_ovls();
 	const struct color_conv_coef ctbl_bt601_5_ovl = {
+		/* YUV -> RGB */
 		298, 409, 0, 298, -208, -100, 298, 0, 517, 0,
 	};
 	const struct color_conv_coef ctbl_bt601_5_wb = {
-		66, 112, -38, 129, -94, -74, 25, -18, 112, 0,
+		/* RGB -> YUV */
+		66, 129, 25, 112, -94, -18, -38, -74, 112, 0,
 	};
 
 	for (i = 1; i < num_ovl; i++)
-- 
2.5.0

