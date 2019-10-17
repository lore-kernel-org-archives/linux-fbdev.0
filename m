From: Beniamin Bia <beniamin.bia@analog.com>
Date: Thu, 17 Oct 2019 14:02:46 +0000
Subject: [PATCH] drivers/staging/fbtft/fb_seps525: New driver for SEPS525 (Syncoam) LCD Controllers
Message-Id: <20191017170203.11999-1-beniamin.bia@analog.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, michal.simek@xilinx.com, Beniamin Bia <beniamin.bia@analog.com>, Jonathan.Cameron@huawei.com, mchehab+samsung@kernel.org, paulmck@linux.ibm.com, davem@davemloft.net

From: Michael Hennerich <michael.hennerich@analog.com>

The SEPS525 is a 160 RGB x 128 Dots, 262K Colors PM-OLED Display Driver and
Controller.

The controller can be found on the NHD-1.69-160128UGC3
(Newhaven Display International, Inc.).

Datasheets:
Link: https://www.newhavendisplay.com/appnotes/datasheets/OLEDs/SEPS525.pdf

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 MAINTAINERS                        |   8 ++
 drivers/staging/fbtft/Kconfig      |   7 +
 drivers/staging/fbtft/Makefile     |   1 +
 drivers/staging/fbtft/fb_seps525.c | 213 +++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+)
 create mode 100644 drivers/staging/fbtft/fb_seps525.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ef00d6210cff..d077d04f9bc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15389,6 +15389,14 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/staging/wilc1000/
 
+STAGING - SEPS525 LCD CONTROLLER DRIVERS
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Beniamin Bia <beniamin.bia@analog.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Supported
+F:	drivers/staging/fbtft/fb_seps525.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+
 STAGING SUBSYSTEM
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
index 8ec524a95ec8..55af11ee2f5b 100644
--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -112,6 +112,13 @@ config FB_TFT_S6D1121
 	help
 	  Generic Framebuffer support for S6D1121
 
+config FB_TFT_SEPS525
+	tristate "FB driver for the SEPS525 LCD Controller"
+	depends on FB_TFT
+	help
+	  Generic Framebuffer support for SEPS525
+	  Say Y if you have such a display that utilizes this controller.
+
 config FB_TFT_SH1106
 	tristate "FB driver for the SH1106 OLED Controller"
 	depends on FB_TFT
diff --git a/drivers/staging/fbtft/Makefile b/drivers/staging/fbtft/Makefile
index 6bc03311c9c7..e7a0cd9166e9 100644
--- a/drivers/staging/fbtft/Makefile
+++ b/drivers/staging/fbtft/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_FB_TFT_PCD8544)     += fb_pcd8544.o
 obj-$(CONFIG_FB_TFT_RA8875)      += fb_ra8875.o
 obj-$(CONFIG_FB_TFT_S6D02A1)     += fb_s6d02a1.o
 obj-$(CONFIG_FB_TFT_S6D1121)     += fb_s6d1121.o
+obj-$(CONFIG_FB_TFT_SEPS525)     += fb_seps525.o
 obj-$(CONFIG_FB_TFT_SH1106)      += fb_sh1106.o
 obj-$(CONFIG_FB_TFT_SSD1289)     += fb_ssd1289.o
 obj-$(CONFIG_FB_TFT_SSD1305)     += fb_ssd1305.o
