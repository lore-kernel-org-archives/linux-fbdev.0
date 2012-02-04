From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:40:27 +0000
Subject: [PATCH 07/13] FB: sa1100: move platform data to platform files
Message-Id: <E1Rtc6d-0000al-KV@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Move platform data out of the sa1100fb driver into the various
platform files themselves.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c |   40 +++++++
 arch/arm/mach-sa1100/collie.c  |   17 +++
 arch/arm/mach-sa1100/generic.c |    8 +-
 arch/arm/mach-sa1100/generic.h |    3 +
 arch/arm/mach-sa1100/h3100.c   |   22 ++++-
 arch/arm/mach-sa1100/h3600.c   |   31 +++++-
 arch/arm/mach-sa1100/lart.c    |   79 +++++++++++++
 arch/arm/mach-sa1100/shannon.c |   17 +++
 drivers/video/sa1100fb.c       |  239 +---------------------------------------
 9 files changed, 218 insertions(+), 238 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 0c4b76a..37fb0cd 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -20,6 +20,8 @@
 #include <linux/delay.h>
 #include <linux/mm.h>
 
+#include <video/sa1100fb.h>
+
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -204,6 +206,39 @@ static struct mcp_plat_data assabet_mcp_data = {
 	.sclk_rate	= 11981000,
 };
 
+#ifndef ASSABET_PAL_VIDEO
+/*
+ * The assabet uses a sharp LQ039Q2DS54 LCD module.  It is actually
+ * takes an RGB666 signal, but we provide it with an RGB565 signal
+ * instead (def_rgb_16).
+ */
+static struct sa1100fb_mach_info lq039q2ds54_info = {
+	.pixclock	= 171521,	.bpp		= 16,
+	.xres		= 320,		.yres		= 240,
+
+	.hsync_len	= 5,		.vsync_len	= 1,
+	.left_margin	= 61,		.upper_margin	= 3,
+	.right_margin	= 9,		.lower_margin	= 0,
+
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+
+	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
+	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
+};
+#else
+static struct sa1100fb_mach_info pal_info = {
+	.pixclock	= 67797,	.bpp		= 16,
+	.xres		= 640,		.yres		= 512,
+
+	.hsync_len	= 64,		.vsync_len	= 6,
+	.left_margin	= 125,		.upper_margin	= 70,
+	.right_margin	= 115,		.lower_margin	= 36,
+
+	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
+	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(512),
+};
+#endif
+
 static void __init assabet_init(void)
 {
 	/*
@@ -249,6 +284,11 @@ static void __init assabet_init(void)
 #endif
 	}
 
+#ifndef ASSABET_PAL_VIDEO
+	sa11x0_register_lcd(&lq039q2ds54_info);
+#else
+	sa11x0_register_lcd(&pal_video);
+#endif
 	sa11x0_register_mtd(&assabet_flash_data, assabet_flash_resources,
 			    ARRAY_SIZE(assabet_flash_resources));
 	sa11x0_register_irda(&assabet_irda_data);
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index fd56521..70f6cdc 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -28,6 +28,8 @@
 #include <linux/gpio.h>
 #include <linux/pda_power.h>
 
+#include <video/sa1100fb.h>
+
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
@@ -310,6 +312,20 @@ static struct resource collie_flash_resources[] = {
 	}
 };
 
+static struct sa1100fb_mach_info collie_lcd_info = {
+	.pixclock	= 171521,	.bpp		= 16,
+	.xres		= 320,		.yres		= 240,
+
+	.hsync_len	= 5,		.vsync_len	= 1,
+	.left_margin	= 11,		.upper_margin	= 2,
+	.right_margin	= 30,		.lower_margin	= 0,
+
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+
+	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
+	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
+};
+
 static void __init collie_init(void)
 {
 	int ret = 0;
@@ -348,6 +364,7 @@ static void __init collie_init(void)
 		printk(KERN_WARNING "collie: Unable to register LoCoMo device\n");
 	}
 
+	sa11x0_register_lcd(&collie_lcd_info);
 	sa11x0_register_mtd(&collie_flash_data, collie_flash_resources,
 			    ARRAY_SIZE(collie_flash_resources));
 	sa11x0_register_mcp(&collie_mcp_data);
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index bb10ee2..f57808f 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -19,6 +19,8 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 
+#include <video/sa1100fb.h>
+
 #include <asm/div64.h>
 #include <mach/hardware.h>
 #include <asm/system.h>
@@ -294,6 +296,11 @@ static struct platform_device sa11x0fb_device = {
 	.resource	= sa11x0fb_resources,
 };
 
+void sa11x0_register_lcd(struct sa1100fb_mach_info *inf)
+{
+	sa11x0_register_device(&sa11x0fb_device, inf);
+}
+
 static struct platform_device sa11x0pcmcia_device = {
 	.name		= "sa11x0-pcmcia",
 	.id		= -1,
@@ -356,7 +363,6 @@ static struct platform_device *sa11x0_devices[] __initdata = {
 	&sa11x0uart3_device,
 	&sa11x0ssp_device,
 	&sa11x0pcmcia_device,
-	&sa11x0fb_device,
 	&sa11x0rtc_device,
 };
 
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 33268cf..3b903f4 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -40,3 +40,6 @@ void sa11x0_register_irda(struct irda_platform_data *irda);
 
 struct mcp_plat_data;
 void sa11x0_register_mcp(struct mcp_plat_data *data);
+
+struct sa1100fb_mach_info;
+void sa11x0_register_lcd(struct sa1100fb_mach_info *inf);
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index 1e6b3c1..1f8a271 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -14,6 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 
+#include <video/sa1100fb.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irda.h>
@@ -36,13 +38,26 @@ static void h3100_lcd_power(int enable)
 	}
 }
 
+static struct sa1100fb_mach_info h3100_lcd_info = {
+	.pixclock	= 406977, 	.bpp		= 4,
+	.xres		= 320,		.yres		= 240,
+
+	.hsync_len	= 26,		.vsync_len	= 41,
+	.left_margin	= 4,		.upper_margin	= 0,
+	.right_margin	= 4,		.lower_margin	= 0,
+
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	.cmap_greyscale	= 1,
+	.cmap_inverse	= 1,
+
+	.lccr0		= LCCR0_Mono | LCCR0_4PixMono | LCCR0_Sngl | LCCR0_Pas,
+	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
+};
 
 static void __init h3100_map_io(void)
 {
 	h3xxx_map_io();
 
-	sa1100fb_lcd_power = h3100_lcd_power;
-
 	/* Older bootldrs put GPIO2-9 in alternate mode on the
 	   assumption that they are used for video */
 	GAFR &= ~0x000001fb;
@@ -80,6 +95,9 @@ static void __init h3100_mach_init(void)
 {
 	h3xxx_init_gpio(h3100_default_gpio, ARRAY_SIZE(h3100_default_gpio));
 	h3xxx_mach_init();
+
+	sa1100fb_lcd_power = h3100_lcd_power;
+	sa11x0_register_lcd(&h3100_lcd_info);
 	sa11x0_register_irda(&h3100_irda_data);
 }
 
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 6b58e74..3dd39bf 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -14,6 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 
+#include <video/sa1100fb.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irda.h>
@@ -56,11 +58,33 @@ err2:	gpio_free(H3XXX_EGPIO_LCD_ON);
 err1:	return;
 }
 
