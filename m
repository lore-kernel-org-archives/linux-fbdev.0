From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 24 Jul 2012 04:27:25 +0000
Subject: [PATCH] da8xx-fb: do not turn ON LCD backlight unless LCDC is enabled
Message-Id: <1343103325-7313-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

LCD blink is observed during suspend/resume and blank/unblank
operations as backlight is ON during LCDC disable and enable.
So make sure to turn OFF backlight before disabling and turn
it ON after enabling.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 drivers/video/da8xx-fb.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 0fb4d7d..1a569ae 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1056,10 +1056,10 @@ static int cfb_blank(int blank, struct fb_info *info)
 	par->blank = blank;
 	switch (blank) {
 	case FB_BLANK_UNBLANK:
+		lcd_enable_raster();
+
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(1);
-
-		lcd_enable_raster();
 		break;
 	case FB_BLANK_POWERDOWN:
 		if (par->panel_power_ctrl)
@@ -1417,11 +1417,12 @@ static int fb_resume(struct platform_device *dev)
 	struct da8xx_fb_par *par = info->par;
 
 	console_lock();
+	clk_enable(par->lcdc_clk);
+	lcd_enable_raster();
+
 	if (par->panel_power_ctrl)
 		par->panel_power_ctrl(1);
 
-	clk_enable(par->lcdc_clk);
-	lcd_enable_raster();
 	fb_set_suspend(info, 0);
 	console_unlock();
 
-- 
1.7.1

