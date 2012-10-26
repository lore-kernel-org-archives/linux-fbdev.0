From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 26 Oct 2012 07:02:25 +0000
Subject: [PATCH 3/3] video: s3c-fb: fix red offset and lengh for ARGB232 format
Message-Id: <002601cdb347$dad82260$90886720$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Green pixel and blue pixel are 3 bits and 2 bits respectively
at ARGB232 format. Thus, the value of red offset should be 5,
not 4. Also, the value of red length should be 2, because
red pixel is 2 bits at ARGB232 format.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index f453b8b..d8bfb4a 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -268,10 +268,10 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *var,
 	case 8:
 		if (sfb->variant.palette[win->index] != 0) {
 			/* non palletised, A:1,R:2,G:3,B:2 mode */
-			var->red.offset		= 4;
+			var->red.offset		= 5;
 			var->green.offset	= 2;
 			var->blue.offset	= 0;
-			var->red.length		= 5;
+			var->red.length		= 2;
 			var->green.length	= 3;
 			var->blue.length	= 2;
 			var->transp.offset	= 7;
-- 
1.7.1


