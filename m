From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 25 Sep 2013 12:14:59 +0000
Subject: [PATCH 4/4] video: riva: Remove incorrect checks
Message-Id: <1380110579-3665-4-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'xoffset' and 'yoffset' are unsigned and hence cannot be less than 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/riva/fbdev.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 9536715..a5514ac 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1185,11 +1185,6 @@ static int rivafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	if (rivafb_do_maximize(info, var, nom, den) < 0)
 		return -EINVAL;
 
-	if (var->xoffset < 0)
-		var->xoffset = 0;
-	if (var->yoffset < 0)
-		var->yoffset = 0;
-
 	/* truncate xoffset and yoffset to maximum if too high */
 	if (var->xoffset > var->xres_virtual - var->xres)
 		var->xoffset = var->xres_virtual - var->xres - 1;
-- 
1.7.9.5