diff --git a/drivers/staging/fbtft/fb_seps525.c b/drivers/staging/fbtft/fb_seps525.c
new file mode 100644
index 000000000000..05882e2cde7f
--- /dev/null
+++ b/drivers/staging/fbtft/fb_seps525.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FB driver for the NHD-1.69-160128UGC3 (Newhaven Display International, Inc.)
+ * using the SEPS525 (Syncoam) LCD Controller
+ *
+ * Copyright (C) 2016 Analog Devices Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+
+#include "fbtft.h"
+
+#define DRVNAME		"fb_seps525"
+#define WIDTH		160
+#define HEIGHT		128
+
+#define SEPS525_INDEX 0x00
+#define SEPS525_STATUS_RD 0x01
+#define SEPS525_OSC_CTL 0x02
+#define SEPS525_IREF 0x80
+#define SEPS525_CLOCK_DIV 0x03
+#define SEPS525_REDUCE_CURRENT 0x04
+#define SEPS525_SOFT_RST 0x05
+#define SEPS525_DISP_ONOFF 0x06
+#define SEPS525_PRECHARGE_TIME_R 0x08
+#define SEPS525_PRECHARGE_TIME_G 0x09
+#define SEPS525_PRECHARGE_TIME_B 0x0A
+#define SEPS525_PRECHARGE_CURRENT_R 0x0B
+#define SEPS525_PRECHARGE_CURRENT_G 0x0C
+#define SEPS525_PRECHARGE_CURRENT_B 0x0D
+#define SEPS525_DRIVING_CURRENT_R 0x10
+#define SEPS525_DRIVING_CURRENT_G 0x11
+#define SEPS525_DRIVING_CURRENT_B 0x12
+#define SEPS525_DISPLAYMODE_SET 0x13
+#define SEPS525_RGBIF 0x14
+#define SEPS525_RGB_POL 0x15
+#define SEPS525_MEMORY_WRITEMODE 0x16
+#define SEPS525_MX1_ADDR 0x17
+#define SEPS525_MX2_ADDR 0x18
+#define SEPS525_MY1_ADDR 0x19
+#define SEPS525_MY2_ADDR 0x1A
+#define SEPS525_MEMORY_ACCESS_POINTER_X 0x20
+#define SEPS525_MEMORY_ACCESS_POINTER_Y 0x21
+#define SEPS525_DDRAM_DATA_ACCESS_PORT 0x22
+#define SEPS525_GRAY_SCALE_TABLE_INDEX 0x50
+#define SEPS525_GRAY_SCALE_TABLE_DATA 0x51
+#define SEPS525_DUTY 0x28
+#define SEPS525_DSL 0x29
+#define SEPS525_D1_DDRAM_FAC 0x2E
+#define SEPS525_D1_DDRAM_FAR 0x2F
+#define SEPS525_D2_DDRAM_SAC 0x31
+#define SEPS525_D2_DDRAM_SAR 0x32
+#define SEPS525_SCR1_FX1 0x33
+#define SEPS525_SCR1_FX2 0x34
+#define SEPS525_SCR1_FY1 0x35
+#define SEPS525_SCR1_FY2 0x36
+#define SEPS525_SCR2_SX1 0x37
+#define SEPS525_SCR2_SX2 0x38
+#define SEPS525_SCR2_SY1 0x39
+#define SEPS525_SCR2_SY2 0x3A
+#define SEPS525_SCREEN_SAVER_CONTEROL 0x3B
+#define SEPS525_SS_SLEEP_TIMER 0x3C
+#define SEPS525_SCREEN_SAVER_MODE 0x3D
+#define SEPS525_SS_SCR1_FU 0x3E
+#define SEPS525_SS_SCR1_MXY 0x3F
+#define SEPS525_SS_SCR2_FU 0x40
+#define SEPS525_SS_SCR2_MXY 0x41
+#define SEPS525_MOVING_DIRECTION 0x42
+#define SEPS525_SS_SCR2_SX1 0x47
+#define SEPS525_SS_SCR2_SX2 0x48
+#define SEPS525_SS_SCR2_SY1 0x49
+#define SEPS525_SS_SCR2_SY2 0x4A
+
+/* SEPS525_DISPLAYMODE_SET */
+#define MODE_SWAP_BGR	BIT(7)
+#define MODE_SM		BIT(6)
+#define MODE_RD		BIT(5)
+#define MODE_CD		BIT(4)
+
+#define seps525_use_window	0 /* FBTFT doesn't really use it today */
+
+/* Init sequence taken from: Arduino Library for the Adafruit 2.2" display */
+static int init_display(struct fbtft_par *par)
+{
+	par->fbtftops.reset(par);
+
+	usleep_range(1000, 5000);
+
+	/* Disable Oscillator Power Down */
+	write_reg(par, SEPS525_REDUCE_CURRENT, 0x03);
+	usleep_range(1000, 5000);
+	/* Set Normal Driving Current */
+	write_reg(par, SEPS525_REDUCE_CURRENT, 0x00);
+	usleep_range(1000, 5000);
+
+	write_reg(par, SEPS525_SCREEN_SAVER_CONTEROL, 0x00);
+	/* Set EXPORT1 Pin at Internal Clock */
+	write_reg(par, SEPS525_OSC_CTL, 0x01);
+	/* Set Clock as 120 Frames/Sec */
+	write_reg(par, SEPS525_CLOCK_DIV, 0x90);
+	/* Set Reference Voltage Controlled by External Resister */
+	write_reg(par, SEPS525_IREF, 0x01);
+
+	/* precharge time R G B */
+	write_reg(par, SEPS525_PRECHARGE_TIME_R, 0x04);
+	write_reg(par, SEPS525_PRECHARGE_TIME_G, 0x05);
+	write_reg(par, SEPS525_PRECHARGE_TIME_B, 0x05);
+
+	/* precharge current R G B (uA) */
+	write_reg(par, SEPS525_PRECHARGE_CURRENT_R, 0x9D);
+	write_reg(par, SEPS525_PRECHARGE_CURRENT_G, 0x8C);
+	write_reg(par, SEPS525_PRECHARGE_CURRENT_B, 0x57);
+
+	/* driving current R G B (uA) */
+	write_reg(par, SEPS525_DRIVING_CURRENT_R, 0x56);
+	write_reg(par, SEPS525_DRIVING_CURRENT_G, 0x4D);
+	write_reg(par, SEPS525_DRIVING_CURRENT_B, 0x46);
+	/* Set Color Sequence */
+	write_reg(par, SEPS525_DISPLAYMODE_SET, 0xA0);
+	write_reg(par, SEPS525_RGBIF, 0x01); /* Set MCU Interface Mode */
+	/* Set Memory Write Mode */
+	write_reg(par, SEPS525_MEMORY_WRITEMODE, 0x66);
+	write_reg(par, SEPS525_DUTY, 0x7F); /* 1/128 Duty (0x0F~0x7F) */
+	/* Set Mapping RAM Display Start Line (0x00~0x7F) */
+	write_reg(par, SEPS525_DSL, 0x00);
+	write_reg(par, SEPS525_DISP_ONOFF, 0x01); /* Display On (0x00/0x01) */
+	/* Set All Internal Register Value as Normal Mode */
+	write_reg(par, SEPS525_SOFT_RST, 0x00);
+	/* Set RGB Interface Polarity as Active Low */
+	write_reg(par, SEPS525_RGB_POL, 0x00);
+
+	write_reg(par, SEPS525_DDRAM_DATA_ACCESS_PORT);
+
+	return 0;
+}
+
+static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
+{
+	if (seps525_use_window) {
+		/* Set Window Xs,Ys Xe,Ye*/
+		write_reg(par, SEPS525_MX1_ADDR, xs);
+		write_reg(par, SEPS525_MX2_ADDR, xe);
+		write_reg(par, SEPS525_MY1_ADDR, ys);
+		write_reg(par, SEPS525_MY2_ADDR, ye);
+	}
+	/* start position X,Y */
+	write_reg(par, SEPS525_MEMORY_ACCESS_POINTER_X, xs);
+	write_reg(par, SEPS525_MEMORY_ACCESS_POINTER_Y, ys);
+
+	write_reg(par, SEPS525_DDRAM_DATA_ACCESS_PORT);
+}
+
+static int set_var(struct fbtft_par *par)
+{
+	u8 val;
+
+	switch (par->info->var.rotate) {
+	case 0:
+		val = 0;
+		break;
+	case 180:
+		val = MODE_RD | MODE_CD;
+		break;
+	case 90:
+	case 270:
+
+	default:
+		return -EINVAL;
+	}
+	/* Memory Access Control  */
+	write_reg(par, SEPS525_DISPLAYMODE_SET, val |
+		       (par->bgr ? MODE_SWAP_BGR : 0));
+
+	write_reg(par, SEPS525_DDRAM_DATA_ACCESS_PORT);
+
+	return 0;
+}
+
+static struct fbtft_display display = {
+	.regwidth = 8,
+	.width = WIDTH,
+	.height = HEIGHT,
+	.fbtftops = {
+		.init_display = init_display,
+		.set_addr_win = set_addr_win,
+		.set_var = set_var,
+	},
+};
+
+FBTFT_REGISTER_DRIVER(DRVNAME, "syncoam,seps525", &display);
+
+MODULE_ALIAS("spi:" DRVNAME);
+MODULE_ALIAS("platform:" DRVNAME);
+MODULE_ALIAS("spi:seps525");
+MODULE_ALIAS("platform:seps525");
+
+MODULE_DESCRIPTION("FB driver for the SEPS525 LCD Controller");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1
