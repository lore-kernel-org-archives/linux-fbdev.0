From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Tue, 01 Nov 2011 19:03:35 +0000
Subject: [PATCH 09/18] MIPS: Alchemy: move au1200fb global functions to platform data
Message-Id: <1320174224-27305-10-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, linux-fbdev@vger.kernel.org

au1200fb calls 3 functions which have to be defined in board code.
Fix this ugliness with the introduction of platform_data.

Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
I'd like this to go in via the MIPS tree since patches depend on it.

 arch/mips/alchemy/devboards/db1200.c         |   51 +++---
 arch/mips/alchemy/devboards/db1300.c         |   52 +++---
 arch/mips/alchemy/devboards/pb1200.c         |   55 ++++---
 arch/mips/include/asm/mach-au1x00/au1200fb.h |   14 ++
 drivers/video/au1200fb.c                     |  241 ++++++++++++--------------
 5 files changed, 213 insertions(+), 200 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-au1x00/au1200fb.h

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 43f5f1b..e2cc5f9 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -37,6 +37,7 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1200fb.h>
 #include <asm/mach-au1x00/au1550_spi.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include <asm/mach-db1x00/db1200.h>
@@ -422,6 +423,33 @@ static struct platform_device db1200_mmc0_dev = {
 
 /**********************************************************************/
 
+static int db1200fb_panel_index(void)
+{
+	return (bcsr_read(BCSR_SWITCHES) >> 8) & 0x0f;
+}
+
+static int db1200fb_panel_init(void)
+{
+	/* Apply power */
+	bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+				BCSR_BOARD_LCDBL);
+	return 0;
+}
+
+static int db1200fb_panel_shutdown(void)
+{
+	/* Remove power */
+	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+			     BCSR_BOARD_LCDBL, 0);
+	return 0;
+}
+
+static struct au1200fb_platdata db1200fb_pd = {
+	.panel_index	= db1200fb_panel_index,
+	.panel_init	= db1200fb_panel_init,
+	.panel_shutdown	= db1200fb_panel_shutdown,
+};
+
 static struct resource au1200_lcd_res[] = {
 	[0] = {
 		.start	= AU1200_LCD_PHYS_ADDR,
@@ -443,6 +471,7 @@ static struct platform_device au1200_lcd_dev = {
 	.dev = {
 		.dma_mask		= &au1200_lcd_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1200fb_pd,
 	},
 	.num_resources	= ARRAY_SIZE(au1200_lcd_res),
 	.resource	= au1200_lcd_res,
@@ -681,25 +710,3 @@ static int __init db1200_dev_init(void)
 	return platform_add_devices(db1200_devs, ARRAY_SIZE(db1200_devs));
 }
 device_initcall(db1200_dev_init);
-
-/* au1200fb calls these: STERBT EINEN TRAGISCHEN TOD!!! */
-int board_au1200fb_panel(void)
-{
-	return (bcsr_read(BCSR_SWITCHES) >> 8) & 0x0f;
-}
-
-int board_au1200fb_panel_init(void)
-{
-	/* Apply power */
-	bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-				BCSR_BOARD_LCDBL);
-	return 0;
-}
-
-int board_au1200fb_panel_shutdown(void)
-{
-	/* Remove power */
-	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-			     BCSR_BOARD_LCDBL, 0);
-	return 0;
-}
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index bf0d1c4..d1a7344 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -22,6 +22,7 @@
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-au1x00/au1200fb.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 #include <asm/mach-db1x00/db1300.h>
@@ -635,6 +636,33 @@ static struct platform_device db1300_sndi2s_dev = {
 
 /**********************************************************************/
 
+static int db1300fb_panel_index(void)
+{
+	return 9;	/* DB1300_800x480 */
+}
+
+static int db1300fb_panel_init(void)
+{
+	/* Apply power (Vee/Vdd logic is inverted on Panel DB1300_800x480) */
+	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD,
+			     BCSR_BOARD_LCDBL);
+	return 0;
+}
+
+static int db1300fb_panel_shutdown(void)
+{
+	/* Remove power (Vee/Vdd logic is inverted on Panel DB1300_800x480) */
+	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDBL,
+			     BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD);
+	return 0;
+}
+
+static struct au1200fb_platdata db1300fb_pd = {
+	.panel_index	= db1300fb_panel_index,
+	.panel_init	= db1300fb_panel_init,
+	.panel_shutdown	= db1300fb_panel_shutdown,
+};
+
 static struct resource au1300_lcd_res[] = {
 	[0] = {
 		.start	= AU1200_LCD_PHYS_ADDR,
@@ -656,6 +684,7 @@ static struct platform_device db1300_lcd_dev = {
 	.dev = {
 		.dma_mask		= &au1300_lcd_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1300fb_pd,
 	},
 	.num_resources	= ARRAY_SIZE(au1300_lcd_res),
 	.resource	= au1300_lcd_res,
@@ -761,26 +790,3 @@ void __init board_setup(void)
 	alchemy_uart_enable(AU1300_UART1_PHYS_ADDR);
 	alchemy_uart_enable(AU1300_UART3_PHYS_ADDR);
 }
-
-
-/* au1200fb calls these: STERBT EINEN TRAGISCHEN TOD!!! */
-int board_au1200fb_panel(void)
-{
-	return 9;	/* DB1300_800x480 */
-}
-
-int board_au1200fb_panel_init(void)
-{
-	/* Apply power (Vee/Vdd logic is inverted on Panel DB1300_800x480) */
-	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD,
-			     BCSR_BOARD_LCDBL);
-	return 0;
-}
-
-int board_au1200fb_panel_shutdown(void)
-{
-	/* Remove power (Vee/Vdd logic is inverted on Panel DB1300_800x480) */
-	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDBL,
-			     BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD);
-	return 0;
-}
diff --git a/arch/mips/alchemy/devboards/pb1200.c b/arch/mips/alchemy/devboards/pb1200.c
index a1b6497..a2676c9 100644
--- a/arch/mips/alchemy/devboards/pb1200.c
+++ b/arch/mips/alchemy/devboards/pb1200.c
@@ -26,6 +26,7 @@
 #include <linux/smc91x.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-au1x00/au1200fb.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-db1x00/bcsr.h>
 #include <asm/mach-pb1x00/pb1200.h>
