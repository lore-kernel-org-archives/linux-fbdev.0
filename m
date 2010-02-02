From: Qiang Wang <rurality.linux@gmail.com>
Date: Tue, 02 Feb 2010 05:14:09 +0000
Subject: Re: [Linux-arm-nuc900] RE: [PATCH]NUC900 LCD Controller Driver
Message-Id: <71413c851002012114r598fd526yd6dff0fb9927ac2@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="00235429d8fcf872db047e972b47"
List-Id: <linux-fbdev.vger.kernel.org>
References: <ae11f36b1001110005k410620datb5444ffa795b27f3@mail.gmail.com>
	<20100129162755.b591a2fb.akpm@linux-foundation.org>
	<BD79186B4FD85F4B8E60E381CAEE1909020E976F@mi8nycmail19.Mi8.com>
	<71413c851002010535w391ca149p210aa448ed10c19c@mail.gmail.com>
In-Reply-To: <71413c851002010535w391ca149p210aa448ed10c19c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--00235429d8fcf872db047e972b47
Content-Type: text/plain; charset=UTF-8

hello, Mr. Andrew Morton

I modified the nuc900 LCD Controller base on your comments.

Hope it will be fine:)

Best regards,
Wang Qiang


Signed-off-by: Wang Qiang <rurality.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Wang Zongshun <mcuos.com@gmail.com>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
---
 arch/arm/configs/nuc950_defconfig             |   53 ++-
 arch/arm/mach-w90x900/cpu.h                   |    1 +
 arch/arm/mach-w90x900/dev.c                   |   42 ++
 arch/arm/mach-w90x900/include/mach/fb.h       |   83 +++
 arch/arm/mach-w90x900/include/mach/regs-ldm.h |  253 ++++++++
 arch/arm/mach-w90x900/mach-nuc950evb.c        |   47 ++
 arch/arm/mach-w90x900/nuc950.c                |    4 +
 drivers/video/Kconfig                         |   21 +
 drivers/video/Makefile                        |    1 +
 drivers/video/nuc900fb.c                      |  779 +++++++++++++++++++++++++
 drivers/video/nuc900fb.h                      |   55 ++
 11 files changed, 1338 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-w90x900/include/mach/fb.h
 create mode 100644 arch/arm/mach-w90x900/include/mach/regs-ldm.h
 create mode 100644 drivers/video/nuc900fb.c
 create mode 100644 drivers/video/nuc900fb.h

diff --git a/arch/arm/configs/nuc950_defconfig
b/arch/arm/configs/nuc950_defconfig
index 97300ec..51cc2a2 100644
--- a/arch/arm/configs/nuc950_defconfig
+++ b/arch/arm/configs/nuc950_defconfig
@@ -590,8 +590,40 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_S1D13XXX is not set
+CONFIG_FB_NUC900=y
+CONFIG_GPM1040A0_320X240=y
+CONFIG_FB_NUC900_DEBUG=y
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+

 #
 # Display device support
@@ -603,6 +635,25 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+CONFIG_FONTS=y
+# CONFIG_FONT_8x8 is not set
+CONFIG_FONT_8x16=y
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_7x14 is not set
+# CONFIG_FONT_PEARL_8x8 is not set
+# CONFIG_FONT_ACORN_8x8 is not set
+# CONFIG_FONT_MINI_4x6 is not set
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+# CONFIG_FONT_10x18 is not set
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_LOGO_LINUX_CLUT224=y
+
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
 CONFIG_USB_SUPPORT=y
diff --git a/arch/arm/mach-w90x900/cpu.h b/arch/arm/mach-w90x900/cpu.h
index 4d58ba1..f8730b6 100644
--- a/arch/arm/mach-w90x900/cpu.h
+++ b/arch/arm/mach-w90x900/cpu.h
@@ -57,3 +57,4 @@ extern struct platform_device nuc900_device_fmi;
 extern struct platform_device nuc900_device_kpi;
 extern struct platform_device nuc900_device_rtc;
 extern struct platform_device nuc900_device_ts;
+extern struct platform_device nuc900_device_lcd;
diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
index ec711f4..4887612 100644
--- a/arch/arm/mach-w90x900/dev.c
+++ b/arch/arm/mach-w90x900/dev.c
@@ -34,6 +34,7 @@
 #include <mach/regs-serial.h>
 #include <mach/nuc900_spi.h>
 #include <mach/map.h>
+#include <mach/fb.h>

 #include "cpu.h"

@@ -380,6 +381,47 @@ struct platform_device nuc900_device_kpi = {
 	.resource	= nuc900_kpi_resource,
 };

