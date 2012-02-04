From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:40:48 +0000
Subject: [PATCH 08/13] FB: sa1100: remove global sa1100fb_.*_power function pointers
Message-Id: <E1Rtc6y-0000ap-1S@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Now that we have platform data contained within the individual board
code, we can get rid of the global function pointers, placing them
inside the platform data instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c |   90 ++++++++++++++++++++++++++-------------
 arch/arm/mach-sa1100/generic.c |    6 ---
 arch/arm/mach-sa1100/generic.h |    3 -
 arch/arm/mach-sa1100/h3100.c   |    3 +-
 arch/arm/mach-sa1100/h3600.c   |    3 +-
 drivers/video/sa1100fb.c       |   32 ++++----------
 drivers/video/sa1100fb.h       |    2 +
 include/video/sa1100fb.h       |    4 ++
 8 files changed, 79 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 37fb0cd..65b0a9a 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -71,33 +71,6 @@ void ASSABET_BCR_frob(unsigned int mask, unsigned int val)
 
 EXPORT_SYMBOL(ASSABET_BCR_frob);
 
-static void assabet_backlight_power(int on)
-{
-#ifndef ASSABET_PAL_VIDEO
-	if (on)
-		ASSABET_BCR_set(ASSABET_BCR_LIGHT_ON);
-	else
-#endif
-		ASSABET_BCR_clear(ASSABET_BCR_LIGHT_ON);
-}
-
-/*
- * Turn on/off the backlight.  When turning the backlight on,
- * we wait 500us after turning it on so we don't cause the
- * supplies to droop when we enable the LCD controller (and
- * cause a hard reset.)
- */
-static void assabet_lcd_power(int on)
-{
-#ifndef ASSABET_PAL_VIDEO
-	if (on) {
-		ASSABET_BCR_set(ASSABET_BCR_LCD_ON);
-		udelay(500);
-	} else
-#endif
-		ASSABET_BCR_clear(ASSABET_BCR_LCD_ON);
-}
-
 
 /*
  * Assabet flash support code.
@@ -206,7 +179,49 @@ static struct mcp_plat_data assabet_mcp_data = {
 	.sclk_rate	= 11981000,
 };
 
+static void assabet_lcd_set_visual(u32 visual)
+{
+	u_int is_true_color = visual = FB_VISUAL_TRUECOLOR;
+
+	if (machine_is_assabet()) {
+#if 1		// phase 4 or newer Assabet's
+		if (is_true_color)
+			ASSABET_BCR_set(ASSABET_BCR_LCD_12RGB);
+		else
+			ASSABET_BCR_clear(ASSABET_BCR_LCD_12RGB);
+#else
+		// older Assabet's
+		if (is_true_color)
+			ASSABET_BCR_clear(ASSABET_BCR_LCD_12RGB);
+		else
+			ASSABET_BCR_set(ASSABET_BCR_LCD_12RGB);
+#endif
+	}
+}
+
 #ifndef ASSABET_PAL_VIDEO
+static void assabet_lcd_backlight_power(int on)
+{
+	if (on)
+		ASSABET_BCR_set(ASSABET_BCR_LIGHT_ON);
+	else
+		ASSABET_BCR_clear(ASSABET_BCR_LIGHT_ON);
+}
+
+/*
+ * Turn on/off the backlight.  When turning the backlight on, we wait
+ * 500us after turning it on so we don't cause the supplies to droop
+ * when we enable the LCD controller (and cause a hard reset.)
+ */
+static void assabet_lcd_power(int on)
+{
+	if (on) {
+		ASSABET_BCR_set(ASSABET_BCR_LCD_ON);
+		udelay(500);
+	} else
+		ASSABET_BCR_clear(ASSABET_BCR_LCD_ON);
+}
+
 /*
  * The assabet uses a sharp LQ039Q2DS54 LCD module.  It is actually
  * takes an RGB666 signal, but we provide it with an RGB565 signal
@@ -224,8 +239,22 @@ static struct sa1100fb_mach_info lq039q2ds54_info = {
 
 	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
 	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
+
+	.backlight_power = assabet_lcd_backlight_power,
+	.lcd_power = assabet_lcd_power,
+	.set_visual = assabet_lcd_set_visual,
 };
 #else
+static void assabet_pal_backlight_power(int on)
+{
+	ASSABET_BCR_clear(ASSABET_BCR_LIGHT_ON);
+}
+
+static void assabet_pal_power(int on)
+{
+	ASSABET_BCR_clear(ASSABET_BCR_LCD_ON);
+}
+
 static struct sa1100fb_mach_info pal_info = {
 	.pixclock	= 67797,	.bpp		= 16,
 	.xres		= 640,		.yres		= 512,
@@ -236,6 +265,10 @@ static struct sa1100fb_mach_info pal_info = {
 
 	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
 	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(512),
+
+	.backlight_power = assabet_pal_backlight_power,
+	.lcd_power = assabet_pal_power,
+	.set_visual = assabet_lcd_set_visual,
 };
 #endif
 
@@ -266,9 +299,6 @@ static void __init assabet_init(void)
 	PPDR |= PPC_TXD3 | PPC_TXD1;
 	PPSR |= PPC_TXD3 | PPC_TXD1;
 
-	sa1100fb_lcd_power = assabet_lcd_power;
-	sa1100fb_backlight_power = assabet_backlight_power;
-
 	if (machine_has_neponset()) {
 		/*
 		 * Angel sets this, but other bootloaders may not.
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index f57808f..9cb4062 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -374,12 +374,6 @@ static int __init sa1100_init(void)
 
 arch_initcall(sa1100_init);
 
-void (*sa1100fb_backlight_power)(int on);
-void (*sa1100fb_lcd_power)(int on);
-
-EXPORT_SYMBOL(sa1100fb_backlight_power);
-EXPORT_SYMBOL(sa1100fb_lcd_power);
-
 
 /*
  * Common I/O mapping:
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 3b903f4..5c68be8 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -16,9 +16,6 @@ extern void sa11x0_restart(char, const char *);
 	mi->bank[__nr].start = (__start), \
 	mi->bank[__nr].size = (__size)
 
-extern void (*sa1100fb_backlight_power)(int on);
-extern void (*sa1100fb_lcd_power)(int on);
-
 extern void sa1110_mb_enable(void);
 extern void sa1110_mb_disable(void);
 
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index 1f8a271..f23e7d0 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -52,6 +52,8 @@ static struct sa1100fb_mach_info h3100_lcd_info = {
 
 	.lccr0		= LCCR0_Mono | LCCR0_4PixMono | LCCR0_Sngl | LCCR0_Pas,
 	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
+
+	.lcd_power = h3100_lcd_power,
 };
 
 static void __init h3100_map_io(void)
@@ -96,7 +98,6 @@ static void __init h3100_mach_init(void)
 	h3xxx_init_gpio(h3100_default_gpio, ARRAY_SIZE(h3100_default_gpio));
 	h3xxx_mach_init();
 
-	sa1100fb_lcd_power = h3100_lcd_power;
 	sa11x0_register_lcd(&h3100_lcd_info);
 	sa11x0_register_irda(&h3100_irda_data);
 }
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 3dd39bf..2feac56 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -79,6 +79,8 @@ static struct sa1100fb_mach_info h3600_lcd_info = {
 	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
 
 	.rgb[RGB_16] = &h3600_rgb_16,
+
+	.lcd_power = h3600_lcd_power,
 };
 
 
@@ -146,7 +148,6 @@ static void __init h3600_mach_init(void)
 	h3xxx_init_gpio(h3600_default_gpio, ARRAY_SIZE(h3600_default_gpio));
 	h3xxx_mach_init();
 
-	sa1100fb_lcd_power = h3600_lcd_power;
 	sa11x0_register_lcd(&h3600_lcd_info);
 	sa11x0_register_irda(&h3600_irda_data);
 }
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index d645c6d..c9f1e7c 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -194,9 +194,6 @@
 
 #include "sa1100fb.h"
 
-extern void (*sa1100fb_backlight_power)(int on);
-extern void (*sa1100fb_lcd_power)(int on);
-
 static const struct sa1100fb_rgb rgb_4 = {
 	.red	= { .offset = 0,  .length = 4, },
 	.green	= { .offset = 0,  .length = 4, },
@@ -426,22 +423,10 @@ sa1100fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	return 0;
 }
 
-static inline void sa1100fb_set_truecolor(u_int is_true_color)
+static void sa1100fb_set_visual(struct sa1100fb_info *fbi, u32 visual)
 {
-	if (machine_is_assabet()) {
-#if 1		// phase 4 or newer Assabet's
-		if (is_true_color)
-			ASSABET_BCR_set(ASSABET_BCR_LCD_12RGB);
-		else
-			ASSABET_BCR_clear(ASSABET_BCR_LCD_12RGB);
-#else
-		// older Assabet's
-		if (is_true_color)
-			ASSABET_BCR_clear(ASSABET_BCR_LCD_12RGB);
-		else
-			ASSABET_BCR_set(ASSABET_BCR_LCD_12RGB);
-#endif
-	}
+	if (fbi->inf->set_visual)
+		fbi->inf->set_visual(visual);
 }
 
 /*
@@ -483,7 +468,7 @@ static int sa1100fb_set_par(struct fb_info *info)
 	/*
 	 * Set (any) board control register to handle new color depth
 	 */
