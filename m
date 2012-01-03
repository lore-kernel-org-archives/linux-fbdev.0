From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 03 Jan 2012 12:52:51 +0000
Subject: [PATCH v3] video: da8xx-fb: reset LCDC only if functional clock changes with DVFS
Message-Id: <1325594451-11963-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

LCDC functional clock may or may not be derived from CPU/MPU DPLL,
For example,
AM335x => Separate independent DPLL for LCDC
Davinci => Same DPLL as MPU

So, on platforms where LCDC functional clock is not derived from CPU/MPU
PLL it is not required to reset LCDC module as its functional clock does
not change with DVFS.

This patch adds check to do reset only if functional clock changes
between pre and post notifier callbacks with DVFS.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Since v2:
Fix, update lcd_fck_rate with current LCD functional clock rate.
Since v1:
Fixed the commit message.

 drivers/video/da8xx-fb.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 6b27751..dee1918 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -163,6 +163,7 @@ struct da8xx_fb_par {
 	int			vsync_timeout;
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
+	unsigned int		lcd_fck_rate;
 #endif
 	void (*panel_power_ctrl)(int);
 };
@@ -895,11 +896,13 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
 	struct da8xx_fb_par *par;
 
 	par = container_of(nb, struct da8xx_fb_par, freq_transition);
-	if (val = CPUFREQ_PRECHANGE) {
-		lcd_disable_raster();
-	} else if (val = CPUFREQ_POSTCHANGE) {
-		lcd_calc_clk_divider(par);
-		lcd_enable_raster();
+	if (val = CPUFREQ_POSTCHANGE) {
+		if (par->lcd_fck_rate != clk_get_rate(par->lcdc_clk)) {
+			par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
+			lcd_disable_raster();
+			lcd_calc_clk_divider(par);
+			lcd_enable_raster();
+		}
 	}
 
 	return 0;
@@ -1192,6 +1195,9 @@ static int __devinit fb_probe(struct platform_device *device)
 
 	par = da8xx_fb_info->par;
 	par->lcdc_clk = fb_clk;
+#ifdef CONFIG_CPU_FREQ
+	par->lcd_fck_rate = clk_get_rate(fb_clk);
+#endif
 	par->pxl_clk = lcdc_info->pxl_clk;
 	if (fb_pdata->panel_power_ctrl) {
 		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
-- 
1.7.1