+#ifdef CONFIG_FB_NUC900
+
+static struct resource nuc900_lcd_resource[] = {
+	[0] = {
+		.start = W90X900_PA_LCD,
+		.end   = W90X900_PA_LCD + W90X900_SZ_LCD - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_LCD,
+		.end   = IRQ_LCD,
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+static u64 nuc900_device_lcd_dmamask = -1;
+struct platform_device nuc900_device_lcd = {
+	.name             = "nuc900-lcd",
+	.id               = -1,
+	.num_resources    = ARRAY_SIZE(nuc900_lcd_resource),
+	.resource         = nuc900_lcd_resource,
+	.dev              = {
+		.dma_mask               = &nuc900_device_lcd_dmamask,
+		.coherent_dma_mask      = -1,
+	}
+};
+
+void  nuc900_fb_set_platdata(struct nuc900fb_mach_info *pd)
+{
+	struct nuc900fb_mach_info *npd;
+
+	npd = kmalloc(sizeof(*npd), GFP_KERNEL);
+	if (npd) {
+		memcpy(npd, pd, sizeof(*npd));
+		nuc900_device_lcd.dev.platform_data = npd;
+	} else {
+		printk(KERN_ERR "no memory for LCD platform data\n");
+	}
+}
+#endif
+
 /*Here should be your evb resourse,such as LCD*/

 static struct platform_device *nuc900_public_dev[] __initdata = {
diff --git a/arch/arm/mach-w90x900/include/mach/fb.h
b/arch/arm/mach-w90x900/include/mach/fb.h
new file mode 100644
index 0000000..cec5ece
--- /dev/null
+++ b/arch/arm/mach-w90x900/include/mach/fb.h
@@ -0,0 +1,83 @@
+/* linux/include/asm/arch-nuc900/fb.h
+ *
+ * Copyright (c) 2008 Nuvoton technology corporation
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Changelog:
+ *
+ *   2008/08/26     vincen.zswan modify this file for LCD.
+ */
+
+#ifndef __ASM_ARM_FB_H
+#define __ASM_ARM_FB_H
+
+
+
+/* LCD Controller Hardware Desc */
+struct nuc900fb_hw {
+	unsigned int lcd_dccs;
+	unsigned int lcd_device_ctrl;
+	unsigned int lcd_mpulcd_cmd;
+	unsigned int lcd_int_cs;
+	unsigned int lcd_crtc_size;
+	unsigned int lcd_crtc_dend;
+	unsigned int lcd_crtc_hr;
+	unsigned int lcd_crtc_hsync;
+	unsigned int lcd_crtc_vr;
+	unsigned int lcd_va_baddr0;
+	unsigned int lcd_va_baddr1;
+	unsigned int lcd_va_fbctrl;
+	unsigned int lcd_va_scale;
+	unsigned int lcd_va_test;
+	unsigned int lcd_va_win;
+	unsigned int lcd_va_stuff;
+};
+
+/* LCD Display Description */
+struct nuc900fb_display {
+	/* LCD Image type */
+	unsigned type;
+
+	/* LCD Screen Size */
+	unsigned short width;
+	unsigned short height;
+
+	/* LCD Screen Info */
+	unsigned short xres;
+	unsigned short yres;
+	unsigned short bpp;
+
+	unsigned long pixclock;
+	unsigned short left_margin;
+	unsigned short right_margin;
+	unsigned short hsync_len;
+	unsigned short upper_margin;
+	unsigned short lower_margin;
+	unsigned short vsync_len;
+
+	/* hardware special register value */
+	unsigned int dccs;
+	unsigned int devctl;
+	unsigned int fbctrl;
+	unsigned int scale;
+};
+
+struct nuc900fb_mach_info {
+	struct nuc900fb_display *displays;
+	unsigned num_displays;
+	unsigned default_display;
+	/* GPIO Setting  Info */
+	unsigned gpio_dir;
+	unsigned gpio_dir_mask;
+	unsigned gpio_data;
+	unsigned gpio_data_mask;
+};
+
+extern void __init nuc900_fb_set_platdata(struct nuc900fb_mach_info *);
+
+#endif /* __ASM_ARM_FB_H */
diff --git a/arch/arm/mach-w90x900/include/mach/regs-ldm.h
b/arch/arm/mach-w90x900/include/mach/regs-ldm.h
new file mode 100644
index 0000000..e9d480a
--- /dev/null
+++ b/arch/arm/mach-w90x900/include/mach/regs-ldm.h
@@ -0,0 +1,253 @@
+/*
+ * arch/arm/mach-w90x900/include/mach/regs-serial.h
+ *
+ * Copyright (c) 2009 Nuvoton technology corporation
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ *  Description:
+ *     Nuvoton Display, LCM Register list
+ *  Author:  Wang Qiang (rurality.linux@gmail.com) 2009/12/11
+ *
+ */
+
+
+#ifndef __ASM_ARM_W90X900_REGS_LDM_H
+#define __ASM_ARM_W90X900_REGS_LDM_H
+
+#include <mach/map.h>
+
+/* Display Controller Control/Status Register */
+#define REG_LCM_DCCS			(0x00)
+
+#define LCM_DCCS_ENG_RST		(1 << 0)
+#define LCM_DCCS_VA_EN			(1 << 1)
+#define LCM_DCCS_OSD_EN			(1 << 2)
+#define LCM_DCCS_DISP_OUT_EN		(1 << 3)
+#define LCM_DCCS_DISP_INT_EN		(1 << 4)
+#define LCM_DCCS_CMD_ON			(1 << 5)
+#define LCM_DCCS_FIELD_INTR		(1 << 6)
+#define LCM_DCCS_SINGLE			(1 << 7)
+
+enum LCM_DCCS_VA_SRC {
+	LCM_DCCS_VA_SRC_YUV422		= (0 << 8),
+	LCM_DCCS_VA_SRC_YCBCR422	= (1 << 8),
+	LCM_DCCS_VA_SRC_RGB888		= (2 << 8),
+	LCM_DCCS_VA_SRC_RGB666		= (3 << 8),
+	LCM_DCCS_VA_SRC_RGB565		= (4 << 8),
+	LCM_DCCS_VA_SRC_RGB444LOW	= (5 << 8),
+	LCM_DCCS_VA_SRC_RGB444HIGH 	= (7 << 8)
+};
+
+
+/* Display Device Control Register */
+#define REG_LCM_DEV_CTRL		(0x04)
+
+enum LCM_DEV_CTRL_SWAP_YCbCr {
+	LCM_DEV_CTRL_SWAP_UYVY		= (0 << 1),
+	LCM_DEV_CTRL_SWAP_YUYV		= (1 << 1),
+	LCM_DEV_CTRL_SWAP_VYUY		= (2 << 1),
+	LCM_DEV_CTRL_SWAP_YVYU		= (3 << 1)
+};
+
+enum LCM_DEV_CTRL_RGB_SHIFT {
+	LCM_DEV_CTRL_RGB_SHIFT_NOT 	= (0 << 3),
+	LCM_DEV_CTRL_RGB_SHIFT_ONECYCLE = (1 << 3),
+	LCM_DEV_CTRL_RGB_SHIFT_TWOCYCLE = (2 << 3),
+	LCM_DEV_CTRL_RGB_SHIFT_NOT_DEF	= (3 << 3)
+};
+
+enum LCM_DEV_CTRL_DEVICE {
+	LCM_DEV_CTRL_DEVICE_YUV422	= (0 << 5),
+	LCM_DEV_CTRL_DEVICE_YUV444	= (1 << 5),
+	LCM_DEV_CTRL_DEVICE_UNIPAC	= (4 << 5),
+	LCM_DEV_CTRL_DEVICE_SEIKO_EPSON	= (5 << 5),
+	LCM_DEV_CTRL_DEVICE_HIGH_COLOR	= (6 << 5),
+	LCM_DEV_CTRL_DEVICE_MPU		= (7 << 5)
+};
+
+#define LCM_DEV_CTRL_LCD_DDA		(8)
+#define LCM_DEV_CTRL_YUV2CCIR		(16)
+
+enum LCM_DEV_CTRL_LCD_SEL {
+	LCM_DEV_CTRL_LCD_SEL_RGB_GBR	= (0 << 17),
+	LCM_DEV_CTRL_LCD_SEL_BGR_RBG	= (1 << 17),
+	LCM_DEV_CTRL_LCD_SEL_GBR_RGB	= (2 << 17),
+	LCM_DEV_CTRL_LCD_SEL_RBG_BGR	= (3 << 17)
+};
+
+enum LCM_DEV_CTRL_FAL_D {
+	LCM_DEV_CTRL_FAL_D_FALLING	= (0 << 19),
+	LCM_DEV_CTRL_FAL_D_RISING	= (1 << 19),
+};
+
+enum LCM_DEV_CTRL_H_POL {
+	LCM_DEV_CTRL_H_POL_LOW		= (0 << 20),
+	LCM_DEV_CTRL_H_POL_HIGH		= (1 << 20),
+};
+
+enum LCM_DEV_CTRL_V_POL {
+	LCM_DEV_CTRL_V_POL_LOW		= (0 << 21),
+	LCM_DEV_CTRL_V_POL_HIGH		= (1 << 21),
+};
+
+enum LCM_DEV_CTRL_VR_LACE {
+	LCM_DEV_CTRL_VR_LACE_NINTERLACE	= (0 << 22),
+	LCM_DEV_CTRL_VR_LACE_INTERLACE	= (1 << 22),
+};
+
+enum LCM_DEV_CTRL_LACE {
+	LCM_DEV_CTRL_LACE_NINTERLACE	= (0 << 23),
+	LCM_DEV_CTRL_LACE_INTERLACE	= (1 << 23),
+};
+
+enum LCM_DEV_CTRL_RGB_SCALE {
+	LCM_DEV_CTRL_RGB_SCALE_4096 	= (0 << 24),
+	LCM_DEV_CTRL_RGB_SCALE_65536 	= (1 << 24),
+	LCM_DEV_CTRL_RGB_SCALE_262144 	= (2 << 24),
+	LCM_DEV_CTRL_RGB_SCALE_16777216 = (3 << 24),
+};
+
+enum LCM_DEV_CTRL_DBWORD {
+	LCM_DEV_CTRL_DBWORD_HALFWORD	= (0 << 26),
+	LCM_DEV_CTRL_DBWORD_FULLWORD	= (1 << 26),
+};
+
+enum LCM_DEV_CTRL_MPU68 {
+	LCM_DEV_CTRL_MPU68_80_SERIES	= (0 << 27),
+	LCM_DEV_CTRL_MPU68_68_SERIES	= (1 << 27),
+};
+
+enum LCM_DEV_CTRL_DE_POL {
+	LCM_DEV_CTRL_DE_POL_HIGH	= (0 << 28),
+	LCM_DEV_CTRL_DE_POL_LOW		= (1 << 28),
+};
+
+#define LCM_DEV_CTRL_CMD16		(29)
+#define LCM_DEV_CTRL_CM16t18		(30)
+#define LCM_DEV_CTRL_CMD_LOW		(31)
+
+/* MPU-Interface LCD Write Command */
+#define REG_LCM_MPU_CMD			(0x08)
+
+/* Interrupt Control/Status Register */
+#define REG_LCM_INT_CS			(0x0c)
+#define LCM_INT_CS_DISP_F_EN		(1 << 0)
+#define LCM_INT_CS_UNDERRUN_EN   	(1 << 1)
+#define LCM_INT_CS_BUS_ERROR_INT 	(1 << 28)
+#define LCM_INT_CS_UNDERRUN_INT  	(1 << 29)
+#define LCM_INT_CS_DISP_F_STATUS 	(1 << 30)
+#define LCM_INT_CS_DISP_F_INT		(1 << 31)
+
+/* CRTC Display Size Control Register */
+#define REG_LCM_CRTC_SIZE		(0x10)
+#define LCM_CRTC_SIZE_VTTVAL(x)		((x) << 16)
+#define LCM_CRTC_SIZE_HTTVAL(x)		((x) << 0)
+
+/* CRTC Display Enable End */
+#define REG_LCM_CRTC_DEND		(0x14)
+#define LCM_CRTC_DEND_VDENDVAL(x)	((x) << 16)
+#define LCM_CRTC_DEND_HDENDVAL(x)	((x) << 0)
+
+/* CRTC Internal Horizontal Retrace Control Register */
+#define REG_LCM_CRTC_HR			(0x18)
+#define LCM_CRTC_HR_EVAL(x)		((x) << 16)
+#define LCM_CRTC_HR_SVAL(x)		((x) << 0)
+
+/* CRTC Horizontal Sync Control Register */
+#define REG_LCM_CRTC_HSYNC		(0x1C)
+#define LCM_CRTC_HSYNC_SHIFTVAL(x)	((x) << 30)
+#define LCM_CRTC_HSYNC_EVAL(x)		((x) << 16)
+#define LCM_CRTC_HSYNC_SVAL(x)		((x) << 0)
+
+/* CRTC Internal Vertical Retrace Control Register */
+#define REG_LCM_CRTC_VR			(0x20)
+#define LCM_CRTC_VR_EVAL(x)		((x) << 16)
+#define LCM_CRTC_VR_SVAL(x)		((x) << 0)
+
+/* Video Stream Frame Buffer-0 Starting Address */
+#define REG_LCM_VA_BADDR0		(0x24)
+
+/* Video Stream Frame Buffer-1 Starting Address */
+#define REG_LCM_VA_BADDR1		(0x28)
+
+/* Video Stream Frame Buffer Control Register */
+#define REG_LCM_VA_FBCTRL		(0x2C)
+#define LCM_VA_FBCTRL_IO_REGION_HALF	(1 << 28)
+#define LCM_VA_FBCTRL_FIELD_DUAL  	(1 << 29)
+#define LCM_VA_FBCTRL_START_BUF 	(1 << 30)
+#define LCM_VA_FBCTRL_DB_EN		(1 << 31)
+
+/* Video Stream Scaling Control Register */
+#define REG_LCM_VA_SCALE		(0x30)
+#define LCM_VA_SCALE_XCOPY_INTERPOLATION (0 << 15)
+#define LCM_VA_SCALE_XCOPY_DUPLICATION	 (1 << 15)
+
+/* Image Stream Active Window Coordinates */
+#define REG_LCM_VA_WIN			(0x38)
+
+/* Image Stream Stuff Pixel */
+#define REG_LCM_VA_STUFF		(0x3C)
+
+/* OSD Window Starting Coordinates */
+#define REG_LCM_OSD_WINS		(0x40)
+
+/* OSD Window Ending Coordinates */
+#define REG_LCM_OSD_WINE		(0x44)
+
+/* OSD Stream Frame Buffer Starting Address */
+#define REG_LCM_OSD_BADDR		(0x48)
+
+/* OSD Stream Frame Buffer Control Register */
+#define REG_LCM_OSD_FBCTRL		(0x4c)
+
+/* OSD Overlay Control Register */
+#define REG_LCM_OSD_OVERLAY		(0x50)
+
+/* OSD Overlay Color-Key Pattern Register */
+#define REG_LCM_OSD_CKEY		(0x54)
+
+/* OSD Overlay Color-Key Mask Register */
+#define REG_LCM_OSD_CMASK		(0x58)
+
+/* OSD Window Skip1 Register */
+#define REG_LCM_OSD_SKIP1		(0x5C)
+
+/* OSD Window Skip2 Register */
+#define REG_LCM_OSD_SKIP2		(0x60)
+
+/* OSD horizontal up scaling control register */
+#define REG_LCM_OSD_SCALE		(0x64)
+
+/* MPU Vsync control register */
+#define REG_LCM_MPU_VSYNC		(0x68)
+
+/* Hardware cursor control Register */
+#define REG_LCM_HC_CTRL			(0x6C)
+
+/* Hardware cursot tip point potison on va picture */
+#define REG_LCM_HC_POS			(0x70)
+
+/* Hardware Cursor Window Buffer Control Register */
+#define REG_LCM_HC_WBCTRL		(0x74)
+
+/* Hardware cursor memory base address register */
+#define REG_LCM_HC_BADDR		(0x78)
+
+/* Hardware cursor color ram register mapped to bpp = 0 */
+#define REG_LCM_HC_COLOR0		(0x7C)
+
+/* Hardware cursor color ram register mapped to bpp = 1 */
+#define REG_LCM_HC_COLOR1		(0x80)
+
+/* Hardware cursor color ram register mapped to bpp = 2 */
+#define REG_LCM_HC_COLOR2		(0x84)
+
+/* Hardware cursor color ram register mapped to bpp = 3 */
+#define REG_LCM_HC_COLOR3		(0x88)
+
+#endif /* __ASM_ARM_W90X900_REGS_LDM_H */
diff --git a/arch/arm/mach-w90x900/mach-nuc950evb.c
b/arch/arm/mach-w90x900/mach-nuc950evb.c
index cef903b..b3edc3c 100644
--- a/arch/arm/mach-w90x900/mach-nuc950evb.c
+++ b/arch/arm/mach-w90x900/mach-nuc950evb.c
@@ -10,6 +10,8 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation;version 2 of the License.
+ *   history:
+ *     Wang Qiang (rurality.linux@gmail.com) add LCD support
  *
  */

@@ -18,9 +20,51 @@
 #include <asm/mach/map.h>
 #include <asm/mach-types.h>
 #include <mach/map.h>
+#include <mach/regs-ldm.h>
+#include <mach/fb.h>

 #include "nuc950.h"

+#ifdef CONFIG_FB_NUC900
+/* LCD Controller */
+static struct nuc900fb_display __initdata nuc950_lcd_info[] = {
+	/* Giantplus Technology GPM1040A0 320x240 Color TFT LCD */
+	[0] = {
+		.type		= LCM_DCCS_VA_SRC_RGB565,
+		.width 		= 320,
+		.height		= 240,
+		.xres		= 320,
+		.yres		= 240,
+		.bpp		= 16,
+		.pixclock	= 200000,
+		.left_margin	= 34,
+		.right_margin   = 54,
+		.hsync_len	= 10,
+		.upper_margin	= 18,
+		.lower_margin	= 4,
+		.vsync_len	= 1,
+		.dccs		= 0x8e00041a,
+		.devctl		= 0x060800c0,
+		.fbctrl		= 0x00a000a0,
+		.scale		= 0x04000400,
+	},
+};
+
+static struct nuc900fb_mach_info nuc950_fb_info __initdata = {
+#if defined(CONFIG_GPM1040A0_320X240)
+	.displays		= &nuc950_lcd_info[0],
+#else
+	.displays		= nuc950_lcd_info,
+#endif
+	.num_displays 		= ARRAY_SIZE(nuc950_lcd_info),
+	.default_display	= 0,
+	.gpio_dir		= 0x00000004,
+	.gpio_dir_mask		= 0xFFFFFFFD,
+	.gpio_data		= 0x00000004,
+	.gpio_data_mask		= 0xFFFFFFFD,
+};
+#endif
+
 static void __init nuc950evb_map_io(void)
 {
 	nuc950_map_io();
@@ -30,6 +74,9 @@ static void __init nuc950evb_map_io(void)
 static void __init nuc950evb_init(void)
 {
 	nuc950_board_init();
+#ifdef CONFIG_FB_NUC900
+	nuc900_fb_set_platdata(&nuc950_fb_info);
+#endif
 }

 MACHINE_START(W90P950EVB, "W90P950EVB")
diff --git a/arch/arm/mach-w90x900/nuc950.c b/arch/arm/mach-w90x900/nuc950.c
index 1495081..4d1f1ab 100644
--- a/arch/arm/mach-w90x900/nuc950.c
+++ b/arch/arm/mach-w90x900/nuc950.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
+
 #include "cpu.h"

 /* define specific CPU platform device */
@@ -25,6 +26,9 @@
 static struct platform_device *nuc950_dev[] __initdata = {
 	&nuc900_device_kpi,
 	&nuc900_device_fmi,
+#ifdef CONFIG_FB_NUC900
+	&nuc900_device_lcd,
+#endif
 };

 /* define specific CPU platform io map */
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5a5c303..a943e5e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1945,6 +1945,27 @@ config FB_S3C2410_DEBUG
 	  Turn on debugging messages. Note that you can set/unset at run time
 	  through sysfs

+config FB_NUC900
+        bool "NUC900 LCD framebuffer support"
+        depends on FB && ARCH_W90X900
+        select FB_CFB_FILLRECT
+        select FB_CFB_COPYAREA
+        select FB_CFB_IMAGEBLIT
+        ---help---
+          Frame buffer driver for the built-in LCD controller in the Nuvoton
+          NUC900 processor
+
+config GPM1040A0_320X240
+        bool "Giantplus Technology GPM1040A0 320x240 Color TFT LCD"
+        depends on FB_NUC900
+
+config FB_NUC900_DEBUG
+        bool "NUC900 lcd debug messages"
+        depends on FB_NUC900
+        help
+          Turn on debugging messages. Note that you can set/unset at run time
+          through sysfs
+
 config FB_SM501
 	tristate "Silicon Motion SM501 framebuffer support"
 	depends on FB && MFD_SM501
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 4ecb30c..a42ad55 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -129,6 +129,7 @@ obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_CARMINE)          += carminefb.o
 obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
 obj-$(CONFIG_FB_MSM)              += msm/
+obj-$(CONFIG_FB_NUC900)           += nuc900fb.o

 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
new file mode 100644
index 0000000..6bf0d46
--- /dev/null
+++ b/drivers/video/nuc900fb.c
@@ -0,0 +1,779 @@
+/*
+ *
+ * Copyright (c) 2009 Nuvoton technology corporation
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ *  Description:
+ *    Nuvoton LCD Controller Driver
+ *  Author:
+ *    Wang Qiang (rurality.linux@gmail.com) 2009/12/11
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/wait.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/io.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+#include <mach/regs-ldm.h>
+#include <mach/fb.h>
+#include <mach/clkdev.h>
+
+#include "nuc900fb.h"
+
+
+/*
+ *  Initialize the nuc900 video (dual) buffer address
+ */
+static void nuc900fb_set_lcdaddr(struct fb_info *info)
+{
+	struct nuc900fb_info *fbi = info->par;
+	void __iomem *regs = fbi->io;
+	unsigned long vbaddr1, vbaddr2;
+
+	vbaddr1  = info->fix.smem_start;
+	vbaddr2  = info->fix.smem_start;
+	vbaddr2 += info->fix.line_length * info->var.yres;
+
+	/* set frambuffer start phy addr*/
+	writel(vbaddr1, regs + REG_LCM_VA_BADDR0);
+	writel(vbaddr2, regs + REG_LCM_VA_BADDR1);
+
+	writel(fbi->regs.lcd_va_fbctrl, regs + REG_LCM_VA_FBCTRL);
+	writel(fbi->regs.lcd_va_scale, regs + REG_LCM_VA_SCALE);
+}
+
+/*
+ *	calculate divider for lcd div
+ */
+static unsigned int nuc900fb_calc_pixclk(struct nuc900fb_info *fbi,
+					 unsigned long pixclk)
+{
+	unsigned long clk = fbi->clk_rate;
+	unsigned long long div;
+
+	/* pixclk is in picseconds. our clock is in Hz*/
+	/* div = (clk * pixclk)/10^12 */
+	div = (unsigned long long)clk * pixclk;
+	div >>= 12;
+	do_div(div, 625 * 625UL * 625);
+
+	dev_dbg(fbi->dev, "pixclk %ld, divisor is %lld\n", pixclk, div);
+
+	return div;
+}
+
+/*
+ *	Check the video params of 'var'.
+ */
+static int nuc900fb_check_var(struct fb_var_screeninfo *var,
+			       struct fb_info *info)
+{
+	struct nuc900fb_info *fbi = info->par;
+	struct nuc900fb_mach_info *mach_info = fbi->dev->platform_data;
+	struct nuc900fb_display *display = NULL;
+	struct nuc900fb_display *default_display = mach_info->displays +
+						   mach_info->default_display;
+	int i;
+
+	dev_dbg(fbi->dev, "check_var(var=%p, info=%p)\n", var, info);
+
+	/* validate x/y resolution */
+	/* choose default mode if possible */
+	if (var->xres == default_display->xres &&
+	    var->yres == default_display->yres &&
+	    var->bits_per_pixel == default_display->bpp)
+		display = default_display;
+	else
+		for (i = 0; i < mach_info->num_displays; i++)
+			if (var->xres == mach_info->displays[i].xres &&
+			    var->yres == mach_info->displays[i].yres &&
+			    var->bits_per_pixel == mach_info->displays[i].bpp) {
+				display = mach_info->displays + i;
+				break;
+			}
+
+	if (display == NULL) {
+		printk(KERN_ERR "wrong resolution or depth %dx%d at %d bit per pixel\n",
+			var->xres, var->yres, var->bits_per_pixel);
+		return -EINVAL;
+	}
+
+	/* it should be the same size as the display */
+	var->xres_virtual	= display->xres;
+	var->yres_virtual	= display->yres;
+	var->height		= display->height;
+	var->width		= display->width;
+
+	/* copy lcd settings */
+	var->pixclock		= display->pixclock;
+	var->left_margin	= display->left_margin;
+	var->right_margin	= display->right_margin;
+	var->upper_margin	= display->upper_margin;
+	var->lower_margin	= display->lower_margin;
+	var->vsync_len		= display->vsync_len;
+	var->hsync_len		= display->hsync_len;
+
+	var->transp.offset	= 0;
+	var->transp.length	= 0;
+
+	fbi->regs.lcd_dccs = display->dccs;
+	fbi->regs.lcd_device_ctrl = display->devctl;
+	fbi->regs.lcd_va_fbctrl = display->fbctrl;
+	fbi->regs.lcd_va_scale = display->scale;
+
+	/* set R/G/B possions */
+	switch (var->bits_per_pixel) {
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+	default:
+		var->red.offset 	= 0;
+		var->red.length 	= var->bits_per_pixel;
+		var->green 		= var->red;
+		var->blue		= var->red;
+		break;
+	case 12:
+		var->red.length		= 4;
+		var->green.length	= 4;
+		var->blue.length	= 4;
+		var->red.offset		= 8;
+		var->green.offset	= 4;
+		var->blue.offset	= 0;
+		break;
+	case 16:
+		var->red.length		= 5;
+		var->green.length	= 6;
+		var->blue.length	= 5;
+		var->red.offset		= 11;
+		var->green.offset	= 5;
+		var->blue.offset	= 0;
+		break;
+	case 18:
+		var->red.length		= 6;
+		var->green.length	= 6;
+		var->blue.length	= 6;
+		var->red.offset		= 12;
+		var->green.offset	= 6;
+		var->blue.offset	= 0;
+		break;
+	case 32:
+		var->red.length		= 8;
+		var->green.length	= 8;
+		var->blue.length	= 8;
+		var->red.offset		= 16;
+		var->green.offset	= 8;
+		var->blue.offset	= 0;
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ *	Calculate lcd register values from var setting & save into hw
+ */
+static void nuc900fb_calculate_lcd_regs(const struct fb_info *info,
+					struct nuc900fb_hw *regs)
+{
+	const struct fb_var_screeninfo *var = &info->var;
+	int vtt = var->height + var->upper_margin + var->lower_margin;
+	int htt = var->width + var->left_margin + var->right_margin;
+	int hsync = var->width + var->right_margin;
+	int vsync = var->height + var->lower_margin;
+
+	regs->lcd_crtc_size = LCM_CRTC_SIZE_VTTVAL(vtt) |
+			      LCM_CRTC_SIZE_HTTVAL(htt);
+	regs->lcd_crtc_dend = LCM_CRTC_DEND_VDENDVAL(var->height) |
+			      LCM_CRTC_DEND_HDENDVAL(var->width);
+	regs->lcd_crtc_hr = LCM_CRTC_HR_EVAL(var->width + 5) |
+			    LCM_CRTC_HR_SVAL(var->width + 1);
+	regs->lcd_crtc_hsync = LCM_CRTC_HSYNC_EVAL(hsync + var->hsync_len) |
+			       LCM_CRTC_HSYNC_SVAL(hsync);
+	regs->lcd_crtc_vr = LCM_CRTC_VR_EVAL(vsync + var->vsync_len) |
+			    LCM_CRTC_VR_SVAL(vsync);
+
+}
+
+/*
+ *	Activate (set) the controller from the given framebuffer
+ *	information
+ */
+static void nuc900fb_activate_var(struct fb_info *info)
+{
+	struct nuc900fb_info *fbi = info->par;
+	void __iomem *regs = fbi->io;
+	struct fb_var_screeninfo *var = &info->var;
+	int clkdiv;
+
+	clkdiv = nuc900fb_calc_pixclk(fbi, var->pixclock) - 1;
+	if (clkdiv < 0)
+		clkdiv = 0;
+
+	nuc900fb_calculate_lcd_regs(info, &fbi->regs);
+
+	/* set the new lcd registers*/
+
+	dev_dbg(fbi->dev, "new lcd register set:\n");
+	dev_dbg(fbi->dev, "dccs       = 0x%08x\n", fbi->regs.lcd_dccs);
+	dev_dbg(fbi->dev, "dev_ctl    = 0x%08x\n", fbi->regs.lcd_device_ctrl);
+	dev_dbg(fbi->dev, "crtc_size  = 0x%08x\n", fbi->regs.lcd_crtc_size);
+	dev_dbg(fbi->dev, "crtc_dend  = 0x%08x\n", fbi->regs.lcd_crtc_dend);
+	dev_dbg(fbi->dev, "crtc_hr    = 0x%08x\n", fbi->regs.lcd_crtc_hr);
+	dev_dbg(fbi->dev, "crtc_hsync = 0x%08x\n", fbi->regs.lcd_crtc_hsync);
+	dev_dbg(fbi->dev, "crtc_vr    = 0x%08x\n", fbi->regs.lcd_crtc_vr);
+
+	writel(fbi->regs.lcd_device_ctrl, regs + REG_LCM_DEV_CTRL);
+	writel(fbi->regs.lcd_crtc_size, regs + REG_LCM_CRTC_SIZE);
+	writel(fbi->regs.lcd_crtc_dend, regs + REG_LCM_CRTC_DEND);
+	writel(fbi->regs.lcd_crtc_hr, regs + REG_LCM_CRTC_HR);
+	writel(fbi->regs.lcd_crtc_hsync, regs + REG_LCM_CRTC_HSYNC);
+	writel(fbi->regs.lcd_crtc_vr, regs + REG_LCM_CRTC_VR);
+
+	/* set lcd address pointers */
+	nuc900fb_set_lcdaddr(info);
+
+	writel(fbi->regs.lcd_dccs, regs + REG_LCM_DCCS);
+}
+
+/*
+ *      Alters the hardware state.
+ *
+ */
+static int nuc900fb_set_par(struct fb_info *info)
+{
+	struct fb_var_screeninfo *var = &info->var;
+
+	switch (var->bits_per_pixel) {
+	case 32:
+	case 24:
+	case 18:
+	case 16:
+	case 12:
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		break;
+	case 1:
+		info->fix.visual = FB_VISUAL_MONO01;
+		break;
+	default:
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	}
+
+	info->fix.line_length = (var->xres_virtual * var->bits_per_pixel) / 8;
+
+	/* activate this new configuration */
+	nuc900fb_activate_var(info);
+	return 0;
+}
+
+static inline unsigned int chan_to_field(unsigned int chan,
+					 struct fb_bitfield *bf)
+{
+	chan &= 0xffff;
+	chan >>= 16 - bf->length;
+	return chan << bf->offset;
+}
+
+static int nuc900fb_setcolreg(unsigned regno,
+			       unsigned red, unsigned green, unsigned blue,
+			       unsigned transp, struct fb_info *info)
+{
+	unsigned int val;
+
+	switch (info->fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		/* true-colour, use pseuo-palette */
+		if (regno < 16) {
+			u32 *pal = info->pseudo_palette;
+
+			val  = chan_to_field(red, &info->var.red);
+			val |= chan_to_field(green, &info->var.green);
+			val |= chan_to_field(blue, &info->var.blue);
+			pal[regno] = val;
+		}
+		break;
+
+	default:
+		return 1;   /* unknown type */
+	}
+	return 0;
+}
+
+/**
+ *      nuc900fb_blank
+ *
+ */
+static int nuc900fb_blank(int blank_mode, struct fb_info *info)
+{
+
+	return 0;
+}
+
+static struct fb_ops nuc900fb_ops = {
+	.owner			= THIS_MODULE,
+	.fb_check_var		= nuc900fb_check_var,
+	.fb_set_par		= nuc900fb_set_par,
+	.fb_blank		= nuc900fb_blank,
+	.fb_setcolreg		= nuc900fb_setcolreg,
+	.fb_fillrect		= cfb_fillrect,
+	.fb_copyarea		= cfb_copyarea,
+	.fb_imageblit		= cfb_imageblit,
+};
+
+
+static inline void modify_gpio(void __iomem *reg,
+			       unsigned long set, unsigned long mask)
+{
+	unsigned long tmp;
+	tmp = readl(reg) & ~mask;
+	writel(tmp | set, reg);
+}
+
+/*
+ * Initialise LCD-related registers
+ */
+static int nuc900fb_init_registers(struct fb_info *info)
+{
+	struct nuc900fb_info *fbi = info->par;
+	struct nuc900fb_mach_info *mach_info = fbi->dev->platform_data;
+	void __iomem *regs = fbi->io;
+
+	/*reset the display engine*/
+	writel(0, regs + REG_LCM_DCCS);
+	writel(readl(regs + REG_LCM_DCCS) | LCM_DCCS_ENG_RST,
+	       regs + REG_LCM_DCCS);
+	ndelay(100);
+	writel(readl(regs + REG_LCM_DCCS) & (~LCM_DCCS_ENG_RST),
+	       regs + REG_LCM_DCCS);
+	ndelay(100);
+
+	writel(0, regs + REG_LCM_DEV_CTRL);
+
+	/* config gpio output */
+	modify_gpio(W90X900_VA_GPIO + 0x54, mach_info->gpio_dir,
+		    mach_info->gpio_dir_mask);
+	modify_gpio(W90X900_VA_GPIO + 0x58, mach_info->gpio_data,
+		    mach_info->gpio_data_mask);
+
+	return 0;
+}
+
+
+/*
+ *    Alloc the SDRAM region of NUC900 for the frame buffer.
+ *    The buffer should be a non-cached, non-buffered, memory region
+ *    to allow palette and pixel writes without flushing the cache.
+ */
+static int __init nuc900fb_map_video_memory(struct fb_info *info)
+{
+	struct nuc900fb_info *fbi = info->par;
+	dma_addr_t map_dma;
+	unsigned long map_size = PAGE_ALIGN(info->fix.smem_len);
+
+	dev_dbg(fbi->dev, "nuc900fb_map_video_memory(fbi=%p) map_size %lu\n",
+		fbi, map_size);
+
+	info->screen_base = dma_alloc_writecombine(fbi->dev, map_size,
+							&map_dma, GFP_KERNEL);
+
+	if (!info->screen_base)
+		return -ENOMEM;
+
+	memset(info->screen_base, 0x00, map_size);
+	info->fix.smem_start = map_dma;
+
+	return 0;
+}
+
+static inline void nuc900fb_unmap_video_memory(struct fb_info *info)
+{
+	struct nuc900fb_info *fbi = info->par;
+	dma_free_writecombine(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
+			      info->screen_base, info->fix.smem_start);
+}
+
+static irqreturn_t nuc900fb_irqhandler(int irq, void *dev_id)
+{
+	struct nuc900fb_info *fbi = dev_id;
+	void __iomem *regs = fbi->io;
+	void __iomem *irq_base = fbi->irq_base;
+	unsigned long lcdirq = readl(regs + REG_LCM_INT_CS);
+
+	if (lcdirq & LCM_INT_CS_DISP_F_STATUS) {
+		writel(readl(irq_base) | 1<<30, irq_base);
+
+		/* wait VA_EN low */
+		if ((readl(regs + REG_LCM_DCCS) &
+		    LCM_DCCS_SINGLE) == LCM_DCCS_SINGLE)
+			while ((readl(regs + REG_LCM_DCCS) &
+			       LCM_DCCS_VA_EN) == LCM_DCCS_VA_EN)
+				;
+		/* display_out-enable */
+		writel(readl(regs + REG_LCM_DCCS) | LCM_DCCS_DISP_OUT_EN,
+			regs + REG_LCM_DCCS);
+		/* va-enable*/
+		writel(readl(regs + REG_LCM_DCCS) | LCM_DCCS_VA_EN,
+			regs + REG_LCM_DCCS);
+	} else if (lcdirq & LCM_INT_CS_UNDERRUN_INT) {
+		writel(readl(irq_base) | LCM_INT_CS_UNDERRUN_INT, irq_base);
+	} else if (lcdirq & LCM_INT_CS_BUS_ERROR_INT) {
+		writel(readl(irq_base) | LCM_INT_CS_BUS_ERROR_INT, irq_base);
+	}
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_CPU_FREQ
+
+static int nuc900fb_cpufreq_transition(struct notifier_block *nb,
+				       unsigned long val, void *data)
+{
+	struct nuc900fb_info *info;
+	struct fb_info *fbinfo;
+	long delta_f;
+	info = container_of(nb, struct nuc900fb_info, freq_transition);
+	fbinfo = platform_get_drvdata(to_platform_device(info->dev));
+
+	delta_f = info->clk_rate - clk_get_rate(info->clk);
+
+	if ((val == CPUFREQ_POSTCHANGE && delta_f > 0) ||
+	   (val == CPUFREQ_PRECHANGE && delta_f < 0)) {
+		info->clk_rate = clk_get_rate(info->clk);
+		nuc900fb_activate_var(fbinfo);
+	}
+
+	return 0;
+}
+
+static inline int nuc900fb_cpufreq_register(struct nuc900fb_info *fbi)
+{
+	fbi->freq_transition.notifier_call = nuc900fb_cpufreq_transition;
+	return cpufreq_register_notifier(&fbi->freq_transition,
+				  CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+static inline void nuc900fb_cpufreq_deregister(struct nuc900fb_info *fbi)
+{
+	cpufreq_unregister_notifier(&fbi->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+}
+#else
+static inline int nuc900fb_cpufreq_transition(struct notifier_block *nb,
+				       unsigned long val, void *data)
+{
+	return 0;
+}
+
+static inline int nuc900fb_cpufreq_register(struct nuc900fb_info *fbi)
+{
+	return 0;
+}
+
+static inline void nuc900fb_cpufreq_deregister(struct nuc900fb_info *info)
+{
+}
+#endif
+
+static char driver_name[] = "nuc900fb";
+
+static int __devinit nuc900fb_probe(struct platform_device *pdev)
+{
+	struct nuc900fb_info *fbi;
+	struct nuc900fb_display *display;
+	struct fb_info	   *fbinfo;
+	struct nuc900fb_mach_info *mach_info;
+	struct resource *res;
+	int ret;
+	int irq;
+	int i;
+	int size;
+
+	dev_dbg(&pdev->dev, "devinit\n");
+	mach_info = pdev->dev.platform_data;
+	if (mach_info == NULL) {
+		dev_err(&pdev->dev,
+			"no platform data for lcd, cannot attach\n");
+		return -EINVAL;
+	}
+
+	if (mach_info->default_display > mach_info->num_displays) {
+		dev_err(&pdev->dev,
+			"default display No. is %d but only %d displays \n",
+			mach_info->default_display, mach_info->num_displays);
+		return -EINVAL;
+	}
+
+
+	display = mach_info->displays + mach_info->default_display;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq for device\n");
+		return -ENOENT;
+	}
+
+	fbinfo = framebuffer_alloc(sizeof(struct nuc900fb_info), &pdev->dev);
+	if (!fbinfo)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, fbinfo);
+
+	fbi = fbinfo->par;
+	fbi->dev = &pdev->dev;
+
+#ifdef CONFIG_CPU_NUC950
+	fbi->drv_type = LCDDRV_NUC950;
+#endif
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	size = (res->end - res->start) + 1;
+	fbi->mem = request_mem_region(res->start, size, pdev->name);
+	if (fbi->mem == NULL) {
+		dev_err(&pdev->dev, "failed to alloc memory region\n");
+		ret = -ENOENT;
+		goto free_fb;
+	}
+
+	fbi->io = ioremap(res->start, size);
+	if (fbi->io == NULL) {
+		dev_err(&pdev->dev, "ioremap() of lcd registers failed\n");
+		ret = -ENXIO;
+		goto release_mem_region;
+	}
+
+	fbi->irq_base = fbi->io + REG_LCM_INT_CS;
+
+
+	/* Stop the LCD */
+	writel(0, fbi->io + REG_LCM_DCCS);
+
+	/* fill the fbinfo*/
+	strcpy(fbinfo->fix.id, driver_name);
+	fbinfo->fix.type		= FB_TYPE_PACKED_PIXELS;
+	fbinfo->fix.type_aux		= 0;
+	fbinfo->fix.xpanstep		= 0;
+	fbinfo->fix.ypanstep		= 0;
+	fbinfo->fix.ywrapstep		= 0;
+	fbinfo->fix.accel		= FB_ACCEL_NONE;
+	fbinfo->var.nonstd		= 0;
+	fbinfo->var.activate		= FB_ACTIVATE_NOW;
+	fbinfo->var.accel_flags		= 0;
+	fbinfo->var.vmode		= FB_VMODE_NONINTERLACED;
+	fbinfo->fbops			= &nuc900fb_ops;
+	fbinfo->flags			= FBINFO_FLAG_DEFAULT;
+	fbinfo->pseudo_palette		= &fbi->pseudo_pal;
+
+	ret = request_irq(irq, nuc900fb_irqhandler, IRQF_DISABLED,
+			  pdev->name, fbinfo);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot register irq handler %d -err %d\n",
+			irq, ret);
+		ret = -EBUSY;
+		goto release_regs;
+	}
+
+	nuc900_driver_clksrc_div(&pdev->dev, "ext", 0x2);
+
+	fbi->clk = clk_get(&pdev->dev, NULL);
+	if (!fbi->clk || IS_ERR(fbi->clk)) {
+		printk(KERN_ERR "nuc900-lcd:failed to get lcd clock source\n");
+		ret = -ENOENT;
+		goto release_irq;
+	}
+
+	clk_enable(fbi->clk);
+	dev_dbg(&pdev->dev, "got and enabled clock\n");
+
+	fbi->clk_rate = clk_get_rate(fbi->clk);
+
+	/* calutate the video buffer size */
+	for (i = 0; i < mach_info->num_displays; i++) {
+		unsigned long smem_len = mach_info->displays[i].xres;
+		smem_len *= mach_info->displays[i].yres;
+		smem_len *= mach_info->displays[i].bpp;
+		smem_len >>= 3;
+		if (fbinfo->fix.smem_len < smem_len)
+			fbinfo->fix.smem_len = smem_len;
+	}
+
+	/* Initialize Video Memory */
+	ret = nuc900fb_map_video_memory(fbinfo);
+	if (ret) {
+		printk(KERN_ERR "Failed to allocate video RAM: %x\n", ret);
+		goto release_clock;
+	}
+
+	dev_dbg(&pdev->dev, "got video memory\n");
+
+	fbinfo->var.xres = display->xres;
+	fbinfo->var.yres = display->yres;
+	fbinfo->var.bits_per_pixel = display->bpp;
+
+	nuc900fb_init_registers(fbinfo);
+
+	nuc900fb_check_var(&fbinfo->var, fbinfo);
+
+	ret = nuc900fb_cpufreq_register(fbi);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register cpufreq\n");
+		goto free_video_memory;
+	}
+
+	ret = register_framebuffer(fbinfo);
+	if (ret) {
+		printk(KERN_ERR "failed to register framebuffer device: %d\n",
+			ret);
+		goto free_cpufreq;
+	}
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n",
+		fbinfo->node, fbinfo->fix.id);
+
+	return 0;
+
+free_cpufreq:
+	nuc900fb_cpufreq_deregister(fbi);
+free_video_memory:
+	nuc900fb_unmap_video_memory(fbinfo);
+release_clock:
+	clk_disable(fbi->clk);
+	clk_put(fbi->clk);
+release_irq:
+	free_irq(irq, fbi);
+release_regs:
+	iounmap(fbi->io);
+release_mem_region:
+	release_mem_region((unsigned long)fbi->mem, size);
+free_fb:
+	framebuffer_release(fbinfo);
+	return ret;
+}
+
+/*
+ * shutdown the lcd controller
+ */
+static void nuc900fb_stop_lcd(struct fb_info *info)
+{
+	struct nuc900fb_info *fbi = info->par;
+	void __iomem *regs = fbi->io;
+
+	writel((~LCM_DCCS_DISP_INT_EN) | (~LCM_DCCS_VA_EN) | (~LCM_DCCS_OSD_EN),
+		regs + REG_LCM_DCCS);
+}
+
+/*
+ *  Cleanup
+ */
+static int nuc900fb_remove(struct platform_device *pdev)
+{
+	struct fb_info *fbinfo = platform_get_drvdata(pdev);
+	struct nuc900fb_info *fbi = fbinfo->par;
+	int irq;
+
+	nuc900fb_stop_lcd(fbinfo);
+	msleep(1);
+
+	nuc900fb_unmap_video_memory(fbinfo);
+
+	iounmap(fbi->io);
+
+	irq = platform_get_irq(pdev, 0);
+	free_irq(irq, fbi);
+
+	release_resource(fbi->mem);
+	kfree(fbi->mem);
+
+	platform_set_drvdata(pdev, NULL);
+	framebuffer_release(fbinfo);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+/*
+ *	suspend and resume support for the lcd controller
+ */
+
+static int nuc900fb_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct fb_info	   *fbinfo = platform_get_drvdata(dev);
+	struct nuc900fb_info *info = fbinfo->par;
+
+	nuc900fb_stop_lcd();
+	msleep(1);
+	clk_disable(info->clk);
+	return 0;
+}
+
+static int nuc900fb_resume(struct platform_device *dev)
+{
+	struct fb_info	   *fbinfo = platform_get_drvdata(dev);
+	struct nuc900fb_info *fbi = fbinfo->par;
+
+	printk(KERN_INFO "nuc900fb resume\n");
+
+	clk_enable(fbi->clk);
+	msleep(1);
+
+	nuc900fb_init_registers(fbinfo);
+	nuc900fb_activate_var(bfinfo);
+
+	return 0;
+}
+
+#else
+#define nuc900fb_suspend NULL
+#define nuc900fb_resume  NULL
+#endif
+
+static struct platform_driver nuc900fb_driver = {
+	.probe		= nuc900fb_probe,
+	.remove		= nuc900fb_remove,
+	.suspend	= nuc900fb_suspend,
+	.resume		= nuc900fb_resume,
+	.driver		= {
+		.name	= "nuc900-lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+int __devinit nuc900fb_init(void)
+{
+	return platform_driver_register(&nuc900fb_driver);
+}
+
+static void __exit nuc900fb_cleanup(void)
+{
+	platform_driver_unregister(&nuc900fb_driver);
+}
+
+module_init(nuc900fb_init);
+module_exit(nuc900fb_cleanup);
+
+MODULE_DESCRIPTION("Framebuffer driver for the NUC900");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/nuc900fb.h b/drivers/video/nuc900fb.h
new file mode 100644
index 0000000..6c23aa3
--- /dev/null
+++ b/drivers/video/nuc900fb.h
@@ -0,0 +1,55 @@
+/*
+ *
+ * Copyright (c) 2009 Nuvoton technology corporation
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ *   Auther:
+ *        Wang Qiang(rurality.linux@gmail.com)  2009/12/16
+ */
+
+#ifndef __NUC900FB_H
+#define __NUC900FB_H
+
+#include <mach/map.h>
+#include <mach/fb.h>
+
+enum nuc900_lcddrv_type {
+	LCDDRV_NUC910,
+	LCDDRV_NUC930,
+	LCDDRV_NUC932,
+	LCDDRV_NUC950,
+	LCDDRV_NUC960,
+};
+
+
+#define PALETTE_BUFFER_SIZE	256
+#define PALETTE_BUFF_CLEAR 	(0x80000000) /* entry is clear/invalid */
+
+struct nuc900fb_info {
+	struct device		*dev;
+	struct clk		*clk;
+
+	struct resource		*mem;
+	void __iomem		*io;
+	void __iomem		*irq_base;
+	int 			drv_type;
+	struct nuc900fb_hw	regs;
+	unsigned long		clk_rate;
+
+#ifdef CONFIG_CPU_FREQ
+	struct notifier_block	freq_transition;
+#endif
+
+	/* keep these registers in case we need to re-write palette */
+	u32			palette_buffer[PALETTE_BUFFER_SIZE];
+	u32			pseudo_pal[16];
+};
+
+int nuc900fb_init(void);
+
+#endif /* __NUC900FB_H */
-- 
1.6.4

--00235429d8fcf872db047e972b47
Content-Type: application/octet-stream; 
	name="nuc900-lcd-controller-driver.patch"
Content-Disposition: attachment; 
	filename="nuc900-lcd-controller-driver.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g568hvui0

U2lnbmVkLW9mZi1ieTogV2FuZyBRaWFuZyA8cnVyYWxpdHkubGludXhAZ21haWwuY29tPgpDYzog
QW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KQ2M6IFJ1c3NlbGwgS2lu
ZyA8cm1rQGFybS5saW51eC5vcmcudWs+CkNjOiBXYW5nIFpvbmdzaHVuIDxtY3Vvcy5jb21AZ21h
aWwuY29tPgpDYzogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUBwb2N6dGEuZm0+CgotLS0K
IGFyY2gvYXJtL2NvbmZpZ3MvbnVjOTUwX2RlZmNvbmZpZyAgICAgICAgICAgICB8ICAgNTMgKyst
CiBhcmNoL2FybS9tYWNoLXc5MHg5MDAvY3B1LmggICAgICAgICAgICAgICAgICAgfCAgICAxICsK
IGFyY2gvYXJtL21hY2gtdzkweDkwMC9kZXYuYyAgICAgICAgICAgICAgICAgICB8ICAgNDIgKysK
IGFyY2gvYXJtL21hY2gtdzkweDkwMC9pbmNsdWRlL21hY2gvZmIuaCAgICAgICB8ICAgODMgKysr
CiBhcmNoL2FybS9tYWNoLXc5MHg5MDAvaW5jbHVkZS9tYWNoL3JlZ3MtbGRtLmggfCAgMjUzICsr
KysrKysrCiBhcmNoL2FybS9tYWNoLXc5MHg5MDAvbWFjaC1udWM5NTBldmIuYyAgICAgICAgfCAg
IDQ3ICsrCiBhcmNoL2FybS9tYWNoLXc5MHg5MDAvbnVjOTUwLmMgICAgICAgICAgICAgICAgfCAg
ICA0ICsKIGRyaXZlcnMvdmlkZW8vS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MjEgKwogZHJpdmVycy92aWRlby9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
MSArCiBkcml2ZXJzL3ZpZGVvL251YzkwMGZiLmMgICAgICAgICAgICAgICAgICAgICAgfCAgNzc5
ICsrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvdmlkZW8vbnVjOTAwZmIuaCAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNTUgKysKIDExIGZpbGVzIGNoYW5nZWQsIDEzMzggaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNo
LXc5MHg5MDAvaW5jbHVkZS9tYWNoL2ZiLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9t
YWNoLXc5MHg5MDAvaW5jbHVkZS9tYWNoL3JlZ3MtbGRtLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3ZpZGVvL251YzkwMGZiLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZpZGVv
L251YzkwMGZiLmgKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9jb25maWdzL251Yzk1MF9kZWZjb25m
aWcgYi9hcmNoL2FybS9jb25maWdzL251Yzk1MF9kZWZjb25maWcKaW5kZXggOTczMDBlYy4uNTFj
YzJhMiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vY29uZmlncy9udWM5NTBfZGVmY29uZmlnCisrKyBi
L2FyY2gvYXJtL2NvbmZpZ3MvbnVjOTUwX2RlZmNvbmZpZwpAQCAtNTkwLDggKzU5MCw0MCBAQCBD
T05GSUdfU1NCX1BPU1NJQkxFPXkKICMKICMgQ09ORklHX1ZHQVNUQVRFIGlzIG5vdCBzZXQKICMg
Q09ORklHX1ZJREVPX09VVFBVVF9DT05UUk9MIGlzIG5vdCBzZXQKLSMgQ09ORklHX0ZCIGlzIG5v
dCBzZXQKICMgQ09ORklHX0JBQ0tMSUdIVF9MQ0RfU1VQUE9SVCBpcyBub3Qgc2V0CitDT05GSUdf
RkI9eQorIyBDT05GSUdfRklSTVdBUkVfRURJRCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9EREMg
aXMgbm90IHNldAorIyBDT05GSUdfRkJfQk9PVF9WRVNBX1NVUFBPUlQgaXMgbm90IHNldAorQ09O
RklHX0ZCX0NGQl9GSUxMUkVDVD15CitDT05GSUdfRkJfQ0ZCX0NPUFlBUkVBPXkKK0NPTkZJR19G
Ql9DRkJfSU1BR0VCTElUPXkKKyMgQ09ORklHX0ZCX0NGQl9SRVZfUElYRUxTX0lOX0JZVEUgaXMg
bm90IHNldAorIyBDT05GSUdfRkJfU1lTX0ZJTExSRUNUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZC
X1NZU19DT1BZQVJFQSBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9TWVNfSU1BR0VCTElUIGlzIG5v
dCBzZXQKKyMgQ09ORklHX0ZCX0ZPUkVJR05fRU5ESUFOIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZC
X1NZU19GT1BTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX1NWR0FMSUIgaXMgbm90IHNldAorIyBD
T05GSUdfRkJfTUFDTU9ERVMgaXMgbm90IHNldAorIyBDT05GSUdfRkJfQkFDS0xJR0hUIGlzIG5v
dCBzZXQKKyMgQ09ORklHX0ZCX01PREVfSEVMUEVSUyBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9U
SUxFQkxJVFRJTkcgaXMgbm90IHNldAorCisjCisjIEZyYW1lIGJ1ZmZlciBoYXJkd2FyZSBkcml2
ZXJzCisjCisjIENPTkZJR19GQl9TMUQxM1hYWCBpcyBub3Qgc2V0CitDT05GSUdfRkJfTlVDOTAw
PXkKK0NPTkZJR19HUE0xMDQwQTBfMzIwWDI0MD15CitDT05GSUdfRkJfTlVDOTAwX0RFQlVHPXkK
KyMgQ09ORklHX0ZCX1ZJUlRVQUwgaXMgbm90IHNldAorIyBDT05GSUdfRkJfTUVUUk9OT01FIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0ZCX01CODYyWFggaXMgbm90IHNldAorIyBDT05GSUdfRkJfQlJP
QURTSEVFVCBpcyBub3Qgc2V0CisjIENPTkZJR19CQUNLTElHSFRfTENEX1NVUFBPUlQgaXMgbm90
IHNldAorCisKIAogIwogIyBEaXNwbGF5IGRldmljZSBzdXBwb3J0CkBAIC02MDMsNiArNjM1LDI1
IEBAIENPTkZJR19TU0JfUE9TU0lCTEU9eQogIwogIyBDT05GSUdfVkdBX0NPTlNPTEUgaXMgbm90
IHNldAogQ09ORklHX0RVTU1ZX0NPTlNPTEU9eQorQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEU9
eQorQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVfREVURUNUX1BSSU1BUlk9eQorIyBDT05GSUdf
RlJBTUVCVUZGRVJfQ09OU09MRV9ST1RBVElPTiBpcyBub3Qgc2V0CitDT05GSUdfRk9OVFM9eQor
IyBDT05GSUdfRk9OVF84eDggaXMgbm90IHNldAorQ09ORklHX0ZPTlRfOHgxNj15CisjIENPTkZJ
R19GT05UXzZ4MTEgaXMgbm90IHNldAorIyBDT05GSUdfRk9OVF83eDE0IGlzIG5vdCBzZXQKKyMg
Q09ORklHX0ZPTlRfUEVBUkxfOHg4IGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZPTlRfQUNPUk5fOHg4
IGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZPTlRfTUlOSV80eDYgaXMgbm90IHNldAorIyBDT05GSUdf
Rk9OVF9TVU44eDE2IGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZPTlRfU1VOMTJ4MjIgaXMgbm90IHNl
dAorIyBDT05GSUdfRk9OVF8xMHgxOCBpcyBub3Qgc2V0CitDT05GSUdfTE9HTz15CisjIENPTkZJ
R19MT0dPX0xJTlVYX01PTk8gaXMgbm90IHNldAorIyBDT05GSUdfTE9HT19MSU5VWF9WR0ExNiBp
cyBub3Qgc2V0CitDT05GSUdfTE9HT19MSU5VWF9DTFVUMjI0PXkKKwogIyBDT05GSUdfU09VTkQg
aXMgbm90IHNldAogIyBDT05GSUdfSElEX1NVUFBPUlQgaXMgbm90IHNldAogQ09ORklHX1VTQl9T
VVBQT1JUPXkKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtdzkweDkwMC9jcHUuaCBiL2FyY2gv
YXJtL21hY2gtdzkweDkwMC9jcHUuaAppbmRleCA0ZDU4YmExLi5mODczMGI2IDEwMDY0NAotLS0g
YS9hcmNoL2FybS9tYWNoLXc5MHg5MDAvY3B1LmgKKysrIGIvYXJjaC9hcm0vbWFjaC13OTB4OTAw
L2NwdS5oCkBAIC01NywzICs1Nyw0IEBAIGV4dGVybiBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIG51
YzkwMF9kZXZpY2VfZm1pOwogZXh0ZXJuIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgbnVjOTAwX2Rl
dmljZV9rcGk7CiBleHRlcm4gc3RydWN0IHBsYXRmb3JtX2RldmljZSBudWM5MDBfZGV2aWNlX3J0
YzsKIGV4dGVybiBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIG51YzkwMF9kZXZpY2VfdHM7CitleHRl
cm4gc3RydWN0IHBsYXRmb3JtX2RldmljZSBudWM5MDBfZGV2aWNlX2xjZDsKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL21hY2gtdzkweDkwMC9kZXYuYyBiL2FyY2gvYXJtL21hY2gtdzkweDkwMC9kZXYu
YwppbmRleCBlYzcxMWY0Li40ODg3NjEyIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLXc5MHg5
MDAvZGV2LmMKKysrIGIvYXJjaC9hcm0vbWFjaC13OTB4OTAwL2Rldi5jCkBAIC0zNCw2ICszNCw3
IEBACiAjaW5jbHVkZSA8bWFjaC9yZWdzLXNlcmlhbC5oPgogI2luY2x1ZGUgPG1hY2gvbnVjOTAw
X3NwaS5oPgogI2luY2x1ZGUgPG1hY2gvbWFwLmg+CisjaW5jbHVkZSA8bWFjaC9mYi5oPgogCiAj
aW5jbHVkZSAiY3B1LmgiCiAKQEAgLTM4MCw2ICszODEsNDcgQEAgc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSBudWM5MDBfZGV2aWNlX2twaSA9IHsKIAkucmVzb3VyY2UJPSBudWM5MDBfa3BpX3Jlc291
cmNlLAogfTsKIAorI2lmZGVmIENPTkZJR19GQl9OVUM5MDAKKworc3RhdGljIHN0cnVjdCByZXNv
dXJjZSBudWM5MDBfbGNkX3Jlc291cmNlW10gPSB7CisJWzBdID0geworCQkuc3RhcnQgPSBXOTBY
OTAwX1BBX0xDRCwKKwkJLmVuZCAgID0gVzkwWDkwMF9QQV9MQ0QgKyBXOTBYOTAwX1NaX0xDRCAt
IDEsCisJCS5mbGFncyA9IElPUkVTT1VSQ0VfTUVNLAorCX0sCisJWzFdID0geworCQkuc3RhcnQg
PSBJUlFfTENELAorCQkuZW5kICAgPSBJUlFfTENELAorCQkuZmxhZ3MgPSBJT1JFU09VUkNFX0lS
USwKKwl9Cit9OworCitzdGF0aWMgdTY0IG51YzkwMF9kZXZpY2VfbGNkX2RtYW1hc2sgPSAtMTsK
K3N0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgbnVjOTAwX2RldmljZV9sY2QgPSB7CisJLm5hbWUgICAg
ICAgICAgICAgPSAibnVjOTAwLWxjZCIsCisJLmlkICAgICAgICAgICAgICAgPSAtMSwKKwkubnVt
X3Jlc291cmNlcyAgICA9IEFSUkFZX1NJWkUobnVjOTAwX2xjZF9yZXNvdXJjZSksCisJLnJlc291
cmNlICAgICAgICAgPSBudWM5MDBfbGNkX3Jlc291cmNlLAorCS5kZXYgICAgICAgICAgICAgID0g
eworCQkuZG1hX21hc2sgICAgICAgICAgICAgICA9ICZudWM5MDBfZGV2aWNlX2xjZF9kbWFtYXNr
LAorCQkuY29oZXJlbnRfZG1hX21hc2sgICAgICA9IC0xLAorCX0KK307CisKK3ZvaWQgIG51Yzkw
MF9mYl9zZXRfcGxhdGRhdGEoc3RydWN0IG51YzkwMGZiX21hY2hfaW5mbyAqcGQpCit7CisJc3Ry
dWN0IG51YzkwMGZiX21hY2hfaW5mbyAqbnBkOworCisJbnBkID0ga21hbGxvYyhzaXplb2YoKm5w
ZCksIEdGUF9LRVJORUwpOworCWlmIChucGQpIHsKKwkJbWVtY3B5KG5wZCwgcGQsIHNpemVvZigq
bnBkKSk7CisJCW51YzkwMF9kZXZpY2VfbGNkLmRldi5wbGF0Zm9ybV9kYXRhID0gbnBkOworCX0g
ZWxzZSB7CisJCXByaW50ayhLRVJOX0VSUiAibm8gbWVtb3J5IGZvciBMQ0QgcGxhdGZvcm0gZGF0
YVxuIik7CisJfQorfQorI2VuZGlmCisKIC8qSGVyZSBzaG91bGQgYmUgeW91ciBldmIgcmVzb3Vy
c2Usc3VjaCBhcyBMQ0QqLwogCiBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqbnVjOTAw
X3B1YmxpY19kZXZbXSBfX2luaXRkYXRhID0gewpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC13
OTB4OTAwL2luY2x1ZGUvbWFjaC9mYi5oIGIvYXJjaC9hcm0vbWFjaC13OTB4OTAwL2luY2x1ZGUv
bWFjaC9mYi5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmNlYzVlY2UKLS0t
IC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9tYWNoLXc5MHg5MDAvaW5jbHVkZS9tYWNoL2ZiLmgK
QEAgLTAsMCArMSw4MyBAQAorLyogbGludXgvaW5jbHVkZS9hc20vYXJjaC1udWM5MDAvZmIuaAor
ICoKKyAqIENvcHlyaWdodCAoYykgMjAwOCBOdXZvdG9uIHRlY2hub2xvZ3kgY29ycG9yYXRpb24K
KyAqIEFsbCByaWdodHMgcmVzZXJ2ZWQuCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVuZGVy
IHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVk
IGJ5CisgKiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9m
IHRoZSBMaWNlbnNlLCBvcgorICogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4K
KyAqCisgKiBDaGFuZ2Vsb2c6CisgKgorICogICAyMDA4LzA4LzI2ICAgICB2aW5jZW4uenN3YW4g
bW9kaWZ5IHRoaXMgZmlsZSBmb3IgTENELgorICovCisKKyNpZm5kZWYgX19BU01fQVJNX0ZCX0gK
KyNkZWZpbmUgX19BU01fQVJNX0ZCX0gKKworCisKKy8qIExDRCBDb250cm9sbGVyIEhhcmR3YXJl
IERlc2MgKi8KK3N0cnVjdCBudWM5MDBmYl9odyB7CisJdW5zaWduZWQgaW50IGxjZF9kY2NzOwor
CXVuc2lnbmVkIGludCBsY2RfZGV2aWNlX2N0cmw7CisJdW5zaWduZWQgaW50IGxjZF9tcHVsY2Rf
Y21kOworCXVuc2lnbmVkIGludCBsY2RfaW50X2NzOworCXVuc2lnbmVkIGludCBsY2RfY3J0Y19z
aXplOworCXVuc2lnbmVkIGludCBsY2RfY3J0Y19kZW5kOworCXVuc2lnbmVkIGludCBsY2RfY3J0
Y19ocjsKKwl1bnNpZ25lZCBpbnQgbGNkX2NydGNfaHN5bmM7CisJdW5zaWduZWQgaW50IGxjZF9j
cnRjX3ZyOworCXVuc2lnbmVkIGludCBsY2RfdmFfYmFkZHIwOworCXVuc2lnbmVkIGludCBsY2Rf
dmFfYmFkZHIxOworCXVuc2lnbmVkIGludCBsY2RfdmFfZmJjdHJsOworCXVuc2lnbmVkIGludCBs
Y2RfdmFfc2NhbGU7CisJdW5zaWduZWQgaW50IGxjZF92YV90ZXN0OworCXVuc2lnbmVkIGludCBs
Y2RfdmFfd2luOworCXVuc2lnbmVkIGludCBsY2RfdmFfc3R1ZmY7Cit9OworCisvKiBMQ0QgRGlz
cGxheSBEZXNjcmlwdGlvbiAqLworc3RydWN0IG51YzkwMGZiX2Rpc3BsYXkgeworCS8qIExDRCBJ
bWFnZSB0eXBlICovCisJdW5zaWduZWQgdHlwZTsKKworCS8qIExDRCBTY3JlZW4gU2l6ZSAqLwor
CXVuc2lnbmVkIHNob3J0IHdpZHRoOworCXVuc2lnbmVkIHNob3J0IGhlaWdodDsKKworCS8qIExD
RCBTY3JlZW4gSW5mbyAqLworCXVuc2lnbmVkIHNob3J0IHhyZXM7CisJdW5zaWduZWQgc2hvcnQg
eXJlczsKKwl1bnNpZ25lZCBzaG9ydCBicHA7CisKKwl1bnNpZ25lZCBsb25nIHBpeGNsb2NrOwor
CXVuc2lnbmVkIHNob3J0IGxlZnRfbWFyZ2luOworCXVuc2lnbmVkIHNob3J0IHJpZ2h0X21hcmdp
bjsKKwl1bnNpZ25lZCBzaG9ydCBoc3luY19sZW47CisJdW5zaWduZWQgc2hvcnQgdXBwZXJfbWFy
Z2luOworCXVuc2lnbmVkIHNob3J0IGxvd2VyX21hcmdpbjsKKwl1bnNpZ25lZCBzaG9ydCB2c3lu
Y19sZW47CisKKwkvKiBoYXJkd2FyZSBzcGVjaWFsIHJlZ2lzdGVyIHZhbHVlICovCisJdW5zaWdu
ZWQgaW50IGRjY3M7CisJdW5zaWduZWQgaW50IGRldmN0bDsKKwl1bnNpZ25lZCBpbnQgZmJjdHJs
OworCXVuc2lnbmVkIGludCBzY2FsZTsKK307CisKK3N0cnVjdCBudWM5MDBmYl9tYWNoX2luZm8g
eworCXN0cnVjdCBudWM5MDBmYl9kaXNwbGF5ICpkaXNwbGF5czsKKwl1bnNpZ25lZCBudW1fZGlz
cGxheXM7CisJdW5zaWduZWQgZGVmYXVsdF9kaXNwbGF5OworCS8qIEdQSU8gU2V0dGluZyAgSW5m
byAqLworCXVuc2lnbmVkIGdwaW9fZGlyOworCXVuc2lnbmVkIGdwaW9fZGlyX21hc2s7CisJdW5z
aWduZWQgZ3Bpb19kYXRhOworCXVuc2lnbmVkIGdwaW9fZGF0YV9tYXNrOworfTsKKworZXh0ZXJu
IHZvaWQgX19pbml0IG51YzkwMF9mYl9zZXRfcGxhdGRhdGEoc3RydWN0IG51YzkwMGZiX21hY2hf
aW5mbyAqKTsKKworI2VuZGlmIC8qIF9fQVNNX0FSTV9GQl9IICovCmRpZmYgLS1naXQgYS9hcmNo
L2FybS9tYWNoLXc5MHg5MDAvaW5jbHVkZS9tYWNoL3JlZ3MtbGRtLmggYi9hcmNoL2FybS9tYWNo
LXc5MHg5MDAvaW5jbHVkZS9tYWNoL3JlZ3MtbGRtLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMC4uZTlkNDgwYQotLS0gL2Rldi9udWxsCisrKyBiL2FyY2gvYXJtL21hY2gtdzkw
eDkwMC9pbmNsdWRlL21hY2gvcmVncy1sZG0uaApAQCAtMCwwICsxLDI1MyBAQAorLyoKKyAqIGFy
Y2gvYXJtL21hY2gtdzkweDkwMC9pbmNsdWRlL21hY2gvcmVncy1zZXJpYWwuaAorICoKKyAqIENv
cHlyaWdodCAoYykgMjAwOSBOdXZvdG9uIHRlY2hub2xvZ3kgY29ycG9yYXRpb24KKyAqIEFsbCBy
aWdodHMgcmVzZXJ2ZWQuCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqIGl0IHVuZGVyIHRoZSB0ZXJt
cyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNl
bnNlLCBvcgorICogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAg
RGVzY3JpcHRpb246CisgKiAgICAgTnV2b3RvbiBEaXNwbGF5LCBMQ00gUmVnaXN0ZXIgbGlzdAor
ICogIEF1dGhvcjogIFdhbmcgUWlhbmcgKHJ1cmFsaXR5LmxpbnV4QGdtYWlsLmNvbSkgMjAwOS8x
Mi8xMQorICoKKyAqLworCisKKyNpZm5kZWYgX19BU01fQVJNX1c5MFg5MDBfUkVHU19MRE1fSAor
I2RlZmluZSBfX0FTTV9BUk1fVzkwWDkwMF9SRUdTX0xETV9ICisKKyNpbmNsdWRlIDxtYWNoL21h
cC5oPgorCisvKiBEaXNwbGF5IENvbnRyb2xsZXIgQ29udHJvbC9TdGF0dXMgUmVnaXN0ZXIgKi8K
KyNkZWZpbmUgUkVHX0xDTV9EQ0NTCQkJKDB4MDApCisKKyNkZWZpbmUgTENNX0RDQ1NfRU5HX1JT
VAkJKDEgPDwgMCkKKyNkZWZpbmUgTENNX0RDQ1NfVkFfRU4JCQkoMSA8PCAxKQorI2RlZmluZSBM
Q01fRENDU19PU0RfRU4JCQkoMSA8PCAyKQorI2RlZmluZSBMQ01fRENDU19ESVNQX09VVF9FTgkJ
KDEgPDwgMykKKyNkZWZpbmUgTENNX0RDQ1NfRElTUF9JTlRfRU4JCSgxIDw8IDQpCisjZGVmaW5l
IExDTV9EQ0NTX0NNRF9PTgkJCSgxIDw8IDUpCisjZGVmaW5lIExDTV9EQ0NTX0ZJRUxEX0lOVFIJ
CSgxIDw8IDYpCisjZGVmaW5lIExDTV9EQ0NTX1NJTkdMRQkJCSgxIDw8IDcpCisKK2VudW0gTENN
X0RDQ1NfVkFfU1JDIHsKKwlMQ01fRENDU19WQV9TUkNfWVVWNDIyCQk9ICgwIDw8IDgpLAorCUxD
TV9EQ0NTX1ZBX1NSQ19ZQ0JDUjQyMgk9ICgxIDw8IDgpLAorCUxDTV9EQ0NTX1ZBX1NSQ19SR0I4
ODgJCT0gKDIgPDwgOCksCisJTENNX0RDQ1NfVkFfU1JDX1JHQjY2NgkJPSAoMyA8PCA4KSwKKwlM
Q01fRENDU19WQV9TUkNfUkdCNTY1CQk9ICg0IDw8IDgpLAorCUxDTV9EQ0NTX1ZBX1NSQ19SR0I0
NDRMT1cJPSAoNSA8PCA4KSwKKwlMQ01fRENDU19WQV9TUkNfUkdCNDQ0SElHSCAJPSAoNyA8PCA4
KQorfTsKKworCisvKiBEaXNwbGF5IERldmljZSBDb250cm9sIFJlZ2lzdGVyICovCisjZGVmaW5l
IFJFR19MQ01fREVWX0NUUkwJCSgweDA0KQorCitlbnVtIExDTV9ERVZfQ1RSTF9TV0FQX1lDYkNy
IHsKKwlMQ01fREVWX0NUUkxfU1dBUF9VWVZZCQk9ICgwIDw8IDEpLAorCUxDTV9ERVZfQ1RSTF9T
V0FQX1lVWVYJCT0gKDEgPDwgMSksCisJTENNX0RFVl9DVFJMX1NXQVBfVllVWQkJPSAoMiA8PCAx
KSwKKwlMQ01fREVWX0NUUkxfU1dBUF9ZVllVCQk9ICgzIDw8IDEpCit9OworCitlbnVtIExDTV9E
RVZfQ1RSTF9SR0JfU0hJRlQgeworCUxDTV9ERVZfQ1RSTF9SR0JfU0hJRlRfTk9UIAk9ICgwIDw8
IDMpLAorCUxDTV9ERVZfQ1RSTF9SR0JfU0hJRlRfT05FQ1lDTEUgPSAoMSA8PCAzKSwKKwlMQ01f
REVWX0NUUkxfUkdCX1NISUZUX1RXT0NZQ0xFID0gKDIgPDwgMyksCisJTENNX0RFVl9DVFJMX1JH
Ql9TSElGVF9OT1RfREVGCT0gKDMgPDwgMykKK307CisKK2VudW0gTENNX0RFVl9DVFJMX0RFVklD
RSB7CisJTENNX0RFVl9DVFJMX0RFVklDRV9ZVVY0MjIJPSAoMCA8PCA1KSwKKwlMQ01fREVWX0NU
UkxfREVWSUNFX1lVVjQ0NAk9ICgxIDw8IDUpLAorCUxDTV9ERVZfQ1RSTF9ERVZJQ0VfVU5JUEFD
CT0gKDQgPDwgNSksCisJTENNX0RFVl9DVFJMX0RFVklDRV9TRUlLT19FUFNPTgk9ICg1IDw8IDUp
LAorCUxDTV9ERVZfQ1RSTF9ERVZJQ0VfSElHSF9DT0xPUgk9ICg2IDw8IDUpLAorCUxDTV9ERVZf
Q1RSTF9ERVZJQ0VfTVBVCQk9ICg3IDw8IDUpCit9OworCisjZGVmaW5lIExDTV9ERVZfQ1RSTF9M
Q0RfRERBCQkoOCkKKyNkZWZpbmUgTENNX0RFVl9DVFJMX1lVVjJDQ0lSCQkoMTYpCisKK2VudW0g
TENNX0RFVl9DVFJMX0xDRF9TRUwgeworCUxDTV9ERVZfQ1RSTF9MQ0RfU0VMX1JHQl9HQlIJPSAo
MCA8PCAxNyksCisJTENNX0RFVl9DVFJMX0xDRF9TRUxfQkdSX1JCRwk9ICgxIDw8IDE3KSwKKwlM
Q01fREVWX0NUUkxfTENEX1NFTF9HQlJfUkdCCT0gKDIgPDwgMTcpLAorCUxDTV9ERVZfQ1RSTF9M
Q0RfU0VMX1JCR19CR1IJPSAoMyA8PCAxNykKK307CisKK2VudW0gTENNX0RFVl9DVFJMX0ZBTF9E
IHsKKwlMQ01fREVWX0NUUkxfRkFMX0RfRkFMTElORwk9ICgwIDw8IDE5KSwKKwlMQ01fREVWX0NU
UkxfRkFMX0RfUklTSU5HCT0gKDEgPDwgMTkpLAorfTsKKworZW51bSBMQ01fREVWX0NUUkxfSF9Q
T0wgeworCUxDTV9ERVZfQ1RSTF9IX1BPTF9MT1cJCT0gKDAgPDwgMjApLAorCUxDTV9ERVZfQ1RS
TF9IX1BPTF9ISUdICQk9ICgxIDw8IDIwKSwKK307CisKK2VudW0gTENNX0RFVl9DVFJMX1ZfUE9M
IHsKKwlMQ01fREVWX0NUUkxfVl9QT0xfTE9XCQk9ICgwIDw8IDIxKSwKKwlMQ01fREVWX0NUUkxf
Vl9QT0xfSElHSAkJPSAoMSA8PCAyMSksCit9OworCitlbnVtIExDTV9ERVZfQ1RSTF9WUl9MQUNF
IHsKKwlMQ01fREVWX0NUUkxfVlJfTEFDRV9OSU5URVJMQUNFCT0gKDAgPDwgMjIpLAorCUxDTV9E
RVZfQ1RSTF9WUl9MQUNFX0lOVEVSTEFDRQk9ICgxIDw8IDIyKSwKK307CisKK2VudW0gTENNX0RF
Vl9DVFJMX0xBQ0UgeworCUxDTV9ERVZfQ1RSTF9MQUNFX05JTlRFUkxBQ0UJPSAoMCA8PCAyMyks
CisJTENNX0RFVl9DVFJMX0xBQ0VfSU5URVJMQUNFCT0gKDEgPDwgMjMpLAorfTsKKworZW51bSBM
Q01fREVWX0NUUkxfUkdCX1NDQUxFIHsKKwlMQ01fREVWX0NUUkxfUkdCX1NDQUxFXzQwOTYgCT0g
KDAgPDwgMjQpLAorCUxDTV9ERVZfQ1RSTF9SR0JfU0NBTEVfNjU1MzYgCT0gKDEgPDwgMjQpLAor
CUxDTV9ERVZfQ1RSTF9SR0JfU0NBTEVfMjYyMTQ0IAk9ICgyIDw8IDI0KSwKKwlMQ01fREVWX0NU
UkxfUkdCX1NDQUxFXzE2Nzc3MjE2ID0gKDMgPDwgMjQpLAorfTsKKworZW51bSBMQ01fREVWX0NU
UkxfREJXT1JEIHsKKwlMQ01fREVWX0NUUkxfREJXT1JEX0hBTEZXT1JECT0gKDAgPDwgMjYpLAor
CUxDTV9ERVZfQ1RSTF9EQldPUkRfRlVMTFdPUkQJPSAoMSA8PCAyNiksCit9OworCitlbnVtIExD
TV9ERVZfQ1RSTF9NUFU2OCB7CisJTENNX0RFVl9DVFJMX01QVTY4XzgwX1NFUklFUwk9ICgwIDw8
IDI3KSwKKwlMQ01fREVWX0NUUkxfTVBVNjhfNjhfU0VSSUVTCT0gKDEgPDwgMjcpLAorfTsKKwor
ZW51bSBMQ01fREVWX0NUUkxfREVfUE9MIHsKKwlMQ01fREVWX0NUUkxfREVfUE9MX0hJR0gJPSAo
MCA8PCAyOCksCisJTENNX0RFVl9DVFJMX0RFX1BPTF9MT1cJCT0gKDEgPDwgMjgpLAorfTsKKwor
I2RlZmluZSBMQ01fREVWX0NUUkxfQ01EMTYJCSgyOSkKKyNkZWZpbmUgTENNX0RFVl9DVFJMX0NN
MTZ0MTgJCSgzMCkKKyNkZWZpbmUgTENNX0RFVl9DVFJMX0NNRF9MT1cJCSgzMSkKKworLyogTVBV
LUludGVyZmFjZSBMQ0QgV3JpdGUgQ29tbWFuZCAqLworI2RlZmluZSBSRUdfTENNX01QVV9DTUQJ
CQkoMHgwOCkKKworLyogSW50ZXJydXB0IENvbnRyb2wvU3RhdHVzIFJlZ2lzdGVyICovCisjZGVm
aW5lIFJFR19MQ01fSU5UX0NTCQkJKDB4MGMpCisjZGVmaW5lIExDTV9JTlRfQ1NfRElTUF9GX0VO
CQkoMSA8PCAwKQorI2RlZmluZSBMQ01fSU5UX0NTX1VOREVSUlVOX0VOICAgCSgxIDw8IDEpCisj
ZGVmaW5lIExDTV9JTlRfQ1NfQlVTX0VSUk9SX0lOVCAJKDEgPDwgMjgpCisjZGVmaW5lIExDTV9J
TlRfQ1NfVU5ERVJSVU5fSU5UICAJKDEgPDwgMjkpCisjZGVmaW5lIExDTV9JTlRfQ1NfRElTUF9G
X1NUQVRVUyAJKDEgPDwgMzApCisjZGVmaW5lIExDTV9JTlRfQ1NfRElTUF9GX0lOVAkJKDEgPDwg
MzEpCisKKy8qIENSVEMgRGlzcGxheSBTaXplIENvbnRyb2wgUmVnaXN0ZXIgKi8KKyNkZWZpbmUg
UkVHX0xDTV9DUlRDX1NJWkUJCSgweDEwKQorI2RlZmluZSBMQ01fQ1JUQ19TSVpFX1ZUVFZBTCh4
KQkJKCh4KSA8PCAxNikKKyNkZWZpbmUgTENNX0NSVENfU0laRV9IVFRWQUwoeCkJCSgoeCkgPDwg
MCkKKworLyogQ1JUQyBEaXNwbGF5IEVuYWJsZSBFbmQgKi8KKyNkZWZpbmUgUkVHX0xDTV9DUlRD
X0RFTkQJCSgweDE0KQorI2RlZmluZSBMQ01fQ1JUQ19ERU5EX1ZERU5EVkFMKHgpCSgoeCkgPDwg
MTYpCisjZGVmaW5lIExDTV9DUlRDX0RFTkRfSERFTkRWQUwoeCkJKCh4KSA8PCAwKQorCisvKiBD
UlRDIEludGVybmFsIEhvcml6b250YWwgUmV0cmFjZSBDb250cm9sIFJlZ2lzdGVyICovCisjZGVm
aW5lIFJFR19MQ01fQ1JUQ19IUgkJCSgweDE4KQorI2RlZmluZSBMQ01fQ1JUQ19IUl9FVkFMKHgp
CQkoKHgpIDw8IDE2KQorI2RlZmluZSBMQ01fQ1JUQ19IUl9TVkFMKHgpCQkoKHgpIDw8IDApCisK
Ky8qIENSVEMgSG9yaXpvbnRhbCBTeW5jIENvbnRyb2wgUmVnaXN0ZXIgKi8KKyNkZWZpbmUgUkVH
X0xDTV9DUlRDX0hTWU5DCQkoMHgxQykKKyNkZWZpbmUgTENNX0NSVENfSFNZTkNfU0hJRlRWQUwo
eCkJKCh4KSA8PCAzMCkKKyNkZWZpbmUgTENNX0NSVENfSFNZTkNfRVZBTCh4KQkJKCh4KSA8PCAx
NikKKyNkZWZpbmUgTENNX0NSVENfSFNZTkNfU1ZBTCh4KQkJKCh4KSA8PCAwKQorCisvKiBDUlRD
IEludGVybmFsIFZlcnRpY2FsIFJldHJhY2UgQ29udHJvbCBSZWdpc3RlciAqLworI2RlZmluZSBS
RUdfTENNX0NSVENfVlIJCQkoMHgyMCkKKyNkZWZpbmUgTENNX0NSVENfVlJfRVZBTCh4KQkJKCh4
KSA8PCAxNikKKyNkZWZpbmUgTENNX0NSVENfVlJfU1ZBTCh4KQkJKCh4KSA8PCAwKQorCisvKiBW
aWRlbyBTdHJlYW0gRnJhbWUgQnVmZmVyLTAgU3RhcnRpbmcgQWRkcmVzcyAqLworI2RlZmluZSBS
RUdfTENNX1ZBX0JBRERSMAkJKDB4MjQpCisKKy8qIFZpZGVvIFN0cmVhbSBGcmFtZSBCdWZmZXIt
MSBTdGFydGluZyBBZGRyZXNzICovCisjZGVmaW5lIFJFR19MQ01fVkFfQkFERFIxCQkoMHgyOCkK
KworLyogVmlkZW8gU3RyZWFtIEZyYW1lIEJ1ZmZlciBDb250cm9sIFJlZ2lzdGVyICovCisjZGVm
aW5lIFJFR19MQ01fVkFfRkJDVFJMCQkoMHgyQykKKyNkZWZpbmUgTENNX1ZBX0ZCQ1RSTF9JT19S
RUdJT05fSEFMRgkoMSA8PCAyOCkKKyNkZWZpbmUgTENNX1ZBX0ZCQ1RSTF9GSUVMRF9EVUFMICAJ
KDEgPDwgMjkpCisjZGVmaW5lIExDTV9WQV9GQkNUUkxfU1RBUlRfQlVGIAkoMSA8PCAzMCkKKyNk
ZWZpbmUgTENNX1ZBX0ZCQ1RSTF9EQl9FTgkJKDEgPDwgMzEpCisKKy8qIFZpZGVvIFN0cmVhbSBT
Y2FsaW5nIENvbnRyb2wgUmVnaXN0ZXIgKi8KKyNkZWZpbmUgUkVHX0xDTV9WQV9TQ0FMRQkJKDB4
MzApCisjZGVmaW5lIExDTV9WQV9TQ0FMRV9YQ09QWV9JTlRFUlBPTEFUSU9OICgwIDw8IDE1KQor
I2RlZmluZSBMQ01fVkFfU0NBTEVfWENPUFlfRFVQTElDQVRJT04JICgxIDw8IDE1KQorCisvKiBJ
bWFnZSBTdHJlYW0gQWN0aXZlIFdpbmRvdyBDb29yZGluYXRlcyAqLworI2RlZmluZSBSRUdfTENN
X1ZBX1dJTgkJCSgweDM4KQorCisvKiBJbWFnZSBTdHJlYW0gU3R1ZmYgUGl4ZWwgKi8KKyNkZWZp
bmUgUkVHX0xDTV9WQV9TVFVGRgkJKDB4M0MpCisKKy8qIE9TRCBXaW5kb3cgU3RhcnRpbmcgQ29v
cmRpbmF0ZXMgKi8KKyNkZWZpbmUgUkVHX0xDTV9PU0RfV0lOUwkJKDB4NDApCisKKy8qIE9TRCBX
aW5kb3cgRW5kaW5nIENvb3JkaW5hdGVzICovCisjZGVmaW5lIFJFR19MQ01fT1NEX1dJTkUJCSgw
eDQ0KQorCisvKiBPU0QgU3RyZWFtIEZyYW1lIEJ1ZmZlciBTdGFydGluZyBBZGRyZXNzICovCisj
ZGVmaW5lIFJFR19MQ01fT1NEX0JBRERSCQkoMHg0OCkKKworLyogT1NEIFN0cmVhbSBGcmFtZSBC
dWZmZXIgQ29udHJvbCBSZWdpc3RlciAqLworI2RlZmluZSBSRUdfTENNX09TRF9GQkNUUkwJCSgw
eDRjKQorCisvKiBPU0QgT3ZlcmxheSBDb250cm9sIFJlZ2lzdGVyICovCisjZGVmaW5lIFJFR19M
Q01fT1NEX09WRVJMQVkJCSgweDUwKQorCisvKiBPU0QgT3ZlcmxheSBDb2xvci1LZXkgUGF0dGVy
biBSZWdpc3RlciAqLworI2RlZmluZSBSRUdfTENNX09TRF9DS0VZCQkoMHg1NCkKKworLyogT1NE
IE92ZXJsYXkgQ29sb3ItS2V5IE1hc2sgUmVnaXN0ZXIgKi8KKyNkZWZpbmUgUkVHX0xDTV9PU0Rf
Q01BU0sJCSgweDU4KQorCisvKiBPU0QgV2luZG93IFNraXAxIFJlZ2lzdGVyICovCisjZGVmaW5l
IFJFR19MQ01fT1NEX1NLSVAxCQkoMHg1QykKKworLyogT1NEIFdpbmRvdyBTa2lwMiBSZWdpc3Rl
ciAqLworI2RlZmluZSBSRUdfTENNX09TRF9TS0lQMgkJKDB4NjApCisKKy8qIE9TRCBob3Jpem9u
dGFsIHVwIHNjYWxpbmcgY29udHJvbCByZWdpc3RlciAqLworI2RlZmluZSBSRUdfTENNX09TRF9T
Q0FMRQkJKDB4NjQpCisKKy8qIE1QVSBWc3luYyBjb250cm9sIHJlZ2lzdGVyICovCisjZGVmaW5l
IFJFR19MQ01fTVBVX1ZTWU5DCQkoMHg2OCkKKworLyogSGFyZHdhcmUgY3Vyc29yIGNvbnRyb2wg
UmVnaXN0ZXIgKi8KKyNkZWZpbmUgUkVHX0xDTV9IQ19DVFJMCQkJKDB4NkMpCisKKy8qIEhhcmR3
YXJlIGN1cnNvdCB0aXAgcG9pbnQgcG90aXNvbiBvbiB2YSBwaWN0dXJlICovCisjZGVmaW5lIFJF
R19MQ01fSENfUE9TCQkJKDB4NzApCisKKy8qIEhhcmR3YXJlIEN1cnNvciBXaW5kb3cgQnVmZmVy
IENvbnRyb2wgUmVnaXN0ZXIgKi8KKyNkZWZpbmUgUkVHX0xDTV9IQ19XQkNUUkwJCSgweDc0KQor
CisvKiBIYXJkd2FyZSBjdXJzb3IgbWVtb3J5IGJhc2UgYWRkcmVzcyByZWdpc3RlciAqLworI2Rl
ZmluZSBSRUdfTENNX0hDX0JBRERSCQkoMHg3OCkKKworLyogSGFyZHdhcmUgY3Vyc29yIGNvbG9y
IHJhbSByZWdpc3RlciBtYXBwZWQgdG8gYnBwID0gMCAqLworI2RlZmluZSBSRUdfTENNX0hDX0NP
TE9SMAkJKDB4N0MpCisKKy8qIEhhcmR3YXJlIGN1cnNvciBjb2xvciByYW0gcmVnaXN0ZXIgbWFw
cGVkIHRvIGJwcCA9IDEgKi8KKyNkZWZpbmUgUkVHX0xDTV9IQ19DT0xPUjEJCSgweDgwKQorCisv
KiBIYXJkd2FyZSBjdXJzb3IgY29sb3IgcmFtIHJlZ2lzdGVyIG1hcHBlZCB0byBicHAgPSAyICov
CisjZGVmaW5lIFJFR19MQ01fSENfQ09MT1IyCQkoMHg4NCkKKworLyogSGFyZHdhcmUgY3Vyc29y
IGNvbG9yIHJhbSByZWdpc3RlciBtYXBwZWQgdG8gYnBwID0gMyAqLworI2RlZmluZSBSRUdfTENN
X0hDX0NPTE9SMwkJKDB4ODgpCisKKyNlbmRpZiAvKiBfX0FTTV9BUk1fVzkwWDkwMF9SRUdTX0xE
TV9IICovCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXc5MHg5MDAvbWFjaC1udWM5NTBldmIu
YyBiL2FyY2gvYXJtL21hY2gtdzkweDkwMC9tYWNoLW51Yzk1MGV2Yi5jCmluZGV4IGNlZjkwM2Iu
LmIzZWRjM2MgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtdzkweDkwMC9tYWNoLW51Yzk1MGV2
Yi5jCisrKyBiL2FyY2gvYXJtL21hY2gtdzkweDkwMC9tYWNoLW51Yzk1MGV2Yi5jCkBAIC0xMCw2
ICsxMCw4IEBACiAgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRp
c3RyaWJ1dGUgaXQgYW5kL29yCiAgKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcwogICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb247dmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLgorICogICBoaXN0b3J5
OgorICogICAgIFdhbmcgUWlhbmcgKHJ1cmFsaXR5LmxpbnV4QGdtYWlsLmNvbSkgYWRkIExDRCBz
dXBwb3J0CiAgKgogICovCiAKQEAgLTE4LDkgKzIwLDUxIEBACiAjaW5jbHVkZSA8YXNtL21hY2gv
bWFwLmg+CiAjaW5jbHVkZSA8YXNtL21hY2gtdHlwZXMuaD4KICNpbmNsdWRlIDxtYWNoL21hcC5o
PgorI2luY2x1ZGUgPG1hY2gvcmVncy1sZG0uaD4KKyNpbmNsdWRlIDxtYWNoL2ZiLmg+CiAKICNp
bmNsdWRlICJudWM5NTAuaCIKIAorI2lmZGVmIENPTkZJR19GQl9OVUM5MDAKKy8qIExDRCBDb250
cm9sbGVyICovCitzdGF0aWMgc3RydWN0IG51YzkwMGZiX2Rpc3BsYXkgX19pbml0ZGF0YSBudWM5
NTBfbGNkX2luZm9bXSA9IHsKKwkvKiBHaWFudHBsdXMgVGVjaG5vbG9neSBHUE0xMDQwQTAgMzIw
eDI0MCBDb2xvciBURlQgTENEICovCisJWzBdID0geworCQkudHlwZQkJPSBMQ01fRENDU19WQV9T
UkNfUkdCNTY1LAorCQkud2lkdGggCQk9IDMyMCwKKwkJLmhlaWdodAkJPSAyNDAsCisJCS54cmVz
CQk9IDMyMCwKKwkJLnlyZXMJCT0gMjQwLAorCQkuYnBwCQk9IDE2LAorCQkucGl4Y2xvY2sJPSAy
MDAwMDAsCisJCS5sZWZ0X21hcmdpbgk9IDM0LAorCQkucmlnaHRfbWFyZ2luICAgPSA1NCwKKwkJ
LmhzeW5jX2xlbgk9IDEwLAorCQkudXBwZXJfbWFyZ2luCT0gMTgsCisJCS5sb3dlcl9tYXJnaW4J
PSA0LAorCQkudnN5bmNfbGVuCT0gMSwKKwkJLmRjY3MJCT0gMHg4ZTAwMDQxYSwKKwkJLmRldmN0
bAkJPSAweDA2MDgwMGMwLAorCQkuZmJjdHJsCQk9IDB4MDBhMDAwYTAsCisJCS5zY2FsZQkJPSAw
eDA0MDAwNDAwLAorCX0sCit9OworCitzdGF0aWMgc3RydWN0IG51YzkwMGZiX21hY2hfaW5mbyBu
dWM5NTBfZmJfaW5mbyBfX2luaXRkYXRhID0geworI2lmIGRlZmluZWQoQ09ORklHX0dQTTEwNDBB
MF8zMjBYMjQwKQorCS5kaXNwbGF5cwkJPSAmbnVjOTUwX2xjZF9pbmZvWzBdLAorI2Vsc2UKKwku
ZGlzcGxheXMJCT0gbnVjOTUwX2xjZF9pbmZvLAorI2VuZGlmCisJLm51bV9kaXNwbGF5cyAJCT0g
QVJSQVlfU0laRShudWM5NTBfbGNkX2luZm8pLAorCS5kZWZhdWx0X2Rpc3BsYXkJPSAwLAorCS5n
cGlvX2RpcgkJPSAweDAwMDAwMDA0LAorCS5ncGlvX2Rpcl9tYXNrCQk9IDB4RkZGRkZGRkQsCisJ
LmdwaW9fZGF0YQkJPSAweDAwMDAwMDA0LAorCS5ncGlvX2RhdGFfbWFzawkJPSAweEZGRkZGRkZE
LAorfTsKKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBfX2luaXQgbnVjOTUwZXZiX21hcF9pbyh2b2lk
KQogewogCW51Yzk1MF9tYXBfaW8oKTsKQEAgLTMwLDYgKzc0LDkgQEAgc3RhdGljIHZvaWQgX19p
bml0IG51Yzk1MGV2Yl9tYXBfaW8odm9pZCkKIHN0YXRpYyB2b2lkIF9faW5pdCBudWM5NTBldmJf
aW5pdCh2b2lkKQogewogCW51Yzk1MF9ib2FyZF9pbml0KCk7CisjaWZkZWYgQ09ORklHX0ZCX05V
QzkwMAorCW51YzkwMF9mYl9zZXRfcGxhdGRhdGEoJm51Yzk1MF9mYl9pbmZvKTsKKyNlbmRpZgog
fQogCiBNQUNISU5FX1NUQVJUKFc5MFA5NTBFVkIsICJXOTBQOTUwRVZCIikKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL21hY2gtdzkweDkwMC9udWM5NTAuYyBiL2FyY2gvYXJtL21hY2gtdzkweDkwMC9u
dWM5NTAuYwppbmRleCAxNDk1MDgxLi40ZDFmMWFiIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNo
LXc5MHg5MDAvbnVjOTUwLmMKKysrIGIvYXJjaC9hcm0vbWFjaC13OTB4OTAwL251Yzk1MC5jCkBA
IC0xOCw2ICsxOCw3IEBACiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CiAjaW5j
bHVkZSA8YXNtL21hY2gvbWFwLmg+CiAjaW5jbHVkZSA8bWFjaC9oYXJkd2FyZS5oPgorCiAjaW5j
bHVkZSAiY3B1LmgiCiAKIC8qIGRlZmluZSBzcGVjaWZpYyBDUFUgcGxhdGZvcm0gZGV2aWNlICov
CkBAIC0yNSw2ICsyNiw5IEBACiBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqbnVjOTUw
X2RldltdIF9faW5pdGRhdGEgPSB7CiAJJm51YzkwMF9kZXZpY2Vfa3BpLAogCSZudWM5MDBfZGV2
aWNlX2ZtaSwKKyNpZmRlZiBDT05GSUdfRkJfTlVDOTAwCisJJm51YzkwMF9kZXZpY2VfbGNkLAor
I2VuZGlmCiB9OwogCiAvKiBkZWZpbmUgc3BlY2lmaWMgQ1BVIHBsYXRmb3JtIGlvIG1hcCAqLwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9LY29uZmlnIGIvZHJpdmVycy92aWRlby9LY29uZmln
CmluZGV4IDVhNWMzMDMuLmE5NDNlNWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vS2NvbmZp
ZworKysgYi9kcml2ZXJzL3ZpZGVvL0tjb25maWcKQEAgLTE5NDUsNiArMTk0NSwyNyBAQCBjb25m
aWcgRkJfUzNDMjQxMF9ERUJVRwogCSAgVHVybiBvbiBkZWJ1Z2dpbmcgbWVzc2FnZXMuIE5vdGUg
dGhhdCB5b3UgY2FuIHNldC91bnNldCBhdCBydW4gdGltZQogCSAgdGhyb3VnaCBzeXNmcwogCitj
b25maWcgRkJfTlVDOTAwCisgICAgICAgIGJvb2wgIk5VQzkwMCBMQ0QgZnJhbWVidWZmZXIgc3Vw
cG9ydCIKKyAgICAgICAgZGVwZW5kcyBvbiBGQiAmJiBBUkNIX1c5MFg5MDAKKyAgICAgICAgc2Vs
ZWN0IEZCX0NGQl9GSUxMUkVDVAorICAgICAgICBzZWxlY3QgRkJfQ0ZCX0NPUFlBUkVBCisgICAg
ICAgIHNlbGVjdCBGQl9DRkJfSU1BR0VCTElUCisgICAgICAgIC0tLWhlbHAtLS0KKyAgICAgICAg
ICBGcmFtZSBidWZmZXIgZHJpdmVyIGZvciB0aGUgYnVpbHQtaW4gTENEIGNvbnRyb2xsZXIgaW4g
dGhlIE51dm90b24KKyAgICAgICAgICBOVUM5MDAgcHJvY2Vzc29yCisKK2NvbmZpZyBHUE0xMDQw
QTBfMzIwWDI0MAorICAgICAgICBib29sICJHaWFudHBsdXMgVGVjaG5vbG9neSBHUE0xMDQwQTAg
MzIweDI0MCBDb2xvciBURlQgTENEIgorICAgICAgICBkZXBlbmRzIG9uIEZCX05VQzkwMAorCitj
b25maWcgRkJfTlVDOTAwX0RFQlVHCisgICAgICAgIGJvb2wgIk5VQzkwMCBsY2QgZGVidWcgbWVz
c2FnZXMiCisgICAgICAgIGRlcGVuZHMgb24gRkJfTlVDOTAwCisgICAgICAgIGhlbHAKKyAgICAg
ICAgICBUdXJuIG9uIGRlYnVnZ2luZyBtZXNzYWdlcy4gTm90ZSB0aGF0IHlvdSBjYW4gc2V0L3Vu
c2V0IGF0IHJ1biB0aW1lCisgICAgICAgICAgdGhyb3VnaCBzeXNmcworCiBjb25maWcgRkJfU001
MDEKIAl0cmlzdGF0ZSAiU2lsaWNvbiBNb3Rpb24gU001MDEgZnJhbWVidWZmZXIgc3VwcG9ydCIK
IAlkZXBlbmRzIG9uIEZCICYmIE1GRF9TTTUwMQpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9N
YWtlZmlsZSBiL2RyaXZlcnMvdmlkZW8vTWFrZWZpbGUKaW5kZXggNGVjYjMwYy4uYTQyYWQ1NSAx
MDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9NYWtlZmlsZQorKysgYi9kcml2ZXJzL3ZpZGVvL01h
a2VmaWxlCkBAIC0xMjksNiArMTI5LDcgQEAgb2JqLSQoQ09ORklHX1hFTl9GQkRFVl9GUk9OVEVO
RCkgICs9IHhlbi1mYmZyb250Lm8KIG9iai0kKENPTkZJR19GQl9DQVJNSU5FKSAgICAgICAgICAr
PSBjYXJtaW5lZmIubwogb2JqLSQoQ09ORklHX0ZCX01CODYyWFgpCSAgKz0gbWI4NjJ4eC8KIG9i
ai0kKENPTkZJR19GQl9NU00pICAgICAgICAgICAgICArPSBtc20vCitvYmotJChDT05GSUdfRkJf
TlVDOTAwKSAgICAgICAgICAgKz0gbnVjOTAwZmIubwogCiAjIFBsYXRmb3JtIG9yIGZhbGxiYWNr
IGRyaXZlcnMgZ28gaGVyZQogb2JqLSQoQ09ORklHX0ZCX1VWRVNBKSAgICAgICAgICAgICs9IHV2
ZXNhZmIubwpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9udWM5MDBmYi5jIGIvZHJpdmVycy92
aWRlby9udWM5MDBmYi5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjZiZjBk
NDYKLS0tIC9kZXYvbnVsbAorKysgYi9kcml2ZXJzL3ZpZGVvL251YzkwMGZiLmMKQEAgLTAsMCAr
MSw3NzkgQEAKKy8qCisgKgorICogQ29weXJpZ2h0IChjKSAyMDA5IE51dm90b24gdGVjaG5vbG9n
eSBjb3Jwb3JhdGlvbgorICogQWxsIHJpZ2h0cyByZXNlcnZlZC4KKyAqCisgKiBUaGlzIHByb2dy
YW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlm
eQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBhcyBwdWJsaXNoZWQgYnkKKyAqIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhl
ciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAoYXQgeW91ciBvcHRpb24pIGFueSBs
YXRlciB2ZXJzaW9uLgorICoKKyAqICBEZXNjcmlwdGlvbjoKKyAqICAgIE51dm90b24gTENEIENv
bnRyb2xsZXIgRHJpdmVyCisgKiAgQXV0aG9yOgorICogICAgV2FuZyBRaWFuZyAocnVyYWxpdHku
bGludXhAZ21haWwuY29tKSAyMDA5LzEyLzExCisgKi8KKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4KKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxsaW51eC9lcnJuby5oPgor
I2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPgorI2luY2x1ZGUgPGxpbnV4L21tLmg+CisjaW5jbHVk
ZSA8bGludXgvdHR5Lmg+CisjaW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4
L2RlbGF5Lmg+CisjaW5jbHVkZSA8bGludXgvZmIuaD4KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+
CisjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1
cHQuaD4KKyNpbmNsdWRlIDxsaW51eC93b3JrcXVldWUuaD4KKyNpbmNsdWRlIDxsaW51eC93YWl0
Lmg+CisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgv
Y2xrLmg+CisjaW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPgorI2luY2x1ZGUgPGxpbnV4L2lvLmg+
CisjaW5jbHVkZSA8bGludXgvcG0uaD4KKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KKworI2lu
Y2x1ZGUgPG1hY2gvbWFwLmg+CisjaW5jbHVkZSA8bWFjaC9yZWdzLWNsb2NrLmg+CisjaW5jbHVk
ZSA8bWFjaC9yZWdzLWxkbS5oPgorI2luY2x1ZGUgPG1hY2gvZmIuaD4KKyNpbmNsdWRlIDxtYWNo
L2Nsa2Rldi5oPgorCisjaW5jbHVkZSAibnVjOTAwZmIuaCIKKworCisvKgorICogIEluaXRpYWxp
emUgdGhlIG51YzkwMCB2aWRlbyAoZHVhbCkgYnVmZmVyIGFkZHJlc3MKKyAqLworc3RhdGljIHZv
aWQgbnVjOTAwZmJfc2V0X2xjZGFkZHIoc3RydWN0IGZiX2luZm8gKmluZm8pCit7CisJc3RydWN0
IG51YzkwMGZiX2luZm8gKmZiaSA9IGluZm8tPnBhcjsKKwl2b2lkIF9faW9tZW0gKnJlZ3MgPSBm
YmktPmlvOworCXVuc2lnbmVkIGxvbmcgdmJhZGRyMSwgdmJhZGRyMjsKKworCXZiYWRkcjEgID0g
aW5mby0+Zml4LnNtZW1fc3RhcnQ7CisJdmJhZGRyMiAgPSBpbmZvLT5maXguc21lbV9zdGFydDsK
Kwl2YmFkZHIyICs9IGluZm8tPmZpeC5saW5lX2xlbmd0aCAqIGluZm8tPnZhci55cmVzOworCisJ
Lyogc2V0IGZyYW1idWZmZXIgc3RhcnQgcGh5IGFkZHIqLworCXdyaXRlbCh2YmFkZHIxLCByZWdz
ICsgUkVHX0xDTV9WQV9CQUREUjApOworCXdyaXRlbCh2YmFkZHIyLCByZWdzICsgUkVHX0xDTV9W
QV9CQUREUjEpOworCisJd3JpdGVsKGZiaS0+cmVncy5sY2RfdmFfZmJjdHJsLCByZWdzICsgUkVH
X0xDTV9WQV9GQkNUUkwpOworCXdyaXRlbChmYmktPnJlZ3MubGNkX3ZhX3NjYWxlLCByZWdzICsg
UkVHX0xDTV9WQV9TQ0FMRSk7Cit9CisKKy8qCisgKgljYWxjdWxhdGUgZGl2aWRlciBmb3IgbGNk
IGRpdgorICovCitzdGF0aWMgdW5zaWduZWQgaW50IG51YzkwMGZiX2NhbGNfcGl4Y2xrKHN0cnVj
dCBudWM5MDBmYl9pbmZvICpmYmksCisJCQkJCSB1bnNpZ25lZCBsb25nIHBpeGNsaykKK3sKKwl1
bnNpZ25lZCBsb25nIGNsayA9IGZiaS0+Y2xrX3JhdGU7CisJdW5zaWduZWQgbG9uZyBsb25nIGRp
djsKKworCS8qIHBpeGNsayBpcyBpbiBwaWNzZWNvbmRzLiBvdXIgY2xvY2sgaXMgaW4gSHoqLwor
CS8qIGRpdiA9IChjbGsgKiBwaXhjbGspLzEwXjEyICovCisJZGl2ID0gKHVuc2lnbmVkIGxvbmcg
bG9uZyljbGsgKiBwaXhjbGs7CisJZGl2ID4+PSAxMjsKKwlkb19kaXYoZGl2LCA2MjUgKiA2MjVV
TCAqIDYyNSk7CisKKwlkZXZfZGJnKGZiaS0+ZGV2LCAicGl4Y2xrICVsZCwgZGl2aXNvciBpcyAl
bGxkXG4iLCBwaXhjbGssIGRpdik7CisKKwlyZXR1cm4gZGl2OworfQorCisvKgorICoJQ2hlY2sg
dGhlIHZpZGVvIHBhcmFtcyBvZiAndmFyJy4KKyAqLworc3RhdGljIGludCBudWM5MDBmYl9jaGVj
a192YXIoc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIsCisJCQkgICAgICAgc3RydWN0IGZi
X2luZm8gKmluZm8pCit7CisJc3RydWN0IG51YzkwMGZiX2luZm8gKmZiaSA9IGluZm8tPnBhcjsK
KwlzdHJ1Y3QgbnVjOTAwZmJfbWFjaF9pbmZvICptYWNoX2luZm8gPSBmYmktPmRldi0+cGxhdGZv
cm1fZGF0YTsKKwlzdHJ1Y3QgbnVjOTAwZmJfZGlzcGxheSAqZGlzcGxheSA9IE5VTEw7CisJc3Ry
dWN0IG51YzkwMGZiX2Rpc3BsYXkgKmRlZmF1bHRfZGlzcGxheSA9IG1hY2hfaW5mby0+ZGlzcGxh
eXMgKworCQkJCQkJICAgbWFjaF9pbmZvLT5kZWZhdWx0X2Rpc3BsYXk7CisJaW50IGk7CisKKwlk
ZXZfZGJnKGZiaS0+ZGV2LCAiY2hlY2tfdmFyKHZhcj0lcCwgaW5mbz0lcClcbiIsIHZhciwgaW5m
byk7CisKKwkvKiB2YWxpZGF0ZSB4L3kgcmVzb2x1dGlvbiAqLworCS8qIGNob29zZSBkZWZhdWx0
IG1vZGUgaWYgcG9zc2libGUgKi8KKwlpZiAodmFyLT54cmVzID09IGRlZmF1bHRfZGlzcGxheS0+
eHJlcyAmJgorCSAgICB2YXItPnlyZXMgPT0gZGVmYXVsdF9kaXNwbGF5LT55cmVzICYmCisJICAg
IHZhci0+Yml0c19wZXJfcGl4ZWwgPT0gZGVmYXVsdF9kaXNwbGF5LT5icHApCisJCWRpc3BsYXkg
PSBkZWZhdWx0X2Rpc3BsYXk7CisJZWxzZQorCQlmb3IgKGkgPSAwOyBpIDwgbWFjaF9pbmZvLT5u
dW1fZGlzcGxheXM7IGkrKykKKwkJCWlmICh2YXItPnhyZXMgPT0gbWFjaF9pbmZvLT5kaXNwbGF5
c1tpXS54cmVzICYmCisJCQkgICAgdmFyLT55cmVzID09IG1hY2hfaW5mby0+ZGlzcGxheXNbaV0u
eXJlcyAmJgorCQkJICAgIHZhci0+Yml0c19wZXJfcGl4ZWwgPT0gbWFjaF9pbmZvLT5kaXNwbGF5
c1tpXS5icHApIHsKKwkJCQlkaXNwbGF5ID0gbWFjaF9pbmZvLT5kaXNwbGF5cyArIGk7CisJCQkJ
YnJlYWs7CisJCQl9CisKKwlpZiAoZGlzcGxheSA9PSBOVUxMKSB7CisJCXByaW50ayhLRVJOX0VS
UiAid3JvbmcgcmVzb2x1dGlvbiBvciBkZXB0aCAlZHglZCBhdCAlZCBiaXQgcGVyIHBpeGVsXG4i
LAorCQkJdmFyLT54cmVzLCB2YXItPnlyZXMsIHZhci0+Yml0c19wZXJfcGl4ZWwpOworCQlyZXR1
cm4gLUVJTlZBTDsKKwl9CisKKwkvKiBpdCBzaG91bGQgYmUgdGhlIHNhbWUgc2l6ZSBhcyB0aGUg
ZGlzcGxheSAqLworCXZhci0+eHJlc192aXJ0dWFsCT0gZGlzcGxheS0+eHJlczsKKwl2YXItPnly
ZXNfdmlydHVhbAk9IGRpc3BsYXktPnlyZXM7CisJdmFyLT5oZWlnaHQJCT0gZGlzcGxheS0+aGVp
Z2h0OworCXZhci0+d2lkdGgJCT0gZGlzcGxheS0+d2lkdGg7CisKKwkvKiBjb3B5IGxjZCBzZXR0
aW5ncyAqLworCXZhci0+cGl4Y2xvY2sJCT0gZGlzcGxheS0+cGl4Y2xvY2s7CisJdmFyLT5sZWZ0
X21hcmdpbgk9IGRpc3BsYXktPmxlZnRfbWFyZ2luOworCXZhci0+cmlnaHRfbWFyZ2luCT0gZGlz
cGxheS0+cmlnaHRfbWFyZ2luOworCXZhci0+dXBwZXJfbWFyZ2luCT0gZGlzcGxheS0+dXBwZXJf
bWFyZ2luOworCXZhci0+bG93ZXJfbWFyZ2luCT0gZGlzcGxheS0+bG93ZXJfbWFyZ2luOworCXZh
ci0+dnN5bmNfbGVuCQk9IGRpc3BsYXktPnZzeW5jX2xlbjsKKwl2YXItPmhzeW5jX2xlbgkJPSBk
aXNwbGF5LT5oc3luY19sZW47CisKKwl2YXItPnRyYW5zcC5vZmZzZXQJPSAwOworCXZhci0+dHJh
bnNwLmxlbmd0aAk9IDA7CisKKwlmYmktPnJlZ3MubGNkX2RjY3MgPSBkaXNwbGF5LT5kY2NzOwor
CWZiaS0+cmVncy5sY2RfZGV2aWNlX2N0cmwgPSBkaXNwbGF5LT5kZXZjdGw7CisJZmJpLT5yZWdz
LmxjZF92YV9mYmN0cmwgPSBkaXNwbGF5LT5mYmN0cmw7CisJZmJpLT5yZWdzLmxjZF92YV9zY2Fs
ZSA9IGRpc3BsYXktPnNjYWxlOworCisJLyogc2V0IFIvRy9CIHBvc3Npb25zICovCisJc3dpdGNo
ICh2YXItPmJpdHNfcGVyX3BpeGVsKSB7CisJY2FzZSAxOgorCWNhc2UgMjoKKwljYXNlIDQ6CisJ
Y2FzZSA4OgorCWRlZmF1bHQ6CisJCXZhci0+cmVkLm9mZnNldCAJPSAwOworCQl2YXItPnJlZC5s
ZW5ndGggCT0gdmFyLT5iaXRzX3Blcl9waXhlbDsKKwkJdmFyLT5ncmVlbiAJCT0gdmFyLT5yZWQ7
CisJCXZhci0+Ymx1ZQkJPSB2YXItPnJlZDsKKwkJYnJlYWs7CisJY2FzZSAxMjoKKwkJdmFyLT5y
ZWQubGVuZ3RoCQk9IDQ7CisJCXZhci0+Z3JlZW4ubGVuZ3RoCT0gNDsKKwkJdmFyLT5ibHVlLmxl
bmd0aAk9IDQ7CisJCXZhci0+cmVkLm9mZnNldAkJPSA4OworCQl2YXItPmdyZWVuLm9mZnNldAk9
IDQ7CisJCXZhci0+Ymx1ZS5vZmZzZXQJPSAwOworCQlicmVhazsKKwljYXNlIDE2OgorCQl2YXIt
PnJlZC5sZW5ndGgJCT0gNTsKKwkJdmFyLT5ncmVlbi5sZW5ndGgJPSA2OworCQl2YXItPmJsdWUu
bGVuZ3RoCT0gNTsKKwkJdmFyLT5yZWQub2Zmc2V0CQk9IDExOworCQl2YXItPmdyZWVuLm9mZnNl
dAk9IDU7CisJCXZhci0+Ymx1ZS5vZmZzZXQJPSAwOworCQlicmVhazsKKwljYXNlIDE4OgorCQl2
YXItPnJlZC5sZW5ndGgJCT0gNjsKKwkJdmFyLT5ncmVlbi5sZW5ndGgJPSA2OworCQl2YXItPmJs
dWUubGVuZ3RoCT0gNjsKKwkJdmFyLT5yZWQub2Zmc2V0CQk9IDEyOworCQl2YXItPmdyZWVuLm9m
ZnNldAk9IDY7CisJCXZhci0+Ymx1ZS5vZmZzZXQJPSAwOworCQlicmVhazsKKwljYXNlIDMyOgor
CQl2YXItPnJlZC5sZW5ndGgJCT0gODsKKwkJdmFyLT5ncmVlbi5sZW5ndGgJPSA4OworCQl2YXIt
PmJsdWUubGVuZ3RoCT0gODsKKwkJdmFyLT5yZWQub2Zmc2V0CQk9IDE2OworCQl2YXItPmdyZWVu
Lm9mZnNldAk9IDg7CisJCXZhci0+Ymx1ZS5vZmZzZXQJPSAwOworCQlicmVhazsKKwl9CisKKwly
ZXR1cm4gMDsKK30KKworLyoKKyAqCUNhbGN1bGF0ZSBsY2QgcmVnaXN0ZXIgdmFsdWVzIGZyb20g
dmFyIHNldHRpbmcgJiBzYXZlIGludG8gaHcKKyAqLworc3RhdGljIHZvaWQgbnVjOTAwZmJfY2Fs
Y3VsYXRlX2xjZF9yZWdzKGNvbnN0IHN0cnVjdCBmYl9pbmZvICppbmZvLAorCQkJCQlzdHJ1Y3Qg
bnVjOTAwZmJfaHcgKnJlZ3MpCit7CisJY29uc3Qgc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2
YXIgPSAmaW5mby0+dmFyOworCWludCB2dHQgPSB2YXItPmhlaWdodCArIHZhci0+dXBwZXJfbWFy
Z2luICsgdmFyLT5sb3dlcl9tYXJnaW47CisJaW50IGh0dCA9IHZhci0+d2lkdGggKyB2YXItPmxl
ZnRfbWFyZ2luICsgdmFyLT5yaWdodF9tYXJnaW47CisJaW50IGhzeW5jID0gdmFyLT53aWR0aCAr
IHZhci0+cmlnaHRfbWFyZ2luOworCWludCB2c3luYyA9IHZhci0+aGVpZ2h0ICsgdmFyLT5sb3dl
cl9tYXJnaW47CisKKwlyZWdzLT5sY2RfY3J0Y19zaXplID0gTENNX0NSVENfU0laRV9WVFRWQUwo
dnR0KSB8CisJCQkgICAgICBMQ01fQ1JUQ19TSVpFX0hUVFZBTChodHQpOworCXJlZ3MtPmxjZF9j
cnRjX2RlbmQgPSBMQ01fQ1JUQ19ERU5EX1ZERU5EVkFMKHZhci0+aGVpZ2h0KSB8CisJCQkgICAg
ICBMQ01fQ1JUQ19ERU5EX0hERU5EVkFMKHZhci0+d2lkdGgpOworCXJlZ3MtPmxjZF9jcnRjX2hy
ID0gTENNX0NSVENfSFJfRVZBTCh2YXItPndpZHRoICsgNSkgfAorCQkJICAgIExDTV9DUlRDX0hS
X1NWQUwodmFyLT53aWR0aCArIDEpOworCXJlZ3MtPmxjZF9jcnRjX2hzeW5jID0gTENNX0NSVENf
SFNZTkNfRVZBTChoc3luYyArIHZhci0+aHN5bmNfbGVuKSB8CisJCQkgICAgICAgTENNX0NSVENf
SFNZTkNfU1ZBTChoc3luYyk7CisJcmVncy0+bGNkX2NydGNfdnIgPSBMQ01fQ1JUQ19WUl9FVkFM
KHZzeW5jICsgdmFyLT52c3luY19sZW4pIHwKKwkJCSAgICBMQ01fQ1JUQ19WUl9TVkFMKHZzeW5j
KTsKKworfQorCisvKgorICoJQWN0aXZhdGUgKHNldCkgdGhlIGNvbnRyb2xsZXIgZnJvbSB0aGUg
Z2l2ZW4gZnJhbWVidWZmZXIKKyAqCWluZm9ybWF0aW9uCisgKi8KK3N0YXRpYyB2b2lkIG51Yzkw
MGZiX2FjdGl2YXRlX3ZhcihzdHJ1Y3QgZmJfaW5mbyAqaW5mbykKK3sKKwlzdHJ1Y3QgbnVjOTAw
ZmJfaW5mbyAqZmJpID0gaW5mby0+cGFyOworCXZvaWQgX19pb21lbSAqcmVncyA9IGZiaS0+aW87
CisJc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIgPSAmaW5mby0+dmFyOworCWludCBjbGtk
aXY7CisKKwljbGtkaXYgPSBudWM5MDBmYl9jYWxjX3BpeGNsayhmYmksIHZhci0+cGl4Y2xvY2sp
IC0gMTsKKwlpZiAoY2xrZGl2IDwgMCkKKwkJY2xrZGl2ID0gMDsKKworCW51YzkwMGZiX2NhbGN1
bGF0ZV9sY2RfcmVncyhpbmZvLCAmZmJpLT5yZWdzKTsKKworCS8qIHNldCB0aGUgbmV3IGxjZCBy
ZWdpc3RlcnMqLworCisJZGV2X2RiZyhmYmktPmRldiwgIm5ldyBsY2QgcmVnaXN0ZXIgc2V0Olxu
Iik7CisJZGV2X2RiZyhmYmktPmRldiwgImRjY3MgICAgICAgPSAweCUwOHhcbiIsIGZiaS0+cmVn
cy5sY2RfZGNjcyk7CisJZGV2X2RiZyhmYmktPmRldiwgImRldl9jdGwgICAgPSAweCUwOHhcbiIs
IGZiaS0+cmVncy5sY2RfZGV2aWNlX2N0cmwpOworCWRldl9kYmcoZmJpLT5kZXYsICJjcnRjX3Np
emUgID0gMHglMDh4XG4iLCBmYmktPnJlZ3MubGNkX2NydGNfc2l6ZSk7CisJZGV2X2RiZyhmYmkt
PmRldiwgImNydGNfZGVuZCAgPSAweCUwOHhcbiIsIGZiaS0+cmVncy5sY2RfY3J0Y19kZW5kKTsK
KwlkZXZfZGJnKGZiaS0+ZGV2LCAiY3J0Y19ociAgICA9IDB4JTA4eFxuIiwgZmJpLT5yZWdzLmxj
ZF9jcnRjX2hyKTsKKwlkZXZfZGJnKGZiaS0+ZGV2LCAiY3J0Y19oc3luYyA9IDB4JTA4eFxuIiwg
ZmJpLT5yZWdzLmxjZF9jcnRjX2hzeW5jKTsKKwlkZXZfZGJnKGZiaS0+ZGV2LCAiY3J0Y192ciAg
ICA9IDB4JTA4eFxuIiwgZmJpLT5yZWdzLmxjZF9jcnRjX3ZyKTsKKworCXdyaXRlbChmYmktPnJl
Z3MubGNkX2RldmljZV9jdHJsLCByZWdzICsgUkVHX0xDTV9ERVZfQ1RSTCk7CisJd3JpdGVsKGZi
aS0+cmVncy5sY2RfY3J0Y19zaXplLCByZWdzICsgUkVHX0xDTV9DUlRDX1NJWkUpOworCXdyaXRl
bChmYmktPnJlZ3MubGNkX2NydGNfZGVuZCwgcmVncyArIFJFR19MQ01fQ1JUQ19ERU5EKTsKKwl3
cml0ZWwoZmJpLT5yZWdzLmxjZF9jcnRjX2hyLCByZWdzICsgUkVHX0xDTV9DUlRDX0hSKTsKKwl3
cml0ZWwoZmJpLT5yZWdzLmxjZF9jcnRjX2hzeW5jLCByZWdzICsgUkVHX0xDTV9DUlRDX0hTWU5D
KTsKKwl3cml0ZWwoZmJpLT5yZWdzLmxjZF9jcnRjX3ZyLCByZWdzICsgUkVHX0xDTV9DUlRDX1ZS
KTsKKworCS8qIHNldCBsY2QgYWRkcmVzcyBwb2ludGVycyAqLworCW51YzkwMGZiX3NldF9sY2Rh
ZGRyKGluZm8pOworCisJd3JpdGVsKGZiaS0+cmVncy5sY2RfZGNjcywgcmVncyArIFJFR19MQ01f
RENDUyk7Cit9CisKKy8qCisgKiAgICAgIEFsdGVycyB0aGUgaGFyZHdhcmUgc3RhdGUuCisgKgor
ICovCitzdGF0aWMgaW50IG51YzkwMGZiX3NldF9wYXIoc3RydWN0IGZiX2luZm8gKmluZm8pCit7
CisJc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIgPSAmaW5mby0+dmFyOworCisJc3dpdGNo
ICh2YXItPmJpdHNfcGVyX3BpeGVsKSB7CisJY2FzZSAzMjoKKwljYXNlIDI0OgorCWNhc2UgMTg6
CisJY2FzZSAxNjoKKwljYXNlIDEyOgorCQlpbmZvLT5maXgudmlzdWFsID0gRkJfVklTVUFMX1RS
VUVDT0xPUjsKKwkJYnJlYWs7CisJY2FzZSAxOgorCQlpbmZvLT5maXgudmlzdWFsID0gRkJfVklT
VUFMX01PTk8wMTsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJaW5mby0+Zml4LnZpc3VhbCA9IEZC
X1ZJU1VBTF9QU0VVRE9DT0xPUjsKKwkJYnJlYWs7CisJfQorCisJaW5mby0+Zml4LmxpbmVfbGVu
Z3RoID0gKHZhci0+eHJlc192aXJ0dWFsICogdmFyLT5iaXRzX3Blcl9waXhlbCkgLyA4OworCisJ
LyogYWN0aXZhdGUgdGhpcyBuZXcgY29uZmlndXJhdGlvbiAqLworCW51YzkwMGZiX2FjdGl2YXRl
X3ZhcihpbmZvKTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQg
Y2hhbl90b19maWVsZCh1bnNpZ25lZCBpbnQgY2hhbiwKKwkJCQkJIHN0cnVjdCBmYl9iaXRmaWVs
ZCAqYmYpCit7CisJY2hhbiAmPSAweGZmZmY7CisJY2hhbiA+Pj0gMTYgLSBiZi0+bGVuZ3RoOwor
CXJldHVybiBjaGFuIDw8IGJmLT5vZmZzZXQ7Cit9CisKK3N0YXRpYyBpbnQgbnVjOTAwZmJfc2V0
Y29scmVnKHVuc2lnbmVkIHJlZ25vLAorCQkJICAgICAgIHVuc2lnbmVkIHJlZCwgdW5zaWduZWQg
Z3JlZW4sIHVuc2lnbmVkIGJsdWUsCisJCQkgICAgICAgdW5zaWduZWQgdHJhbnNwLCBzdHJ1Y3Qg
ZmJfaW5mbyAqaW5mbykKK3sKKwl1bnNpZ25lZCBpbnQgdmFsOworCisJc3dpdGNoIChpbmZvLT5m
aXgudmlzdWFsKSB7CisJY2FzZSBGQl9WSVNVQUxfVFJVRUNPTE9SOgorCQkvKiB0cnVlLWNvbG91
ciwgdXNlIHBzZXVvLXBhbGV0dGUgKi8KKwkJaWYgKHJlZ25vIDwgMTYpIHsKKwkJCXUzMiAqcGFs
ID0gaW5mby0+cHNldWRvX3BhbGV0dGU7CisKKwkJCXZhbCAgPSBjaGFuX3RvX2ZpZWxkKHJlZCwg
JmluZm8tPnZhci5yZWQpOworCQkJdmFsIHw9IGNoYW5fdG9fZmllbGQoZ3JlZW4sICZpbmZvLT52
YXIuZ3JlZW4pOworCQkJdmFsIHw9IGNoYW5fdG9fZmllbGQoYmx1ZSwgJmluZm8tPnZhci5ibHVl
KTsKKwkJCXBhbFtyZWdub10gPSB2YWw7CisJCX0KKwkJYnJlYWs7CisKKwlkZWZhdWx0OgorCQly
ZXR1cm4gMTsgICAvKiB1bmtub3duIHR5cGUgKi8KKwl9CisJcmV0dXJuIDA7Cit9CisKKy8qKgor
ICogICAgICBudWM5MDBmYl9ibGFuaworICoKKyAqLworc3RhdGljIGludCBudWM5MDBmYl9ibGFu
ayhpbnQgYmxhbmtfbW9kZSwgc3RydWN0IGZiX2luZm8gKmluZm8pCit7CisKKwlyZXR1cm4gMDsK
K30KKworc3RhdGljIHN0cnVjdCBmYl9vcHMgbnVjOTAwZmJfb3BzID0geworCS5vd25lcgkJCT0g
VEhJU19NT0RVTEUsCisJLmZiX2NoZWNrX3ZhcgkJPSBudWM5MDBmYl9jaGVja192YXIsCisJLmZi
X3NldF9wYXIJCT0gbnVjOTAwZmJfc2V0X3BhciwKKwkuZmJfYmxhbmsJCT0gbnVjOTAwZmJfYmxh
bmssCisJLmZiX3NldGNvbHJlZwkJPSBudWM5MDBmYl9zZXRjb2xyZWcsCisJLmZiX2ZpbGxyZWN0
CQk9IGNmYl9maWxscmVjdCwKKwkuZmJfY29weWFyZWEJCT0gY2ZiX2NvcHlhcmVhLAorCS5mYl9p
bWFnZWJsaXQJCT0gY2ZiX2ltYWdlYmxpdCwKK307CisKKworc3RhdGljIGlubGluZSB2b2lkIG1v
ZGlmeV9ncGlvKHZvaWQgX19pb21lbSAqcmVnLAorCQkJICAgICAgIHVuc2lnbmVkIGxvbmcgc2V0
LCB1bnNpZ25lZCBsb25nIG1hc2spCit7CisJdW5zaWduZWQgbG9uZyB0bXA7CisJdG1wID0gcmVh
ZGwocmVnKSAmIH5tYXNrOworCXdyaXRlbCh0bXAgfCBzZXQsIHJlZyk7Cit9CisKKy8qCisgKiBJ
bml0aWFsaXNlIExDRC1yZWxhdGVkIHJlZ2lzdGVycworICovCitzdGF0aWMgaW50IG51YzkwMGZi
X2luaXRfcmVnaXN0ZXJzKHN0cnVjdCBmYl9pbmZvICppbmZvKQoreworCXN0cnVjdCBudWM5MDBm
Yl9pbmZvICpmYmkgPSBpbmZvLT5wYXI7CisJc3RydWN0IG51YzkwMGZiX21hY2hfaW5mbyAqbWFj
aF9pbmZvID0gZmJpLT5kZXYtPnBsYXRmb3JtX2RhdGE7CisJdm9pZCBfX2lvbWVtICpyZWdzID0g
ZmJpLT5pbzsKKworCS8qcmVzZXQgdGhlIGRpc3BsYXkgZW5naW5lKi8KKwl3cml0ZWwoMCwgcmVn
cyArIFJFR19MQ01fRENDUyk7CisJd3JpdGVsKHJlYWRsKHJlZ3MgKyBSRUdfTENNX0RDQ1MpIHwg
TENNX0RDQ1NfRU5HX1JTVCwKKwkgICAgICAgcmVncyArIFJFR19MQ01fRENDUyk7CisJbmRlbGF5
KDEwMCk7CisJd3JpdGVsKHJlYWRsKHJlZ3MgKyBSRUdfTENNX0RDQ1MpICYgKH5MQ01fRENDU19F
TkdfUlNUKSwKKwkgICAgICAgcmVncyArIFJFR19MQ01fRENDUyk7CisJbmRlbGF5KDEwMCk7CisK
Kwl3cml0ZWwoMCwgcmVncyArIFJFR19MQ01fREVWX0NUUkwpOworCisJLyogY29uZmlnIGdwaW8g
b3V0cHV0ICovCisJbW9kaWZ5X2dwaW8oVzkwWDkwMF9WQV9HUElPICsgMHg1NCwgbWFjaF9pbmZv
LT5ncGlvX2RpciwKKwkJICAgIG1hY2hfaW5mby0+Z3Bpb19kaXJfbWFzayk7CisJbW9kaWZ5X2dw
aW8oVzkwWDkwMF9WQV9HUElPICsgMHg1OCwgbWFjaF9pbmZvLT5ncGlvX2RhdGEsCisJCSAgICBt
YWNoX2luZm8tPmdwaW9fZGF0YV9tYXNrKTsKKworCXJldHVybiAwOworfQorCisKKy8qCisgKiAg
ICBBbGxvYyB0aGUgU0RSQU0gcmVnaW9uIG9mIE5VQzkwMCBmb3IgdGhlIGZyYW1lIGJ1ZmZlci4K
KyAqICAgIFRoZSBidWZmZXIgc2hvdWxkIGJlIGEgbm9uLWNhY2hlZCwgbm9uLWJ1ZmZlcmVkLCBt
ZW1vcnkgcmVnaW9uCisgKiAgICB0byBhbGxvdyBwYWxldHRlIGFuZCBwaXhlbCB3cml0ZXMgd2l0
aG91dCBmbHVzaGluZyB0aGUgY2FjaGUuCisgKi8KK3N0YXRpYyBpbnQgX19pbml0IG51YzkwMGZi
X21hcF92aWRlb19tZW1vcnkoc3RydWN0IGZiX2luZm8gKmluZm8pCit7CisJc3RydWN0IG51Yzkw
MGZiX2luZm8gKmZiaSA9IGluZm8tPnBhcjsKKwlkbWFfYWRkcl90IG1hcF9kbWE7CisJdW5zaWdu
ZWQgbG9uZyBtYXBfc2l6ZSA9IFBBR0VfQUxJR04oaW5mby0+Zml4LnNtZW1fbGVuKTsKKworCWRl
dl9kYmcoZmJpLT5kZXYsICJudWM5MDBmYl9tYXBfdmlkZW9fbWVtb3J5KGZiaT0lcCkgbWFwX3Np
emUgJWx1XG4iLAorCQlmYmksIG1hcF9zaXplKTsKKworCWluZm8tPnNjcmVlbl9iYXNlID0gZG1h
X2FsbG9jX3dyaXRlY29tYmluZShmYmktPmRldiwgbWFwX3NpemUsCisJCQkJCQkJJm1hcF9kbWEs
IEdGUF9LRVJORUwpOworCisJaWYgKCFpbmZvLT5zY3JlZW5fYmFzZSkKKwkJcmV0dXJuIC1FTk9N
RU07CisKKwltZW1zZXQoaW5mby0+c2NyZWVuX2Jhc2UsIDB4MDAsIG1hcF9zaXplKTsKKwlpbmZv
LT5maXguc21lbV9zdGFydCA9IG1hcF9kbWE7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGlu
bGluZSB2b2lkIG51YzkwMGZiX3VubWFwX3ZpZGVvX21lbW9yeShzdHJ1Y3QgZmJfaW5mbyAqaW5m
bykKK3sKKwlzdHJ1Y3QgbnVjOTAwZmJfaW5mbyAqZmJpID0gaW5mby0+cGFyOworCWRtYV9mcmVl
X3dyaXRlY29tYmluZShmYmktPmRldiwgUEFHRV9BTElHTihpbmZvLT5maXguc21lbV9sZW4pLAor
CQkJICAgICAgaW5mby0+c2NyZWVuX2Jhc2UsIGluZm8tPmZpeC5zbWVtX3N0YXJ0KTsKK30KKwor
c3RhdGljIGlycXJldHVybl90IG51YzkwMGZiX2lycWhhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2
X2lkKQoreworCXN0cnVjdCBudWM5MDBmYl9pbmZvICpmYmkgPSBkZXZfaWQ7CisJdm9pZCBfX2lv
bWVtICpyZWdzID0gZmJpLT5pbzsKKwl2b2lkIF9faW9tZW0gKmlycV9iYXNlID0gZmJpLT5pcnFf
YmFzZTsKKwl1bnNpZ25lZCBsb25nIGxjZGlycSA9IHJlYWRsKHJlZ3MgKyBSRUdfTENNX0lOVF9D
Uyk7CisKKwlpZiAobGNkaXJxICYgTENNX0lOVF9DU19ESVNQX0ZfU1RBVFVTKSB7CisJCXdyaXRl
bChyZWFkbChpcnFfYmFzZSkgfCAxPDwzMCwgaXJxX2Jhc2UpOworCisJCS8qIHdhaXQgVkFfRU4g
bG93ICovCisJCWlmICgocmVhZGwocmVncyArIFJFR19MQ01fRENDUykgJgorCQkgICAgTENNX0RD
Q1NfU0lOR0xFKSA9PSBMQ01fRENDU19TSU5HTEUpCisJCQl3aGlsZSAoKHJlYWRsKHJlZ3MgKyBS
RUdfTENNX0RDQ1MpICYKKwkJCSAgICAgICBMQ01fRENDU19WQV9FTikgPT0gTENNX0RDQ1NfVkFf
RU4pCisJCQkJOworCQkvKiBkaXNwbGF5X291dC1lbmFibGUgKi8KKwkJd3JpdGVsKHJlYWRsKHJl
Z3MgKyBSRUdfTENNX0RDQ1MpIHwgTENNX0RDQ1NfRElTUF9PVVRfRU4sCisJCQlyZWdzICsgUkVH
X0xDTV9EQ0NTKTsKKwkJLyogdmEtZW5hYmxlKi8KKwkJd3JpdGVsKHJlYWRsKHJlZ3MgKyBSRUdf
TENNX0RDQ1MpIHwgTENNX0RDQ1NfVkFfRU4sCisJCQlyZWdzICsgUkVHX0xDTV9EQ0NTKTsKKwl9
IGVsc2UgaWYgKGxjZGlycSAmIExDTV9JTlRfQ1NfVU5ERVJSVU5fSU5UKSB7CisJCXdyaXRlbChy
ZWFkbChpcnFfYmFzZSkgfCBMQ01fSU5UX0NTX1VOREVSUlVOX0lOVCwgaXJxX2Jhc2UpOworCX0g
ZWxzZSBpZiAobGNkaXJxICYgTENNX0lOVF9DU19CVVNfRVJST1JfSU5UKSB7CisJCXdyaXRlbChy
ZWFkbChpcnFfYmFzZSkgfCBMQ01fSU5UX0NTX0JVU19FUlJPUl9JTlQsIGlycV9iYXNlKTsKKwl9
CisKKwlyZXR1cm4gSVJRX0hBTkRMRUQ7Cit9CisKKyNpZmRlZiBDT05GSUdfQ1BVX0ZSRVEKKwor
c3RhdGljIGludCBudWM5MDBmYl9jcHVmcmVxX3RyYW5zaXRpb24oc3RydWN0IG5vdGlmaWVyX2Js
b2NrICpuYiwKKwkJCQkgICAgICAgdW5zaWduZWQgbG9uZyB2YWwsIHZvaWQgKmRhdGEpCit7CisJ
c3RydWN0IG51YzkwMGZiX2luZm8gKmluZm87CisJc3RydWN0IGZiX2luZm8gKmZiaW5mbzsKKwls
b25nIGRlbHRhX2Y7CisJaW5mbyA9IGNvbnRhaW5lcl9vZihuYiwgc3RydWN0IG51YzkwMGZiX2lu
Zm8sIGZyZXFfdHJhbnNpdGlvbik7CisJZmJpbmZvID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEodG9f
cGxhdGZvcm1fZGV2aWNlKGluZm8tPmRldikpOworCisJZGVsdGFfZiA9IGluZm8tPmNsa19yYXRl
IC0gY2xrX2dldF9yYXRlKGluZm8tPmNsayk7CisKKwlpZiAoKHZhbCA9PSBDUFVGUkVRX1BPU1RD
SEFOR0UgJiYgZGVsdGFfZiA+IDApIHx8CisJICAgKHZhbCA9PSBDUFVGUkVRX1BSRUNIQU5HRSAm
JiBkZWx0YV9mIDwgMCkpIHsKKwkJaW5mby0+Y2xrX3JhdGUgPSBjbGtfZ2V0X3JhdGUoaW5mby0+
Y2xrKTsKKwkJbnVjOTAwZmJfYWN0aXZhdGVfdmFyKGZiaW5mbyk7CisJfQorCisJcmV0dXJuIDA7
Cit9CisKK3N0YXRpYyBpbmxpbmUgaW50IG51YzkwMGZiX2NwdWZyZXFfcmVnaXN0ZXIoc3RydWN0
IG51YzkwMGZiX2luZm8gKmZiaSkKK3sKKwlmYmktPmZyZXFfdHJhbnNpdGlvbi5ub3RpZmllcl9j
YWxsID0gbnVjOTAwZmJfY3B1ZnJlcV90cmFuc2l0aW9uOworCXJldHVybiBjcHVmcmVxX3JlZ2lz
dGVyX25vdGlmaWVyKCZmYmktPmZyZXFfdHJhbnNpdGlvbiwKKwkJCQkgIENQVUZSRVFfVFJBTlNJ
VElPTl9OT1RJRklFUik7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBudWM5MDBmYl9jcHVmcmVx
X2RlcmVnaXN0ZXIoc3RydWN0IG51YzkwMGZiX2luZm8gKmZiaSkKK3sKKwljcHVmcmVxX3VucmVn
aXN0ZXJfbm90aWZpZXIoJmZiaS0+ZnJlcV90cmFuc2l0aW9uLAorCQkJCSAgICBDUFVGUkVRX1RS
QU5TSVRJT05fTk9USUZJRVIpOworfQorI2Vsc2UKK3N0YXRpYyBpbmxpbmUgaW50IG51YzkwMGZi
X2NwdWZyZXFfdHJhbnNpdGlvbihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLAorCQkJCSAgICAg
ICB1bnNpZ25lZCBsb25nIHZhbCwgdm9pZCAqZGF0YSkKK3sKKwlyZXR1cm4gMDsKK30KKworc3Rh
dGljIGlubGluZSBpbnQgbnVjOTAwZmJfY3B1ZnJlcV9yZWdpc3RlcihzdHJ1Y3QgbnVjOTAwZmJf
aW5mbyAqZmJpKQoreworCXJldHVybiAwOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgbnVjOTAw
ZmJfY3B1ZnJlcV9kZXJlZ2lzdGVyKHN0cnVjdCBudWM5MDBmYl9pbmZvICppbmZvKQoreworfQor
I2VuZGlmCisKK3N0YXRpYyBjaGFyIGRyaXZlcl9uYW1lW10gPSAibnVjOTAwZmIiOworCitzdGF0
aWMgaW50IF9fZGV2aW5pdCBudWM5MDBmYl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQoreworCXN0cnVjdCBudWM5MDBmYl9pbmZvICpmYmk7CisJc3RydWN0IG51YzkwMGZiX2Rp
c3BsYXkgKmRpc3BsYXk7CisJc3RydWN0IGZiX2luZm8JICAgKmZiaW5mbzsKKwlzdHJ1Y3QgbnVj
OTAwZmJfbWFjaF9pbmZvICptYWNoX2luZm87CisJc3RydWN0IHJlc291cmNlICpyZXM7CisJaW50
IHJldDsKKwlpbnQgaXJxOworCWludCBpOworCWludCBzaXplOworCisJZGV2X2RiZygmcGRldi0+
ZGV2LCAiZGV2aW5pdFxuIik7CisJbWFjaF9pbmZvID0gcGRldi0+ZGV2LnBsYXRmb3JtX2RhdGE7
CisJaWYgKG1hY2hfaW5mbyA9PSBOVUxMKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwKKwkJCSJu
byBwbGF0Zm9ybSBkYXRhIGZvciBsY2QsIGNhbm5vdCBhdHRhY2hcbiIpOworCQlyZXR1cm4gLUVJ
TlZBTDsKKwl9CisKKwlpZiAobWFjaF9pbmZvLT5kZWZhdWx0X2Rpc3BsYXkgPiBtYWNoX2luZm8t
Pm51bV9kaXNwbGF5cykgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsCisJCQkiZGVmYXVsdCBkaXNw
bGF5IE5vLiBpcyAlZCBidXQgb25seSAlZCBkaXNwbGF5cyBcbiIsCisJCQltYWNoX2luZm8tPmRl
ZmF1bHRfZGlzcGxheSwgbWFjaF9pbmZvLT5udW1fZGlzcGxheXMpOworCQlyZXR1cm4gLUVJTlZB
TDsKKwl9CisKKworCWRpc3BsYXkgPSBtYWNoX2luZm8tPmRpc3BsYXlzICsgbWFjaF9pbmZvLT5k
ZWZhdWx0X2Rpc3BsYXk7CisKKwlpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOworCWlm
IChpcnEgPCAwKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgIm5vIGlycSBmb3IgZGV2aWNlXG4i
KTsKKwkJcmV0dXJuIC1FTk9FTlQ7CisJfQorCisJZmJpbmZvID0gZnJhbWVidWZmZXJfYWxsb2Mo
c2l6ZW9mKHN0cnVjdCBudWM5MDBmYl9pbmZvKSwgJnBkZXYtPmRldik7CisJaWYgKCFmYmluZm8p
CisJCXJldHVybiAtRU5PTUVNOworCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZmJpbmZv
KTsKKworCWZiaSA9IGZiaW5mby0+cGFyOworCWZiaS0+ZGV2ID0gJnBkZXYtPmRldjsKKworI2lm
ZGVmIENPTkZJR19DUFVfTlVDOTUwCisJZmJpLT5kcnZfdHlwZSA9IExDRERSVl9OVUM5NTA7Cisj
ZW5kaWYKKworCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01F
TSwgMCk7CisKKwlzaXplID0gKHJlcy0+ZW5kIC0gcmVzLT5zdGFydCkgKyAxOworCWZiaS0+bWVt
ID0gcmVxdWVzdF9tZW1fcmVnaW9uKHJlcy0+c3RhcnQsIHNpemUsIHBkZXYtPm5hbWUpOworCWlm
IChmYmktPm1lbSA9PSBOVUxMKSB7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byBh
bGxvYyBtZW1vcnkgcmVnaW9uXG4iKTsKKwkJcmV0ID0gLUVOT0VOVDsKKwkJZ290byBmcmVlX2Zi
OworCX0KKworCWZiaS0+aW8gPSBpb3JlbWFwKHJlcy0+c3RhcnQsIHNpemUpOworCWlmIChmYmkt
PmlvID09IE5VTEwpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiaW9yZW1hcCgpIG9mIGxjZCBy
ZWdpc3RlcnMgZmFpbGVkXG4iKTsKKwkJcmV0ID0gLUVOWElPOworCQlnb3RvIHJlbGVhc2VfbWVt
X3JlZ2lvbjsKKwl9CisKKwlmYmktPmlycV9iYXNlID0gZmJpLT5pbyArIFJFR19MQ01fSU5UX0NT
OworCisKKwkvKiBTdG9wIHRoZSBMQ0QgKi8KKwl3cml0ZWwoMCwgZmJpLT5pbyArIFJFR19MQ01f
RENDUyk7CisKKwkvKiBmaWxsIHRoZSBmYmluZm8qLworCXN0cmNweShmYmluZm8tPmZpeC5pZCwg
ZHJpdmVyX25hbWUpOworCWZiaW5mby0+Zml4LnR5cGUJCT0gRkJfVFlQRV9QQUNLRURfUElYRUxT
OworCWZiaW5mby0+Zml4LnR5cGVfYXV4CQk9IDA7CisJZmJpbmZvLT5maXgueHBhbnN0ZXAJCT0g
MDsKKwlmYmluZm8tPmZpeC55cGFuc3RlcAkJPSAwOworCWZiaW5mby0+Zml4Lnl3cmFwc3RlcAkJ
PSAwOworCWZiaW5mby0+Zml4LmFjY2VsCQk9IEZCX0FDQ0VMX05PTkU7CisJZmJpbmZvLT52YXIu
bm9uc3RkCQk9IDA7CisJZmJpbmZvLT52YXIuYWN0aXZhdGUJCT0gRkJfQUNUSVZBVEVfTk9XOwor
CWZiaW5mby0+dmFyLmFjY2VsX2ZsYWdzCQk9IDA7CisJZmJpbmZvLT52YXIudm1vZGUJCT0gRkJf
Vk1PREVfTk9OSU5URVJMQUNFRDsKKwlmYmluZm8tPmZib3BzCQkJPSAmbnVjOTAwZmJfb3BzOwor
CWZiaW5mby0+ZmxhZ3MJCQk9IEZCSU5GT19GTEFHX0RFRkFVTFQ7CisJZmJpbmZvLT5wc2V1ZG9f
cGFsZXR0ZQkJPSAmZmJpLT5wc2V1ZG9fcGFsOworCisJcmV0ID0gcmVxdWVzdF9pcnEoaXJxLCBu
dWM5MDBmYl9pcnFoYW5kbGVyLCBJUlFGX0RJU0FCTEVELAorCQkJICBwZGV2LT5uYW1lLCBmYmlu
Zm8pOworCWlmIChyZXQpIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiY2Fubm90IHJlZ2lzdGVy
IGlycSBoYW5kbGVyICVkIC1lcnIgJWRcbiIsCisJCQlpcnEsIHJldCk7CisJCXJldCA9IC1FQlVT
WTsKKwkJZ290byByZWxlYXNlX3JlZ3M7CisJfQorCisJbnVjOTAwX2RyaXZlcl9jbGtzcmNfZGl2
KCZwZGV2LT5kZXYsICJleHQiLCAweDIpOworCisJZmJpLT5jbGsgPSBjbGtfZ2V0KCZwZGV2LT5k
ZXYsIE5VTEwpOworCWlmICghZmJpLT5jbGsgfHwgSVNfRVJSKGZiaS0+Y2xrKSkgeworCQlwcmlu
dGsoS0VSTl9FUlIgIm51YzkwMC1sY2Q6ZmFpbGVkIHRvIGdldCBsY2QgY2xvY2sgc291cmNlXG4i
KTsKKwkJcmV0ID0gLUVOT0VOVDsKKwkJZ290byByZWxlYXNlX2lycTsKKwl9CisKKwljbGtfZW5h
YmxlKGZiaS0+Y2xrKTsKKwlkZXZfZGJnKCZwZGV2LT5kZXYsICJnb3QgYW5kIGVuYWJsZWQgY2xv
Y2tcbiIpOworCisJZmJpLT5jbGtfcmF0ZSA9IGNsa19nZXRfcmF0ZShmYmktPmNsayk7CisKKwkv
KiBjYWx1dGF0ZSB0aGUgdmlkZW8gYnVmZmVyIHNpemUgKi8KKwlmb3IgKGkgPSAwOyBpIDwgbWFj
aF9pbmZvLT5udW1fZGlzcGxheXM7IGkrKykgeworCQl1bnNpZ25lZCBsb25nIHNtZW1fbGVuID0g
bWFjaF9pbmZvLT5kaXNwbGF5c1tpXS54cmVzOworCQlzbWVtX2xlbiAqPSBtYWNoX2luZm8tPmRp
c3BsYXlzW2ldLnlyZXM7CisJCXNtZW1fbGVuICo9IG1hY2hfaW5mby0+ZGlzcGxheXNbaV0uYnBw
OworCQlzbWVtX2xlbiA+Pj0gMzsKKwkJaWYgKGZiaW5mby0+Zml4LnNtZW1fbGVuIDwgc21lbV9s
ZW4pCisJCQlmYmluZm8tPmZpeC5zbWVtX2xlbiA9IHNtZW1fbGVuOworCX0KKworCS8qIEluaXRp
YWxpemUgVmlkZW8gTWVtb3J5ICovCisJcmV0ID0gbnVjOTAwZmJfbWFwX3ZpZGVvX21lbW9yeShm
YmluZm8pOworCWlmIChyZXQpIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJGYWlsZWQgdG8gYWxsb2Nh
dGUgdmlkZW8gUkFNOiAleFxuIiwgcmV0KTsKKwkJZ290byByZWxlYXNlX2Nsb2NrOworCX0KKwor
CWRldl9kYmcoJnBkZXYtPmRldiwgImdvdCB2aWRlbyBtZW1vcnlcbiIpOworCisJZmJpbmZvLT52
YXIueHJlcyA9IGRpc3BsYXktPnhyZXM7CisJZmJpbmZvLT52YXIueXJlcyA9IGRpc3BsYXktPnly
ZXM7CisJZmJpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwgPSBkaXNwbGF5LT5icHA7CisKKwludWM5
MDBmYl9pbml0X3JlZ2lzdGVycyhmYmluZm8pOworCisJbnVjOTAwZmJfY2hlY2tfdmFyKCZmYmlu
Zm8tPnZhciwgZmJpbmZvKTsKKworCXJldCA9IG51YzkwMGZiX2NwdWZyZXFfcmVnaXN0ZXIoZmJp
KTsKKwlpZiAocmV0IDwgMCkgeworCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVn
aXN0ZXIgY3B1ZnJlcVxuIik7CisJCWdvdG8gZnJlZV92aWRlb19tZW1vcnk7CisJfQorCisJcmV0
ID0gcmVnaXN0ZXJfZnJhbWVidWZmZXIoZmJpbmZvKTsKKwlpZiAocmV0KSB7CisJCXByaW50ayhL
RVJOX0VSUiAiZmFpbGVkIHRvIHJlZ2lzdGVyIGZyYW1lYnVmZmVyIGRldmljZTogJWRcbiIsCisJ
CQlyZXQpOworCQlnb3RvIGZyZWVfY3B1ZnJlcTsKKwl9CisKKwlwcmludGsoS0VSTl9JTkZPICJm
YiVkOiAlcyBmcmFtZSBidWZmZXIgZGV2aWNlXG4iLAorCQlmYmluZm8tPm5vZGUsIGZiaW5mby0+
Zml4LmlkKTsKKworCXJldHVybiAwOworCitmcmVlX2NwdWZyZXE6CisJbnVjOTAwZmJfY3B1ZnJl
cV9kZXJlZ2lzdGVyKGZiaSk7CitmcmVlX3ZpZGVvX21lbW9yeToKKwludWM5MDBmYl91bm1hcF92
aWRlb19tZW1vcnkoZmJpbmZvKTsKK3JlbGVhc2VfY2xvY2s6CisJY2xrX2Rpc2FibGUoZmJpLT5j
bGspOworCWNsa19wdXQoZmJpLT5jbGspOworcmVsZWFzZV9pcnE6CisJZnJlZV9pcnEoaXJxLCBm
YmkpOworcmVsZWFzZV9yZWdzOgorCWlvdW5tYXAoZmJpLT5pbyk7CityZWxlYXNlX21lbV9yZWdp
b246CisJcmVsZWFzZV9tZW1fcmVnaW9uKCh1bnNpZ25lZCBsb25nKWZiaS0+bWVtLCBzaXplKTsK
K2ZyZWVfZmI6CisJZnJhbWVidWZmZXJfcmVsZWFzZShmYmluZm8pOworCXJldHVybiByZXQ7Cit9
CisKKy8qCisgKiBzaHV0ZG93biB0aGUgbGNkIGNvbnRyb2xsZXIKKyAqLworc3RhdGljIHZvaWQg
bnVjOTAwZmJfc3RvcF9sY2Qoc3RydWN0IGZiX2luZm8gKmluZm8pCit7CisJc3RydWN0IG51Yzkw
MGZiX2luZm8gKmZiaSA9IGluZm8tPnBhcjsKKwl2b2lkIF9faW9tZW0gKnJlZ3MgPSBmYmktPmlv
OworCisJd3JpdGVsKCh+TENNX0RDQ1NfRElTUF9JTlRfRU4pIHwgKH5MQ01fRENDU19WQV9FTikg
fCAofkxDTV9EQ0NTX09TRF9FTiksCisJCXJlZ3MgKyBSRUdfTENNX0RDQ1MpOworfQorCisvKgor
ICogIENsZWFudXAKKyAqLworc3RhdGljIGludCBudWM5MDBmYl9yZW1vdmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKK3sKKwlzdHJ1Y3QgZmJfaW5mbyAqZmJpbmZvID0gcGxhdGZvcm1f
Z2V0X2RydmRhdGEocGRldik7CisJc3RydWN0IG51YzkwMGZiX2luZm8gKmZiaSA9IGZiaW5mby0+
cGFyOworCWludCBpcnE7CisKKwludWM5MDBmYl9zdG9wX2xjZChmYmluZm8pOworCW1zbGVlcCgx
KTsKKworCW51YzkwMGZiX3VubWFwX3ZpZGVvX21lbW9yeShmYmluZm8pOworCisJaW91bm1hcChm
YmktPmlvKTsKKworCWlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7CisJZnJlZV9pcnEo
aXJxLCBmYmkpOworCisJcmVsZWFzZV9yZXNvdXJjZShmYmktPm1lbSk7CisJa2ZyZWUoZmJpLT5t
ZW0pOworCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CisJZnJhbWVidWZmZXJf
cmVsZWFzZShmYmluZm8pOworCisJcmV0dXJuIDA7Cit9CisKKyNpZmRlZiBDT05GSUdfUE0KKwor
LyoKKyAqCXN1c3BlbmQgYW5kIHJlc3VtZSBzdXBwb3J0IGZvciB0aGUgbGNkIGNvbnRyb2xsZXIK
KyAqLworCitzdGF0aWMgaW50IG51YzkwMGZiX3N1c3BlbmQoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqZGV2LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCit7CisJc3RydWN0IGZiX2luZm8JICAgKmZiaW5m
byA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKGRldik7CisJc3RydWN0IG51YzkwMGZiX2luZm8gKmlu
Zm8gPSBmYmluZm8tPnBhcjsKKworCW51YzkwMGZiX3N0b3BfbGNkKCk7CisJbXNsZWVwKDEpOwor
CWNsa19kaXNhYmxlKGluZm8tPmNsayk7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgbnVj
OTAwZmJfcmVzdW1lKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikKK3sKKwlzdHJ1Y3QgZmJf
aW5mbwkgICAqZmJpbmZvID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoZGV2KTsKKwlzdHJ1Y3QgbnVj
OTAwZmJfaW5mbyAqZmJpID0gZmJpbmZvLT5wYXI7CisKKwlwcmludGsoS0VSTl9JTkZPICJudWM5
MDBmYiByZXN1bWVcbiIpOworCisJY2xrX2VuYWJsZShmYmktPmNsayk7CisJbXNsZWVwKDEpOwor
CisJbnVjOTAwZmJfaW5pdF9yZWdpc3RlcnMoZmJpbmZvKTsKKwludWM5MDBmYl9hY3RpdmF0ZV92
YXIoYmZpbmZvKTsKKworCXJldHVybiAwOworfQorCisjZWxzZQorI2RlZmluZSBudWM5MDBmYl9z
dXNwZW5kIE5VTEwKKyNkZWZpbmUgbnVjOTAwZmJfcmVzdW1lICBOVUxMCisjZW5kaWYKKworc3Rh
dGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbnVjOTAwZmJfZHJpdmVyID0geworCS5wcm9iZQkJ
PSBudWM5MDBmYl9wcm9iZSwKKwkucmVtb3ZlCQk9IG51YzkwMGZiX3JlbW92ZSwKKwkuc3VzcGVu
ZAk9IG51YzkwMGZiX3N1c3BlbmQsCisJLnJlc3VtZQkJPSBudWM5MDBmYl9yZXN1bWUsCisJLmRy
aXZlcgkJPSB7CisJCS5uYW1lCT0gIm51YzkwMC1sY2QiLAorCQkub3duZXIJPSBUSElTX01PRFVM
RSwKKwl9LAorfTsKKworaW50IF9fZGV2aW5pdCBudWM5MDBmYl9pbml0KHZvaWQpCit7CisJcmV0
dXJuIHBsYXRmb3JtX2RyaXZlcl9yZWdpc3RlcigmbnVjOTAwZmJfZHJpdmVyKTsKK30KKworc3Rh
dGljIHZvaWQgX19leGl0IG51YzkwMGZiX2NsZWFudXAodm9pZCkKK3sKKwlwbGF0Zm9ybV9kcml2
ZXJfdW5yZWdpc3RlcigmbnVjOTAwZmJfZHJpdmVyKTsKK30KKworbW9kdWxlX2luaXQobnVjOTAw
ZmJfaW5pdCk7Cittb2R1bGVfZXhpdChudWM5MDBmYl9jbGVhbnVwKTsKKworTU9EVUxFX0RFU0NS
SVBUSU9OKCJGcmFtZWJ1ZmZlciBkcml2ZXIgZm9yIHRoZSBOVUM5MDAiKTsKK01PRFVMRV9MSUNF
TlNFKCJHUEwiKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vbnVjOTAwZmIuaCBiL2RyaXZl
cnMvdmlkZW8vbnVjOTAwZmIuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi42
YzIzYWEzCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy92aWRlby9udWM5MDBmYi5oCkBAIC0w
LDAgKzEsNTUgQEAKKy8qCisgKgorICogQ29weXJpZ2h0IChjKSAyMDA5IE51dm90b24gdGVjaG5v
bG9neSBjb3Jwb3JhdGlvbgorICogQWxsIHJpZ2h0cyByZXNlcnZlZC4KKyAqCisgKiBUaGlzIHBy
b2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1v
ZGlmeQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVp
dGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAoYXQgeW91ciBvcHRpb24pIGFu
eSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICAgQXV0aGVyOgorICogICAgICAgIFdhbmcgUWlhbmco
cnVyYWxpdHkubGludXhAZ21haWwuY29tKSAgMjAwOS8xMi8xNgorICovCisKKyNpZm5kZWYgX19O
VUM5MDBGQl9ICisjZGVmaW5lIF9fTlVDOTAwRkJfSAorCisjaW5jbHVkZSA8bWFjaC9tYXAuaD4K
KyNpbmNsdWRlIDxtYWNoL2ZiLmg+CisKK2VudW0gbnVjOTAwX2xjZGRydl90eXBlIHsKKwlMQ0RE
UlZfTlVDOTEwLAorCUxDRERSVl9OVUM5MzAsCisJTENERFJWX05VQzkzMiwKKwlMQ0REUlZfTlVD
OTUwLAorCUxDRERSVl9OVUM5NjAsCit9OworCisKKyNkZWZpbmUgUEFMRVRURV9CVUZGRVJfU0la
RQkyNTYKKyNkZWZpbmUgUEFMRVRURV9CVUZGX0NMRUFSIAkoMHg4MDAwMDAwMCkgLyogZW50cnkg
aXMgY2xlYXIvaW52YWxpZCAqLworCitzdHJ1Y3QgbnVjOTAwZmJfaW5mbyB7CisJc3RydWN0IGRl
dmljZQkJKmRldjsKKwlzdHJ1Y3QgY2xrCQkqY2xrOworCisJc3RydWN0IHJlc291cmNlCQkqbWVt
OworCXZvaWQgX19pb21lbQkJKmlvOworCXZvaWQgX19pb21lbQkJKmlycV9iYXNlOworCWludCAJ
CQlkcnZfdHlwZTsKKwlzdHJ1Y3QgbnVjOTAwZmJfaHcJcmVnczsKKwl1bnNpZ25lZCBsb25nCQlj
bGtfcmF0ZTsKKworI2lmZGVmIENPTkZJR19DUFVfRlJFUQorCXN0cnVjdCBub3RpZmllcl9ibG9j
awlmcmVxX3RyYW5zaXRpb247CisjZW5kaWYKKworCS8qIGtlZXAgdGhlc2UgcmVnaXN0ZXJzIGlu
IGNhc2Ugd2UgbmVlZCB0byByZS13cml0ZSBwYWxldHRlICovCisJdTMyCQkJcGFsZXR0ZV9idWZm
ZXJbUEFMRVRURV9CVUZGRVJfU0laRV07CisJdTMyCQkJcHNldWRvX3BhbFsxNl07Cit9OworCitp
bnQgbnVjOTAwZmJfaW5pdCh2b2lkKTsKKworI2VuZGlmIC8qIF9fTlVDOTAwRkJfSCAqLwotLSAK
MS42LjQKCg==
--00235429d8fcf872db047e972b47--
