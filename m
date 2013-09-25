From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 25 Sep 2013 12:14:56 +0000
Subject: [PATCH 1/4] video: vfb: Remove incorrect check
Message-Id: <1380110579-3665-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'yoffset' is unsigned and hence cannot be less than 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/vfb.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index ee5985e..ea2b523 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -390,9 +390,8 @@ static int vfb_pan_display(struct fb_var_screeninfo *var,
 			   struct fb_info *info)
 {
 	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->yoffset < 0
-		    || var->yoffset >= info->var.yres_virtual
-		    || var->xoffset)
+		if (var->yoffset >= info->var.yres_virtual ||
+		    var->xoffset)
 			return -EINVAL;
 	} else {
 		if (var->xoffset + info->var.xres > info->var.xres_virtual ||
-- 
1.7.9.5

