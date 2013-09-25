From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 25 Sep 2013 12:14:57 +0000
Subject: [PATCH 2/4] video: cirrusfb: Remove incorrect checks
Message-Id: <1380110579-3665-2-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'xoffset' and 'yoffset' are unsigned and hence cannot be less than 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
---
 drivers/video/cirrusfb.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index b016746..5aab9b9 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -595,11 +595,6 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
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

