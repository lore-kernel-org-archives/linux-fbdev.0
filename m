From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 22 Apr 2011 07:09:40 +0000
Subject: [PATCH 2/3] video: s3c-fb: add additional validate bpps
Message-Id: <1303456180-19135-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Additional validate bpps are added to windows as follows:
window0: 18 bpp for RGB666
window1, 2 and 3: 28 bpp for ARGB4888
window4: 19 bpp for ARGB1666, 28 bpp for ARGB4888

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 6d0622c..7f4c1b3 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1630,7 +1630,8 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] = {
 		.has_osd_c	= 1,
 		.osd_size_off	= 0x8,
 		.palette_sz	= 256,
-		.valid_bpp	= VALID_BPP1248 | VALID_BPP(16) | VALID_BPP(24),
+		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(16) |
+				   VALID_BPP(18) | VALID_BPP(24)),
 	},
 	[1] = {
 		.has_osd_c	= 1,
@@ -1640,7 +1641,8 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] = {
 		.palette_sz	= 256,
 		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(16) |
 				   VALID_BPP(18) | VALID_BPP(19) |
-				   VALID_BPP(24) | VALID_BPP(25)),
+				   VALID_BPP(24) | VALID_BPP(25) |
+				   VALID_BPP(28)),
 	},
 	[2] = {
 		.has_osd_c	= 1,
@@ -1651,7 +1653,8 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] = {
 		.palette_16bpp	= 1,
 		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(16) |
 				   VALID_BPP(18) | VALID_BPP(19) |
-				   VALID_BPP(24) | VALID_BPP(25)),
+				   VALID_BPP(24) | VALID_BPP(25) |
+				   VALID_BPP(28)),
 	},
 	[3] = {
 		.has_osd_c	= 1,
@@ -1660,7 +1663,8 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] = {
 		.palette_16bpp	= 1,
 		.valid_bpp	= (VALID_BPP124  | VALID_BPP(16) |
 				   VALID_BPP(18) | VALID_BPP(19) |
-				   VALID_BPP(24) | VALID_BPP(25)),
+				   VALID_BPP(24) | VALID_BPP(25) |
+				   VALID_BPP(28)),
 	},
 	[4] = {
 		.has_osd_c	= 1,
@@ -1669,7 +1673,8 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] = {
 		.palette_16bpp	= 1,
 		.valid_bpp	= (VALID_BPP(1) | VALID_BPP(2) |
 				   VALID_BPP(16) | VALID_BPP(18) |
-				   VALID_BPP(24) | VALID_BPP(25)),
+				   VALID_BPP(19) | VALID_BPP(24) |
+				   VALID_BPP(25) | VALID_BPP(28)),
 	},
 };
 
-- 
1.7.1