@@ -351,6 +352,33 @@ static struct platform_device pb1200_i2c_dev = {
 	.resource	= au1200_psc0_res,
 };
 
+static int pb1200fb_panel_index(void)
+{
+	return (bcsr_read(BCSR_SWITCHES) >> 8) & 0x0f;
+}
+
+static int pb1200fb_panel_init(void)
+{
+	/* Apply power */
+	bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+				BCSR_BOARD_LCDBL);
+	return 0;
+}
+
+static int pb1200fb_panel_shutdown(void)
+{
+	/* Remove power */
+	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+			     BCSR_BOARD_LCDBL, 0);
+	return 0;
+}
+
+static struct au1200fb_platdata pb1200fb_pd = {
+	.panel_index	= pb1200fb_panel_index,
+	.panel_init	= pb1200fb_panel_init,
+	.panel_shutdown	= pb1200fb_panel_shutdown,
+};
+
 static struct resource au1200_lcd_res[] = {
 	[0] = {
 		.start	= AU1200_LCD_PHYS_ADDR,
@@ -366,12 +394,13 @@ static struct resource au1200_lcd_res[] = {
 
 static u64 au1200_lcd_dmamask = DMA_BIT_MASK(32);
 
-static struct platform_device au1200_lcd_dev = {
+static struct platform_device pb1200_lcd_dev = {
 	.name		= "au1200-lcd",
 	.id		= 0,
 	.dev = {
 		.dma_mask		= &au1200_lcd_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &pb1200fb_pd,
 	},
 	.num_resources	= ARRAY_SIZE(au1200_lcd_res),
 	.resource	= au1200_lcd_res,
@@ -383,7 +412,7 @@ static struct platform_device *board_platform_devices[] __initdata = {
 	&pb1200_i2c_dev,
 	&pb1200_mmc0_dev,
 	&pb1200_mmc1_dev,
-	&au1200_lcd_dev,
+	&pb1200_lcd_dev,
 };
 
 static int __init board_register_devices(void)
@@ -440,25 +469,3 @@ static int __init board_register_devices(void)
 				    ARRAY_SIZE(board_platform_devices));
 }
 device_initcall(board_register_devices);
-
-
-int board_au1200fb_panel(void)
-{
-	return (bcsr_read(BCSR_SWITCHES) >> 8) & 0x0f;
-}
-
-int board_au1200fb_panel_init(void)
-{
-	/* Apply power */
-	bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-				BCSR_BOARD_LCDBL);
-	return 0;
-}
-
-int board_au1200fb_panel_shutdown(void)
-{
-	/* Remove power */
-	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-			     BCSR_BOARD_LCDBL, 0);
-	return 0;
-}
diff --git a/arch/mips/include/asm/mach-au1x00/au1200fb.h b/arch/mips/include/asm/mach-au1x00/au1200fb.h
new file mode 100644
index 0000000..b3c87cc
--- /dev/null
+++ b/arch/mips/include/asm/mach-au1x00/au1200fb.h
@@ -0,0 +1,14 @@
+/*
+ * platform data for au1200fb driver.
+ */
+
+#ifndef _AU1200FB_PLAT_H_
+#define _AU1200FB_PLAT_H_
+
+struct au1200fb_platdata {
+	int (*panel_index)(void);
+	int (*panel_init)(void);
+	int (*panel_shutdown)(void);
+};
+
+#endif
diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 6c4342f..04e4479 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -44,6 +44,7 @@
 #include <linux/slab.h>
 
 #include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1200fb.h>	/* platform_data */
 #include "au1200fb.h"
 
 #define DRIVER_NAME "au1200fb"
@@ -143,6 +144,7 @@ struct au1200_lcd_iodata_t {
 /* Private, per-framebuffer management information (independent of the panel itself) */
 struct au1200fb_device {
 	struct fb_info *fb_info;		/* FB driver info record */
+	struct au1200fb_platdata *pd;
 
 	int					plane;
 	unsigned char* 		fb_mem;		/* FrameBuffer memory map */
@@ -201,9 +203,6 @@ struct window_settings {
 #define LCD_WINCTRL1_PO_16BPP LCD_WINCTRL1_PO_01
 #endif
 
-extern int board_au1200fb_panel_init (void);
-extern int board_au1200fb_panel_shutdown (void);
-
 /*
  * Default window configurations
  */
@@ -334,8 +333,6 @@ struct panel_settings
 	uint32 mode_toyclksrc;
 	uint32 mode_backlight;
 	uint32 mode_auxpll;
-	int (*device_init)(void);
-	int (*device_shutdown)(void);
 #define Xres min_xres
 #define Yres min_yres
 	u32	min_xres;		/* Minimum horizontal resolution */
@@ -385,8 +382,6 @@ static struct panel_settings known_lcd_panels[]  		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
 		.mode_auxpll		= 8, /* 96MHz AUXPLL */
-		.device_init		= NULL,
-		.device_shutdown	= NULL,
 		320, 320,
 		240, 240,
 	},
@@ -415,8 +410,6 @@ static struct panel_settings known_lcd_panels[]  		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
 		.mode_auxpll		= 8, /* 96MHz AUXPLL */
-		.device_init		= NULL,
-		.device_shutdown	= NULL,
 		640, 480,
 		640, 480,
 	},
@@ -445,8 +438,6 @@ static struct panel_settings known_lcd_panels[]  		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
 		.mode_auxpll		= 8, /* 96MHz AUXPLL */
-		.device_init		= NULL,
-		.device_shutdown	= NULL,
 		800, 800,
 		600, 600,
 	},
@@ -475,8 +466,6 @@ static struct panel_settings known_lcd_panels[]  		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
 		.mode_auxpll		= 6, /* 72MHz AUXPLL */
-		.device_init		= NULL,
-		.device_shutdown	= NULL,
 		1024, 1024,
 		768, 768,
 	},
