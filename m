From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 24 May 2011 08:55:23 +0000
Subject: [PATCH] [resend] video: s3c-fb: correct transparency checking in 32bpp
Message-Id: <1306227323-22681-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

32bpp means ARGB 8888 in the driver, therfore the transparency length
and offset should be 8 and 24 respectively. However, the transparency
length and offset were previously 0, which means that the driver supports
RGB 888 without alpha blending when 32bpp is used.

So, the transparency checking in 32bpp is corrected so that the
transparency length and offset are 8 and 24 respectively.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 6b7c5a8..574e046 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -302,6 +302,7 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *var,
 		var->blue.length	= 5;
 		break;
 
+	case 32:
 	case 28:
 	case 25:
 		var->transp.length	= var->bits_per_pixel - 24;
@@ -310,7 +311,6 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *var,
 	case 24:
 		/* our 24bpp is unpacked, so 32bpp */
 		var->bits_per_pixel	= 32;
-	case 32:
 		var->red.offset		= 16;
 		var->red.length		= 8;
 		var->green.offset	= 8;
-- 
1.7.1

