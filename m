From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 01 Jun 2016 08:49:50 +0000
Subject: [PATCH] fbdev: pxafb: clampval() doesn't update the variable
Message-Id: <eddfe3528f38f8c67b15fea81758fe1aa44904a2.1464770175.git.viresh.kumar@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

clampval() returns the clamped value instead of updating the variable
itself. And the driver is using it in a wrong way. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/video/fbdev/pxafb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 2c0487f4f805..b1197980b9b1 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -417,12 +417,12 @@ static int pxafb_adjust_timing(struct pxafb_info *fbi,
 	var->yres = max_t(int, var->yres, MIN_YRES);
 
 	if (!(fbi->lccr0 & LCCR0_LCDT)) {
-		clamp_val(var->hsync_len, 1, 64);
-		clamp_val(var->vsync_len, 1, 64);
-		clamp_val(var->left_margin,  1, 255);
-		clamp_val(var->right_margin, 1, 255);
-		clamp_val(var->upper_margin, 1, 255);
-		clamp_val(var->lower_margin, 1, 255);
+		var->hsync_len = clamp_val(var->hsync_len, 1, 64);
+		var->vsync_len = clamp_val(var->vsync_len, 1, 64);
+		var->left_margin = clamp_val(var->left_margin,  1, 255);
+		var->right_margin = clamp_val(var->right_margin, 1, 255);
+		var->upper_margin = clamp_val(var->upper_margin, 1, 255);
+		var->lower_margin = clamp_val(var->lower_margin, 1, 255);
 	}
 
 	/* make sure each line is aligned on word boundary */
-- 
2.7.1.410.g6faf27b

