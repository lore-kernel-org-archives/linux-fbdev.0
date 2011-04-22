From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 22 Apr 2011 07:09:48 +0000
Subject: [PATCH 3/3] video: s3c-fb: add window variant information for S5P
Message-Id: <1303456188-19165-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Compared to s3c64xx, S5P series such as S5PC100 and S5PV210 have
the different window features including valid bpp, palette size
and palette bpp. Therefore, window variant information for S5P
should be added.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |   77 +++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 7f4c1b3..061a557 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1678,6 +1678,63 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] = {
 	},
 };
 
+static struct s3c_fb_win_variant s3c_fb_data_s5p_wins[] = {
+	[0] = {
+		.has_osd_c	= 1,
+		.osd_size_off	= 0x8,
+		.palette_sz	= 256,
+		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
+				   VALID_BPP(15) | VALID_BPP(16) |
+				   VALID_BPP(18) | VALID_BPP(19) |
+				   VALID_BPP(24) | VALID_BPP(25) |
+				   VALID_BPP(32)),
+	},
+	[1] = {
+		.has_osd_c	= 1,
+		.has_osd_d	= 1,
+		.osd_size_off	= 0xc,
+		.has_osd_alpha	= 1,
+		.palette_sz	= 256,
+		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
+				   VALID_BPP(15) | VALID_BPP(16) |
+				   VALID_BPP(18) | VALID_BPP(19) |
+				   VALID_BPP(24) | VALID_BPP(25) |
+				   VALID_BPP(32)),
+	},
+	[2] = {
+		.has_osd_c	= 1,
+		.has_osd_d	= 1,
+		.osd_size_off	= 0xc,
+		.has_osd_alpha	= 1,
+		.palette_sz	= 256,
+		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
+				   VALID_BPP(15) | VALID_BPP(16) |
+				   VALID_BPP(18) | VALID_BPP(19) |
+				   VALID_BPP(24) | VALID_BPP(25) |
+				   VALID_BPP(32)),
+	},
+	[3] = {
+		.has_osd_c	= 1,
+		.has_osd_alpha	= 1,
+		.palette_sz	= 256,
+		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
+				   VALID_BPP(15) | VALID_BPP(16) |
+				   VALID_BPP(18) | VALID_BPP(19) |
+				   VALID_BPP(24) | VALID_BPP(25) |
+				   VALID_BPP(32)),
+	},
+	[4] = {
+		.has_osd_c	= 1,
+		.has_osd_alpha	= 1,
+		.palette_sz	= 256,
+		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
+				   VALID_BPP(15) | VALID_BPP(16) |
+				   VALID_BPP(18) | VALID_BPP(19) |
+				   VALID_BPP(24) | VALID_BPP(25) |
+				   VALID_BPP(32)),
+	},
+};
+
 static struct s3c_fb_driverdata s3c_fb_data_64xx = {
 	.variant = {
 		.nr_windows	= 5,
@@ -1731,11 +1788,11 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pc100 = {
 
 		.has_prtcon	= 1,
 	},
-	.win[0]	= &s3c_fb_data_64xx_wins[0],
-	.win[1]	= &s3c_fb_data_64xx_wins[1],
-	.win[2]	= &s3c_fb_data_64xx_wins[2],
-	.win[3]	= &s3c_fb_data_64xx_wins[3],
-	.win[4]	= &s3c_fb_data_64xx_wins[4],
+	.win[0]	= &s3c_fb_data_s5p_wins[0],
+	.win[1]	= &s3c_fb_data_s5p_wins[1],
+	.win[2]	= &s3c_fb_data_s5p_wins[2],
+	.win[3]	= &s3c_fb_data_s5p_wins[3],
+	.win[4]	= &s3c_fb_data_s5p_wins[4],
 };
 
 static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
@@ -1761,11 +1818,11 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
 
 		.has_shadowcon	= 1,
 	},
-	.win[0]	= &s3c_fb_data_64xx_wins[0],
-	.win[1]	= &s3c_fb_data_64xx_wins[1],
-	.win[2]	= &s3c_fb_data_64xx_wins[2],
-	.win[3]	= &s3c_fb_data_64xx_wins[3],
-	.win[4]	= &s3c_fb_data_64xx_wins[4],
+	.win[0]	= &s3c_fb_data_s5p_wins[0],
+	.win[1]	= &s3c_fb_data_s5p_wins[1],
+	.win[2]	= &s3c_fb_data_s5p_wins[2],
+	.win[3]	= &s3c_fb_data_s5p_wins[3],
+	.win[4]	= &s3c_fb_data_s5p_wins[4],
 };
 
 /* S3C2443/S3C2416 style hardware */
-- 
1.7.1

