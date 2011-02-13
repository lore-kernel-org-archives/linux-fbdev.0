From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Sun, 13 Feb 2011 01:12:30 +0000
Subject: Question wrt custom LCD controller protocol
Message-Id: <4D572FFE.2070405@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010404090408070103010009"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

This is a multi-part message in MIME format.
--------------010404090408070103010009
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm trying to add SLCD support for the Jz4740 LCD controller, which has a 
"custom" interface allowing communication (8-18bit, serial/parallel) from CPU to 
LCD panel through some registers.

As this differs from how other LCD panels are currently implemented in Linux 
(mostly using SPI), and as my board needs LCD initialization, I've exported 
functions from the jz4740 FB driver which can be used by 
drivers/video/backlight/*.c users.

However, the problem I'm currently facing is that the LCD panel driver gets 
loaded prior to the framebuffer, which obviously can't work as the LCD 
controller IP hasn't been initialized yet.

I've considered the possibility of emulating an SPI master driver on-top of the 
LCD controller, but this seems like a lot of boiler-plate for not much added 
benefit.

I've looked into tricking the driver base code getting to probe the framebuffer 
before the LCD panel driver, but AFAICS this can only be reliably done by making 
the framebuffer a bus and the LCD panel its child (simply setting the 
framebuffer as its parent doesn't work).

I've attached a patch containing my current implementation.

Any pointers would be appreciated.

-- 
Maurus Cuelenaere

--------------010404090408070103010009
Content-Type: text/x-patch;
 name="jz4740-slcd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jz4740-slcd.diff"

diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
index 6a50e6f..18af90e 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_fb.h
@@ -30,8 +30,17 @@ enum jz4740_fb_lcd_type {
 	JZ_LCD_TYPE_DUAL_COLOR_STN = 10,
 	JZ_LCD_TYPE_DUAL_MONOCHROME_STN = 11,
 	JZ_LCD_TYPE_8BIT_SERIAL = 12,
+
+	JZ_SLCD_TYPE_PARALLEL_8_BIT = 1 | (1 << 5),
+	JZ_SLCD_TYPE_PARALLEL_16_BIT = 0 | (1 << 5),
+	JZ_SLCD_TYPE_PARALLEL_18_BIT = 2 | (1 << 5),
+	JZ_SLCD_TYPE_SERIAL_8_BIT = 1 | (3 << 5),
+	JZ_SLCD_TYPE_SERIAL_16_BIT = 0 | (3 << 5),
+	JZ_SLCD_TYPE_SERIAL_18_BIT = 2 | (3 << 5),
 };
 
+#define JZ4740_FB_IS_SLCD_TYPE(type) ((type) & (1 << 5))
+#define JZ4740_FB_IS_SLCD_SERIAL_TYPE(type) ((type) & (2 << 5))
 #define JZ4740_FB_SPECIAL_TFT_CONFIG(start, stop) (((start) << 16) | (stop))
 
 /*
@@ -62,6 +71,20 @@ struct jz4740_fb_platform_data {
 
 	unsigned pixclk_falling_edge:1;
 	unsigned date_enable_active_low:1;
+	unsigned chip_select_active_low:1;
+	unsigned register_select_active_low:1;
 };
 
+struct platform_device;
+
+extern void jz4740_fb_slcd_disable_transfer(struct platform_device *pdev);
+extern void jz4740_fb_slcd_enable_transfer(struct platform_device *pdev);
+extern void jz4740_fb_slcd_send_cmd_data(struct platform_device *pdev,
+					 unsigned int cmd, unsigned int data);
+extern void jz4740_fb_slcd_send_cmd(struct platform_device *pdev,
+				    unsigned int cmd);
+
 #endif
diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
index 3e7141f..cc6f9f2 100644
--- a/arch/mips/jz4740/Kconfig
+++ b/arch/mips/jz4740/Kconfig
@@ -6,6 +6,9 @@ choice
 config JZ4740_QI_LB60
 	bool "Qi Hardware Ben NanoNote"
 
+config JZ4740_ONDAVX747
+	bool "Onda VX747"
+
 endchoice
 
 config HAVE_PWM
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index a604eae..2d6512c 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_DEBUG_FS) += clock-debugfs.o
 # board specific support
 
 obj-$(CONFIG_JZ4740_QI_LB60)	+= board-qi_lb60.o
+obj-$(CONFIG_JZ4740_ONDAVX747)	+= board-ondavx747.o
 
 # PM support
 
diff --git a/arch/mips/jz4740/board-ondavx747.c b/arch/mips/jz4740/board-ondavx747.c
new file mode 100644
index 0000000..1baa931
--- /dev/null
+++ b/arch/mips/jz4740/board-ondavx747.c
@@ -0,0 +1,263 @@
+/*
+ * linux/arch/mips/jz4740/board-ondavx747.c
+ *
+ * Onda VX747 board support
+ *
+ * Copyright (c) 2010 Maurus Cuelenaere <mcuelenaere@gmail.com>
+ *  based on board-qi_lb60.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or later
+ * as published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+
+#include <video/truly_g240400rtsw.h>
+
+#include <asm/mach-jz4740/jz4740_fb.h>
+#include <asm/mach-jz4740/platform.h>
+
+#include "clock.h"
+
+/* Display */
+static struct fb_videomode ondavx747_video_modes[] = {
+	{
+		.name = "240x400",
+		.xres = 240,
+		.yres = 400,
+		.refresh = 36*1000000,
+		.vmode = FB_VMODE_NONINTERLACED,
+	},
+};
+
+static struct jz4740_fb_platform_data ondavx747_fb_pdata = {
+	.modes				= ondavx747_video_modes,
+	.num_modes			= ARRAY_SIZE(ondavx747_video_modes),
+	.bpp				= 16,
+	.lcd_type			= JZ_SLCD_TYPE_PARALLEL_16_BIT,
+	.pixclk_falling_edge		= 1,
+	.chip_select_active_low		= 1,
+	.register_select_active_low	= 1,
+};
+
+static struct g240400_pdata ondavx747_lcd_pdata __initdata = {
+	.jz4740_fb		= &jz4740_framebuffer_device,
+	.default_mode		= ondavx747_video_modes,
+	.gpio_cs		= JZ_GPIO_PORTB(17),
+	.gpio_reset		= JZ_GPIO_PORTB(18),
+};
+
+static struct platform_device ondavx747_lcd_device = {
+	.name			= "truly_g240400rtsw",
+	.id			= -1,
+	.dev.platform_data	= &ondavx747_lcd_pdata,
+	.dev.parent		= &jz4740_framebuffer_device.dev,
+};
+
+static struct platform_device *ondavx747_pdevices[] __initdata = {
+	&jz4740_framebuffer_device,
+	&ondavx747_lcd_device,
+};
+
+struct jz4740_clock_board_data jz4740_clock_bdata = {
+	.ext_rate	= 12000000,
+	.rtc_rate	= 32768,
+};
+
+static int __init ondavx747_board_setup(void)
+{
+	jz4740_framebuffer_device.dev.platform_data = &ondavx747_fb_pdata;
+
+	jz4740_serial_device_register();
+
+	return platform_add_devices(ondavx747_pdevices,
+				    ARRAY_SIZE(ondavx747_pdevices));
+}
+arch_initcall(ondavx747_board_setup);
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index e54a337..afa96c2 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -109,6 +109,13 @@ config LCD_S6E63M0
 	  If you have an S6E63M0 LCD Panel, say Y to enable its
 	  LCD control driver.
 