-	sa1100fb_set_truecolor(fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR);
+	sa1100fb_set_visual(fbi, fbi->fb.fix.visual);
 	sa1100fb_activate_var(var, fbi);
 
 	return 0;
@@ -740,16 +725,16 @@ static inline void __sa1100fb_backlight_power(struct sa1100fb_info *fbi, int on)
 {
 	dev_dbg(fbi->dev, "backlight o%s\n", on ? "n" : "ff");
 
-	if (sa1100fb_backlight_power)
-		sa1100fb_backlight_power(on);
+	if (fbi->inf->backlight_power)
+		fbi->inf->backlight_power(on);
 }
 
 static inline void __sa1100fb_lcd_power(struct sa1100fb_info *fbi, int on)
 {
 	dev_dbg(fbi->dev, "LCD power o%s\n", on ? "n" : "ff");
 
-	if (sa1100fb_lcd_power)
-		sa1100fb_lcd_power(on);
+	if (fbi->inf->lcd_power)
+		fbi->inf->lcd_power(on);
 }
 
 static void sa1100fb_setup_gpio(struct sa1100fb_info *fbi)
@@ -1197,6 +1182,7 @@ static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
 	fbi->task_state			= (u_char)-1;
 	fbi->fb.fix.smem_len		= fbi->max_xres * fbi->max_yres *
 					  fbi->max_bpp / 8;
