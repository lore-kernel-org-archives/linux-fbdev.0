From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 25 Sep 2013 12:14:58 +0000
Subject: [PATCH 3/4] video: aty: Remove incorrect checks
Message-Id: <1380110579-3665-3-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'xoffset' and 'yoffset' are unsigned and hence cannot be less than 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/aty/radeon_base.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 1e30b2b..26d80a4 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -819,11 +819,6 @@ static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *in
 	if (v.xres_virtual < v.xres)
 		v.xres = v.xres_virtual;
 
-	if (v.xoffset < 0)
-                v.xoffset = 0;
-        if (v.yoffset < 0)
-                v.yoffset = 0;
-         
         if (v.xoffset > v.xres_virtual - v.xres)
                 v.xoffset = v.xres_virtual - v.xres - 1;
                         
-- 
1.7.9.5

