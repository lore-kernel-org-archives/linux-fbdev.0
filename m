From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Fri, 31 Aug 2012 13:12:20 +0000
Subject: [PATCH] da8xx-fb: enable LCDC if FB is unblanked
Message-Id: <1346418020-31779-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Check for FB_BLANK_UNBLANK before enabling LCDC from PM resume
and DVFS. Without this, behavior in case of below used case is
not be not expected,
1) Issue FB_BLANK, LCDC disabled.
2) Do suspend/resume cycle or DVFS.
3) Do not expect LCDC to get enabled at this point.

Re-enabling of LCDC is done when FB_BLANK_UNBLANK is issued.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Applies on top of fbdev-next of Florian Tobias Schandinat's tree.

 drivers/video/da8xx-fb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 761c8d1..1273354 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -962,7 +962,8 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
 			par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
 			lcd_disable_raster();
 			lcd_calc_clk_divider(par);
-			lcd_enable_raster();
+			if (par->blank = FB_BLANK_UNBLANK)
+				lcd_enable_raster();
 		}
 	}
 
@@ -1486,10 +1487,12 @@ static int fb_resume(struct platform_device *dev)
 
 	console_lock();
 	clk_enable(par->lcdc_clk);
-	lcd_enable_raster();
+	if (par->blank = FB_BLANK_UNBLANK) {
+		lcd_enable_raster();
 
-	if (par->panel_power_ctrl)
-		par->panel_power_ctrl(1);
+		if (par->panel_power_ctrl)
+			par->panel_power_ctrl(1);
+	}
 
 	fb_set_suspend(info, 0);
 	console_unlock();
-- 
1.7.1