+config LCD_G240400
+	tristate "Truly G240400RTSW LCD Driver"
+	depends on MACH_JZ4740
+	help
+	  If you have a Truly G2400400RTSW LCD panel, say Y to enable its LCD
+	  control driver.
+
 endif # LCD_CLASS_DEVICE
 
 #
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 44c0f81..1e338ce 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_LCD_VGG2432A4)	   += vgg2432a4.o
 obj-$(CONFIG_LCD_TDO24M)	   += tdo24m.o
 obj-$(CONFIG_LCD_TOSA)		   += tosa_lcd.o
 obj-$(CONFIG_LCD_S6E63M0)	+= s6e63m0.o
+obj-$(CONFIG_LCD_G240400)	+= truly_g240400rtsw.o
 
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
 obj-$(CONFIG_BACKLIGHT_ATMEL_PWM)    += atmel-pwm-bl.o
diff --git a/drivers/video/backlight/truly_g240400rtsw.c b/drivers/video/backlight/truly_g240400rtsw.c
new file mode 100644
index 0000000..87c8543
--- /dev/null
+++ b/drivers/video/backlight/truly_g240400rtsw.c
@@ -0,0 +1,446 @@
+#include <linux/backlight.h>
+#include <linux/device.h>
+#include <linux/fb.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/lcd.h>
+
+#include <linux/spi/spi.h>
+
+#include <asm/mach-jz4740/jz4740_fb.h>
+
+#include <video/truly_g240400rtsw.h>
+
+/* Register list */
+#define REG_DEVICE_CODE                  0x000
+#define REG_DRIVER_OUTPUT                0x001
+#define REG_LCD_DR_WAVE_CTRL             0x002
+#define REG_ENTRY_MODE                   0x003
+#define REG_OUTL_SHARP_CTRL              0x006
+#define REG_DISP_CTRL1                   0x007
+#define REG_DISP_CTRL2                   0x008
+#define REG_DISP_CTRL3                   0x009
+#define REG_LPCTRL                       0x00B
+#define REG_EXT_DISP_CTRL1               0x00C
+#define REG_EXT_DISP_CTRL2               0x00F
+#define REG_PAN_INTF_CTRL1               0x010
+#define REG_PAN_INTF_CTRL2               0x011
+#define REG_PAN_INTF_CTRL3               0x012
+#define REG_PAN_INTF_CTRL4               0x020
+#define REG_PAN_INTF_CTRL5               0x021
+#define REG_PAN_INTF_CTRL6               0x022
+#define REG_FRM_MRKR_CTRL                0x090
+
+#define REG_PWR_CTRL1                    0x100
+#define REG_PWR_CTRL2                    0x101
+#define REG_PWR_CTRL3                    0x102
+#define REG_PWR_CTRL4                    0x103
+#define REG_PWR_CTRL5                    0x107
+#define REG_PWR_CTRL6                    0x110
+#define REG_PWR_CTRL7                    0x112
+
+#define REG_RAM_HADDR_SET                0x200
+#define REG_RAM_VADDR_SET                0x201
+#define REG_RW_GRAM                      0x202
+#define REG_RAM_HADDR_START              0x210
+#define REG_RAM_HADDR_END                0x211
+#define REG_RAM_VADDR_START              0x212
+#define REG_RAM_VADDR_END                0x213
+#define REG_RW_NVM                       0x280
+#define REG_VCOM_HVOLTAGE1               0x281
+#define REG_VCOM_HVOLTAGE2               0x282
+
+#define REG_GAMMA_CTRL1                  0x300
+#define REG_GAMMA_CTRL2                  0x301
+#define REG_GAMMA_CTRL3                  0x302
+#define REG_GAMMA_CTRL4                  0x303
+#define REG_GAMMA_CTRL5                  0x304
+#define REG_GAMMA_CTRL6                  0x305
+#define REG_GAMMA_CTRL7                  0x306
+#define REG_GAMMA_CTRL8                  0x307
+#define REG_GAMMA_CTRL9                  0x308
+#define REG_GAMMA_CTRL10                 0x309
+#define REG_GAMMA_CTRL11                 0x30A
+#define REG_GAMMA_CTRL12                 0x30B
+#define REG_GAMMA_CTRL13                 0x30C
+#define REG_GAMMA_CTRL14                 0x30D
+
+#define REG_BIMG_NR_LINE                 0x400
+#define REG_BIMG_DISP_CTRL               0x401
+#define REG_BIMG_VSCROLL_CTRL            0x404
+
+#define REG_PARTIMG1_POS                 0x500
+#define REG_PARTIMG1_RAM_START           0x501
+#define REG_PARTIMG1_RAM_END             0x502
+#define REG_PARTIMG2_POS                 0x503
+#define REG_PARTIMG2_RAM_START           0x504
+#define REG_PARTIMG2_RAM_END             0x505
+
+#define REG_SOFT_RESET                   0x600
+#define REG_ENDIAN_CTRL                  0x606
+#define REG_NVM_ACCESS_CTRL              0x6F0
+
+/* Bits */
+#define DRIVER_OUTPUT_SS_BIT             (1 << 8)
+#define DRIVER_OUTPUT_SM_BIT             (1 << 10)
+
+#define ENTRY_MODE_TRI                   (1 << 15)
+#define ENTRY_MODE_DFM                   (1 << 14)
+#define ENTRY_MODE_BGR                   (1 << 12)
+#define ENTRY_MODE_HWM                   (1 << 9)
+#define ENTRY_MODE_ORG                   (1 << 7)
+#define ENTRY_MODE_VID                   (1 << 5)
+#define ENTRY_MODE_HID                   (1 << 4)
+#define ENTRY_MODE_AM                    (1 << 3)
+#define ENTRY_MODE_EPF(n)                (n & 3)
+
+#define OUTL_SHARP_CTRL_EGMODE           (1 << 15)
+#define OUTL_SHARP_CTRL_AVST(n)          ((n & 7) << 7)
+#define OUTL_SHARP_CTRL_ADST(n)          ((n & 7) << 4)
+#define OUTL_SHARP_CTRL_DTHU(n)          ((n & 3) << 2)
+#define OUTL_SHARP_CTRL_DTHL(n)          (n & 3)
+
+#define DISP_CTRL1_PTDE(n)               ((n & 4) << 12)
+#define DISP_CTRL1_BASEE                 (1 << 8)
+#define DISP_CTRL1_VON                   (1 << 6)
+#define DISP_CTRL1_GON                   (1 << 5)
+#define DISP_CTRL1_DTE                   (1 << 4)
+#define DISP_CTRL1_D(n)                  (n & 3)
+
+#define EXT_DISP_CTRL1_ENC(n)            ((n & 7) << 12)
+#define EXT_DISP_CTRL1_RM(n)             ((n & 1) << 8)
+#define EXT_DISP_CTRL1_DM(n)             ((n & 3) << 4)
+#define EXT_DISP_CTRL1_RIM(n)            (n & 3)
+
+#define PWR_CTRL1_SAP(n)                 ((n & 3) << 13)
+#define PWR_CTRL1_SAPE                   (1 << 12)
+#define PWR_CTRL1_BT(n)                  ((n & 7) << 8)
+#define PWR_CTRL1_APE                    (1 << 7)
+#define PWR_CTRL1_AP(n)                  ((n & 7) << 4)
+#define PWR_CTRL1_DSTB                   (1 << 2)
+#define PWR_CTRL1_SLP                    (1 << 1)
+
+#define SOFT_RESET(n)                    (n << 0)
+
+struct g240400 {
+	struct device			*dev;
+	struct lcd_device		*lcd;
+
+	struct g240400_pdata		pdata;
+
+	int				power;
+};
+
+#define POWER_IS_ON(pwr)		((pwr) <= FB_BLANK_NORMAL)
+
+static void g240400_reset(struct g240400 *lcm)
+{
+	struct platform_device *jzfb = lcm->pdata.jz4740_fb;
+
+	gpio_direction_output(lcm->pdata.gpio_reset, 1);
+	mdelay(2*10);
+	gpio_direction_output(lcm->pdata.gpio_reset, 0);
+	mdelay(2*10);
+	gpio_direction_output(lcm->pdata.gpio_reset, 1);
+	mdelay(2*10);
+
+	jz4740_fb_slcd_disable_transfer(jzfb);
+
+#define i 20
+#define SLEEP(x) mdelay(x/10000)
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_SOFT_RESET, SOFT_RESET(1));
+	//SLEEP(700000);
+	mdelay(2*i);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_SOFT_RESET, SOFT_RESET(0));
+	//SLEEP(700000);
+	mdelay(2*i);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_ENDIAN_CTRL, 0);
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DRIVER_OUTPUT, 0x100);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_LCD_DR_WAVE_CTRL, 0x100);
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_ENTRY_MODE, (ENTRY_MODE_BGR | ENTRY_MODE_HWM /*| ENTRY_MODE_DFM*/ | ENTRY_MODE_VID | ENTRY_MODE_HID));
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL2, 0x503);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL3, 1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_LPCTRL, 0x10);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_EXT_DISP_CTRL1, EXT_DISP_CTRL1_RIM(1)); /* 16-bit RGB interface */
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_EXT_DISP_CTRL2, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL1, DISP_CTRL1_D(1));
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PAN_INTF_CTRL1, 0x12);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PAN_INTF_CTRL2, 0x202);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PAN_INTF_CTRL3, 0x300);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PAN_INTF_CTRL4, 0x21e);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PAN_INTF_CTRL5, 0x202);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PAN_INTF_CTRL6, 0x100);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_FRM_MRKR_CTRL, 0x8000);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PWR_CTRL1, (PWR_CTRL1_SAPE | PWR_CTRL1_BT(6) | PWR_CTRL1_APE | PWR_CTRL1_AP(3)));
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PWR_CTRL2, 0x147);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PWR_CTRL3, 0x1bd);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PWR_CTRL4, 0x2f00);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PWR_CTRL5, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PWR_CTRL6, 1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RW_NVM, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_VCOM_HVOLTAGE1, 6);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_VCOM_HVOLTAGE2, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL1, 0x101);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL2, 0xb27);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL3, 0x132a);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL4, 0x2a13);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL5, 0x270b);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL6, 0x101);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL7, 0x1205);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL8, 0x512);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL9, 5);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL10, 3);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL11, 0xf04);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL12, 0xf00);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL13, 0xf);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_GAMMA_CTRL14, 0x40f);
+	jz4740_fb_slcd_send_cmd_data(jzfb, 0x30e, 0x300);
+	jz4740_fb_slcd_send_cmd_data(jzfb, 0x30f, 0x500);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_BIMG_NR_LINE, 0x3100);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_BIMG_DISP_CTRL, 1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_BIMG_VSCROLL_CTRL, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PARTIMG1_POS, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PARTIMG1_RAM_START, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PARTIMG1_RAM_END, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PARTIMG2_POS, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PARTIMG2_RAM_START, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PARTIMG2_RAM_END, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_ENDIAN_CTRL, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_NVM_ACCESS_CTRL, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, 0x7f0, 0x5420);
+	jz4740_fb_slcd_send_cmd_data(jzfb, 0x7f3, 0x288a);
+	jz4740_fb_slcd_send_cmd_data(jzfb, 0x7f4, 0x22);
+	jz4740_fb_slcd_send_cmd_data(jzfb, 0x7f5, 1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, 0x7f0, 0);
+
+	/* LCD ON */
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL1, (DISP_CTRL1_BASEE | DISP_CTRL1_VON |
+					DISP_CTRL1_GON   | DISP_CTRL1_DTE | DISP_CTRL1_D(3)));
+	//SLEEP(3500000);
+	mdelay(10*i);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL1, (DISP_CTRL1_BASEE | DISP_CTRL1_VON |
+					DISP_CTRL1_GON   | DISP_CTRL1_DTE | DISP_CTRL1_D(2)));
+	//SLEEP(3500000);
+	mdelay(10*i);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL1, (DISP_CTRL1_BASEE | DISP_CTRL1_VON |
+					DISP_CTRL1_GON   | DISP_CTRL1_DTE | DISP_CTRL1_D(3)));
+	//SLEEP(3500000);
+	mdelay(10*i);
+#undef i
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_HADDR_START, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_HADDR_END,   lcm->pdata.default_mode->xres - 1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_VADDR_START, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_VADDR_END,   lcm->pdata.default_mode->yres - 1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_HADDR_SET,   0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_VADDR_SET,   0);
+	jz4740_fb_slcd_send_cmd(jzfb, REG_RW_GRAM); /* write data to GRAM */
+
+	jz4740_fb_slcd_enable_transfer(jzfb);
+}
+
+static void g240400_powerdown(struct g240400 *lcm)
+{
+}
+
+static void g240400_standby(struct g240400 *lcm)
+{
+}
+
+static void g240400_poweron(struct g240400 *lcm)
+{
+}
+
+static int g240400_get_power(struct lcd_device *lcd)
+{
+	struct g240400 *lcm = lcd_get_data(lcd);
+
+	return lcm->power;
+}
+
+static int g240400_set_power(struct lcd_device *lcd, int power)
+{
+	struct g240400 *lcm = lcd_get_data(lcd);
+
+	if (power == lcm->power)
+		return 0;
+
+	if (POWER_IS_ON(power))
+		g240400_poweron(lcm);
+	else
+		g240400_standby(lcm);
+
+	lcm->power = power;
+
+	return 0;
+}
+
+static int g240400_set_mode(struct lcd_device *lcd, struct fb_videomode *mode)
+{
+	struct g240400 *lcm = lcd_get_data(lcd);
+	struct platform_device *jzfb = lcm->pdata.jz4740_fb;
+
+	jz4740_fb_slcd_disable_transfer(jzfb);
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_HADDR_START, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_HADDR_END,   mode->xres - 1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_VADDR_START, 0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_VADDR_END,   mode->yres - 1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_HADDR_SET,   0);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_RAM_VADDR_SET,   0);
+	jz4740_fb_slcd_send_cmd(jzfb, REG_RW_GRAM); /* write data to GRAM */
+
+	jz4740_fb_slcd_enable_transfer(jzfb);
+
+	lcm->pdata.default_mode = mode;
+
+	return 0;
+}
+
+static struct lcd_ops g240400_lcd_ops = {
+	.get_power	= g240400_get_power,
+	.set_power	= g240400_set_power,
+	.set_mode	= g240400_set_mode,
+};
+
+static int __devinit g240400_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct g240400 *lcm;
+	struct lcd_device *lcd;
+	struct g240400_pdata *pdata = pdev->dev.platform_data;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "Platform data wasn't provided!");
+		return -EINVAL;
+	}
+
+	lcm = kzalloc(sizeof(struct g240400), GFP_KERNEL);
+	if (!lcm)
+		return -ENOMEM;
+
+	lcm->dev = &pdev->dev;
+	memcpy(&lcm->pdata, pdata, sizeof(struct g240400_pdata));
+
+	lcd = lcd_device_register("truly_g240400", &pdev->dev, lcm, &g240400_lcd_ops);
+	if (IS_ERR(lcd)) {
+		ret = PTR_ERR(lcd);
+		goto out_free_device;
+	}
+
+	if (gpio_is_valid(lcm->pdata.gpio_reset)) {
+		ret = gpio_request(lcm->pdata.gpio_reset, "lcd reset");
+		if (!ret)
+			goto out_unregister_lcd;
+	}
+
+	if (gpio_is_valid(lcm->pdata.gpio_cs)) {
+		ret = gpio_request(lcm->pdata.gpio_cs, "lcd chip select");
+		if (!ret)
+			goto out_free_pin_cs;
+	}
+
+	dev_set_drvdata(&pdev->dev, lcm);
+
+	/* Always select LCD chip */
+	gpio_direction_output(lcm->pdata.gpio_cs, 0);
+	g240400_reset(lcm);
+
+	return 0;
+
+out_free_pin_cs:
+	if (gpio_is_valid(lcm->pdata.gpio_cs))
+		gpio_free(lcm->pdata.gpio_cs);
+out_unregister_lcd:
+	lcd_device_unregister(lcd);
+out_free_device:
+	kfree(lcm);
+
+	return ret;
+}
+
+static int __devexit g240400_remove(struct platform_device *pdev)
+{
+	struct g240400 *lcm = dev_get_drvdata(&pdev->dev);
+
+	if (gpio_is_valid(lcm->pdata.gpio_reset))
+		gpio_free(lcm->pdata.gpio_reset);
+	if (gpio_is_valid(lcm->pdata.gpio_cs))
+		gpio_free(lcm->pdata.gpio_cs);
+	lcd_device_unregister(lcm->lcd);
+	kfree(lcm);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int g240400_suspend(struct device *dev)
+{
+	struct g240400 *lcm = dev_get_drvdata(dev);
+
+	g240400_powerdown(lcm);
+	gpio_direction_output(lcm->pdata.gpio_cs, 1);
+
+	return 0;
+}
+
+static int g240400_resume(struct device *dev)
+{
+	struct g240400 *lcm = dev_get_drvdata(dev);
+
+	gpio_direction_output(lcm->pdata.gpio_cs, 0);
+	g240400_reset(lcm);
+
+	return 0;
+}
+
+static const struct dev_pm_ops g240400_ops = {
+	.suspend	= g240400_suspend,
+	.resume		= g240400_resume,
+};
+#endif
+
+static struct platform_driver g240400_driver = {
+	.driver		= {
+		.name	= "truly_g240400rtsw",
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &g240400_ops,
+#endif
+	},
+	.probe		= g240400_probe,
+	.remove		= __devexit_p(g240400_remove),
+};
+
+static int __init g240400_init(void)
+{
+	return platform_driver_register(&g240400_driver);
+}
+module_init(g240400_init);
+
+static void __exit g240400_exit(void)
+{
+	platform_driver_unregister(&g240400_driver);
+}
+module_exit(g240400_exit);
diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index f6a0cdc..89e7e58 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -26,6 +26,7 @@
 
 #include <linux/dma-mapping.h>
 
+#include <asm/mach-jz4740/dma.h>
 #include <asm/mach-jz4740/jz4740_fb.h>
 #include <asm/mach-jz4740/gpio.h>
 
@@ -107,6 +108,38 @@
 
 #define JZ_LCD_STATE_DISABLED BIT(0)
 
+#define JZ_REG_SLCD_CFG		0xA0
+#define JZ_REG_SLCD_CTRL	0xA4
+#define JZ_REG_SLCD_STATE	0xA8
+#define JZ_REG_SLCD_DATA	0xAC
+#define JZ_REG_SLCD_FIFO	0xB0
+
+#define JZ_SLCD_CFG_BURST_8_WORD	BIT(14)
+#define JZ_SLCD_CFG_DWIDTH_18		(0 << 10)
+#define JZ_SLCD_CFG_DWIDTH_16		(1 << 10)
+#define JZ_SLCD_CFG_DWIDTH_8_x3		(2 << 10)
+#define JZ_SLCD_CFG_DWIDTH_8_x2		(3 << 10)
+#define JZ_SLCD_CFG_DWIDTH_8_x1		(4 << 10)
+#define JZ_SLCD_CFG_DWIDTH_9_x2		(7 << 10)
+#define JZ_SLCD_CFG_CWIDTH(n)		((n) << 8)
+#define JZ_SLCD_CFG_CWIDTH_16BIT	(0 << 8)
+#define JZ_SLCD_CFG_CWIDTH_8BIT		(1 << 8)
+#define JZ_SLCD_CFG_CWIDTH_18BIT	(2 << 8)
+#define JZ_SLCD_CFG_CS_ACTIVE_HIGH	BIT(4)
+#define JZ_SLCD_CFG_RS_CMD_HIGH		BIT(3)
+#define JZ_SLCD_CFG_CLK_ACTIVE_RISING	BIT(1)
+#define JZ_SLCD_CFG_TYPE_SERIAL		BIT(0)
+
+#define JZ_SLCD_CTRL_DMA_EN		(1 << 0)
+
+#define JZ_SLCD_STATE_BUSY		(1 << 0)
+
+#define JZ_SLCD_DATA_RS_DATA		(0 << 31)
+#define JZ_SLCD_DATA_RS_COMMAND		(1 << 31)
+
+#define JZ_SLCD_FIFO_RS_DATA		(0 << 31)
+#define JZ_SLCD_FIFO_RS_COMMAND		(1 << 31)
+
 struct jzfb_framedesc {
 	uint32_t next;
 	uint32_t addr;
@@ -118,6 +151,7 @@ struct jzfb {
 	struct fb_info *fb;
 	struct platform_device *pdev;
 	void __iomem *base;
+	phys_t phys_base;
 	struct resource *mem;
 	struct jz4740_fb_platform_data *pdata;
 
@@ -126,6 +160,7 @@ struct jzfb {
 	dma_addr_t vidmem_phys;
 	struct jzfb_framedesc *framedesc;
 	dma_addr_t framedesc_phys;
+	struct jz4740_dma_chan *slcd_dma;
 
 	struct clk *ldclk;
 	struct clk *lpclk;
@@ -136,6 +171,8 @@ struct jzfb {
 	uint32_t pseudo_palette[16];
 };
 
+#define JZFB_IS_SLCD(jzfb) JZ4740_FB_IS_SLCD_TYPE((jzfb)->pdata->lcd_type)
+
 static const struct fb_fix_screeninfo jzfb_fix __devinitdata = {
 	.id		= "JZ4740 FB",
 	.type		= FB_TYPE_PACKED_PIXELS,
@@ -178,59 +215,72 @@ static const struct jz_gpio_bulk_request jz_lcd_data_pins[] = {
 	JZ_GPIO_BULK_PIN(LCD_DATA17),
 };
 
-static unsigned int jzfb_num_ctrl_pins(struct jzfb *jzfb)
+enum jzfb_pin_operation {
+	REQUEST_PINS,
+	FREE_PINS,
+	RESUME_PINS,
+	SUSPEND_PINS,
+};
+
+static void jzfb_pins_operation(struct jzfb *jzfb,
+				enum jzfb_pin_operation operation)
 {
-	unsigned int num;
+	unsigned int ctrl_num = 0, data_num = 0, data_start = 0;
 
 	switch (jzfb->pdata->lcd_type) {
 	case JZ_LCD_TYPE_GENERIC_16_BIT:
-		num = 4;
+	case JZ_SLCD_TYPE_PARALLEL_16_BIT:
+		ctrl_num = 4;
+		data_num = 16;
 		break;
 	case JZ_LCD_TYPE_GENERIC_18_BIT:
-		num = 4;
+	case JZ_SLCD_TYPE_PARALLEL_18_BIT:
+		ctrl_num = 4;
+		data_num = 18;
 		break;
 	case JZ_LCD_TYPE_8BIT_SERIAL:
-		num = 3;
+	case JZ_SLCD_TYPE_PARALLEL_8_BIT:
+		ctrl_num = 3;
+		data_num = 8;
 		break;
 	case JZ_LCD_TYPE_SPECIAL_TFT_1:
 	case JZ_LCD_TYPE_SPECIAL_TFT_2:
 	case JZ_LCD_TYPE_SPECIAL_TFT_3:
-		num = 8;
+		ctrl_num = 8;
+		if (jzfb->pdata->bpp == 18)
+			data_num = 18;
+		else
+			data_num = 16;
 		break;
-	default:
-		num = 0;
+	case JZ_SLCD_TYPE_SERIAL_8_BIT:
+	case JZ_SLCD_TYPE_SERIAL_16_BIT:
+	case JZ_SLCD_TYPE_SERIAL_18_BIT:
+		data_start = 15;
+		data_num = 1;
 		break;
 	}
-	return num;
-}
 
-static unsigned int jzfb_num_data_pins(struct jzfb *jzfb)
-{
-	unsigned int num;
+	if (JZFB_IS_SLCD(jzfb))
+		ctrl_num = 3;
 
-	switch (jzfb->pdata->lcd_type) {
-	case JZ_LCD_TYPE_GENERIC_16_BIT:
-		num = 16;
+	switch (operation) {
+	case REQUEST_PINS:
+		jz_gpio_bulk_request(jz_lcd_ctrl_pins, ctrl_num);
+		jz_gpio_bulk_request(&jz_lcd_data_pins[data_start], data_num);
 		break;
-	case JZ_LCD_TYPE_GENERIC_18_BIT:
-		num = 18;
+	case FREE_PINS:
+		jz_gpio_bulk_free(jz_lcd_ctrl_pins, ctrl_num);
+		jz_gpio_bulk_free(&jz_lcd_data_pins[data_start], data_num);
 		break;
-	case JZ_LCD_TYPE_8BIT_SERIAL:
-		num = 8;
+	case RESUME_PINS:
+		jz_gpio_bulk_resume(jz_lcd_ctrl_pins, ctrl_num);
+		jz_gpio_bulk_resume(&jz_lcd_data_pins[data_start], data_num);
 		break;
-	case JZ_LCD_TYPE_SPECIAL_TFT_1:
-	case JZ_LCD_TYPE_SPECIAL_TFT_2:
-	case JZ_LCD_TYPE_SPECIAL_TFT_3:
-		if (jzfb->pdata->bpp == 18)
-			num = 18;
-		else
-			num = 16;
-		break;
-	default:
-		num = 0;
+	case SUSPEND_PINS:
+		jz_gpio_bulk_suspend(jz_lcd_ctrl_pins, ctrl_num);
+		jz_gpio_bulk_suspend(&jz_lcd_data_pins[data_start], data_num);
 		break;
 	}
-	return num;
 }
 
 /* Based on CNVT_TOHW macro from skeletonfb.c */
@@ -347,12 +397,9 @@ static int jzfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fb)
 	return 0;
 }
 
-static int jzfb_set_par(struct fb_info *info)
+static void jzfb_lcd_set_par(struct jzfb *jzfb, struct fb_videomode *mode)
 {
-	struct jzfb *jzfb = info->par;
 	struct jz4740_fb_platform_data *pdata = jzfb->pdata;
-	struct fb_var_screeninfo *var = &info->var;
-	struct fb_videomode *mode;
 	uint16_t hds, vds;
 	uint16_t hde, vde;
 	uint16_t ht, vt;
@@ -360,15 +407,6 @@ static int jzfb_set_par(struct fb_info *info)
 	uint32_t cfg;
 	unsigned long rate;
 
-	mode = jzfb_get_mode(jzfb, var);
-	if (mode == NULL)
-		return -EINVAL;
-
-	if (mode == info->mode)
-		return 0;
-
-	info->mode = mode;
-
 	hds = mode->hsync_len + mode->left_margin;
 	hde = hds + mode->xres;
 	ht = hde + mode->right_margin;
@@ -477,42 +515,199 @@ static int jzfb_set_par(struct fb_info *info)
 
 	clk_set_rate(jzfb->lpclk, rate);
 	clk_set_rate(jzfb->ldclk, rate * 3);
+}
+
+static void jzfb_slcd_set_par(struct jzfb *jzfb, struct fb_videomode *mode)
+{
+	struct jz4740_fb_platform_data *pdata = jzfb->pdata;
+	uint32_t cfg;
+	unsigned long rate;
+
+	cfg = JZ_SLCD_CFG_BURST_8_WORD;
+	cfg |= JZ_SLCD_CFG_CWIDTH(jzfb->pdata->lcd_type & 3);
+
+	if (JZ4740_FB_IS_SLCD_SERIAL_TYPE(jzfb->pdata->lcd_type)) {
+		switch (jzfb->pdata->lcd_type) {
+		case JZ_SLCD_TYPE_SERIAL_8_BIT:
+			cfg |= JZ_SLCD_CFG_DWIDTH_8_x1;
+			break;
+		case JZ_SLCD_TYPE_SERIAL_16_BIT:
+			cfg |= JZ_SLCD_CFG_DWIDTH_16;
+			break;
+		case JZ_SLCD_TYPE_SERIAL_18_BIT:
+			cfg |= JZ_SLCD_CFG_DWIDTH_18;
+			break;
+		}
+		cfg |= JZ_SLCD_CFG_TYPE_SERIAL;
+	} else {
+		switch (jzfb->pdata->bpp) {
+		case 8:
+			cfg |= JZ_SLCD_CFG_DWIDTH_8_x1;
+			break;
+		case 15:
+		case 16:
+			switch (jzfb->pdata->lcd_type) {
+			case JZ_SLCD_TYPE_PARALLEL_8_BIT:
+				cfg |= JZ_SLCD_CFG_DWIDTH_8_x2;
+				break;
+			case JZ_SLCD_TYPE_PARALLEL_16_BIT:
+			case JZ_SLCD_TYPE_PARALLEL_18_BIT:
+				cfg |= JZ_SLCD_CFG_DWIDTH_16;
+				break;
+			}
+			break;
+		case 18:
+			switch (jzfb->pdata->lcd_type) {
+			case JZ_SLCD_TYPE_PARALLEL_8_BIT:
+				cfg |= JZ_SLCD_CFG_DWIDTH_8_x3;
+				break;
+			case JZ_SLCD_TYPE_PARALLEL_16_BIT:
+				cfg |= JZ_SLCD_CFG_DWIDTH_9_x2;
+				break;
+			case JZ_SLCD_TYPE_PARALLEL_18_BIT:
+				cfg |= JZ_SLCD_CFG_DWIDTH_18;
+				break;
+			}
+			break;
+		case 24:
+			/* ??? */
+			cfg |= JZ_SLCD_CFG_DWIDTH_8_x3;
+			break;
+		}
+	}
+
+	if (!pdata->pixclk_falling_edge)
+		cfg |= JZ_SLCD_CFG_CLK_ACTIVE_RISING;
+
+	if (!pdata->chip_select_active_low)
+		cfg |= JZ_SLCD_CFG_CS_ACTIVE_HIGH;
+
+	if (!pdata->register_select_active_low)
+		cfg |= JZ_SLCD_CFG_RS_CMD_HIGH;
+
+	if (mode->pixclock) {
+		rate = PICOS2KHZ(mode->pixclock) * 1000;
+		mode->refresh = rate;
+	} else {
+		rate = mode->refresh;
+		mode->pixclock = KHZ2PICOS(rate / 1000);
+	}
+
+	mutex_lock(&jzfb->lock);
+	if (!jzfb->is_enabled)
+		clk_enable(jzfb->ldclk);
+
+	writel(JZ_LCD_CFG_SLCD, jzfb->base + JZ_REG_LCD_CFG);
+	writel(cfg, jzfb->base + JZ_REG_SLCD_CFG);
+	writel(0, jzfb->base + JZ_REG_SLCD_CTRL);
+
+	if (!jzfb->is_enabled)
+		clk_disable(jzfb->ldclk);
+	mutex_unlock(&jzfb->lock);
+
+	clk_set_rate(jzfb->lpclk, rate);
+	clk_set_rate(jzfb->ldclk, rate * 3);
+}
+
+static int jzfb_set_par(struct fb_info *info)
+{
+	struct jzfb *jzfb = info->par;
+	struct fb_var_screeninfo *var = &info->var;
+	struct fb_videomode *mode;
+
+	mode = jzfb_get_mode(jzfb, var);
+	if (mode == NULL)
+		return -EINVAL;
+
+	if (mode == info->mode)
+		return 0;
+
+	info->mode = mode;
+
+	if (JZFB_IS_SLCD(jzfb))
+		jzfb_slcd_set_par(jzfb, mode);
+	else
+		jzfb_lcd_set_par(jzfb, mode);
 
 	return 0;
 }
 
+static void jzfb_slcd_wait(struct jzfb *jzfb)
+{
+	int timeout = 1000;
+	while (readb(jzfb->base + JZ_REG_SLCD_STATE) & JZ_SLCD_STATE_BUSY
+	       && timeout--)
+	    cpu_relax();
+
+	if (timeout <= 0)
+		dev_warn(&jzfb->pdev->dev, "waiting for SLCD busy timed out!");
+}
+
+static void jzfb_slcd_start_dma(struct jzfb *jzfb)
+{
+	struct fb_info *fb = jzfb->fb;
+	unsigned int length = fb->fix.line_length * fb->mode->yres;
+
+	jzfb_slcd_wait(jzfb);
+
+	jz4740_dma_set_src_addr(jzfb->slcd_dma, jzfb->vidmem_phys);
+	jz4740_dma_set_dst_addr(jzfb->slcd_dma,
+				jzfb->phys_base + JZ_REG_SLCD_FIFO);
+	jz4740_dma_set_transfer_count(jzfb->slcd_dma, length);
+
+	jz4740_dma_enable(jzfb->slcd_dma);
+}
+
+static void jzfb_slcd_dma_callback(struct jz4740_dma_chan *chan, int unk,
+				   void *dev)
+{
+	struct jzfb *jzfb = dev;
+
+	/* FIXME: use DMA descriptors! */
+	jzfb_slcd_start_dma(jzfb);
+}
+
 static void jzfb_enable(struct jzfb *jzfb)
 {
 	uint32_t ctrl;
 
 	clk_enable(jzfb->ldclk);
 
-	jz_gpio_bulk_resume(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
-	jz_gpio_bulk_resume(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
+	if (JZFB_IS_SLCD(jzfb)) {
+		jzfb_slcd_wait(jzfb);
+		writeb(JZ_SLCD_CTRL_DMA_EN, jzfb->base + JZ_REG_SLCD_CTRL);
 
-	writel(0, jzfb->base + JZ_REG_LCD_STATE);
+		jzfb_slcd_start_dma(jzfb);
+	} else {
+		writel(0, jzfb->base + JZ_REG_LCD_STATE);
 
-	writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
+		writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
 
-	ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
-	ctrl |= JZ_LCD_CTRL_ENABLE;
-	ctrl &= ~JZ_LCD_CTRL_DISABLE;
-	writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
+		ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
+		ctrl |= JZ_LCD_CTRL_ENABLE;
+		ctrl &= ~JZ_LCD_CTRL_DISABLE;
+		writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
+	}
 }
 
 static void jzfb_disable(struct jzfb *jzfb)
 {
 	uint32_t ctrl;
 
-	ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
-	ctrl |= JZ_LCD_CTRL_DISABLE;
-	writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
-	do {
-		ctrl = readl(jzfb->base + JZ_REG_LCD_STATE);
-	} while (!(ctrl & JZ_LCD_STATE_DISABLED));
+	if (JZFB_IS_SLCD(jzfb)) {
+		jz4740_dma_disable(jzfb->slcd_dma);
 
-	jz_gpio_bulk_suspend(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
-	jz_gpio_bulk_suspend(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
+		jzfb_slcd_wait(jzfb);
+		writeb(0, jzfb->base + JZ_REG_SLCD_CTRL);
+	} else {
+		ctrl = readl(jzfb->base + JZ_REG_LCD_CTRL);
+		ctrl |= JZ_LCD_CTRL_DISABLE;
+		writel(ctrl, jzfb->base + JZ_REG_LCD_CTRL);
+		do {
+			ctrl = readl(jzfb->base + JZ_REG_LCD_STATE);
+		} while (!(ctrl & JZ_LCD_STATE_DISABLED));
+	}
 
 	clk_disable(jzfb->ldclk);
 }
@@ -565,12 +760,19 @@ static int jzfb_alloc_devmem(struct jzfb *jzfb)
 
 	max_videosize *= jzfb_get_controller_bpp(jzfb) >> 3;
 
-	jzfb->framedesc = dma_alloc_coherent(&jzfb->pdev->dev,
-					sizeof(*jzfb->framedesc),
-					&jzfb->framedesc_phys, GFP_KERNEL);
+	if (!JZFB_IS_SLCD(jzfb)) {
+		jzfb->framedesc = dma_alloc_coherent(&jzfb->pdev->dev,
+						sizeof(*jzfb->framedesc),
+						&jzfb->framedesc_phys,
+						GFP_KERNEL);
 
-	if (!jzfb->framedesc)
-		return -ENOMEM;
+		if (!jzfb->framedesc)
+			return -ENOMEM;
+	} else {
+		jzfb->slcd_dma = jz4740_dma_request(jzfb, "SLCD");
+		if (!jzfb->slcd_dma)
+			return -ENXIO;
+	}
 
 	jzfb->vidmem_size = PAGE_ALIGN(max_videosize);
 	jzfb->vidmem = dma_alloc_coherent(&jzfb->pdev->dev,
@@ -586,17 +788,48 @@ static int jzfb_alloc_devmem(struct jzfb *jzfb)
 		SetPageReserved(virt_to_page(page));
 	}
 
-	jzfb->framedesc->next = jzfb->framedesc_phys;
-	jzfb->framedesc->addr = jzfb->vidmem_phys;
-	jzfb->framedesc->id = 0xdeafbead;
-	jzfb->framedesc->cmd = 0;
-	jzfb->framedesc->cmd |= max_videosize / 4;
+	if (jzfb->framedesc) {
+		jzfb->framedesc->next = jzfb->framedesc_phys;
+		jzfb->framedesc->addr = jzfb->vidmem_phys;
+		jzfb->framedesc->id = 0xdeafbead;
+		jzfb->framedesc->cmd = 0;
+		jzfb->framedesc->cmd |= max_videosize / 4;
+	} else {
+		struct jz4740_dma_config config = {
+			.src_width	= JZ4740_DMA_WIDTH_32BIT,
+			.request_type	= JZ4740_DMA_TYPE_SLCD,
+			.flags		= JZ4740_DMA_SRC_AUTOINC,
+			.mode		= JZ4740_DMA_MODE_SINGLE,
+		};
+
+		switch (jzfb->pdata->bpp) {
+		case 1 ... 8:
+			config.dst_width = JZ4740_DMA_WIDTH_8BIT;
+			config.transfer_size = JZ4740_DMA_TRANSFER_SIZE_1BYTE;
+			break;
+		case 9 ... 16:
+			config.dst_width = JZ4740_DMA_WIDTH_16BIT;
+			config.transfer_size = JZ4740_DMA_TRANSFER_SIZE_2BYTE;
+			break;
+		case 17 ... 32:
+			config.dst_width = JZ4740_DMA_WIDTH_32BIT;
+			config.transfer_size = JZ4740_DMA_TRANSFER_SIZE_4BYTE;
+			break;
+		}
+
+		jz4740_dma_configure(jzfb->slcd_dma, &config);
+		jz4740_dma_set_complete_cb(jzfb->slcd_dma,
+					   jzfb_slcd_dma_callback);
+	}
 
 	return 0;
 
 err_free_framedesc:
-	dma_free_coherent(&jzfb->pdev->dev, sizeof(*jzfb->framedesc),
-				jzfb->framedesc, jzfb->framedesc_phys);
+	if (jzfb->framedesc)
+		dma_free_coherent(&jzfb->pdev->dev, sizeof(*jzfb->framedesc),
+				  jzfb->framedesc, jzfb->framedesc_phys);
+	if (jzfb->slcd_dma)
+		jz4740_dma_free(jzfb->slcd_dma);
 	return -ENOMEM;
 }
 
@@ -604,8 +837,11 @@ static void jzfb_free_devmem(struct jzfb *jzfb)
 {
 	dma_free_coherent(&jzfb->pdev->dev, jzfb->vidmem_size,
 				jzfb->vidmem, jzfb->vidmem_phys);
-	dma_free_coherent(&jzfb->pdev->dev, sizeof(*jzfb->framedesc),
-				jzfb->framedesc, jzfb->framedesc_phys);
+	if (jzfb->framedesc)
+		dma_free_coherent(&jzfb->pdev->dev, sizeof(*jzfb->framedesc),
+				  jzfb->framedesc, jzfb->framedesc_phys);
+	if (jzfb->slcd_dma)
+		jz4740_dma_free(jzfb->slcd_dma);
 }
 
 static struct  fb_ops jzfb_ops = {
@@ -619,6 +855,350 @@ static struct  fb_ops jzfb_ops = {
 	.fb_setcolreg = jzfb_setcolreg,
 };
 
+#define JZ_SLCD_CFG_DWIDTH_MASK    (0x7 << 10)
+#define JZ_SLCD_CFG_CWIDTH_MASK    (0x3 << 8)
+
+/* Send a command without data. */
+static void send_panel_command(struct jzfb *jzfb, u32 cmd)
+{
+  u16 slcd_cfg = readw(jzfb->base + JZ_REG_SLCD_CFG);
+
+  switch (slcd_cfg & JZ_SLCD_CFG_CWIDTH_MASK) {
+  case JZ_SLCD_CFG_CWIDTH_8BIT:
+    jzfb_slcd_wait(jzfb);
+    writel(JZ_SLCD_DATA_RS_COMMAND | ((cmd & 0xff00) >> 8), jzfb->base + JZ_REG_SLCD_DATA);
+    jzfb_slcd_wait(jzfb);
+    writel(JZ_SLCD_DATA_RS_COMMAND | ((cmd & 0xff) >> 0), jzfb->base + JZ_REG_SLCD_DATA);
+    break;
+
+  case JZ_SLCD_CFG_CWIDTH_16BIT:
+    jzfb_slcd_wait(jzfb);
+    writel(JZ_SLCD_DATA_RS_COMMAND | (cmd & 0xffff), jzfb->base + JZ_REG_SLCD_DATA);
+    break;
+
+  case JZ_SLCD_CFG_CWIDTH_18BIT:
+    jzfb_slcd_wait(jzfb);
+    writel(JZ_SLCD_DATA_RS_COMMAND | ((cmd & 0xff00) << 2) | ((cmd & 0xff) << 1), jzfb->base + JZ_REG_SLCD_DATA);
+    break;
+  }
+}
+
+static void send_panel_data(struct jzfb *jzfb, u32 data)
+{
+  u16 slcd_cfg = readw(jzfb->base + JZ_REG_SLCD_CFG);
+
+  switch (slcd_cfg & JZ_SLCD_CFG_DWIDTH_MASK) {
+  case JZ_SLCD_CFG_DWIDTH_18:
+    data = ((data & 0xff) << 1) | ((data & 0xff00) << 2);
+    data = ((data << 6) & 0xfc0000) | ((data << 4) & 0xfc00) | ((data << 2) & 0xfc);
+    break;
+
+  case JZ_SLCD_CFG_DWIDTH_9_x2:
+    data = ((data & 0xff) << 1) | ((data & 0xff00) << 2);
+    data = ((data << 6) & 0xfc0000) | ((data << 4) & 0xfc00) | ((data << 2) & 0xfc);
+    break;
+
+  case JZ_SLCD_CFG_DWIDTH_16:
+  default:
+    data &= 0xffff;
+    break;
+  }
+
+  jzfb_slcd_wait(jzfb);
+  writel(JZ_SLCD_DATA_RS_DATA | data, jzfb->base + JZ_REG_SLCD_DATA);
+}
+
+void jz4740_fb_slcd_disable_transfer(struct platform_device *pdev)
+{
+	struct jzfb *jzfb = platform_get_drvdata(pdev);
+
+	mutex_lock(&jzfb->lock);
+
+	if (jzfb->is_enabled) {
+		jz4740_dma_disable(jzfb->slcd_dma);
+		jzfb_slcd_wait(jzfb);
+	}
+
+	mutex_unlock(&jzfb->lock);
+}
+
+void jz4740_fb_slcd_enable_transfer(struct platform_device *pdev)
+{
+	struct jzfb *jzfb = platform_get_drvdata(pdev);
+
+	mutex_lock(&jzfb->lock);
+
+	if (jzfb->is_enabled)
+		jzfb_slcd_start_dma(jzfb);
+
+	mutex_unlock(&jzfb->lock);
+}
+
+void jz4740_fb_slcd_send_cmd_data(struct platform_device *pdev,
+				  unsigned int cmd, unsigned int data)
+{
+	struct jzfb *jzfb = platform_get_drvdata(pdev);
+
+	mutex_lock(&jzfb->lock);
+
+	if (!jzfb->is_enabled)
+		clk_enable(jzfb->ldclk);
+
+	send_panel_command(jzfb, cmd);
+	send_panel_data(jzfb, data);
+
+	if (!jzfb->is_enabled) {
+		jzfb_slcd_wait(jzfb);
+		clk_disable(jzfb->ldclk);
+	}
+
+	mutex_unlock(&jzfb->lock);
+}
+
+void jz4740_fb_slcd_send_cmd(struct platform_device *pdev, unsigned int cmd)
+{
+	struct jzfb *jzfb = platform_get_drvdata(pdev);
+
+	mutex_lock(&jzfb->lock);
+
+	if (!jzfb->is_enabled)
+		clk_enable(jzfb->ldclk);
+
+	send_panel_command(jzfb, cmd);
+
+	if (!jzfb->is_enabled) {
+		jzfb_slcd_wait(jzfb);
+		clk_disable(jzfb->ldclk);
+	}
+
+	mutex_unlock(&jzfb->lock);
+}
+
 static int __devinit jzfb_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -655,6 +1235,7 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
 	fb->flags = FBINFO_DEFAULT;
 
 	jzfb = fb->par;
+	jzfb->fb = fb;
 	jzfb->pdev = pdev;
 	jzfb->pdata = pdata;
 	jzfb->mem = mem;
@@ -673,6 +1254,7 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
 		goto err_put_ldclk;
 	}
 
+	jzfb->phys_base = mem->start;
 	jzfb->base = ioremap(mem->start, resource_size(mem));
 	if (!jzfb->base) {
 		dev_err(&pdev->dev, "Failed to ioremap register memory region\n");
@@ -707,16 +1289,14 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
 
 	fb_alloc_cmap(&fb->cmap, 256, 0);
 
-	clk_enable(jzfb->ldclk);
-	jzfb->is_enabled = 1;
-
-	writel(jzfb->framedesc->next, jzfb->base + JZ_REG_LCD_DA0);
-
 	fb->mode = NULL;
 	jzfb_set_par(fb);
 
-	jz_gpio_bulk_request(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
-	jz_gpio_bulk_request(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
+	jzfb_pins_operation(jzfb, REQUEST_PINS);
+
+	jzfb_blank(FB_BLANK_UNBLANK, fb);
 
 	ret = register_framebuffer(fb);
 	if (ret) {
@@ -724,13 +1304,11 @@ static int __devinit jzfb_probe(struct platform_device *pdev)
 		goto err_free_devmem;
 	}
 
-	jzfb->fb = fb;
-
 	return 0;
 
 err_free_devmem:
-	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
-	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
+	jzfb_disable(jzfb);
+	jzfb_pins_operation(jzfb, FREE_PINS);
 
 	fb_dealloc_cmap(&fb->cmap);
 	jzfb_free_devmem(jzfb);
@@ -753,8 +1331,7 @@ static int __devexit jzfb_remove(struct platform_device *pdev)
 
 	jzfb_blank(FB_BLANK_POWERDOWN, jzfb->fb);
 
-	jz_gpio_bulk_free(jz_lcd_ctrl_pins, jzfb_num_ctrl_pins(jzfb));
-	jz_gpio_bulk_free(jz_lcd_data_pins, jzfb_num_data_pins(jzfb));
+	jzfb_pins_operation(jzfb, FREE_PINS);
 
 	iounmap(jzfb->base);
 	release_mem_region(jzfb->mem->start, resource_size(jzfb->mem));
@@ -785,6 +1362,7 @@ static int jzfb_suspend(struct device *dev)
 	mutex_lock(&jzfb->lock);
 	if (jzfb->is_enabled)
 		jzfb_disable(jzfb);
+	jzfb_pins_operation(jzfb, SUSPEND_PINS);
 	mutex_unlock(&jzfb->lock);
 
 	return 0;
@@ -795,6 +1373,7 @@ static int jzfb_resume(struct device *dev)
 	struct jzfb *jzfb = dev_get_drvdata(dev);
 
 	mutex_lock(&jzfb->lock);
+	jzfb_pins_operation(jzfb, RESUME_PINS);
 	if (jzfb->is_enabled)
 		jzfb_enable(jzfb);
 	mutex_unlock(&jzfb->lock);
diff --git a/include/video/truly_g240400rtsw.h b/include/video/truly_g240400rtsw.h
new file mode 100644
index 0000000..662851b
--- /dev/null
+++ b/include/video/truly_g240400rtsw.h
@@ -0,0 +1,31 @@
+#ifndef __VIDEO_TRULY_G240400RTSW_H__
+#define __VIDEO_TRULY_G240400RTSW_H__
+
+struct platform_device;
+struct fb_videomode;
+
+struct g240400_pdata {
+	struct platform_device		*jz4740_fb;
+	struct fb_videomode		*default_mode;
+	int				gpio_reset;
+	int				gpio_cs;
+};
+
+#endif /* __VIDEO_TRULY_G240400RTSW_H__ */

--------------010404090408070103010009--
