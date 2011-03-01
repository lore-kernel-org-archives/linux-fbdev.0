From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Tue, 01 Mar 2011 12:06:07 +0000
Subject: [RFC/PATCH 6/6] backlight: Add Truly G240400RTSW LCD panel driver
Message-Id: <916310c85f03dec73b745b91b3437381b6dd73eb.1298980528.git.mcuelenaere@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is a driver for the Truly G240400RTSW LCD panel using the Jz4740
SLCD framebuffer functions to communicate with the driver chip (Renesas R61509).

It currently supports initializing at boot and suspending, but it fails to come
back up after resume and it doesn't support any gamma or image control.

Tested on an Onda VX747 (Ingenic Jz4740 device).

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/video/backlight/Kconfig             |    7 +
 drivers/video/backlight/Makefile            |    1 +
 drivers/video/backlight/truly_g240400rtsw.c |  464 +++++++++++++++++++++++++++
 include/video/truly_g240400rtsw.h           |   35 ++
 4 files changed, 507 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/backlight/truly_g240400rtsw.c
 create mode 100644 include/video/truly_g240400rtsw.h

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
index 0000000..437980b
--- /dev/null
+++ b/drivers/video/backlight/truly_g240400rtsw.c
@@ -0,0 +1,464 @@
+/*
+ *  drivers/video/backlight/truly_g240400rtsw.c
+ *
+ *  Truly G240400RTSW LCD panel driver
+ *
+ *  Copyright (c) 2011, Maurus Cuelenaere <mcuelenaere@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of  the GNU General Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
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
+#include <asm/mach-jz4740/jz4740_fb.h>
+
+#include <video/truly_g240400rtsw.h>
+
+/* This LCD panel contains a Renesas R61509 driver chip */
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
+	if (gpio_is_valid(lcm->pdata.gpio_reset)) {
+		gpio_direction_output(lcm->pdata.gpio_reset, 0);
+		mdelay(1);
+		gpio_direction_output(lcm->pdata.gpio_reset, 1);
+	}
+
+	jz4740_fb_slcd_disable_transfer(jzfb);
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_SOFT_RESET, SOFT_RESET(1));
+	mdelay(1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_SOFT_RESET, SOFT_RESET(0));
+	mdelay(1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_ENDIAN_CTRL, 0);
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DRIVER_OUTPUT, 0x100);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_LCD_DR_WAVE_CTRL, 0x100);
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_ENTRY_MODE, (ENTRY_MODE_BGR | ENTRY_MODE_HWM | ENTRY_MODE_DFM | ENTRY_MODE_VID | ENTRY_MODE_HID));
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
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL1, (DISP_CTRL1_GON |
+				     DISP_CTRL1_D(1)));
+	mdelay(1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL1, (DISP_CTRL1_VON |
+				     DISP_CTRL1_GON | DISP_CTRL1_D(1)));
+	mdelay(1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL1, (DISP_CTRL1_BASEE |
+				     DISP_CTRL1_VON | DISP_CTRL1_GON |
+				     DISP_CTRL1_DTE | DISP_CTRL1_D(3)));
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
+	struct platform_device *jzfb = lcm->pdata.jz4740_fb;
+
+	jz4740_fb_slcd_disable_transfer(jzfb);
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL1, (DISP_CTRL1_VON |
+				     DISP_CTRL1_GON | DISP_CTRL1_DTE |
+				     DISP_CTRL1_D(2)));
+	mdelay(1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL1, DISP_CTRL1_D(1));
+	mdelay(1);
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_DISP_CTRL1, DISP_CTRL1_D(0));
+
+	jz4740_fb_slcd_enable_transfer(jzfb);
+}
+
+static void g240400_standby(struct g240400 *lcm)
+{
+	struct platform_device *jzfb = lcm->pdata.jz4740_fb;
+
+	jz4740_fb_slcd_disable_transfer(jzfb);
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PWR_CTRL1, PWR_CTRL1_SLP);
+
+	jz4740_fb_slcd_enable_transfer(jzfb);
+}
+
+static void g240400_poweron(struct g240400 *lcm)
+{
+	struct platform_device *jzfb = lcm->pdata.jz4740_fb;
+
+	jz4740_fb_slcd_disable_transfer(jzfb);
+
+	jz4740_fb_slcd_send_cmd_data(jzfb, REG_PWR_CTRL1, (PWR_CTRL1_SAPE | PWR_CTRL1_BT(6) | PWR_CTRL1_APE | PWR_CTRL1_AP(3)));
+
+	jz4740_fb_slcd_enable_transfer(jzfb);
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
+	if (power = lcm->power)
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
+	lcd = lcd_device_register("truly_g240400", &pdev->dev, lcm,
+				  &g240400_lcd_ops);
+	if (IS_ERR(lcd)) {
+		ret = PTR_ERR(lcd);
+		goto out_free_device;
+	}
+
+	if (gpio_is_valid(lcm->pdata.gpio_reset)) {
+		ret = gpio_request(lcm->pdata.gpio_reset, "lcd reset");
+		if (ret)
+			goto out_unregister_lcd;
+	}
+
+	if (gpio_is_valid(lcm->pdata.gpio_cs)) {
+		ret = gpio_request(lcm->pdata.gpio_cs, "lcd chip select");
+		if (ret)
+			goto out_free_pin_cs;
+	}
+
+	dev_set_drvdata(&pdev->dev, lcm);
+
+	/* Always select LCD chip */
+	if (gpio_is_valid(lcm->pdata.gpio_cs))
+		gpio_direction_output(lcm->pdata.gpio_cs, 0);
+
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
+late_initcall(g240400_init); /* Ensure this gets loaded *after* the FB */
+
+static void __exit g240400_exit(void)
+{
+	platform_driver_unregister(&g240400_driver);
+}
+module_exit(g240400_exit);
diff --git a/include/video/truly_g240400rtsw.h b/include/video/truly_g240400rtsw.h
new file mode 100644
index 0000000..e4147b2
--- /dev/null
+++ b/include/video/truly_g240400rtsw.h
@@ -0,0 +1,35 @@
+/*
+ *  include/video/truly_g240400rtsw.h
+ *
+ *  Truly G240400RTSW LCD panel driver
+ *
+ *  Copyright (c) 2011, Maurus Cuelenaere <mcuelenaere@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of  the GNU General Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __VIDEO_TRULY_G240400RTSW_H__
+#define __VIDEO_TRULY_G240400RTSW_H__
+
+struct platform_device;
+struct fb_videomode;
+
+/**
+ * @jz4740_fb: pointer to the platform_device corresponding with the Ingenic
+ *             Jz4740 framebuffer driver, required
+ * @default_mode: initial video mode when LCD panel gets powered on, required
+ * @gpio_reset: GPIO reset pin, set to -1 for unused
+ * @gpio_cs: GPIO chip select pin, set to -1 for unused
+ */
+struct g240400_pdata {
+	struct platform_device		*jz4740_fb;
+	struct fb_videomode		*default_mode;
+	int				gpio_reset;
+	int				gpio_cs;
+};
+
+#endif /* __VIDEO_TRULY_G240400RTSW_H__ */
-- 
1.7.4

