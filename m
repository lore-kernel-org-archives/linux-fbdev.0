From: Darren Etheridge <detheridge@ti.com>
Date: Fri, 23 Aug 2013 21:52:50 +0000
Subject: [PATCH 1/4] video: da8xx-fb fixing incorrect porch mappings
Message-Id: <1377294773-25678-2-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The driver was mapping the wrong fbdev margins to the
front porch / back porch for both vertical and horizontal
timings.

This patch corrects it so that:

hfp = right margin
hbp = left margin
vbp = upper margin
vfp = lower margin

Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 1d9aff1..0333a0b 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -784,10 +784,10 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
 		return ret;
 
 	/* Configure the vertical and horizontal sync properties. */
-	lcd_cfg_vertical_sync(panel->lower_margin, panel->vsync_len,
-			panel->upper_margin);
-	lcd_cfg_horizontal_sync(panel->right_margin, panel->hsync_len,
-			panel->left_margin);
+	lcd_cfg_vertical_sync(panel->upper_margin, panel->vsync_len,
+			panel->lower_margin);
+	lcd_cfg_horizontal_sync(panel->left_margin, panel->hsync_len,
+			panel->right_margin);
 
 	/* Configure for disply */
 	ret = lcd_cfg_display(cfg, panel);
-- 
1.7.0.4

