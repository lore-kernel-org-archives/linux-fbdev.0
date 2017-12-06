From: Lars Poeschel <poeschel@lemonage.de>
Date: Wed, 06 Dec 2017 13:52:55 +0000
Subject: [PATCH] video: hd44780: Add hd44780 lcd display driver
Message-Id: <20171206135255.6990-1-poeschel@lemonage.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Stafford Horne <shorne@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Randy Dunlap <rdunlap@infradead.org>, Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Sean Paul <seanpaul@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Lars Poeschel <poeschel@lemonage.de>

This adds a console driver for hd44780 based character lcd displays and
clones. The driver currently supports 20x4 character displays with
character ROMs A00 and A02.
The hardware wirings to the display have to be supplied to the kernel in
the devicetree. The binding doc has the necessary information.
There are also tons of these cheap displays sold with a serial
interface. Many of them use a simple pcf8574 gpio expanders. An example
for using that kind of display is also in the binding doc.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 .../bindings/video/console/hd44780con.txt          |  42 ++
 drivers/video/console/Kconfig                      |  13 +
 drivers/video/console/Makefile                     |   1 +
 drivers/video/console/hd44780con.c                 | 676 +++++++++++++++++++++
 4 files changed, 732 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/console/hd44780con.txt
 create mode 100644 drivers/video/console/hd44780con.c

diff --git a/Documentation/devicetree/bindings/video/console/hd44780con.txt b/Documentation/devicetree/bindings/video/console/hd44780con.txt
new file mode 100644
index 000000000000..261301eb0c68
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/console/hd44780con.txt
@@ -0,0 +1,42 @@
+Console display driver for Hitachi HD44780 based displays and clones
+
+Required properties:
+- compatible : "hit,hd44780"
+- rs-gpios : GPIO reference for the register select line of the display
+- rw-gpios : GPIO reference for the r/w line of the display
+- e-gpios : GPIO reference for the enable line of the display
+- bl-gpios : GPIO reference for the backlight of the display
+- data-gpios : GPIO reference for the data lines of the display. Currently
+		only the 4 bit mode is supported by the driver. So you have
+		to connect the 4 data lines to DB4 - DB7 of the display.
+- charset-rom : Either "a00" or "a02". The datasheet mentions these two
+		charset roms to be available. Supply the one you have here.
+
+Example:
+
+hd44780con: hd44780@27 {
+	compatible =	"hit,hd44780";
+	rs-gpios =	<&gpiom27 0 GPIO_ACTIVE_HIGH>;
+	rw-gpios =	<&gpiom27 1 GPIO_ACTIVE_HIGH>;
+	e-gpios =	<&gpiom27 2 GPIO_ACTIVE_HIGH>;
+	bl-gpios =	<&gpiom27 3 GPIO_ACTIVE_HIGH>;
+	data-gpios =	<&gpiom27 4 GPIO_ACTIVE_HIGH>,
+			<&gpiom27 5 GPIO_ACTIVE_HIGH>,
+			<&gpiom27 6 GPIO_ACTIVE_HIGH>,
+			<&gpiom27 7 GPIO_ACTIVE_HIGH>;
+	charset-rom =	"a00";
+};
+
+
+These hd44780 displays often come with some sort of serial interface. The
+cheap ones often only have a pcf8574 gpio expander from nxp on it. You
+connect to your controller via i2c and gpio expander drives the raw lines
+of your display. Such a display would need a devicetree entry for the
+pcf8574 that looks like this:
+
+gpiom27: gpio27@27 {
+	reg = <0x27>;
+	compatible = "nxp,pcf8574";
+	gpio-controller;
+	#gpio-cells = <2>;
+};
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fbcef9e..204e6ddf1417 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -161,5 +161,18 @@ config STI_CONSOLE
           machines.  Say Y here to build support for it into your kernel.
           The alternative is to use your primary serial port as a console.
 