@@ -505,8 +494,6 @@ static struct panel_settings known_lcd_panels[]  		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
 		.mode_auxpll		= 10, /* 120MHz AUXPLL */
-		.device_init		= NULL,
-		.device_shutdown	= NULL,
 		1280, 1280,
 		1024, 1024,
 	},
@@ -535,8 +522,6 @@ static struct panel_settings known_lcd_panels[]  		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
 		.mode_auxpll		= 8, /* 96MHz AUXPLL */
-		.device_init		= board_au1200fb_panel_init,
-		.device_shutdown	= board_au1200fb_panel_shutdown,
 		1024, 1024,
 		768, 768,
 	},
@@ -568,8 +553,6 @@ static struct panel_settings known_lcd_panels[]  		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
 		.mode_auxpll		= 8, /* 96MHz AUXPLL */
-		.device_init		= board_au1200fb_panel_init,
-		.device_shutdown	= board_au1200fb_panel_shutdown,
 		640, 480,
 		640, 480,
 	},
@@ -601,8 +584,6 @@ static struct panel_settings known_lcd_panels[]  		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
 		.mode_auxpll		= 8, /* 96MHz AUXPLL */
-		.device_init		= board_au1200fb_panel_init,
-		.device_shutdown	= board_au1200fb_panel_shutdown,
 		320, 320,
 		240, 240,
 	},