+	fbi->inf			= inf;
 
 	/* Copy the RGB bitfield overrides */
 	for (i = 0; i < NR_RGB; i++)
diff --git a/drivers/video/sa1100fb.h b/drivers/video/sa1100fb.h
index 9ff9ba9..3a634ab 100644
--- a/drivers/video/sa1100fb.h
+++ b/drivers/video/sa1100fb.h
@@ -65,6 +65,8 @@ struct sa1100fb_info {
 	struct notifier_block	freq_transition;
 	struct notifier_block	freq_policy;
 #endif
+
+	const struct sa1100fb_mach_info *inf;
 };
 
 #define TO_INF(ptr,member)	container_of(ptr,struct sa1100fb_info,member)
diff --git a/include/video/sa1100fb.h b/include/video/sa1100fb.h
index e73c813..4ab4096 100644
--- a/include/video/sa1100fb.h
+++ b/include/video/sa1100fb.h
@@ -54,6 +54,10 @@ struct sa1100fb_mach_info {
 
 	/* Overrides for the default RGB maps */
 	const struct sa1100fb_rgb *rgb[NR_RGB];
+
+	void (*backlight_power)(int);
+	void (*lcd_power)(int);
+	void (*set_visual)(u32);
 };
 
 #endif
-- 
1.7.4.4