+config HD44780_CONSOLE
+        tristate "Hitachi HD44780 20x4 character display as console"
+        depends on GPIOLIB
+        default n
+        help
+          This is a driver that lets you use the cheap lcd 20x4 character
+          display with i2c serial interface using a pcf8574at chip as a
+          console output device. The display is a simple single color
+          character display. It is often referred to as HD44780. To use this
+          driver, you have to connect it to an I2C bus with the lcm1602
+          device. This device contains the pcf8574at chip.
+          This driver only supports the 20x4 character version of the
+          display at the moment.
 endmenu
 
diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
index db07b784bd2c..1d3df4173280 100644
--- a/drivers/video/console/Makefile
+++ b/drivers/video/console/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_DUMMY_CONSOLE)       += dummycon.o
 obj-$(CONFIG_SGI_NEWPORT_CONSOLE) += newport_con.o
 obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o
+obj-$(CONFIG_HD44780_CONSOLE)     += hd44780con.o
 obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
 
diff --git a/drivers/video/console/hd44780con.c b/drivers/video/console/hd44780con.c
new file mode 100644
index 000000000000..c5195410f3bc
--- /dev/null
+++ b/drivers/video/console/hd44780con.c
@@ -0,0 +1,676 @@
+/*
+ *  console driver for hitachi hd44780 20x4 character displays
+ *
+ *  This is a driver allowing you to use a HD44780 character lcd display
+ *  as console output device. Currently only the 20x4 character version
+ *  of the display is supported.
+ *  The display is able to work in a 4 bit or a 8 bit mode. This driver
+ *  currently only supports 4 bit mode.
+ *
+ *  (C) 2017 by Lemonage Software GmbH
+ *  Author: Lars Pöschel <poeschel@lemonage.de>
+ *  All rights reserved.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/kd.h>
+#include <linux/tty.h>
+#include <linux/console_struct.h>
+#include <linux/console.h>
+#include <linux/vt_kern.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+
+#define HD44780_CMD_CLEAR_DISPLAY	0x01
+#define HD44780_CMD_RETURN_HOME		0x02
+#define HD44780_CMD_ENTRY_MODE_SET	0x04
+#define HD44780_CMD_ON_OFF_CONTROL	0x08
+#define HD44780_CMD_CUR_SHIFT_LEFT	0x10
+#define HD44780_CMD_CUR_SHIFT_RIGHT	0x14
+#define HD44780_CMD_FUNCTION_SET	0x20
+#define HD44780_CMD_DDRAM_ADDR		0x80
+
+#define HD44780_ENTRY_MODE_INC		0x02
+#define HD44780_DISPLAY_SHIFT		2
+#define HD44780_CUR_UL_SHIFT		1
+#define HD44780_CUR_BLINK_SHIFT		0
+
+#define HD44780_FIRST			8
+#define HD44780_LAST			9
+
+#define HD44780_MAX_ROWS		4
+#define HD44780_MAX_COLS		20
+
+struct hd44780_characteristics {
+	uint8_t num_rows;
+	uint8_t num_cols;
+	uint8_t row_to_ddram[];
+};
+
+struct hd44780_data {
+	struct gpio_desc *rs, *rw, *e, *bl;
+	struct gpio_descs *data;
+	uint8_t cur_row;
+	uint8_t cur_col;
+	unsigned int cur_blink:1;
+	unsigned int cur_ul:1;
+	unsigned int display:1;
+	struct hd44780_characteristics const *ch;
+	const uint8_t *cs;
+	unsigned short display_buf[HD44780_MAX_ROWS][HD44780_MAX_COLS];
+};
+
+static const struct hd44780_characteristics ch20x4 = {
+	.num_rows = 4,
+	.num_cols = 20,
+	.row_to_ddram = { 0, 0x40, 20, 0x40 + 20 }
+};
+
+static const uint8_t hd44780_a00_charset[] = {
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, /* 0x00 - 0x0f */
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1,
+	0x7e, 0x7f, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, /* 0x10 - 0x1f */
+	/*→	←*/
+	0xa1, 0xa1, 0x7e, 0x7f, 0xa1, 0xa1, 0xa1, 0xa1,
+	/*	      →     ←*/
+	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, /* 0x20 - 0x2f */
+	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, /* 0x30 - 0x3f */
+	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
+	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x40 - 0x4f */
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
+	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x50 - 0x5f */
+	0x58, 0x59, 0x5a, 0x5b, 0xa1, 0x5d, 0x5e, 0x5f,
+	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, /* 0x60 - 0x6f */
+	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
+	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, /* 0x70 - 0x7f */
+	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0xa1, 0xa1,
+	0xa1, 0xf5, 0xa1, 0xa1, 0xe1, 0xa1, 0xa1, 0xa1, /* 0x80 - 0x8f */
+	/*	ü		  ä*/
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1,
+	0xa1, 0xa1, 0xa1, 0xa1, 0xef, 0xa1, 0xa1, 0xa1, /* 0x90 - 0x9f */
+	/*			  ö*/
+	0xa1, 0xa1, 0xa1, 0xef, 0xa1, 0x5c, 0xa1, 0xa1,
+	/*		    ¢		¥*/
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, /* 0xa0 - 0xaf */
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1,
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, /* 0xb0 - 0xbf */
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1,
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, /* 0xc0 - 0xcf */
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1,
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, /* 0xd0 - 0xdf */
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1,
+	0xe0, 0xe2, 0xa1, 0xf7, 0xf6, 0xe5, 0xe6, 0xa1, /* 0xe0 - 0xef */
+	/*α     β	    π     ∑     σ     μ*/
+	0xa1, 0xf2, 0xf4, 0xa1, 0xf3, 0xa1, 0xe3, 0xa1,
+	/*      θ     Ω		  ∞	      ε*/
+	0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xa1, 0xfd, /* 0xf0 - 0xff */
+	/*					    ÷*/
+	0xa1, 0xa5, 0x2e, 0xe8, 0xa1, 0xa1, 0xff, 0x20
+	/*∘	∙     .     √*/
+};
+
+static const uint8_t hd44780_a02_charset[] = {
+	0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xb7, /* 0x00 - 0x0f */
+	0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xb7,
+	0x10, 0x11, 0xb7, 0xb7, 0x93, 0xa7, 0xb7, 0xb7, /* 0x10 - 0x1f */
+	/*⏵	⏴		  π	§←*/
+	0x18, 0x19, 0x1a, 0x1b, 0xb7, 0xb7, 0x1e, 0x1f,
+	/*↑	↓     →     ←		      ⏶	    ⏷*/
+	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, /* 0x20 - 0x2f */
+	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, /* 0x30 - 0x3f */
+	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
+	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, /* 0x40 - 0x4f */
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
+	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, /* 0x50 - 0x5f */
+	0x58, 0x59, 0x5a, 0x5b, 0xa1, 0x5d, 0x5e, 0x5f,
+	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, /* 0x60 - 0x6f */
+	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
+	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, /* 0x70 - 0x7f */
+	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,
+	0xc7, 0xfc, 0xe9, 0xe2, 0xe4, 0xe0, 0xe5, 0xe7, /* 0x80 - 0x8f */
+	/*Ç	ü     é	    â	  ä	à     å	    ç*/
+	0xea, 0xeb, 0xe8, 0xef, 0xee, 0xec, 0xc4, 0xc5,
+	/*ê	ë     è	    ï	  î	ì     Ä	    Å*/
+	0xc8, 0xe6, 0xc6, 0xf4, 0xf6, 0xf2, 0xfb, 0xf9, /* 0x90 - 0x9f */
+	/*È	æ     Æ	    ô	  ö	ò     û	    ù*/
+	0xff, 0xd6, 0xdc, 0xb7, 0xa3, 0xb7, 0xd7, 0xa8,
+	/*ÿ	Ö     Ü		  £	      ×	    ƒ*/
+	0xe1, 0xed, 0xf3, 0xfa, 0xf1, 0xd1, 0xb7, 0xb7 /* 0xa0 - 0xaf */
+	/*á	í     ó	    ú	  ñ	Ñ*/
+	0xbf, 0xae, 0xb7, 0xbd, 0xbc, 0xa1, 0xab, 0xbb,
+	/*¿	®	    ½	  ¼	¡     «	    »*/
+	0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xc1, 0xc2, 0xc0, /* 0xb0 - 0xbf */
+	/*				Á     Â	    À*/
+	0xa9, 0xb7, 0xb7, 0xb7, 0xb7, 0xa2, 0xa5, 0xb7,
+	/*©				¢     ¥*/
+	0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xe3, 0xc3, /* 0xc0 - 0xcf */
+					/*    ã	    Ã*/
+	0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xb7, 0xa4,
+	/*					    ¤*/
+	0xf0, 0xd0, 0xca, 0xcb, 0xc8, 0xb7, 0xcd, 0xce, /* 0xd0 - 0xdf */
+	/*ð	Ð     Ê	    Ë	  È	      Í	    Î*/
+	0xcf, 0xb7, 0xb7, 0xb7, 0xb7, 0xa6, 0xcc, 0xb7,
+	/*Ï				¦     Ì*/
+	0xd3, 0xdf, 0xd4, 0xd2, 0xf5, 0xd5, 0xb5, 0xde, /* 0xe0 - 0xef */
+	/*Ó     β     Ô	    Ò     õ     Õ     µ     Ϸ*/
+	0xfe, 0xda, 0xdb, 0xd9, 0xfd, 0xdd, 0xb7, 0xaf,
+	/*ϸ     Ú     Û	    Ù	  ý	Ý	    ´*/
+	0xb7, 0xb7, 0xb7, 0xbe, 0x93, 0xa7, 0xf7, 0xb7, /* 0xf0 - 0xff */
+	/*		    ¾	  π	∮     ÷*/
+	0xb0, 0xb7, 0xb7, 0xb9, 0xb3, 0xb2, 0xb7, 0x20
+	/*∘	      .	    ¹	  ³	²*/
+};
+
+static struct hd44780_data hd44780;
+
+static void hd44780_fill_gpio_array(uint8_t value, int * const array)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (value & 0x01)
+			array[i] = 1;
+		else
+			array[i] = 0;
+
+		value >>= 1;
+	}
+}
+
+static void hd44780_write_4bit(uint8_t value)
+{
+	int array[4];
+
+	gpiod_set_value_cansleep(hd44780.rw, 0);
+	hd44780_fill_gpio_array(value, array);
+	gpiod_set_array_value_cansleep(4, hd44780.data->desc, array);
+	gpiod_set_value_cansleep(hd44780.e, 1);
+	udelay(30);
+	gpiod_set_value_cansleep(hd44780.e, 0);
+	udelay(120);
+}
+
+static void hd44780_write_4bit_instr(uint8_t value)
+{
+	gpiod_set_value_cansleep(hd44780.rs, 0);
+	hd44780_write_4bit(value);
+}
+
+static void hd44780_write_8bit_instr(uint8_t value)
+{
+	hd44780_write_4bit_instr(value >> 4);
+	hd44780_write_4bit_instr(value);
+}
+
+static void hd44780_write_4bit_data(uint8_t value)
+{
+	gpiod_set_value_cansleep(hd44780.rs, 1);
+	hd44780_write_4bit(value);
+}
+
+static void hd44780_write_8bit_data(uint8_t value)
+{
+	hd44780_write_4bit_data(value >> 4);
+	hd44780_write_4bit_data(value);
+}
+
+static void hd44780_clear_display(void)
+{
+	hd44780_write_8bit_instr(HD44780_CMD_CLEAR_DISPLAY);
+	hd44780.cur_row = 0;
+	hd44780.cur_col = 0;
+	memset(hd44780.display_buf, ' ', sizeof(hd44780.display_buf));
+}
+
+static void hd44780_reset_cursor(void)
+{
+	hd44780_write_8bit_instr(HD44780_CMD_RETURN_HOME);
+	hd44780.cur_row = 0;
+	hd44780.cur_col = 0;
+}
+
+static void hd44780_set_ddram_addr(int row, int col)
+{
+	pr_debug("%s row:%i col:%i\n", __func__, row, col);
+	if ((row < 0) || (col < 0))
+		return;
+
+	if ((row >= hd44780.ch->num_rows) || (col >= hd44780.ch->num_cols))
+		return;
+
+	hd44780_write_8bit_instr(HD44780_CMD_DDRAM_ADDR |
+			(hd44780.ch->row_to_ddram[row] + col));
+}
+
+static void hd44780_set_cursor(int row, int col)
+{
+	pr_debug("%s row:%i, col:%i\n", __func__, row, col);
+	if ((hd44780.cur_row = row) && (hd44780.cur_col = col)) {
+		pr_debug("not setting cursor");
+		return;
+	}
+
+	hd44780_set_ddram_addr(row, col);
+	hd44780.cur_row = row;
+	hd44780.cur_col = col;
+}
+
+static void hd44780_display_on(void)
+{
+	if (!hd44780.display) {
+		hd44780.display = 1;
+		hd44780_write_8bit_instr(HD44780_CMD_ON_OFF_CONTROL |
+				hd44780.display << HD44780_DISPLAY_SHIFT |
+				hd44780.cur_ul << HD44780_CUR_UL_SHIFT |
+				hd44780.cur_blink << HD44780_CUR_BLINK_SHIFT);
+	}
+}
+
+static void hd44780_display_off(void)
+{
+	if (hd44780.display) {
+		hd44780.display = 0;
+		hd44780_write_8bit_instr(HD44780_CMD_ON_OFF_CONTROL |
+				hd44780.display << HD44780_DISPLAY_SHIFT |
+				hd44780.cur_ul << HD44780_CUR_UL_SHIFT |
+				hd44780.cur_blink << HD44780_CUR_BLINK_SHIFT);
+	}
+}
+
+static void hd44780_cursor_ul_on(void)
+{
+	if (!hd44780.cur_ul) {
+		hd44780.cur_ul = 1;
+		hd44780_write_8bit_instr(HD44780_CMD_ON_OFF_CONTROL |
+				hd44780.display << HD44780_DISPLAY_SHIFT |
+				hd44780.cur_ul << HD44780_CUR_UL_SHIFT |
+				hd44780.cur_blink << HD44780_CUR_BLINK_SHIFT);
+	}
+}
+
+static void hd44780_cursor_ul_off(void)
+{
+	if (hd44780.cur_ul) {
+		hd44780.cur_ul = 0;
+		hd44780_write_8bit_instr(HD44780_CMD_ON_OFF_CONTROL |
+				hd44780.display << HD44780_DISPLAY_SHIFT |
+				hd44780.cur_ul << HD44780_CUR_UL_SHIFT |
+				hd44780.cur_blink << HD44780_CUR_BLINK_SHIFT);
+	}
+}
+
+static void hd44780_cursor_blink_on(void)
+{
+	if (!hd44780.cur_blink) {
+		hd44780.cur_blink = 1;
+		hd44780_write_8bit_instr(HD44780_CMD_ON_OFF_CONTROL |
+				hd44780.display << HD44780_DISPLAY_SHIFT |
+				hd44780.cur_ul << HD44780_CUR_UL_SHIFT |
+				hd44780.cur_blink << HD44780_CUR_BLINK_SHIFT);
+	}
+}
+
+static void hd44780_cursor_blink_off(void)
+{
+	if (hd44780.cur_blink) {
+		hd44780.cur_blink = 0;
+		hd44780_write_8bit_instr(HD44780_CMD_ON_OFF_CONTROL |
+				hd44780.display << HD44780_DISPLAY_SHIFT |
+				hd44780.cur_ul << HD44780_CUR_UL_SHIFT |
+				hd44780.cur_blink << HD44780_CUR_BLINK_SHIFT);
+	}
+}
+
+static const char *hd44780_startup(void)
+{
+	return "hd44780 console";
+}
+
+/*
+ * init is set if console is currently allocated during init
+ */
+static void hd44780_init(struct vc_data *con, int init)
+{
+	hd44780.ch = &ch20x4;
+	/* initialisation sequence - set display to 4 bit mode */
+	hd44780_write_4bit_instr(0x03);
+	usleep_range(5000, 20000);
+	hd44780_write_4bit_instr(0x03);
+	usleep_range(100, 1000);
+	hd44780_write_4bit_instr(0x03);
+	hd44780_write_4bit_instr(0x02);
+	/* we are in 4 bit mode now, function set */
+	hd44780_write_8bit_instr(HD44780_CMD_FUNCTION_SET | 0x08);
+	/* display off, cursor off, blinking off */
+	hd44780_write_8bit_instr(HD44780_CMD_ON_OFF_CONTROL);
+	hd44780.display = 0;
+	hd44780.cur_ul = 0;
+	hd44780.cur_blink = 0;
+	/* display clear */
+	hd44780_clear_display();
+	/* entry mode set */
+	hd44780_write_8bit_instr(HD44780_CMD_ENTRY_MODE_SET |
+				HD44780_ENTRY_MODE_INC);
+
+	/* turn backlight on */
+	gpiod_set_value_cansleep(hd44780.bl, 1);
+	hd44780_display_on();
+	hd44780_cursor_ul_on();
+	hd44780_reset_cursor();
+
+	con->vc_can_do_color = 0;
+	con->vc_hi_font_mask = 0;
+
+	if (init) {
+		con->vc_rows = hd44780.ch->num_rows;
+		con->vc_cols = hd44780.ch->num_cols;
+	} else
+		vc_resize(con, hd44780.ch->num_cols, hd44780.ch->num_rows);
+}
+
+static void hd44780_deinit(struct vc_data *con)
+{
+	hd44780_display_off();
+	hd44780_cursor_ul_off();
+	hd44780_cursor_blink_off();
+	gpiod_set_value_cansleep(hd44780.bl, 0);
+}
+
+static void hd44780_increase_cursor(void)
+{
+	hd44780.cur_col++;
+	if (hd44780.cur_col > hd44780.ch->num_cols) {
+		hd44780.cur_col = 0;
+		hd44780.cur_row++;
+		if (hd44780.cur_row > hd44780.ch->num_rows)
+			hd44780.cur_row = 0;
+	}
+}
+
+static void hd44780_putc(struct vc_data *con, int data, int row, int col)
+{
+	pr_debug("%s data:0x%x, row:%i, col:%i\n", __func__, data, row, col);
+	hd44780_set_cursor(row, col);
+	hd44780_write_8bit_data(hd44780.cs[data & 0xff]);
+	hd44780.display_buf[row][col] = data;
+	hd44780_increase_cursor();
+}
+
+static void hd44780_putcs(struct vc_data *con, const unsigned short *buf,
+			int len, int row, int col)
+{
+	int i;
+
+	pr_debug("%s len:%i, row:%i, col:%i\n", __func__, len, row, col);
+	hd44780_set_cursor(row, col);
+	for (i = 0; i < len; i++) {
+		hd44780_write_8bit_data(hd44780.cs[buf[i] & 0xff]);
+		hd44780.display_buf[row][col + i] = buf[i];
+		hd44780_increase_cursor();
+	}
+}
+
+static void hd44780_clear(struct vc_data *con, int s_row, int s_col,
+			int height, int width)
+{
+	unsigned short buf[width];
+	uint8_t i;
+
+	pr_debug("%s\n", __func__);
+	if (width <= 0 || height <= 0)
+		return;
+
+	/* if the whole display is to clear, we have a single command */
+	if (s_col = 0 && s_row = 0 &&
+		height >= con->vc_rows - 1 && width >= con->vc_cols - 1) {
+		hd44780_clear_display();
+		return;
+	}
+
+	memset(buf, ' ', width);
+	for (i = s_col; i <= height; i++)
+		hd44780_putcs(con, buf, width, s_row, i);
+}
+
+static void hd44780_cursor(struct vc_data *con, int mode)
+{
+	pr_debug("%s ", __func__);
+	switch (mode) {
+	case CM_ERASE:
+		pr_debug("CM_ERASE\n");
+		hd44780_cursor_blink_off();
+		hd44780_cursor_ul_off();
+		break;
+	case CM_MOVE:
+		pr_debug("CM_MOVE ");
+	case CM_DRAW:
+		if (mode = CM_DRAW)
+			pr_debug("CM_DRAW ");
+
+		hd44780_set_cursor(con->vc_y, con->vc_x);
+		switch (con->vc_cursor_type & CUR_HWMASK) {
+		case CUR_UNDERLINE:
+			pr_debug("CUR_UNDERLINE\n");
+			hd44780_cursor_ul_on();
+			hd44780_cursor_blink_off();
+			break;
+		case CUR_NONE:
+			pr_debug("CUR_NONE\n");
+			hd44780_cursor_blink_off();
+			hd44780_cursor_ul_off();
+			break;
+		default:
+			pr_debug("default\n");
+			hd44780_cursor_blink_on();
+			hd44780_cursor_ul_off();
+			break;
+		}
+		break;
+	}
+}
+
+static bool hd44780_scroll(struct vc_data *con, unsigned int top,
+		unsigned int bot, enum con_scroll dir, unsigned int lines)
+{
+	uint8_t i;
+
+	pr_debug("%s top:%i bot:%i dir:%i lines:%i\n", __func__,
+			top, bot, dir, lines);
+
+	if (lines >= hd44780.ch->num_rows)
+		memset(hd44780.display_buf, ' ', sizeof(hd44780.display_buf));
+	else
+		switch (dir) {
+		case SM_UP:
+			memmove(&hd44780.display_buf[0][0],
+				&hd44780.display_buf[lines][0],
+				sizeof(hd44780.display_buf[0][0]) *
+				hd44780.ch->num_cols *
+				(hd44780.ch->num_rows - lines));
+			memset(&hd44780.display_buf[
+					hd44780.ch->num_rows - lines][0],
+				' ',
+				sizeof(hd44780.display_buf[0][0]) *
+				hd44780.ch->num_cols * lines);
+			break;
+		case SM_DOWN:
+			memmove(&hd44780.display_buf[lines][0],
+				&hd44780.display_buf[
+					hd44780.ch->num_rows - lines][0],
+				sizeof(hd44780.display_buf[0][0]) *
+				hd44780.ch->num_cols *
+				(hd44780.ch->num_rows - lines));
+			memset(&hd44780.display_buf[0][0], ' ',
+				sizeof(hd44780.display_buf[0][0]) *
+				hd44780.ch->num_rows * lines);
+			break;
+		}
+
+	for (i = 0; i < hd44780.ch->num_rows; i++)
+		hd44780_putcs(con,
+			(const unsigned short *)&hd44780.display_buf[i][0],
+			hd44780.ch->num_cols, i, 0);
+
+	return true;
+}
+
+static int hd44780_switch(struct vc_data *con)
+{
+	return 1;
+}
+
+static int hd44780_blank(struct vc_data *con, int blank, int mode_switch)
+{
+	switch (blank) {
+	case 0:		/* unblank */
+		hd44780_display_on();
+		hd44780_cursor_ul_on();
+		hd44780_cursor_blink_on();
+		break;
+	case 1:		/* normal blanking */
+		hd44780_display_off();
+		hd44780_cursor_ul_off();
+		hd44780_cursor_blink_off();
+		break;
+	}
+	return 0;
+}
+
+static const struct consw hd44780_con = {
+	.owner			= THIS_MODULE,
+	.con_startup		= hd44780_startup,
+	.con_init		= hd44780_init,
+	.con_deinit		= hd44780_deinit,
+	.con_clear		= hd44780_clear,
+	.con_putc		= hd44780_putc,
+	.con_putcs		= hd44780_putcs,
+	.con_cursor		= hd44780_cursor,
+	.con_scroll		= hd44780_scroll,
+	.con_switch		= hd44780_switch,
+	.con_blank		= hd44780_blank,
+};
+
+static const struct of_device_id hd44780_of_match[] = {
+	{ .compatible = "hit,hd44780", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hd44780_of_match);
+
+static int hd44780_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *dn = dev->of_node;
+	int err;
+	const char *cs;
+
+	hd44780.rs = gpiod_get(dev, "rs", GPIOD_OUT_LOW);
+	if (IS_ERR(hd44780.rs)) {
+		err = PTR_ERR(hd44780.rs);
+		goto fail_rs;
+	}
+
+	hd44780.rw = gpiod_get(dev, "rw", GPIOD_OUT_LOW);
+	if (IS_ERR(hd44780.rw)) {
+		err = PTR_ERR(hd44780.rw);
+		goto fail_rw;
+	}
+
+	hd44780.e = gpiod_get(dev, "e", GPIOD_OUT_LOW);
+	if (IS_ERR(hd44780.e)) {
+		err = PTR_ERR(hd44780.e);
+		goto fail_e;
+	}
+
+	hd44780.bl = gpiod_get(dev, "bl", GPIOD_OUT_HIGH);
+	if (IS_ERR(hd44780.bl)) {
+		err = PTR_ERR(hd44780.bl);
+		goto fail_bl;
+	}
+
+	hd44780.data = gpiod_get_array(dev, "data", GPIOD_OUT_LOW);
+	if (IS_ERR(hd44780.data)) {
+		err = PTR_ERR(hd44780.data);
+		goto fail_data;
+	}
+
+	if (hd44780.data->ndescs != 4) {
+		dev_err(dev, "can only work with 4 data lines (4 bit mode)");
+		err = -EINVAL;
+		goto fail;
+	}
+
+	err = of_property_read_string(dn, "charset-rom", &cs);
+	if (err < 0) {
+		dev_err(dev,
+		"please specify charset-rom for the hd44780 lcd display");
+		goto fail;
+	}
+
+	if (!strcasecmp(cs, "a00")) {
+		hd44780.cs = hd44780_a00_charset;
+	} else if (!strcasecmp(cs, "a02")) {
+		hd44780.cs = hd44780_a02_charset;
+	} else {
+		dev_err(dev,
+		"unknown charset specified for hd44780 lcd display");
+		goto fail;
+	}
+
+	console_lock();
+	do_take_over_console(&hd44780_con, HD44780_FIRST, HD44780_LAST, 1);
+	console_unlock();
+
+	return 0;
+fail:
+	gpiod_put_array(hd44780.data);
+fail_data:
+	gpiod_put(hd44780.bl);
+fail_bl:
+	gpiod_put(hd44780.e);
+fail_e:
+	gpiod_put(hd44780.rw);
+fail_rw:
+	gpiod_put(hd44780.rs);
+fail_rs:
+	return err;
+}
+
+static int hd44780_remove(struct platform_device *pdev)
+{
+	/* unregister from console subsystem */
+	do_unregister_con_driver(&hd44780_con);
+
+	gpiod_put(hd44780.rs);
+	gpiod_put(hd44780.rw);
+	gpiod_put(hd44780.e);
+	gpiod_put(hd44780.bl);
+	gpiod_put_array(hd44780.data);
+	return 0;
+}
+
+static struct platform_driver hd44780_device_driver = {
+	.probe		= hd44780_probe,
+	.remove		= hd44780_remove,
+	.driver		= {
+		.name	= "hd44780con",
+		.of_match_table = hd44780_of_match,
+	}
+};
+
+module_platform_driver(hd44780_device_driver);
+
+MODULE_DESCRIPTION("hd44780 character display console driver using gpio");
+MODULE_AUTHOR("Lars Pöschel");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:hd44780con");
-- 
2.15.0