@@ -634,8 +615,6 @@ static struct panel_settings known_lcd_panels[]  		.mode_toyclksrc	= 0x00000004, /* AUXPLL directly */
 		.mode_backlight	= 0x00000000,
 		.mode_auxpll		= 8, /* 96MHz AUXPLL */
-		.device_init		= board_au1200fb_panel_init,
-		.device_shutdown	= board_au1200fb_panel_shutdown,
 		856, 856,
 		480, 480,
 	},
@@ -670,8 +649,6 @@ static struct panel_settings known_lcd_panels[]  		.mode_toyclksrc		= 0x00000004, /* AUXPLL directly */
 		.mode_backlight		= 0x00000000,
 		.mode_auxpll		= (48/12) * 2,
-		.device_init		= board_au1200fb_panel_init,
-		.device_shutdown	= board_au1200fb_panel_shutdown,
 		800, 800,
 		480, 480,
 	},
@@ -800,7 +777,8 @@ static int au1200_setlocation (struct au1200fb_device *fbdev, int plane,
 	return 0;
 }
 
-static void au1200_setpanel (struct panel_settings *newpanel)
+static void au1200_setpanel(struct panel_settings *newpanel,
+			    struct au1200fb_platdata *pd)
 {
 	/*
 	 * Perform global setup/init of LCD controller
@@ -834,8 +812,8 @@ static void au1200_setpanel (struct panel_settings *newpanel)
 		    the controller, the clock cannot be turned off before first
 			shutting down the controller.
 		 */
-		if (panel->device_shutdown != NULL)
-			panel->device_shutdown();
+		if (pd->panel_shutdown)
+			pd->panel_shutdown();
 	}
 
 	/* Newpanel = NULL indicates a shutdown operation only */
@@ -888,7 +866,8 @@ static void au1200_setpanel (struct panel_settings *newpanel)
 	au_sync();
 
 	/* Call init of panel */
-	if (panel->device_init != NULL) panel->device_init();
+	if (pd->panel_init)
+		pd->panel_init();
 
 	/* FIX!!!! not appropriate on panel change!!! Global setup/init */
 	lcd->intenable = 0;
