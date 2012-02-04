From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:39:26 +0000
Subject: [PATCH 04/13] FB: sa1100: convert printks to dev_xxx()
Message-Id: <E1Rtc5e-0000aZ-Bp@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use the dev_xxx() macros for driver kernel message output, rather than
open coded printk() with KERN_ levels etc.  Remove DPRINTK().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/sa1100fb.c |   72 +++++++++++++++++++++------------------------
 drivers/video/sa1100fb.h |    9 ------
 2 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index a797220..ecd7cd4 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -184,10 +184,6 @@
 #include <mach/shannon.h>
 
 /*
- * debugging?
- */
-#define DEBUG 0
-/*
  * Complain if VAR is out of range.
  */
 #define DEBUG_VAR 1
@@ -614,7 +610,7 @@ sa1100fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	var->xres_virtual = max(var->xres_virtual, var->xres);
 	var->yres_virtual = max(var->yres_virtual, var->yres);
 
-	DPRINTK("var->bits_per_pixel=%d\n", var->bits_per_pixel);
+	dev_dbg(fbi->dev, "var->bits_per_pixel=%d\n", var->bits_per_pixel);
 	switch (var->bits_per_pixel) {
 	case 4:
 		rgbidx = RGB_4;
@@ -638,16 +634,16 @@ sa1100fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	var->blue   = fbi->rgb[rgbidx]->blue;
 	var->transp = fbi->rgb[rgbidx]->transp;
 
-	DPRINTK("RGBT length = %d:%d:%d:%d\n",
+	dev_dbg(fbi->dev, "RGBT length = %d:%d:%d:%d\n",
 		var->red.length, var->green.length, var->blue.length,
 		var->transp.length);
 
-	DPRINTK("RGBT offset = %d:%d:%d:%d\n",
+	dev_dbg(fbi->dev, "RGBT offset = %d:%d:%d:%d\n",
 		var->red.offset, var->green.offset, var->blue.offset,
 		var->transp.offset);
 
 #ifdef CONFIG_CPU_FREQ
-	printk(KERN_DEBUG "dma period = %d ps, clock = %d kHz\n",
+	dev_dbg(fbi->dev, "dma period = %d ps, clock = %d kHz\n",
 		sa1100fb_display_dma_period(var),
 		cpufreq_get(smp_processor_id()));
 #endif
@@ -683,7 +679,7 @@ static int sa1100fb_set_par(struct fb_info *info)
 	struct fb_var_screeninfo *var = &info->var;
 	unsigned long palette_mem_size;
 
-	DPRINTK("set_par\n");
+	dev_dbg(fbi->dev, "set_par\n");
 
 	if (var->bits_per_pixel = 16)
 		fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR;
@@ -704,7 +700,7 @@ static int sa1100fb_set_par(struct fb_info *info)
 
 	palette_mem_size = fbi->palette_size * sizeof(u16);
 
-	DPRINTK("palette_mem_size = 0x%08lx\n", (u_long) palette_mem_size);
+	dev_dbg(fbi->dev, "palette_mem_size = 0x%08lx\n", palette_mem_size);
 
 	fbi->palette_cpu = (u16 *)(fbi->map_cpu + PAGE_SIZE - palette_mem_size);
 	fbi->palette_dma = fbi->map_dma + PAGE_SIZE - palette_mem_size;
@@ -775,7 +771,7 @@ static int sa1100fb_blank(int blank, struct fb_info *info)
 	struct sa1100fb_info *fbi = (struct sa1100fb_info *)info;
 	int i;
 
-	DPRINTK("sa1100fb_blank: blank=%d\n", blank);
+	dev_dbg(fbi->dev, "sa1100fb_blank: blank=%d\n", blank);
 
 	switch (blank) {
 	case FB_BLANK_POWERDOWN:
@@ -863,39 +859,39 @@ static int sa1100fb_activate_var(struct fb_var_screeninfo *var, struct sa1100fb_
 	u_int half_screen_size, yres, pcd;
 	u_long flags;
 
-	DPRINTK("Configuring SA1100 LCD\n");
+	dev_dbg(fbi->dev, "Configuring SA1100 LCD\n");
 
-	DPRINTK("var: xres=%d hslen=%d lm=%d rm=%d\n",
+	dev_dbg(fbi->dev, "var: xres=%d hslen=%d lm=%d rm=%d\n",
 		var->xres, var->hsync_len,
 		var->left_margin, var->right_margin);
-	DPRINTK("var: yres=%d vslen=%d um=%d bm=%d\n",
+	dev_dbg(fbi->dev, "var: yres=%d vslen=%d um=%d bm=%d\n",
 		var->yres, var->vsync_len,
 		var->upper_margin, var->lower_margin);
 
 #if DEBUG_VAR
 	if (var->xres < 16        || var->xres > 1024)
-		printk(KERN_ERR "%s: invalid xres %d\n",
+		dev_err(fbi->dev, "%s: invalid xres %d\n",
 			fbi->fb.fix.id, var->xres);
 	if (var->hsync_len < 1    || var->hsync_len > 64)
-		printk(KERN_ERR "%s: invalid hsync_len %d\n",
+		dev_err(fbi->dev, "%s: invalid hsync_len %d\n",
 			fbi->fb.fix.id, var->hsync_len);
 	if (var->left_margin < 1  || var->left_margin > 255)
-		printk(KERN_ERR "%s: invalid left_margin %d\n",
+		dev_err(fbi->dev, "%s: invalid left_margin %d\n",
 			fbi->fb.fix.id, var->left_margin);
 	if (var->right_margin < 1 || var->right_margin > 255)
-		printk(KERN_ERR "%s: invalid right_margin %d\n",
+		dev_err(fbi->dev, "%s: invalid right_margin %d\n",
 			fbi->fb.fix.id, var->right_margin);
 	if (var->yres < 1         || var->yres > 1024)
-		printk(KERN_ERR "%s: invalid yres %d\n",
+		dev_err(fbi->dev, "%s: invalid yres %d\n",
 			fbi->fb.fix.id, var->yres);
 	if (var->vsync_len < 1    || var->vsync_len > 64)
-		printk(KERN_ERR "%s: invalid vsync_len %d\n",
+		dev_err(fbi->dev, "%s: invalid vsync_len %d\n",
 			fbi->fb.fix.id, var->vsync_len);
 	if (var->upper_margin < 0 || var->upper_margin > 255)
-		printk(KERN_ERR "%s: invalid upper_margin %d\n",
+		dev_err(fbi->dev, "%s: invalid upper_margin %d\n",
 			fbi->fb.fix.id, var->upper_margin);
 	if (var->lower_margin < 0 || var->lower_margin > 255)
-		printk(KERN_ERR "%s: invalid lower_margin %d\n",
+		dev_err(fbi->dev, "%s: invalid lower_margin %d\n",
 			fbi->fb.fix.id, var->lower_margin);
 #endif
 
@@ -928,10 +924,10 @@ static int sa1100fb_activate_var(struct fb_var_screeninfo *var, struct sa1100fb_
 		(var->sync & FB_SYNC_HOR_HIGH_ACT ? LCCR3_HorSnchH : LCCR3_HorSnchL) |
 		(var->sync & FB_SYNC_VERT_HIGH_ACT ? LCCR3_VrtSnchH : LCCR3_VrtSnchL);
 
-	DPRINTK("nlccr0 = 0x%08lx\n", new_regs.lccr0);
-	DPRINTK("nlccr1 = 0x%08lx\n", new_regs.lccr1);
-	DPRINTK("nlccr2 = 0x%08lx\n", new_regs.lccr2);
-	DPRINTK("nlccr3 = 0x%08lx\n", new_regs.lccr3);
+	dev_dbg(fbi->dev, "nlccr0 = 0x%08lx\n", new_regs.lccr0);
+	dev_dbg(fbi->dev, "nlccr1 = 0x%08lx\n", new_regs.lccr1);
+	dev_dbg(fbi->dev, "nlccr2 = 0x%08lx\n", new_regs.lccr2);
+	dev_dbg(fbi->dev, "nlccr3 = 0x%08lx\n", new_regs.lccr3);
 
 	half_screen_size = var->bits_per_pixel;
 	half_screen_size = half_screen_size * var->xres * var->yres / 16;
@@ -967,7 +963,7 @@ static int sa1100fb_activate_var(struct fb_var_screeninfo *var, struct sa1100fb_
  */
 static inline void __sa1100fb_backlight_power(struct sa1100fb_info *fbi, int on)
 {
-	DPRINTK("backlight o%s\n", on ? "n" : "ff");
+	dev_dbg(fbi->dev, "backlight o%s\n", on ? "n" : "ff");
 
 	if (sa1100fb_backlight_power)
 		sa1100fb_backlight_power(on);
@@ -975,7 +971,7 @@ static inline void __sa1100fb_backlight_power(struct sa1100fb_info *fbi, int on)
 
 static inline void __sa1100fb_lcd_power(struct sa1100fb_info *fbi, int on)
 {
-	DPRINTK("LCD power o%s\n", on ? "n" : "ff");
+	dev_dbg(fbi->dev, "LCD power o%s\n", on ? "n" : "ff");
 
 	if (sa1100fb_lcd_power)
 		sa1100fb_lcd_power(on);
@@ -1015,7 +1011,7 @@ static void sa1100fb_setup_gpio(struct sa1100fb_info *fbi)
 
 static void sa1100fb_enable_controller(struct sa1100fb_info *fbi)
 {
-	DPRINTK("Enabling LCD controller\n");
+	dev_dbg(fbi->dev, "Enabling LCD controller\n");
 
 	/*
 	 * Make sure the mode bits are present in the first palette entry
@@ -1037,19 +1033,19 @@ static void sa1100fb_enable_controller(struct sa1100fb_info *fbi)
 		GPSR |= SHANNON_GPIO_DISP_EN;
 	}
 
-	DPRINTK("DBAR1 = 0x%08x\n", DBAR1);
-	DPRINTK("DBAR2 = 0x%08x\n", DBAR2);
-	DPRINTK("LCCR0 = 0x%08x\n", LCCR0);
-	DPRINTK("LCCR1 = 0x%08x\n", LCCR1);
-	DPRINTK("LCCR2 = 0x%08x\n", LCCR2);
-	DPRINTK("LCCR3 = 0x%08x\n", LCCR3);
+	dev_dbg(fbi->dev, "DBAR1 = 0x%08lx\n", DBAR1);
+	dev_dbg(fbi->dev, "DBAR2 = 0x%08lx\n", DBAR2);
+	dev_dbg(fbi->dev, "LCCR0 = 0x%08lx\n", LCCR0);
+	dev_dbg(fbi->dev, "LCCR1 = 0x%08lx\n", LCCR1);
+	dev_dbg(fbi->dev, "LCCR2 = 0x%08lx\n", LCCR2);
+	dev_dbg(fbi->dev, "LCCR3 = 0x%08lx\n", LCCR3);
 }
 
 static void sa1100fb_disable_controller(struct sa1100fb_info *fbi)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
-	DPRINTK("Disabling LCD controller\n");
+	dev_dbg(fbi->dev, "Disabling LCD controller\n");
 
 	if (machine_is_shannon()) {
 		GPCR |= SHANNON_GPIO_DISP_EN;
@@ -1268,7 +1264,7 @@ sa1100fb_freq_policy(struct notifier_block *nb, unsigned long val,
 	switch (val) {
 	case CPUFREQ_ADJUST:
 	case CPUFREQ_INCOMPATIBLE:
-		printk(KERN_DEBUG "min dma period: %d ps, "
+		dev_dbg(fbi->dev, "min dma period: %d ps, "
 			"new clock %d kHz\n", sa1100fb_min_dma_period(fbi),
 			policy->max);
 		/* todo: fill in min/max values */
@@ -1459,7 +1455,7 @@ static int __devinit sa1100fb_probe(struct platform_device *pdev)
 
 	ret = request_irq(irq, sa1100fb_handle_irq, 0, "LCD", fbi);
 	if (ret) {
-		printk(KERN_ERR "sa1100fb: request_irq failed: %d\n", ret);
+		dev_err(&pdev->dev, "request_irq failed: %d\n", ret);
 		goto failed;
 	}
 
diff --git a/drivers/video/sa1100fb.h b/drivers/video/sa1100fb.h
index 7a3d66a..b1d5b08 100644
--- a/drivers/video/sa1100fb.h
+++ b/drivers/video/sa1100fb.h
@@ -130,15 +130,6 @@ struct sa1100fb_info {
 #define SA1100_NAME	"SA1100"
 
 /*
- *  Debug macros 
- */
-#if DEBUG
-#  define DPRINTK(fmt, args...)	printk("%s: " fmt, __func__ , ## args)
-#else
-#  define DPRINTK(fmt, args...)
-#endif
-
-/*
  * Minimum X and Y resolutions
  */
 #define MIN_XRES	64
-- 
1.7.4.4

