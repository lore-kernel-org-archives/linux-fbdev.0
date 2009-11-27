From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/4] davinci: fb : Add suspend/resume suuport for
	DA8xx/OMAP-L1xx fb driver
Date: Fri, 27 Nov 2009 12:13:37 +0530
Message-ID: <1259304217-19388-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org

Suspend/resume support DA8xx/OMAP-L1xx frame buffer driver.
This feature has been tested on DA850/OMAP-L138 EVM. For the purpose
of testing, the patch series[1] which adds suspend support for
DA850/OMAP-L138 SoC was applied.

[1] http://patchwork.kernel.org/patch/60260/

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
---
 drivers/video/da8xx-fb.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index b3c22e1..fcaa344 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
+#include <linux/console.h>
 #include <video/da8xx-fb.h>
 
 #define DRIVER_NAME "da8xx_lcdc"
@@ -930,11 +931,35 @@ err_request_mem:
 #ifdef CONFIG_PM
 static int fb_suspend(struct platform_device *dev, pm_message_t state)
 {
-	 return -EBUSY;
+	struct fb_info *info = platform_get_drvdata(dev);
+	struct da8xx_fb_par *par = info->par;
+
+	acquire_console_sem();
+	if (par->panel_power_ctrl)
+		par->panel_power_ctrl(0);
+
+	fb_set_suspend(info, 1);
+	lcd_disable_raster();
+	clk_disable(par->lcdc_clk);
+	release_console_sem();
+
+	return 0;
 }
 static int fb_resume(struct platform_device *dev)
 {
-	 return -EBUSY;
+	struct fb_info *info = platform_get_drvdata(dev);
+	struct da8xx_fb_par *par = info->par;
+
+	acquire_console_sem();
+	if (par->panel_power_ctrl)
+		par->panel_power_ctrl(1);
+
+	clk_enable(par->lcdc_clk);
+	lcd_enable_raster();
+	fb_set_suspend(info, 0);
+	release_console_sem();
+
+	return 0;
 }
 #else
 #define fb_suspend NULL
-- 
1.5.6