@@ -1221,6 +1200,8 @@ static int au1200fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green,
  */
 static int au1200fb_fb_blank(int blank_mode, struct fb_info *fbi)
 {
+	struct au1200fb_device *fbdev = fbi->par;
+
 	/* Short-circuit screen blanking */
 	if (noblanking)
 		return 0;
@@ -1230,13 +1211,13 @@ static int au1200fb_fb_blank(int blank_mode, struct fb_info *fbi)
 	case FB_BLANK_UNBLANK:
 	case FB_BLANK_NORMAL:
 		/* printk("turn on panel\n"); */
-		au1200_setpanel(panel);
+		au1200_setpanel(panel, fbdev->pd);
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_POWERDOWN:
 		/* printk("turn off panel\n"); */
-		au1200_setpanel(NULL);
+		au1200_setpanel(NULL, fbdev->pd);
 		break;
 	default:
 		break;
@@ -1464,6 +1445,7 @@ static void get_window(unsigned int plane,
 static int au1200fb_ioctl(struct fb_info *info, unsigned int cmd,
                           unsigned long arg)
 {
+	struct au1200fb_device *fbdev = info->par;
 	int plane;
 	int val;
 
@@ -1508,7 +1490,7 @@ static int au1200fb_ioctl(struct fb_info *info, unsigned int cmd,
 				struct panel_settings *newpanel;
 				panel_index = iodata.global.panel_choice;
 				newpanel = &known_lcd_panels[panel_index];
-				au1200_setpanel(newpanel);
+				au1200_setpanel(newpanel, fbdev->pd);
 			}
 			break;
 
@@ -1624,22 +1606,102 @@ static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
 
 /*-------------------------------------------------------------------------*/
 
-/* AU1200 LCD controller device driver */
 
+static int au1200fb_setup(struct au1200fb_platdata *pd)
+{
+	char *options = NULL;
+	char *this_opt, *endptr;
+	int num_panels = ARRAY_SIZE(known_lcd_panels);
+	int panel_idx = -1;
+
+	fb_get_options(DRIVER_NAME, &options);
+
+	if (!options)
+		goto out;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		/* Panel option - can be panel name,
+		 * "bs" for board-switch, or number/index */
+		if (!strncmp(this_opt, "panel:", 6)) {
+			int i;
+			long int li;
+			char *endptr;
+			this_opt += 6;
+			/* First check for index, which allows
+			 * to short circuit this mess */
+			li = simple_strtol(this_opt, &endptr, 0);
+			if (*endptr = '\0')
+				panel_idx = (int)li;
+			else if (strcmp(this_opt, "bs") = 0)
+				panel_idx = pd->panel_index();
+			else {
+				for (i = 0; i < num_panels; i++) {
+					if (!strcmp(this_opt,
+						    known_lcd_panels[i].name)) {
+						panel_idx = i;
+						break;
+					}
+				}
+			}
+			if ((panel_idx < 0) || (panel_idx >= num_panels))
+				print_warn("Panel %s not supported!", this_opt);
+			else
+				panel_index = panel_idx;
+
+		} else if (strncmp(this_opt, "nohwcursor", 10) = 0)
+			nohwcursor = 1;
+		else if (strncmp(this_opt, "devices:", 8) = 0) {
+			this_opt += 8;
+			device_count = simple_strtol(this_opt, &endptr, 0);
+			if ((device_count < 0) ||
+			    (device_count > MAX_DEVICE_COUNT))
+				device_count = MAX_DEVICE_COUNT;
+		} else if (strncmp(this_opt, "wincfg:", 7) = 0) {
+			this_opt += 7;
+			window_index = simple_strtol(this_opt, &endptr, 0);
+			if ((window_index < 0) ||
+			    (window_index >= ARRAY_SIZE(windows)))
+				window_index = DEFAULT_WINDOW_INDEX;
+		} else if (strncmp(this_opt, "off", 3) = 0)
+			return 1;
+		else
+			print_warn("Unsupported option \"%s\"", this_opt);
+	}
+
+out:
+	return 0;
+}
+
+/* AU1200 LCD controller device driver */
 static int __devinit au1200fb_drv_probe(struct platform_device *dev)
 {
 	struct au1200fb_device *fbdev;
+	struct au1200fb_platdata *pd;
 	struct fb_info *fbi = NULL;
 	unsigned long page;
 	int bpp, plane, ret, irq;
 
+	print_info("" DRIVER_DESC "");
+
+	pd = dev->dev.platform_data;
+	if (!pd)
+		return -ENODEV;
+
+	/* Setup driver with options */
+	if (au1200fb_setup(pd))
+		return -ENODEV;
+
+	/* Point to the panel selected */
+	panel = &known_lcd_panels[panel_index];
+	win = &windows[window_index];
+
+	printk(DRIVER_NAME ": Panel %d %s\n", panel_index, panel->name);
+	printk(DRIVER_NAME ": Win %d %s\n", window_index, win->name);
+
 	/* shut gcc up */
 	ret = 0;
 	fbdev = NULL;
 
-	/* Kickstart the panel */
-	au1200_setpanel(panel);
-
 	for (plane = 0; plane < device_count; ++plane) {
 		bpp = winbpp(win->w[plane].mode_winctrl1);
 		if (win->w[plane].xres = 0)
@@ -1655,6 +1717,7 @@ static int __devinit au1200fb_drv_probe(struct platform_device *dev)
 		_au1200fb_infos[plane] = fbi;
 		fbdev = fbi->par;
 		fbdev->fb_info = fbi;
+		fbdev->pd = pd;
 
 		fbdev->plane = plane;
 
@@ -1716,6 +1779,11 @@ static int __devinit au1200fb_drv_probe(struct platform_device *dev)
 		goto failed;
 	}
 
+	platform_set_drvdata(dev, pd);
+
+	/* Kickstart the panel */
+	au1200_setpanel(panel, pd);
+
 	return 0;
 
 failed:
@@ -1735,12 +1803,13 @@ failed:
 
 static int __devexit au1200fb_drv_remove(struct platform_device *dev)
 {
+	struct au1200fb_platdata *pd = platform_get_drvdata(dev);
 	struct au1200fb_device *fbdev;
 	struct fb_info *fbi;
 	int plane;
 
 	/* Turn off the panel */
-	au1200_setpanel(NULL);
+	au1200_setpanel(NULL, pd);
 
 	for (plane = 0; plane < device_count; ++plane)	{
 		fbi = _au1200fb_infos[plane];
@@ -1768,7 +1837,8 @@ static int __devexit au1200fb_drv_remove(struct platform_device *dev)
 #ifdef CONFIG_PM
 static int au1200fb_drv_suspend(struct device *dev)
 {
-	au1200_setpanel(NULL);
+	struct au1200fb_platdata *pd = dev_get_drvdata(dev);
+	au1200_setpanel(NULL, pd);
 
 	lcd->outmask = 0;
 	au_sync();
@@ -1778,11 +1848,12 @@ static int au1200fb_drv_suspend(struct device *dev)
 
 static int au1200fb_drv_resume(struct device *dev)
 {
+	struct au1200fb_platdata *pd = dev_get_drvdata(dev);
 	struct fb_info *fbi;
 	int i;
 
 	/* Kickstart the panel */
-	au1200_setpanel(panel);
+	au1200_setpanel(panel, pd);
 
 	for (i = 0; i < device_count; i++) {
 		fbi = _au1200fb_infos[i];
@@ -1817,100 +1888,8 @@ static struct platform_driver au1200fb_driver = {
 
 /*-------------------------------------------------------------------------*/
 
-/* Kernel driver */
-
-static int au1200fb_setup(void)
-{
-	char *options = NULL;
-	char *this_opt, *endptr;
-	int num_panels = ARRAY_SIZE(known_lcd_panels);
-	int panel_idx = -1;
-
-	fb_get_options(DRIVER_NAME, &options);
-
-	if (options) {
-		while ((this_opt = strsep(&options,",")) != NULL) {
-			/* Panel option - can be panel name,
-			 * "bs" for board-switch, or number/index */
-			if (!strncmp(this_opt, "panel:", 6)) {
-				int i;
-				long int li;
-				char *endptr;
-				this_opt += 6;
-				/* First check for index, which allows
-				 * to short circuit this mess */
-				li = simple_strtol(this_opt, &endptr, 0);
-				if (*endptr = '\0') {
-					panel_idx = (int)li;
-				}
-				else if (strcmp(this_opt, "bs") = 0) {
-					extern int board_au1200fb_panel(void);
-					panel_idx = board_au1200fb_panel();
-				}
-
-				else
-				for (i = 0; i < num_panels; i++) {
-					if (!strcmp(this_opt, known_lcd_panels[i].name)) {
-						panel_idx = i;
-						break;
-					}
-				}
-
-				if ((panel_idx < 0) || (panel_idx >= num_panels)) {
-						print_warn("Panel %s not supported!", this_opt);
-				}
-				else
-					panel_index = panel_idx;
-			}
-
-			else if (strncmp(this_opt, "nohwcursor", 10) = 0) {
-				nohwcursor = 1;
-			}
-
-			else if (strncmp(this_opt, "devices:", 8) = 0) {
-				this_opt += 8;
-				device_count = simple_strtol(this_opt,
-							     &endptr, 0);
-				if ((device_count < 0) ||
-				    (device_count > MAX_DEVICE_COUNT))
-					device_count = MAX_DEVICE_COUNT;
-			}
-
-			else if (strncmp(this_opt, "wincfg:", 7) = 0) {
-				this_opt += 7;
-				window_index = simple_strtol(this_opt,
-							     &endptr, 0);
-				if ((window_index < 0) ||
-				    (window_index >= ARRAY_SIZE(windows)))
-					window_index = DEFAULT_WINDOW_INDEX;
-			}
-
-			else if (strncmp(this_opt, "off", 3) = 0)
-				return 1;
-			/* Unsupported option */
-			else {
-				print_warn("Unsupported option \"%s\"", this_opt);
-			}
-		}
-	}
-	return 0;
-}
-
 static int __init au1200fb_init(void)
 {
-	print_info("" DRIVER_DESC "");
-
-	/* Setup driver with options */
-	if (au1200fb_setup())
-		return -ENODEV;
-
-	/* Point to the panel selected */
-	panel = &known_lcd_panels[panel_index];
-	win = &windows[window_index];
-
-	printk(DRIVER_NAME ": Panel %d %s\n", panel_index, panel->name);
-	printk(DRIVER_NAME ": Win %d %s\n", window_index, win->name);
-
 	return platform_driver_register(&au1200fb_driver);
 }
 
-- 
1.7.7.1

