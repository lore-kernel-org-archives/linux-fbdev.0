From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] davinci: fb: Add cpufreq support
Date: Tue, 20 Oct 2009 15:52:58 +0530
Message-ID: <1256034178-1742-1-git-send-email-chaithrika@ti.com>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org

Add cpufreq support for DA8xx/OMAP-L1xx frame buffer driver.
Tested on DA850/OMAP-L138 EVM for Davinci GIT tree as cpufreq support is not
in the mainline yet.

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
---
This patch applies to Linus' kernel tree and is dependent on 'davinci: fb:
Calculate the clock divider from pixel clock info' patch submitted earlier.

 drivers/video/da8xx-fb.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index d9ab839..94d48c4 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -28,6 +28,7 @@
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
+#include <linux/cpufreq.h>
 #include <video/da8xx-fb.h>
 
 #define DRIVER_NAME "da8xx_lcdc"
@@ -114,6 +115,9 @@ struct da8xx_fb_par {
 	unsigned int databuf_sz;
 	unsigned int palette_sz;
 	unsigned int pxl_clk;
+#ifdef CONFIG_CPU_FREQ
+	struct notifier_block	freq_transition;
+#endif
 };
 
 /* Variable Screen Information */
@@ -586,6 +590,41 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 	return err;
 }
 
+#ifdef CONFIG_CPU_FREQ
+static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
+				     unsigned long val, void *data)
+{
+	struct da8xx_fb_par *par;
+	unsigned int reg;
+
+	par = container_of(nb, struct da8xx_fb_par, freq_transition);
+	if (val == CPUFREQ_PRECHANGE) {
+		reg = lcdc_read(LCD_RASTER_CTRL_REG);
+		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+	} else if (val == CPUFREQ_POSTCHANGE) {
+		lcd_calc_clk_divider(par);
+		reg = lcdc_read(LCD_RASTER_CTRL_REG);
+		lcdc_write(reg | LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+	}
+
+	return 0;
+}
+
+static inline int lcd_da8xx_cpufreq_register(struct da8xx_fb_par *par)
+{
+	par->freq_transition.notifier_call = lcd_da8xx_cpufreq_transition;
+
+	return cpufreq_register_notifier(&par->freq_transition,
+					 CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+static inline void lcd_da8xx_cpufreq_deregister(struct da8xx_fb_par *par)
+{
+	cpufreq_unregister_notifier(&par->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+}
+#endif
+
 static int __devexit fb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(&dev->dev);
@@ -593,6 +632,9 @@ static int __devexit fb_remove(struct platform_device *dev)
 	if (info) {
 		struct da8xx_fb_par *par = info->par;
 
+#ifdef CONFIG_CPUFREQ
+		lcd_da8xx_cpufreq_deregister(par);
+#endif
 		if (lcdc_read(LCD_RASTER_CTRL_REG) & LCD_RASTER_ENABLE)
 			lcd_disable_raster(par);
 		lcdc_write(0, LCD_RASTER_CTRL_REG);
@@ -823,12 +865,25 @@ static int __init fb_probe(struct platform_device *device)
 		goto err_dealloc_cmap;
 	}
 
+#ifdef CONFIG_CPU_FREQ
+	ret = lcd_da8xx_cpufreq_register(par);
+	if (ret) {
+		dev_err(&device->dev, "failed to register cpufreq\n");
+		goto err_cpu_freq;
+	}
+#endif
+
 	/* enable raster engine */
 	lcdc_write(lcdc_read(LCD_RASTER_CTRL_REG) |
 			LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
 
 	return 0;
 
+#ifdef CONFIG_CPU_FREQ
+err_cpu_freq:
+	unregister_framebuffer(da8xx_fb_info);
+#endif
+
 err_dealloc_cmap:
 	fb_dealloc_cmap(&da8xx_fb_info->cmap);
 
-- 
1.5.6
