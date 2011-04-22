From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 22 Apr 2011 07:09:31 +0000
Subject: [PATCH 1/3] video: s3c-fb: correct window osd size offset values
Message-Id: <1303456171-19105-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Offset values for OSD size registers of window 1 and 2 are corrected.
The offset values of OSD size registers are as follows:
window0: VIDOSDC (0x8)
window1 and 2: VIDOSDD (0xc)
window3 and 4: not present

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 3fa7911..6d0622c 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1635,7 +1635,7 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] = {
 	[1] = {
 		.has_osd_c	= 1,
 		.has_osd_d	= 1,
-		.osd_size_off	= 0x12,
+		.osd_size_off	= 0xc,
 		.has_osd_alpha	= 1,
 		.palette_sz	= 256,
 		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(16) |
@@ -1645,7 +1645,7 @@ static struct s3c_fb_win_variant s3c_fb_data_64xx_wins[] = {
 	[2] = {
 		.has_osd_c	= 1,
 		.has_osd_d	= 1,
-		.osd_size_off	= 0x12,
+		.osd_size_off	= 0xc,
 		.has_osd_alpha	= 1,
 		.palette_sz	= 16,
 		.palette_16bpp	= 1,
-- 
1.7.1