+static const struct sa1100fb_rgb h3600_rgb_16 = {
+	.red	= { .offset = 12, .length = 4, },
+	.green	= { .offset = 7,  .length = 4, },
+	.blue	= { .offset = 1,  .length = 4, },
+	.transp	= { .offset = 0,  .length = 0, },
+};
+
+static struct sa1100fb_mach_info h3600_lcd_info = {
+	.pixclock	= 174757, 	.bpp		= 16,
+	.xres		= 320,		.yres		= 240,
+
+	.hsync_len	= 3,		.vsync_len	= 3,
+	.left_margin	= 12,		.upper_margin	= 10,
+	.right_margin	= 17,		.lower_margin	= 1,
+
+	.cmap_static	= 1,
+
+	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
+	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
+
+	.rgb[RGB_16] = &h3600_rgb_16,
+};
+
+
 static void __init h3600_map_io(void)
 {
 	h3xxx_map_io();
-
-	sa1100fb_lcd_power = h3600_lcd_power;
 }
 
 /*
@@ -121,6 +145,9 @@ static void __init h3600_mach_init(void)
 {
 	h3xxx_init_gpio(h3600_default_gpio, ARRAY_SIZE(h3600_default_gpio));
 	h3xxx_mach_init();
+
+	sa1100fb_lcd_power = h3600_lcd_power;
+	sa11x0_register_lcd(&h3600_lcd_info);
 	sa11x0_register_irda(&h3600_irda_data);
 }
 
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index af4e276..463a322 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -6,6 +6,8 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 
+#include <video/sa1100fb.h>
+
 #include <mach/hardware.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -26,8 +28,85 @@ static struct mcp_plat_data lart_mcp_data = {
 	.sclk_rate	= 11981000,
 };
 
+#ifdef LART_GREY_LCD
+static struct sa1100fb_mach_info lart_grey_info = {
+	.pixclock	= 150000,	.bpp		= 4,
+	.xres		= 320,		.yres		= 240,
+
+	.hsync_len	= 1,		.vsync_len	= 1,
+	.left_margin	= 4,		.upper_margin	= 0,
+	.right_margin	= 2,		.lower_margin	= 0,
+
+	.cmap_greyscale	= 1,
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+
+	.lccr0		= LCCR0_Mono | LCCR0_Sngl | LCCR0_Pas | LCCR0_4PixMono,
+	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(512),
+};
+#endif
+#ifdef LART_COLOR_LCD
+static struct sa1100fb_mach_info lart_color_info = {
+	.pixclock	= 150000,	.bpp		= 16,
+	.xres		= 320,		.yres		= 240,
+
+	.hsync_len	= 2,		.vsync_len	= 3,
+	.left_margin	= 69,		.upper_margin	= 14,
+	.right_margin	= 8,		.lower_margin	= 4,
+
+	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
+	.lccr3		= LCCR3_OutEnH | LCCR3_PixFlEdg | LCCR3_ACBsDiv(512),
+};
+#endif
+#ifdef LART_VIDEO_OUT
+static struct sa1100fb_mach_info lart_video_info = {
+	.pixclock	= 39721,	.bpp		= 16,
+	.xres		= 640,		.yres		= 480,
+
+	.hsync_len	= 95,		.vsync_len	= 2,
+	.left_margin	= 40,		.upper_margin	= 32,
+	.right_margin	= 24,		.lower_margin	= 11,
+
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+
+	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
+	.lccr3		= LCCR3_OutEnL | LCCR3_PixFlEdg | LCCR3_ACBsDiv(512),
+};
+#endif
+
+#ifdef LART_KIT01_LCD
+static struct sa1100fb_mach_info lart_kit01_info = {
+	.pixclock	= 63291,	.bpp		= 16,
+	.xres		= 640,		.yres		= 480,
+
+	.hsync_len	= 64,		.vsync_len	= 3,
+	.left_margin	= 122,		.upper_margin	= 45,
+	.right_margin	= 10,		.lower_margin	= 10,
+
+	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
+	.lccr3		= LCCR3_OutEnH | LCCR3_PixFlEdg
+};
+#endif
+
 static void __init lart_init(void)
 {
+	struct sa1100fb_mach_info *inf = NULL;
+
+#ifdef LART_GREY_LCD
+	inf = &lart_grey_info;
+#endif
+#ifdef LART_COLOR_LCD
+	inf = &lart_color_info;
+#endif
+#ifdef LART_VIDEO_OUT
+	inf = &lart_video_info;
+#endif
+#ifdef LART_KIT01_LCD
+	inf = &lart_kit01_info;
+#endif
+
+	if (inf)
+		sa11x0_register_lcd(inf);
+
 	sa11x0_register_mcp(&lart_mcp_data);
 }
 
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 318b2b7..c695b73 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -9,6 +9,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
+#include <video/sa1100fb.h>
+
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/setup.h>
@@ -57,8 +59,23 @@ static struct mcp_plat_data shannon_mcp_data = {
 	.sclk_rate	= 11981000,
 };
 
+static struct sa1100fb_mach_info shannon_lcd_info = {
+	.pixclock	= 152500,	.bpp		= 8,
+	.xres		= 640,		.yres		= 480,
+
+	.hsync_len	= 4,		.vsync_len	= 3,
+	.left_margin	= 2,		.upper_margin	= 0,
+	.right_margin	= 1,		.lower_margin	= 0,
+
+	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+
+	.lccr0		= LCCR0_Color | LCCR0_Dual | LCCR0_Pas,
+	.lccr3		= LCCR3_ACBsDiv(512),
+};
+
 static void __init shannon_init(void)
 {
+	sa11x0_register_lcd(&shannon_lcd_info);
 	sa11x0_register_mtd(&shannon_flash_data, &shannon_flash_resource, 1);
 	sa11x0_register_mcp(&shannon_mcp_data);
 }
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index 8f5557a..d645c6d 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -218,235 +218,7 @@ static const struct sa1100fb_rgb def_rgb_16 = {
 	.transp	= { .offset = 0,  .length = 0, },
 };
 
-#ifdef CONFIG_SA1100_ASSABET
-#ifndef ASSABET_PAL_VIDEO
-/*
- * The assabet uses a sharp LQ039Q2DS54 LCD module.  It is actually
- * takes an RGB666 signal, but we provide it with an RGB565 signal
- * instead (def_rgb_16).
- */
-static struct sa1100fb_mach_info lq039q2ds54_info __devinitdata = {
-	.pixclock	= 171521,	.bpp		= 16,
-	.xres		= 320,		.yres		= 240,
-
-	.hsync_len	= 5,		.vsync_len	= 1,
-	.left_margin	= 61,		.upper_margin	= 3,
-	.right_margin	= 9,		.lower_margin	= 0,
-
-	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-
-	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
-	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
-};
-#else
-static struct sa1100fb_mach_info pal_info __devinitdata = {
-	.pixclock	= 67797,	.bpp		= 16,
-	.xres		= 640,		.yres		= 512,
-
-	.hsync_len	= 64,		.vsync_len	= 6,
-	.left_margin	= 125,		.upper_margin	= 70,
-	.right_margin	= 115,		.lower_margin	= 36,
-
-	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
-	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(512),
-};
-#endif
-#endif
-
-#ifdef CONFIG_SA1100_H3600
-static const struct sa1100fb_rgb h3600_rgb_16 = {
-	.red	= { .offset = 12, .length = 4, },
-	.green	= { .offset = 7,  .length = 4, },
-	.blue	= { .offset = 1,  .length = 4, },
-	.transp	= { .offset = 0,  .length = 0, },
-};
-
-static struct sa1100fb_mach_info h3600_info __devinitdata = {
-	.pixclock	= 174757, 	.bpp		= 16,
-	.xres		= 320,		.yres		= 240,
-
-	.hsync_len	= 3,		.vsync_len	= 3,
-	.left_margin	= 12,		.upper_margin	= 10,
-	.right_margin	= 17,		.lower_margin	= 1,
-
-	.cmap_static	= 1,
-
-	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
-	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
-
-	.rgb[RGB_16] = &h3600_rgb_16,
-};
-#endif
-
-#ifdef CONFIG_SA1100_H3100
-static struct sa1100fb_mach_info h3100_info __devinitdata = {
-	.pixclock	= 406977, 	.bpp		= 4,
-	.xres		= 320,		.yres		= 240,
 
-	.hsync_len	= 26,		.vsync_len	= 41,
-	.left_margin	= 4,		.upper_margin	= 0,
-	.right_margin	= 4,		.lower_margin	= 0,
-
-	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	.cmap_greyscale	= 1,
-	.cmap_inverse	= 1,
-
-	.lccr0		= LCCR0_Mono | LCCR0_4PixMono | LCCR0_Sngl | LCCR0_Pas,
-	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
-};
-#endif
-
-#ifdef CONFIG_SA1100_COLLIE
-static struct sa1100fb_mach_info collie_info __devinitdata = {
-	.pixclock	= 171521,	.bpp		= 16,
-	.xres		= 320,		.yres		= 240,
-
-	.hsync_len	= 5,		.vsync_len	= 1,
-	.left_margin	= 11,		.upper_margin	= 2,
-	.right_margin	= 30,		.lower_margin	= 0,
-
-	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-
-	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
-	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
-};
-#endif
-
-#ifdef LART_GREY_LCD
-static struct sa1100fb_mach_info lart_grey_info __devinitdata = {
-	.pixclock	= 150000,	.bpp		= 4,
-	.xres		= 320,		.yres		= 240,
-
-	.hsync_len	= 1,		.vsync_len	= 1,
-	.left_margin	= 4,		.upper_margin	= 0,
-	.right_margin	= 2,		.lower_margin	= 0,
-
-	.cmap_greyscale	= 1,
-	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-
-	.lccr0		= LCCR0_Mono | LCCR0_Sngl | LCCR0_Pas | LCCR0_4PixMono,
-	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(512),
-};
-#endif
-#ifdef LART_COLOR_LCD
-static struct sa1100fb_mach_info lart_color_info __devinitdata = {
-	.pixclock	= 150000,	.bpp		= 16,
-	.xres		= 320,		.yres		= 240,
-
-	.hsync_len	= 2,		.vsync_len	= 3,
-	.left_margin	= 69,		.upper_margin	= 14,
-	.right_margin	= 8,		.lower_margin	= 4,
-
-	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
-	.lccr3		= LCCR3_OutEnH | LCCR3_PixFlEdg | LCCR3_ACBsDiv(512),
-};
-#endif
-#ifdef LART_VIDEO_OUT
-static struct sa1100fb_mach_info lart_video_info __devinitdata = {
-	.pixclock	= 39721,	.bpp		= 16,
-	.xres		= 640,		.yres		= 480,
-
-	.hsync_len	= 95,		.vsync_len	= 2,
-	.left_margin	= 40,		.upper_margin	= 32,
-	.right_margin	= 24,		.lower_margin	= 11,
-
-	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-
-	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
-	.lccr3		= LCCR3_OutEnL | LCCR3_PixFlEdg | LCCR3_ACBsDiv(512),
-};
-#endif
-
-#ifdef LART_KIT01_LCD
-static struct sa1100fb_mach_info lart_kit01_info __devinitdata = {
-	.pixclock	= 63291,	.bpp		= 16,
-	.xres		= 640,		.yres		= 480,
-
-	.hsync_len	= 64,		.vsync_len	= 3,
-	.left_margin	= 122,		.upper_margin	= 45,
-	.right_margin	= 10,		.lower_margin	= 10,
-
-	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
-	.lccr3		= LCCR3_OutEnH | LCCR3_PixFlEdg
-};
-#endif
-
-#ifdef CONFIG_SA1100_SHANNON
-static struct sa1100fb_mach_info shannon_info __devinitdata = {
-	.pixclock	= 152500,	.bpp		= 8,
-	.xres		= 640,		.yres		= 480,
-
-	.hsync_len	= 4,		.vsync_len	= 3,
-	.left_margin	= 2,		.upper_margin	= 0,
-	.right_margin	= 1,		.lower_margin	= 0,
-
-	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-
-	.lccr0		= LCCR0_Color | LCCR0_Dual | LCCR0_Pas,
-	.lccr3		= LCCR3_ACBsDiv(512),
-};
-#endif
-
-
-
-static struct sa1100fb_mach_info * __devinit
-sa1100fb_get_machine_info(struct sa1100fb_info *fbi)
-{
-	struct sa1100fb_mach_info *inf = NULL;
-
-	/*
-	 *            R        G       B       T
-	 * default  {11,5}, { 5,6}, { 0,5}, { 0,0}
-	 * h3600    {12,4}, { 7,4}, { 1,4}, { 0,0}
-	 * freebird { 8,4}, { 4,4}, { 0,4}, {12,4}
-	 */
-#ifdef CONFIG_SA1100_ASSABET
-	if (machine_is_assabet()) {
-#ifndef ASSABET_PAL_VIDEO
-		inf = &lq039q2ds54_info;
-#else
-		inf = &pal_info;
-#endif
-	}
-#endif
-#ifdef CONFIG_SA1100_H3100
-	if (machine_is_h3100()) {
-		inf = &h3100_info;
-	}
-#endif
-#ifdef CONFIG_SA1100_H3600
-	if (machine_is_h3600()) {
-		inf = &h3600_info;
-	}
-#endif
-#ifdef CONFIG_SA1100_COLLIE
-	if (machine_is_collie()) {
-		inf = &collie_info;
-	}
-#endif
-#ifdef CONFIG_SA1100_LART
-	if (machine_is_lart()) {
-#ifdef LART_GREY_LCD
-		inf = &lart_grey_info;
-#endif
-#ifdef LART_COLOR_LCD
-		inf = &lart_color_info;
-#endif
-#ifdef LART_VIDEO_OUT
-		inf = &lart_video_info;
-#endif
-#ifdef LART_KIT01_LCD
-		inf = &lart_kit01_info;
-#endif
-	}
-#endif
-#ifdef CONFIG_SA1100_SHANNON
-	if (machine_is_shannon()) {
-		inf = &shannon_info;
-	}
-#endif
-	return inf;
-}
 
 static int sa1100fb_activate_var(struct fb_var_screeninfo *var, struct sa1100fb_info *);
 static void set_ctrlr_state(struct sa1100fb_info *fbi, u_int state);
@@ -1353,7 +1125,7 @@ static struct fb_monspecs monspecs __devinitdata = {
 
 static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
 {
-	struct sa1100fb_mach_info *inf;
+	struct sa1100fb_mach_info *inf = dev->platform_data;
 	struct sa1100fb_info *fbi;
 	unsigned i;
 
@@ -1390,10 +1162,6 @@ static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
 	fbi->rgb[RGB_8]		= &rgb_8;
 	fbi->rgb[RGB_16]	= &def_rgb_16;
 
-	inf = dev->platform_data;
-	if (!inf)
-		inf = sa1100fb_get_machine_info(fbi);
-
 	/*
 	 * People just don't seem to get this.  We don't support
 	 * anything but correct entries now, so panic if someone
@@ -1447,6 +1215,11 @@ static int __devinit sa1100fb_probe(struct platform_device *pdev)
 	struct sa1100fb_info *fbi;
 	int ret, irq;
 
+	if (!pdev->dev.platform_data) {
+		dev_err(&pdev->dev, "no platform LCD data\n");
+		return -EINVAL;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return -EINVAL;
-- 
1.7.4.4

